Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC90EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 19:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGJThV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJThT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 15:37:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796949E
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:18 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b7233e594eso1084506fac.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689017837; x=1691609837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvFBhf8O5wtxdf+GbxftJGicZNCKW2qY4PsJ/Bq0vhY=;
        b=YUpT+s0tW2SlfI9wIHWotBNd2ibsQaELH2S8eFGvxcA2LEndysa1ANYCMR8PdZO6HH
         FQG5US0CWMHTTP7X4I/dWnfO7TUXmQpgzBbr7eMd1+dCMBXSfN6rLrnN+WYuo8Uu516d
         H06gTxQN9QevASM8LjOPRo4LEF+8LtPmtJzllQ+z8zZ0sTYYptL4cOeob7ILsL4WLJIF
         VWQrqYyQf8SkfPhf5oRprAFBxUJlzsAi3ivaS5TJg2irvt3R6DHp0tA2bD2akbOJkToO
         dDWTciqWuATyq9p8Bvj9hQR7KbTfGLT3RfIu1Zl876edon8j8a7VcnNQnliMgX+ulBo9
         pB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017837; x=1691609837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvFBhf8O5wtxdf+GbxftJGicZNCKW2qY4PsJ/Bq0vhY=;
        b=BoeDb5yIxQuWeSL+CmjtGRP0lIVuwjanSpGRJl6M2FS/WI1YEh0olG+LlyAs98/6IJ
         nZIdlpKxGx9G6qPycw06f9bGdg2NiG+YmREYqm4ntawDNdSFqHAwmn5oAKpKrE6qu8bs
         EPXZQ4YyGr19Ni0RTaIPhTAUbV5mj7O31G14X39o+8+dmtEdVRZxnUgM3FNgYMCHgj29
         EOItgEd9gfnyEf0DwkWd/T0e49dNS8nAFLxb64Ho4eSq4OPhkHu16rtnms3iyt/xMQTa
         7gOOuKrI7E+6JQOEkXWgktg57ITBj2CQXRBxO6H1qnERIZEkQ/3gi2QtBJ1gQyMCusjV
         8oSA==
X-Gm-Message-State: ABy/qLaiP7E+Afuu6jG8negts/ugIrGFU9NLGBPMlNO/i3lwC6UrBgqc
        pakTjDqFe0yWtQuQ41Fpr6MoRrhZVipG2WA9CMiwmA==
X-Google-Smtp-Source: APBJJlF/8v5e3YIRF8XYH0pRrAARk2Dz0szmdzbZVs3oj9SgMtOTqu6rCJzNtFbvroROY4I/xC7Cxg==
X-Received: by 2002:a05:6870:f148:b0:1b4:4935:653f with SMTP id l8-20020a056870f14800b001b44935653fmr11602536oac.49.1689017837117;
        Mon, 10 Jul 2023 12:37:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v145-20020a814897000000b0057a8de72338sm139265ywa.68.2023.07.10.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:37:16 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:37:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 1/2] builtin/repack.c: only repack `.pack`s that exist
Message-ID: <f14a88f1075093c870cd1d53b4e0cea10d5ab67d.1689017830.git.me@ttaylorr.com>
References: <cover.1689017830.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689017830.git.me@ttaylorr.com>
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
 t/t7700-repack.sh | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

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
index af79266c58..284954791d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -213,16 +213,16 @@ test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
 		cd keep-pack &&
-		# avoid producing difference packs to delta/base choices
+		# avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
 		P4=$(commit_and_pack 4) &&
-		ls .git/objects/pack/*.pack >old-counts &&
+		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
 		test_line_count = 4 old-counts &&
 		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
-		ls .git/objects/pack/*.pack >new-counts &&
+		find .git/objects/pack -name "*.pack" -type f | sort >new-counts &&
 		grep -q $P1 new-counts &&
 		grep -q $P4 new-counts &&
 		test_line_count = 3 new-counts &&
@@ -239,14 +239,51 @@ test_expect_success 'repack --keep-pack' '
 			mv "$from" "$to" || return 1
 		done &&
 
+		# A .idx file without a .pack should not stop us from
+		# repacking what we can.
+		touch .git/objects/pack/pack-does-not-exist.idx &&
+
+		find .git/objects/pack -name "*.pack" -type f | sort >packs.before &&
 		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
+		find .git/objects/pack -name "*.pack" -type f | sort >packs.after &&
 
-		ls .git/objects/pack/*.pack >newer-counts &&
-		test_cmp new-counts newer-counts &&
+		test_cmp packs.before packs.after &&
 		git fsck
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
+		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
+		test_line_count = 4 old-counts &&
+
+		# Remove one .pack file
+		rm .git/objects/pack/$P2 &&
+
+		find .git/objects/pack -name "*.pack" -type f |
+			sort >before-pack-dir &&
+
+		test_must_fail git fsck &&
+		test_must_fail git repack --cruft -d 2>err &&
+		grep "bad object" err &&
+
+		# Before failing, the repack did not modify the
+		# pack directory.
+		find .git/objects/pack -name "*.pack" -type f |
+			sort >after-pack-dir &&
+		test_cmp before-pack-dir after-pack-dir
+	)
+'
+
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
 	rm -f bare.git/objects/pack/*.bitmap &&
-- 
2.41.0.320.gb3d0d9308ef

