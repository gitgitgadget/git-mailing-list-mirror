Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65320CD610E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377438AbjJIRUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377410AbjJIRUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:20:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA69E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:20:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4197fa36b6aso27403551cf.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696872033; x=1697476833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTV9b5OG7oiPtmDnD5yK0zD0qd+NcZ/8Yv5cdjYeE9E=;
        b=jrBLmwWvDN0O7eO2FHh3v82oc2vUC55hNI5V9NiQEg+1HfZoceFR5/5cV4U9x88o0G
         LmGD4kkSQmsa8EXUIyeKBF8T8NRdsw9IL/a+tgSi/OMZ0uuIVfeyXkcZppFf3phFxqAT
         UpfOy/ko/N2JUohNdz4P4EtoGypv1nMR6t6ddDqeg6AUdAB0TPjYGIrfQcmYv9ptpsL5
         aMZB2/3bCCpjuobjE3NFw4l87AsoLajl/A08AxRw9UHa84JWOEXvSYR/pvQc+Y4G0zRf
         hnlqW6xysuG2avylyc2iQO9wUuf1YND7+jG/DBfP9AfmSFGMHU46RSCTrQyvGk+bRMbm
         aQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872033; x=1697476833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTV9b5OG7oiPtmDnD5yK0zD0qd+NcZ/8Yv5cdjYeE9E=;
        b=OEyoKv6WCGvJaE4sT9BZB+9HMnAmz3Ly9Oj8EtY7XodO+jmHoGtV1OB1+/g9yQRTtG
         AFpVgT5YyvphJMtRNkWK+hVPxHWaj/qH/1eQaN9UoYB1LOK4fZDPlcFfoUWg9WdoSMZC
         TOW15ZEIhRfAvdZKQhbVgxLll7fpqWt7U9qH1i3lWRDlhueAD3Um2b9h8DjchqiY4SNi
         ZVf95n8bJ1NRjTXtoKymZVngIas8lA0Y3LgGUOhp5ZUvoWXNFAfnxgq19SzWIBkrw3Kh
         RJTgDIys+zFcaLpis6Oejcbb6kJY954jmCp5IKv2R8+CBYso4lKtJkLc0d2b/XFwBtdG
         VnvA==
X-Gm-Message-State: AOJu0Yzk0r9Gu2nEosUignNFJ5SWS11v0p7C0WKYlq7a0ixPQRV5c2DC
        YNOxyL7dIgkab/nHamzeuoTPD+2iP/ivvDEqWtoahg==
X-Google-Smtp-Source: AGHT+IFpRaTV3zj9UviLti8fak01894JXW1Al3hrsq8Or0g76tTO0PIul8dlqNfGP7HQrySIRjobNA==
X-Received: by 2002:ac8:5a88:0:b0:412:2d22:2aab with SMTP id c8-20020ac85a88000000b004122d222aabmr18901491qtc.53.1696872033649;
        Mon, 09 Oct 2023 10:20:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k24-20020ac84758000000b004199f47ccdbsm3819819qtp.51.2023.10.09.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:20:33 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:20:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <ZSQ2XwbTM4DDLfJq@nand.local>
References: <ZQnmTXUO94/Qy8mq@nand.local>
 <20231002225546.409837-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002225546.409837-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2023 at 03:55:46PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/revision.c b/revision.c
> > index 2f4c53ea20..1d36df49e2 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -837,14 +837,24 @@ static int rev_compare_tree(struct rev_info *revs,
> >  static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
> >  {
> >  	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
> > +	int bloom_ret = 1;
> >
> >  	if (!t1)
> >  		return 0;
> >
> > +	if (revs->bloom_keys_nr) {
> > +		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
> > +		if (!bloom_ret)
> > +			return 1;
> > +	}
> > +
> >  	tree_difference = REV_TREE_SAME;
> >  	revs->pruning.flags.has_changes = 0;
> >  	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
> >
> > +	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
> > +		count_bloom_filter_false_positive++;
> > +
> >  	return tree_difference == REV_TREE_SAME;
> >  }
>
> I'll concentrate on getting this patch in, and will look at (and
> discuss) the other Bloom filter-related emails later.

Sounds good. I know that I have some pending mail from SZEDER as well,
so I'll try and apply any feedback from both of you before sending a
reroll so that we can get this all done in one shot.

> This looks good, possibly except a code path in try_to_simplify_commit()
> that calls this rev_same_tree_as_empty() function when
> rev_compare_tree() between a commit and its parent returns REV_TREE_NEW.
> So there are 2 issues: How can rev_compare_tree() ever return
> REV_TREE_NEW? And it doesn't seem right to check Bloom filters in this
> code path, since rev_same_tree_as_empty() was invoked here while we are
> enumerating through a commit's parents, which necessarily implies that
> the commit has parents, but here we're using the Bloom filter as if the
> commit is known to have no parents.

> As for the first issue, rev_compare_tree() returns REV_TREE_NEW when the
> parent's tree is NULL. I'm not sure how this can happen - the tree can
> be NULL if the parent commit is not parsed, but at this point I think
> that it has been parsed. And I think every commit has a tree. This goes
> back all the way to 3a5e860815 (revision: make tree comparison functions
> take commits rather than trees, 2008-11-03) and even beyond that (I
> didn't dig further).

The more I think about this, the more confused I become ;-). I was able
to track this all the way back to Linus's 461cf59f89 (rev-list: stop
when the file disappears, 2006-01-18), but am convinced that both of
these cases (we have an analogous one for when t2 is NULL and we return
REV_TREE_OLD) are dead code.

I replaced the "if (!t1) return REV_TREE_NEW;" with "if (!t1)
BUG("oops")", and was able to get the whole test suite to pass. So... I
am pretty sure that this is dead code, but not sure enough to remove it
myself ;-).

To your point about seeing the tree as NULL before parsing the parent, I
don't think that is the case here, since we parse the parent immediately
before calling rev_compare_tree() (and indeed Git will refuse to read
commit objects which do not list a tree).

> As for the second issue, we can probably solve this by being defensive
> in rev_same_tree_as_empty() by only using the Bloom filter when the
> commit has no parents. Not sure if this is being overly defensive,
> though.

I am also unsure whether we are being overly defensive here or not. But
I agree that it does feel safer to apply something like:

--- 8< ---
diff --git a/revision.c b/revision.c
index 3d78ea6a9a..21b3085465 100644
--- a/revision.c
+++ b/revision.c
@@ -834,7 +834,8 @@ static int rev_compare_tree(struct rev_info *revs,
 	return tree_difference;
 }

-static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
+				  int use_bloom_filter)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
 	int bloom_ret = 1;
@@ -842,7 +843,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 	if (!t1)
 		return 0;

-	if (revs->bloom_keys_nr) {
+	if (use_bloom_filter && revs->bloom_keys_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -892,7 +893,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, 1))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -988,7 +989,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;

 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, 1))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -1069,7 +1070,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)

 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p)) {
+			    rev_same_tree_as_empty(revs, p, 0)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
--- >8 ---

on top.

> There is also the issue that count_bloom_filter_false_positive is
> incremented even when no Bloom filters are present, but I think this is
> fine (it matches the behavior of rev_compare_tree()).

Yep, agreed.

Thanks,
Taylor
