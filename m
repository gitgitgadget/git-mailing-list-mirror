Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0310F1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 22:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756381AbeBOWp4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:45:56 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34799 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756375AbeBOWpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:45:55 -0500
Received: by mail-wr0-f193.google.com with SMTP id m5so1268410wrg.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4shMFmaykSwilP5A1+SEnVEgSAjpuDex5tey9aCrnwI=;
        b=mYTEd17RlkY2NgWkHnosP0q7U3p5v+1/9bc/VpXZCHoI2OJfrJ3EcgYLD4/ir8PZ1l
         iar/xtpmyGocIR6wmibBM1+8KyY7sm4Jk6y3cssxI80zzPDUHwUwU5cjjIIw/+GLH7Zy
         1gxlMBeeLIGV2EGvVAN0VU4OjDaPfoUuuKIpUZQa3iKvaFK5EgzGmZFYBABp0FgGcuwy
         c+vf2Z9FpfSFm+MuX+UNyXhvgCtXBN6FL+5hTbO6o99SCZhJoBzvIpGX7ZbJvyrRea95
         3S4RUAFmyKKZdtl3PG62TxY0RcgpAR1Sdlv7c5HsI4CApu5YBKzmQ0FbEi4cPHUmaIc6
         Ktrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4shMFmaykSwilP5A1+SEnVEgSAjpuDex5tey9aCrnwI=;
        b=uPwcLtkmCclDPATgEWIzhBpd2ppxyTgLZf4yRniPYtTzY60NV9RueKHmI8FUkr2rG5
         SQhoDoNvxY/yY5VU3EVZf8XCZcm9go1E8P3QBJT0Qu9opAuznJoHCSgk8nLiUKqHc4b/
         HrkB9A0EbTcxmzVkasI53xENk+iyXVK0Z/6wk5Epg6DFb/gSIZ1mWxr6uQ3wNAJG4HNB
         HxNZ5SkGpr9ByueuDAKcCSgSaIpBQLryrMO3qSMW/G/9AuCDGD6l/q5eUaK1LcqTFic9
         NWcZ35/aw51pJA5tB3K8OV029XHW6cJT7MCNZ9LYqdc/sDDAs8Wmexo+LYr7Os673jdW
         sa9Q==
X-Gm-Message-State: APf1xPCfaTpDkAn0+4CszouEoqWh7wKiihBKRd/Us85cOZQh4TRm6l7l
        EIhmEgKk8wqGjbSPt+B01QgJQmHz
X-Google-Smtp-Source: AH8x224N/KSD63P47XboDv67IKE6RDrrnqI0/n9swd3lBCrcIn8EROQi2HAL+3KocbDgfBuo6fuYeg==
X-Received: by 10.223.186.144 with SMTP id p16mr4154754wrg.259.1518734753332;
        Thu, 15 Feb 2018 14:45:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9sm2265076wrf.43.2018.02.15.14.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 14:45:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] merge: allow fast-forward when merging a tracked tag
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
        <20180212222157.0a3bd472@vento.lan>
        <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
        <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
        <xmqqfu63o2xv.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Feb 2018 14:45:51 -0800
In-Reply-To: <xmqqfu63o2xv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 14 Feb 2018 10:12:44 -0800")
Message-ID: <xmqqy3jt7ty8.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long time ago at fab47d05 ("merge: force edit and no-ff mode when
merging a tag object", 2011-11-07), "git merge" was made to always
create a merge commit when merging a tag, even when the side branch
being merged is a descendant of the current branch.

This default is good for merges made by upstream maintainers to
integrate work signed by downstream contributors, but will leave
pointless no-ff merges when downstream contributors pull a newer
release tag to make their long-running topic branches catch up with
the upstream.  When there is no local work left on the topic, such a
merge should simply fast-forward to the commit pointed at by the
release tag.

Update the default (again) for "git merge" that merges a tag object
to (1) --no-ff (i.e. create a merge commit even when side branch
fast forwards) if the tag being merged is not at its expected place
in refs/tags/ hierarchy and (2) --ff (i.e. allow fast-forward update
when able) otherwise.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    > There are a few fallouts in the testsuite if we go this route.  I am
    > not quite decided if I like the approach.

    This time with a few tests for the new default, and minimum
    adjustement to the documentation.

 Documentation/merge-options.txt |  3 ++-
 builtin/merge.c                 | 42 +++++++++++++++++++++++++++++++++++++----
 t/t6200-fmt-merge-msg.sh        |  2 +-
 t/t7600-merge.sh                | 38 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 3888c3ff85..63a3fc0954 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -35,7 +35,8 @@ set to `no` at the beginning of them.
 --no-ff::
 	Create a merge commit even when the merge resolves as a
 	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag.
+	annotated (and possibly signed) tag that is not stored in
+	its natural place in 'refs/tags/' hierarchy.
 
 --ff-only::
 	Refuse to merge and exit with a non-zero status unless the
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..45c7916505 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "tag.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1125,6 +1126,42 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static int merging_a_throwaway_tag(struct commit *commit)
+{
+	const char *tag_ref;
+	struct object_id oid;
+
+	/* Are we merging a tag? */
+	if (!merge_remote_util(commit) ||
+	    !merge_remote_util(commit)->obj ||
+	    merge_remote_util(commit)->obj->type != OBJ_TAG)
+		return 0;
+
+	/*
+	 * Now we know we are merging a tag object.  Are we downstream
+	 * and following the tags from upstream?  If so, we must have
+	 * the tag object pointed at by "refs/tags/$T" where $T is the
+	 * tagname recorded in the tag object.  We want to allow such
+	 * a "just to catch up" merge to fast-forward.
+	 */
+	tag_ref = xstrfmt("refs/tags/%s",
+			  ((struct tag *)merge_remote_util(commit)->obj)->tag);
+
+	if (!read_ref(tag_ref, &oid) &&
+	    !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
+		return 0;
+
+	/*
+	 * Otherwise, we are playing an integrator's role, making a
+	 * merge with a throw-away tag from a contributor with
+	 * something like "git pull $contributor $signed_tag".
+	 * We want to forbid such a merge from fast-forwarding
+	 * by default; otherwise we would not keep the signature
+	 * anywhere.
+	 */
+	return 1;
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	struct object_id result_tree, stash, head_oid;
@@ -1322,10 +1359,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&commit->object.oid));
 		setenv(buf.buf, merge_remote_util(commit)->name, 1);
 		strbuf_reset(&buf);
-		if (fast_forward != FF_ONLY &&
-		    merge_remote_util(commit) &&
-		    merge_remote_util(commit)->obj &&
-		    merge_remote_util(commit)->obj->type == OBJ_TAG)
+		if (fast_forward != FF_ONLY && merging_a_throwaway_tag(commit))
 			fast_forward = FF_NO;
 	}
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2e2fb0e957..a54a52aaa4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -512,7 +512,7 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 
 	test_when_finished "git reset --hard" &&
 	annote=$(git rev-parse annote) &&
-	git merge --no-commit $annote &&
+	git merge --no-commit --no-ff $annote &&
 	{
 		cat <<-EOF
 		Merge tag '\''$annote'\''
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index dfde6a675a..6736d8d131 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -700,6 +700,42 @@ test_expect_success 'merge --no-ff --edit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'merge annotated/signed tag w/o tracking' '
+	test_when_finished "rm -rf dst; git tag -d anno1" &&
+	git tag -a -m "anno c1" anno1 c1 &&
+	git init dst &&
+	git rev-parse c1 >dst/expect &&
+	(
+		# c0 fast-forwards to c1 but because this repository
+		# is not a "downstream" whose refs/tags follows along
+		# tag from the "upstream", this pull defaults to --no-ff
+		cd dst &&
+		git pull .. c0 &&
+		git pull .. anno1 &&
+		git rev-parse HEAD^2 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'merge annotated/signed tag w/ tracking' '
+	test_when_finished "rm -rf dst; git tag -d anno1" &&
+	git tag -a -m "anno c1" anno1 c1 &&
+	git init dst &&
+	git rev-parse c1 >dst/expect &&
+	(
+		# c0 fast-forwards to c1 and because this repository
+		# is a "downstream" whose refs/tags follows along
+		# tag from the "upstream", this pull defaults to --ff
+		cd dst &&
+		git remote add origin .. &&
+		git pull origin c0 &&
+		git fetch origin &&
+		git merge anno1 &&
+		git rev-parse HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success GPG 'merge --ff-only tag' '
 	git reset --hard c0 &&
 	git commit --allow-empty -m "A newer commit" &&
@@ -718,7 +754,7 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	git tag -f -s -m "A newer commit" signed &&
 	git reset --hard c0 &&
 
-	EDITOR=false git merge --no-edit signed &&
+	EDITOR=false git merge --no-edit --no-ff signed &&
 	git rev-parse signed^0 >expect &&
 	git rev-parse HEAD^2 >actual &&
 	test_cmp expect actual
-- 
2.16.1-194-gb2e45c695d

