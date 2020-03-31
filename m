Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49772C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61220784
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZhaxGzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgCaQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:51:03 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:36550 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaQvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 12:51:03 -0400
Received: by mail-pj1-f74.google.com with SMTP id np18so2657731pjb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z4HLXxDjqTh7utDzuszATBeOzdrc4l8O6s7UUrxG4l4=;
        b=MZhaxGzYJNpNnvBc3txHbUhzxPiv7pbhVsKNCOuF2YBLt8J1yjhQr+CUux9oST51tW
         sKl15fD1jMFq8fTHtxOeV8qcC6zmO/IKO890xyA9++5dOA88qgSk3Dv/7Q6WR7D1tn9i
         8GymNTSqUro64na9lRhieXu4NPqEAsDjH5jtSwp0nlzvTCTBKmcuJVKSoyXwWoZ7VZFJ
         IDB83ZOSyh8LSWBcb2kk/NPyBH62A1Ko0Lo3orvPZ/ntoCJwt/F1ezQWihCzWzcChALf
         MUf8a/4e17bAcyrfR2p5zWzubfMeydU20AxQwxNE/vkezKFNXrd9dDDNr6kHQPGOVOvR
         eFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z4HLXxDjqTh7utDzuszATBeOzdrc4l8O6s7UUrxG4l4=;
        b=XzABIG/c4025hez1ydovtAiuzDPT74YCL7V+fF39kIFKq98NboL6AaNE34R0ydQ9lX
         hShjlSLwlgMNT+R07HohxyQ1/EeIQBVcx/qrtKGlRt7mYmvFRKs9nDhmvd2KI6rFshDE
         hmnKL02yu653iKQIIYD+SmCC8oFWonNRPgScfdEmUw4YBN+KMl4LxMPe+3WOSeXCVppW
         DLbKI110vG4VaoQCm25SeLJyCoyyH4kCAHwuib/+nyF410RNg9YtWkvhXEYk8ziiwAEf
         m0MUS+pVE3VAsW06pRSN4KRh/x384WAXLscMRB3+ZDaf5vxc72nZhHtg0Jt7d98pjbII
         wJqA==
X-Gm-Message-State: ANhLgQ01P3Uee1td8OaNLPi/vPXZFmIy5cBO0iaUIe+f3gRibGF86YnQ
        wuMCOD6b55wdtvOGyXVg+J9f1TT2kwAEooaUh3dU
X-Google-Smtp-Source: ADFU+vtS+ZZZHJD7RsjktO84Q4rooZM6vlJU6MFWEjpwePk6GLXo1D6oBZMbh+WKFQ0xGrDaiDo3uK4fffETkgimMAt/
X-Received: by 2002:a63:4d2:: with SMTP id 201mr18151487pge.276.1585673461392;
 Tue, 31 Mar 2020 09:51:01 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:50:58 -0700
In-Reply-To: <b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com>
Message-Id: <20200331165058.53637-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: Re: [PATCH] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This conflicts with [3], so please keep that in mind.
> 
> Maybe [3] should be adjusted to assume this patch, because that change
> is mostly about disabling the batch download when no renames are required.
> As Peff said [2] the full rename detection trigger is "overly broad".
> 
> However, the changed-path Bloom filters are an excellent test for this
> patch, as computing them in a partial clone will trigger downloading all
> blobs without [3].
> 
> [3] https://lore.kernel.org/git/55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com/T/#u
> 
> > [1] https://lore.kernel.org/git/20200128213508.31661-1-jonathantanmy@google.com/
> > [2] https://lore.kernel.org/git/20200130055136.GA2184413@coredump.intra.peff.net/

Thanks for the pointer. Yes, I think that [3] should be adjusted to
assume this patch.

> > +		for (i = 0; i < rename_dst_nr; i++) {
> > +			if (rename_dst[i].pair)
> > +				continue; /* already found exact match */
> > +			add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
> 
> Could this be reversed instead to avoid the "continue"?

Hmm...I prefer the "return early" approach, but can change it if others
prefer to avoid the "continue" here.

> 	if (!rename_dst[i].pair)
> 		add_if_missing(options->repo, &to_fetch, rename_dst[i].two);
> 
> > +		}
> > +		for (i = 0; i < rename_src_nr; i++)
> > +			add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);
> 
> Does this not have the equivalent "rename_src[i].pair" logic for exact
> matches?

Thanks for the catch. There's no "pair" in rename_src[i], but the
equivalent is "if (skip_unmodified &&
diff_unmodified_pair(rename_src[i].p))", which you can see in the "for"
loop later in the function. I've added this.

> > +		if (to_fetch.nr)
> > +			promisor_remote_get_direct(options->repo,
> > +						   to_fetch.oid, to_fetch.nr);
> 
> Perhaps promisor_remote_get_direct() could have the check for
> nr == 0 to exit early instead of putting that upon all the
> callers?

The 2nd param is a pointer to an array, and I think it would be strange
to pass a pointer to a 0-size region of memory anywhere, so I'll leave
it as it is.

> > +test_expect_success 'diff does not fetch anything if inexact rename detection is not needed' '
> > +	test_when_finished "rm -rf server client trace" &&
> > +
> > +	test_create_repo server &&
> > +	echo a >server/a &&
> > +	printf "b\nb\nb\nb\nb\n" >server/b &&
> > +	git -C server add a b &&
> > +	git -C server commit -m x &&
> 
> > +	rm server/b &&
> > +	printf "b\nb\nb\nb\nb\n" >server/c &&
> 
> Would "mv server/b server/c" make it more clear that
> this is an exact rename?

True. Will do.

Thanks for the review.
