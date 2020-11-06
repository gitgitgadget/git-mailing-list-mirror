Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5025C388F9
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A8206D4
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Msv4KAJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgKFWwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgKFWwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:52:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFCEC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:52:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 64so2319702pfg.9
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T1/7yclLkvAeB9SfN/g4T1BeY11Q1VkpXW4tcYSjwc0=;
        b=Msv4KAJK0StCeoviTIwFApGV441woN7pY1N337CoPmE+W28RVKSd1Un9PYGNFTylP5
         LP4TUcoj2FxQ7fP2bfNrHjCztu6+cgprJWNKmaOs247vCNhd0S3GXFSbqt0oiNeB8HrU
         kVAlVB5SBIx1D50QaIao+FUHChBEwjhiTiSusgJM8BB4DmtUQHC5oui6Ork04MUy89xe
         TAfxOHpNasXtCfZYXTej8sppAWMgvxuR0ynf7xBCkXLtPODMyNXh6x26JpBFzjpWI91b
         fTgOc7yILfm/nmDnwvWcC+fkUjoNglvQKPA9zkU8YsE9GMM8lhZ07e1lhkwmtp4HN2Pv
         LzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T1/7yclLkvAeB9SfN/g4T1BeY11Q1VkpXW4tcYSjwc0=;
        b=IjD9XKTslqFCNps5bELNQg4bFMMjt2AfqanUcYLZJ73gz5tzMRJMOuci8FY1QuShnr
         hIDrGHLSP+ZSN9MuVlB+rZKa4JO8iYKdnv7+Pzpen8zZ0HblmpsU4njWqlel9qgKSvgH
         tt8YCISZT1SmBVd3d7TqQ4o9p5tPSpIG+kRdULT/mbkQYyAjzd/t3lIitg3TUrwGaF6M
         IGTpS/IIG5ri3x00y2/X1F79eM165ziw5fMvVU92vu+4VRyChJwx9WdEzLAvUd6SJsTh
         hAcimq+jq4SyDsBxtMrMD9R5mkjrKHYUBWCsyu8nUbWXnw9jSWQZpuarHUQAPT986m+q
         wqMw==
X-Gm-Message-State: AOAM533P4IiqIXNDRNdfmDB1ClEGjHRl7BikmU4qGrDzCAtQPsRbXHF1
        3vqYuduweoSLQTJEJ3B50N+tj7uZ3kMtlQ+FsU4A
X-Google-Smtp-Source: ABdhPJyTbjgSmSxddxRFBHSRPkNLyILPPJEv0AlwfoFnyEAq/pzqoFi7ovrER9F0QbTfC6qnEHop6caeNW6+Oi30fLfO
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:7bc4:: with SMTP id
 d4mr1939209pjl.48.1604703133960; Fri, 06 Nov 2020 14:52:13 -0800 (PST)
Date:   Fri,  6 Nov 2020 14:52:11 -0800
In-Reply-To: <20201102204344.342633-9-newren@gmail.com>
Message-Id: <20201106225211.772384-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-9-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: Re: [PATCH v2 08/20] merge-ort: compute a few more useful fields for collect_merge_info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +	/*
> +	 * Note: We only label files with df_conflict, not directories.
> +	 * Since directories stay where they are, and files move out of the
> +	 * way to make room for a directory, we don't care if there was a
> +	 * directory/file conflict for a parent directory of the current path.
> +	 */
> +	unsigned df_conflict = (filemask != 0) && (dirmask != 0);

Suppose you have:

 [ours]
  foo/
    bar/
      baz
    quux
 [theirs]
  foo

By "we only label files with df_conflict, not directories", are you
referring to not labelling "foo/" in [ours], or to "bar/", "baz", and
"quux" (so, the files and directories within a directory)? At first I
thought you were referring to the former, but perhaps you are referring
to the latter.

> @@ -161,6 +179,13 @@ static int collect_merge_info_callback(int n,
>  		newinfo.name = p->path;
>  		newinfo.namelen = p->pathlen;
>  		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> +		/*
> +		 * If we did care about parent directories having a D/F
> +		 * conflict, then we'd include
> +		 *    newinfo.df_conflicts |= (mask & ~dirmask);
> +		 * here.  But we don't.  (See comment near setting of local
> +		 * df_conflict variable near the beginning of this function).
> +		 */

I'm not sure how "mask" and "dirmask" contains information about parent
directories. "mask" represents the available entries, and "dirmask"
represents which of them are directories, as far as I know. So we can
notice when something is missing, but I don't see how this distinguishes
between the case that something is missing because it was in a parent
directory that got deleted, vs something is missing because it itself
got deleted.
