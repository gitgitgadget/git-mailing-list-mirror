Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA1C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692A65096
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 02:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCDCFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhCDCF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 21:05:28 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55104C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 18:04:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v16so15480580pgl.23
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 18:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DtE2BjtY/23dot2MatBxR7iUIFXPZOS/HLkl1zMXLEU=;
        b=TYh5DJ/Dwmplc20wECZH3P7I3pRDUC0FWpzZ3mjw9CRy5PwfRSMVflMTMAx5roJX+T
         zLLoCLblKr2WimeYI1+DE1ZbSscbv2n1kGYtBY8u4P5OL2YfWYDu/zqGuc0SZ8yqM8He
         adm1MMQEXfv5DSaZl+ndS3afCjh/AV7XH0jhvxDZ5khbWQqj45uyJi/8b7K1qgjZICXO
         gSIlDYdeHkY//D0hs3JULLMpkzEH6HK69ZFQJDYLIcXx0zIlNbEBNtqDZ5lEy4RufrlL
         zvqjsd3nGzjW7rb6iFX/BJo3558h5EPYUhL3Y24xr86CyrUyy0iYijRZd2FLQdVguWWT
         9qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DtE2BjtY/23dot2MatBxR7iUIFXPZOS/HLkl1zMXLEU=;
        b=a6jfBHttQTxiPHQ0uWXb+9mttLF6d1PhqJSWNB4b1a6FjUInAyyyf+tYfXt32Zo1Xz
         AWJshD68xFhp46RHRKMs1v5+0/6BgY9yXKSuNlwTnxgeSzupvQvjyLvHmssjrZinb9Gz
         /P5QfJ+M5ZNMVnzOX/s6e3auZMm0k97tg9CKlkudVy6qeNdmxBT6ZnraFMx8cmvnGIH4
         ke0SgUf/N3pyeiWRgRaNfu/sORhnBVGqliAAsPJcl9AhQUBqhx+FfdiqqHuMro9KfFBf
         QG8INx5wmwJRrU+DRY8zT4dxcCLBsMVSJKUNEWMcIz5z0LJFJ2FUmVhKKycVXnMR6PdU
         vTMA==
X-Gm-Message-State: AOAM531HSvkeNaDbjwQqWbJnUTMLeAdOge2H0+dCLn1iUI+IEmzGUpsh
        OsOQfxwdnSXJhjfaKBevwlSNAabAs8rlmbIXS5ht
X-Google-Smtp-Source: ABdhPJwK+1iA6Sq12pdr3GtPj16cv/0hcaGwI3exsZ/+8XlHFrU61erQ+eFS9dApbMTB0FqylO8pI1r8AHlm//g1Yj9S
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:888b:0:b029:1ec:df4a:4da2 with
 SMTP id z11-20020aa7888b0000b02901ecdf4a4da2mr1682357pfe.66.1614823486809;
 Wed, 03 Mar 2021 18:04:46 -0800 (PST)
Date:   Wed,  3 Mar 2021 18:04:44 -0800
In-Reply-To: <YD+rlaYGylVSkg1D@nand.local>
Message-Id: <20210304020444.1803406-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YD+rlaYGylVSkg1D@nand.local>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v2 15/15] pack-revindex: write multi-pack reverse indexes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Mar 02, 2021 at 10:40:33AM -0800, Jonathan Tan wrote:
> > > @@ -1018,6 +1080,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> > >
> > >  	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
> > >  	free_chunkfile(cf);
> > > +
> > > +	if (flags & MIDX_WRITE_REV_INDEX)
> > > +		ctx.pack_order = midx_pack_order(&ctx);
> > > +
> > > +	if (flags & MIDX_WRITE_REV_INDEX)
> > > +		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> > > +	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> > > +
> > >  	commit_lock_file(&lk);
> > >
> > >  cleanup:
> >
> > Any reason why we're using 2 separate "if" statements?
> 
> Yeah. This first if statement will turn into:
> 
>   if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
> 
> so that the pack order is computed in either case (since both the
> existing write_midx_reverse_index() and the eventual write_midx_bitmap()
> will be able to use the pack order).

Ah, OK. That's what I was thinking of, but nice to have confirmation.
Maybe write in the commit message that these are separated because in
the future, one of the conditions will change.
