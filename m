Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDDF20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbdBQSm3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:42:29 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33612 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbdBQSm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:42:28 -0500
Received: by mail-lf0-f53.google.com with SMTP id x1so26449513lff.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=89Fbx1yryR4whXjopbMS7SqL/ziyLIp/I+G5+XtYP0Y=;
        b=o8vZ2hZvHa2ecdHn3jixm+ZtXHKS8CVMtysHWlWiYO3XPONZ0EumXlDCiC9MIC3lWo
         3oVFvj6bBEjums+Z+tyqUn89cUvzPhvJpKp8n7X0E2uFL4nnNdNv4pUhSD/CkyZ6+GbM
         nARHAG4igluozhYcgPe5hO2PipBdBRxwK24W5E/17DK2R6YItFFaLZ/4+KtpgMZN3Bqu
         4hwGgivoNeg6EMQHtCDarnLOszqRYkotNKYDWlt3sK13ucEDKDd1qAp1eHV55JSKCAUI
         RD/V6IPGzr6N3x3YDXu/ppaDeX2f0UfqvNYgGOieSyPYhlcvSiZXS5PtR13Mxl7MbnlR
         2W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=89Fbx1yryR4whXjopbMS7SqL/ziyLIp/I+G5+XtYP0Y=;
        b=iuZEmLIqR065XES5JQCaaaKmkPM5ybzrJMGwVpbVyIh9bJShaRVOkUlK/Iq6ZlP402
         PTsw8AykSjeSvuHhiuLc8GH0qm/H2FtdcE9IXLK0BABqRAyzWqS0MWWGzeywcjkYKlV8
         may83Pn1RyH6RD1Tuai8oN+P2GhA4nSyb04cP9Ehh4ZU8f91COK8zlldx3OrHcYqFjjj
         lD390J12wLZE5ZHbYNFK1uVCee0QJinfuzVIpFfXkARHiHm9cigDqxJy5m7s5A5fc6n7
         xdVdbFMO4RgIG9CpEU+1iS5cNHSBb9+UEWMhQJ9T4iWF0a0nDS5SZNTGaEW6ynWmzQZu
         vdxg==
X-Gm-Message-State: AMke39mreG0TKcUckVipwgJLDfYqnOWYs+MpsNNupIeKCvK343QW1tDZ1fKLDVhyJQfjehl/jzhdgfrJEm+8hw==
X-Received: by 10.25.79.79 with SMTP id a15mr2730325lfk.58.1487356946917; Fri,
 17 Feb 2017 10:42:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 17 Feb 2017 10:42:06 -0800 (PST)
In-Reply-To: <20170216003811.18273-13-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 17 Feb 2017 10:42:06 -0800
Message-ID: <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation
 for submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
> +       if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))

Here, and in other cases where we use
is_active_submodule_with_strategy(), why do we only ever check
SM_UPDATE_UNSPECIFIED? It seems really weird that we're only going to
check submodules who's strategy is unspecified, when that defaults to
checkout if I recall correctly? Shouldn't we check both? This applies
to pretty much everywhere that you call this function that I noticed,
which is why I removed the context.

Thanks,
Jake
