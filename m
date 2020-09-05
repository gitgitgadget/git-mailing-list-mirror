Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B8CC433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D252086A
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fM66DB15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIERid (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgIERid (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 13:38:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344FC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 10:38:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so9390903qkb.10
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WvfN5Pezs1HL2d59+Kiait7hVhKdIW3OaCUgUf5iQgc=;
        b=fM66DB15rniuwCj1qOBmC+E8ulOUtwxp5VysS+Lo5Qy32rpvZIl5fJnUhsPA1U6S+Z
         v0nLdpFzfJiyq+F0GOJIRvTuDSYMPP/WrBNTUUpAeNdKFc0bC26JthNiJejJcA6JMCx3
         JVvXZ6sQFiBjmeKrIGgG3TtGuAypDJoktZnLP1zwXl68813KR5KvwnTOBcgd8i/cbsuY
         fFC239Q4gjtliOldG1Q5MMy+lkP5toZ1pliiKzVHhR8CMzD2r7Ic3JfByp4H7g/fAQsw
         TnNbN7Y49myP7LT8RwX3TOvfUGvuTKiYGJitzfN7574y5tq7PFzfS7jXAdPxAwRq2/Yw
         N8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WvfN5Pezs1HL2d59+Kiait7hVhKdIW3OaCUgUf5iQgc=;
        b=Xadz0RzggfNH7l4OBB7B+0KV//Rz/gpBEb4oMHAUmuhWXPUNwTLveXBVx2mRNKUADn
         8t0o4oqHvCxp/GOUkyGSSNWw7el4rTbhzER/4MWQcnkaLhw4Qm3RBUBRKpND7f42Mp9c
         uO4j44pYdGSfSJ985utvzB8FkbjJX5327TtHpXFz/SEeOgQxEXknZ7pQ/yK0fX44nEKH
         DacsQXkzFneDHBYQG9sqSqaYlVB17LosS0h3ncVDFhACoNrm3b+qD2RFRWG7ToSqcVYR
         KB9BNx2Y4jLxJIFoyBTo0UejntHS4hP315P4cEtyZviujGH5JIbuH5YXk+OzrEZtnWDQ
         BMdA==
X-Gm-Message-State: AOAM530s/puqB+/NPUHccPY5PBox0uiZ5p2K7tWrqltQLHABjxANR1zS
        eUUBeSDNX1frELC8maxlRZxH12uTtJcBZ4x7
X-Google-Smtp-Source: ABdhPJxvvbJXMJkfw/8QhKjVb5lKDstXoqiDQh+CX0L2X8LuBzWQxKCxEzzI19pNWnWJqj1Q4y+IlA==
X-Received: by 2002:a05:620a:21d9:: with SMTP id h25mr13184531qka.477.1599327508800;
        Sat, 05 Sep 2020 10:38:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f423:2c6a:683a:2c57])
        by smtp.gmail.com with ESMTPSA id v185sm7386048qki.26.2020.09.05.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:38:28 -0700 (PDT)
Date:   Sat, 5 Sep 2020 13:38:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
Message-ID: <20200905173825.GA6820@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
 <85h7sc9m0v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85h7sc9m0v.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 05, 2020 at 07:22:08PM +0200, Jakub Narębski wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> How do you distinguish between no changed paths stored because there
> were no changes (which should not count as *_found_large), and no
> changed paths stored because there were too many changes?  If I remember
> it correctly in current implemetation both are represented as
> zero-length filter (no changed paths could have been represented as all
> zeros filter, too many changed paths could have been represented as all
> ones filter).

Right, once we get handed back a filter from
'get_or_compute_bloom_filter()', we can't distinguish between (a) a
commit with too many changes to store in a single Bloom filter, and (b)
a commit with no changes at all.

It's unfortunate that callers can't pick between the two, but this
implementation is actually an improvement on the status-quo! Why?
Because right now we'll see an "empty" Bloom filter and recompute it
because it's "missing", only to discover that it has no changes.

With this patch, we'll say "this filter looks too large", and stop
computing it, because we have already gone through the effort to compute
it once (and marked it in the BFXL chunk).

Now, you could certainly argue that 'BFXL' could be called 'BFWC'
("Bloom filter was computed"), and then the "was this filter too large"
check means that the commit was (a) marked in a BFWC chunk, and (b) has
length zero. I'm not necessarily opposed, but I think that this is
probably not worth it, since we're trying to disambiguate something that
is inherently ambiguous. (That is, even with this new check, a
length-zero would still be thought to be "too large", since it was
computed, and has length 0).

> No changes to store in filter can happen not only with `--allow-empty`
> (e.g. via interactive rebase), but also with merge where all changes
> came from the second parent -- we are storing only changes to first
> parent, if I remember it correctly.

Agreed. And yes, Bloom filters store changes only to their commit's
first parent.

> This is a minor issue, though.

Thanks for raising it. I don't think that this is a show-stopper for
this series.

Thanks,
Taylor
