Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14882EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGKRck (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGKRci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:32:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838C9F
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:36 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57a551ce7e9so65511587b3.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689096756; x=1691688756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGrq2rGgnKGGIEKKKR44fjlWWS9cRPBI3L170bSGAG0=;
        b=kOJh4nchxrK45OhTkDNT+vVFxewJRa2nkYwlx8Z7iomYBmiQFDlz8//kvLGngPmcz9
         cpUZOm4UrbmalP+URH2vL+HzbyhbcsHFnhvO/hV6Os05cB57VDIZ+w5/IUFdXF/2o5to
         BxstNhcx8ec5SiX1ldV/HjZPMggukNMYYd51kL1blIiYT6ElfKW7IffgA9bHDns7qSJn
         erDqNeXlb0kuKNerQMkk/St50al8cyTozuS6YJYlT2BCwXJuKyjZRNAwbpbZQYfNLenv
         tp8iLbUsf+XCoxrcFoO+ham/E3GiepWS7zmTqE6UZ0NszOp1a4BFYUfDexUd+DiHnWox
         klzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096756; x=1691688756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGrq2rGgnKGGIEKKKR44fjlWWS9cRPBI3L170bSGAG0=;
        b=aHh9Bw9KmhkLdRJCO7NgFvpws2Zo0r4zB5bbpVBvqyonpy9+MxR96Ayq8sK+l01Q7H
         KrFUE1rj6H8mFzq42TwkR4XEqzl3ri8sEs81LFE7FwR/uF9J7U2BcyTg0VCMYzxkEfdb
         ppN/0BNdiUs4IQ4QP0z0v0ZRbn2qYCyr5nxAoVQE6QdsAh4Cw2SfoECJuO/heNzqGpUy
         UyVSKiSTLnyncBLvecNvKRyP89/eKbfgAAhEEvr0IHvy1tkONVoy1av8BV/rqEQH3NTI
         fdj6tzGO1kRE64WrP61ZbZjtq9RgH1Y1wcfP48n7ReyEy3D9ouS9V7E6rDDac+e5+FZO
         B9pA==
X-Gm-Message-State: ABy/qLZpJpgogVqBBCrgez9XnInzJ+wRFJAlvVjprek+wYYGOi2c8qFl
        wEFioCHCxmjDyCbRnKnZpBqUyP4isub5ZcIdUDwITg==
X-Google-Smtp-Source: APBJJlHNLi+dfTWztqbmwovojvL6BlZpYbwl8TSHbT2afeLyjgO9Uy0v6NCQNzd5OQZsB6vkqACTcg==
X-Received: by 2002:a81:4e0f:0:b0:577:1533:ea95 with SMTP id c15-20020a814e0f000000b005771533ea95mr16108198ywb.28.1689096755856;
        Tue, 11 Jul 2023 10:32:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q6-20020a0dce06000000b0055a881abfc3sm681362ywd.135.2023.07.11.10.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:32:35 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:32:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] builtin/repack.c: only repack `.pack`s that exist
Message-ID: <410d2f01655266419c583aba085edfb62800f174.1689096750.git.me@ttaylorr.com>
References: <cover.1689017830.git.me@ttaylorr.com>
 <cover.1689096750.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689096750.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In 73320e49add (builtin/repack.c: only collect fully-formed packs,
2023-06-07), we switched the check for which packs to collect by
starting at the .idx files and looking for matching .pack files. This
avoids trying to repack pack-files that have not had their pack-indexes
installed yet.

However, it does cause maintenance to halt if we find the (problematic,
but not insurmountable) case of a .idx file without a corresponding
.pack file. In an environment where packfile maintenance is a critical
function, such a hard stop is costly and requires human intervention to
resolve (by deleting the .idx file).

This was not the case before. We successfully repacked through this
scenario until the recent change to scan for .idx files.

Further, if we are actually in a case where objects are missing, we
detect this at a different point during the reachability walk.

In other cases, Git prepares its list of packfiles by scanning .idx
files and then only adds it to the packfile list if the corresponding
.pack file exists. It even does so without a warning! (See
add_packed_git() in packfile.c for details.)

This case is much less likely to occur than the failures seen before
73320e49add. Packfiles are "installed" by writing the .pack file before
the .idx and that process can be interrupted. Packfiles _should_ be
deleted by deleting the .idx first, followed by the .pack file, but
unlink_pack_path() does not do this: it deletes the .pack _first_,
allowing a window where this process could be interrupted. We leave the
consideration of changing this order as a separate concern. Knowing that
this condition is possible from interrupted Git processes and not other
tools lends some weight that Git should be more flexible around this
scenario.

Add a check to see if the .pack file exists before adding it to the list
for repacking. This will stop a number of maintenance failures seen in
production but fixed by deleting the .idx files.

This brings us closer to the case before 73320e49add in that 'git
repack' will not fail when there is an orphaned .idx file, at least, not
due to the way we scan for packfiles. In the case that the .pack file
was erroneously deleted without copies of its objects in other installed
packfiles, then 'git repack' will fail due to the reachable object walk.

This does resolve the case where automated repacks will no longer be
halted on this case. The tests in t7700 show both these successful
scenarios and the case of failing if the .pack was truly required.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  |  3 +++
 t/t7700-repack.sh | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 51698e3c68..724e09536e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -125,6 +125,9 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		strbuf_add(&buf, e->d_name, len);
 		strbuf_addstr(&buf, ".pack");
 
+		if (!file_exists(mkpath("%s/%s", packdir, buf.buf)))
+			continue;
+
 		for (i = 0; i < extra_keep->nr; i++)
 			if (!fspathcmp(buf.buf, extra_keep->items[i].string))
 				break;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index af79266c58..27b66807cd 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -213,7 +213,7 @@ test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
 		cd keep-pack &&
-		# avoid producing difference packs to delta/base choices
+		# avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
@@ -239,6 +239,10 @@ test_expect_success 'repack --keep-pack' '
 			mv "$from" "$to" || return 1
 		done &&
 
+		# A .idx file without a .pack should not stop us from
+		# repacking what we can.
+		touch .git/objects/pack/pack-does-not-exist.idx &&
+
 		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
 
 		ls .git/objects/pack/*.pack >newer-counts &&
@@ -247,6 +251,36 @@ test_expect_success 'repack --keep-pack' '
 	)
 '
 
+test_expect_success 'repacking fails when missing .pack actually means missing objects' '
+	test_create_repo idx-without-pack &&
+	(
+		cd idx-without-pack &&
+
+		# Avoid producing different packs due to delta/base choices
+		git config pack.window 0 &&
+		P1=$(commit_and_pack 1) &&
+		P2=$(commit_and_pack 2) &&
+		P3=$(commit_and_pack 3) &&
+		P4=$(commit_and_pack 4) &&
+		ls .git/objects/pack/*.pack >old-counts &&
+		test_line_count = 4 old-counts &&
+
+		# Remove one .pack file
+		rm .git/objects/pack/$P2 &&
+
+		ls .git/objects/pack/*.pack >before-pack-dir &&
+
+		test_must_fail git fsck &&
+		test_must_fail git repack --cruft -d 2>err &&
+		grep "bad object" err &&
+
+		# Before failing, the repack did not modify the
+		# pack directory.
+		ls .git/objects/pack/*.pack >after-pack-dir &&
+		test_cmp before-pack-dir after-pack-dir
+	)
+'
+
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
 	rm -f bare.git/objects/pack/*.bitmap &&
-- 
2.41.0.329.gffdf85f6d39

