Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 692AA201A7
	for <e@80x24.org>; Mon, 15 May 2017 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbdEOXMc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 19:12:32 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33262 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdEOXMb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 19:12:31 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so70254117pfh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 16:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hNrkUnQMraqa4sKUFhde6Egk/lRGLyXH761tZNvPczM=;
        b=u9kOS0TXEVFh3BDG/kdhyJf2PUXlVt+tMDcUrFIpEp0KxY1h4hRc+Y4zjLWQsKeMof
         fEu+KRQbghJtP2+T7NAiMLR1xN7glZVlNsh42qFic2plMWqZnNv6IPAjZ4OEzebKGxC0
         1QdDbbnmAaPmT1xm3hgpQYNxOcXowzY/xDZIF/cCAw3K3E0sO42LiP2sKXcvXpDZIZ4b
         wfw8e6XuwGJHNkrGHiVxs3SvQN1epNiDvfnCAMrajLQx6EaH2AxsgbhewgX8Vk6m5irf
         2ZpekjmsJ+mJXcobd39dvp0bp/Myfz1pAZKqzN2OBTQm0vf4PUHhS1JOZ9EpOIdOcWj0
         Jyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hNrkUnQMraqa4sKUFhde6Egk/lRGLyXH761tZNvPczM=;
        b=tN2FaZB3TYahX36giqjbmOD2HLaxs/aSIxi+XdINyiAtxSARaLB91VDtGSbjbzg6fb
         10GCl0dX8IBWrZeeI4lfr/2IFbi+vq+8rviQV/W0eT3Xddr11aUKXVGL0nR6NIcBOK0K
         Npujn83FaU0/lNpWyZAkGuqbGAXuwxoZ8FpUg1Pu9GGDYeY4DHqkLwLzGkKqcQhc9jai
         kNfVHoow48yNgMK2smHHO7D7jgN1pnF2Fi+p9qYG17VGz/cpVV1oYVF7LL2QLnKEJEPp
         7sAWoFWiCgA5OpZTnuzbTGHDQWx9pDesa7UGpKoZ+8fbfF6R+XCPduw2zhr/nMNob8G7
         848g==
X-Gm-Message-State: AODbwcDRFhyJ3iNptQOw+AN4BPZbyb6z6kHTI7KQLFi4rwxqdJ/Tt2mN
        6cku3rQYaTL0jLRHQs4nuHZnyFNsRDlufFE=
X-Received: by 10.84.142.133 with SMTP id 5mr11734134plx.52.1494889950794;
 Mon, 15 May 2017 16:12:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 16:12:30 -0700 (PDT)
In-Reply-To: <f49dc4f8-cc83-934f-e582-79efdc613f70@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-15-sbeller@google.com>
 <f49dc4f8-cc83-934f-e582-79efdc613f70@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 16:12:30 -0700
Message-ID: <CAGZ79kYx18HZGOLfN7jGzoG0DAEb7O+=L=7uZ07fDsNRK0ic_g@mail.gmail.com>
Subject: Re: [PATCH 14/19] diff.c: convert word diffing to use emit_line_*
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 3:40 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> I suspect that this will need to be refactored more thoroughly. Here, for
> example, emit_line (which prints the prefix) is printed nearly
> unconditionally, whereas in the original version, "fputs(line_prefix, fp)"
> is only printed when "print" is true.

Yes, manual testing confirms this is the case. Maybe I should to add a test
for "git diff --word-diff --line-prefix"

Thanks,
Stefan
