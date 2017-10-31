Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050F81FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbdJaAdv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:33:51 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:55534 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753704AbdJaAdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:33:50 -0400
Received: by mail-pf0-f180.google.com with SMTP id 17so12352890pfn.12
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MuSV5U+MdBFtVi6tWOwccqPTN4SOo6EzNz6EXEygr6c=;
        b=OkcDnyQigE6uFjESkJjTJEkB4R1nTH7fcWG0ETkRk29PLmyLiIFiLkv6sN9fDJ9fPM
         +ADLynsw5p2jILH8ZCImQGc7D7gCYTmyo2yMDUx7KmTaocsGIPVhJSKTKtXU9U1z1M9I
         V6t//MLoCmk3zcWWis3FRsLNkKfJy7Srs6OPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MuSV5U+MdBFtVi6tWOwccqPTN4SOo6EzNz6EXEygr6c=;
        b=ahkmw/u3N01KGVwYVqf5Vmq8eEa8ndrXY9V4vLDA9JhAatusLv+X0grPuz8ljO5UyV
         gTj6Nw01DYAo7c6N2XkS2cvpjvVYdK4xNI8/GJ1mS8bDmbtGFyyk89k3JG6MlFf10UbD
         B1DXZ2jtqYLKw3DoIXXR4jhtuIklIPK/PutRJx9BSyM51mX6tvgnlLw4dKpM1Hfbc7F9
         xoc513hVk8ibGeRR0QdByLLGqR1kPGaZ3iDU/OPRD9HogDg77WodSsgN55BkGhwRtKD+
         vTua92ADICjsfWcoONJZu4v/jR6MJVgIoJ6oyxyj6EoOb9Fmhm+PwdaVUoflk2tM8Qn4
         qAJQ==
X-Gm-Message-State: AMCzsaWHE5VOSNWDO2t4cNR1QA26ZjN2ijYSefT30+apk/tnpj3UtvNN
        5++qHNu0XnE3s9D64M4ixXvTXg==
X-Google-Smtp-Source: ABhQp+R0Z5MWsIm3XS6rgoZfyCPPyzIwBhlcY9nKXw0kU1GmbiNMg8q89RgGnD3s0TOfYqLVGzeJsg==
X-Received: by 10.98.220.29 with SMTP id t29mr129191pfg.25.1509410029102;
        Mon, 30 Oct 2017 17:33:49 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id r24sm191503pfj.106.2017.10.30.17.33.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:33:48 -0700 (PDT)
Date:   Mon, 30 Oct 2017 17:33:39 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Jeff King <peff@peff.net>
cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
        t.gummerer@gmail.com, l.s.r@web.de, jsorianopastor@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
In-Reply-To: <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.10.1710301727160.10801@alexmv-linux>
References: <20171018142725.10948-1-benpeart@microsoft.com> <20171024144544.7544-1-benpeart@microsoft.com> <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com> <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Oct 2017, Jeff King wrote:
> On Mon, Oct 30, 2017 at 08:48:48AM -0400, Ben Peart wrote:
> 
> > Any updates or thoughts on this one?  While the patch has become quite
> > trivial, it does results in a savings of 5%-15% in index load time.
> 
> I like the general direction of avoiding the check during each read.

Same -- the savings here are well worth it, IMHO.

> > I thought the compromise of having this test only run when DEBUG is defined
> > should limit it to developer builds (hopefully everyone developing on git is
> > running DEBUG builds :)).  Since the test is trying to detect buggy code
> > when writing the index, I thought that was the right time to test/catch any
> > issues.
> 
> I certainly don't build with DEBUG. It traditionally hasn't done
> anything useful. But I'm also not convinced that this is a likely way to
> find bugs in the first place, so I'm OK missing out on it.

I also don't compile with DEBUG -- there's no documentation that
mentions it, and I don't think I'd considered going poking for what
was `#ifdef`d.  I think it'd be reasonable to provide some
configure-time setting that adds `CFLAGS="-ggdb3 -O0 -DDEBUG"` or
similar, but that seems possibly moot for this particular change (see
below).

> But what we probably _do_ need is to make sure that "git fsck" would
> detect such an out-of-order index. So that developers and users alike
> can diagnose suspected problems.

Agree -- that seems like a better home for this logic.

> > I am working on other, more substantial savings for index load times
> > (stay tuned) but this seemed like a small simple way to help speed
> > things up.

I'm interested to hear more about what direction you're looking in here.
 - Alex
