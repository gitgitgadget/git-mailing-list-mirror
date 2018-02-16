Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA2B1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 21:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750787AbeBPV1T (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 16:27:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40150 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPV1R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 16:27:17 -0500
Received: by mail-wr0-f196.google.com with SMTP id o76so4188477wrb.7
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MNx+B+KLeYOcIo1dluHkYjzt0cmy1LxbpYKzhh1/wh4=;
        b=p7LMOKrKD4bkh84Ky5uO1EG4V1FmgQj1NrC53xgmRnAXxi4rTzrS8UVUCPPjfgc/B8
         VV+QQCSqMNWWta6QqRXeA+AKXl/b5jMa8Wb3l3CO3PoHUZ7tc51L0jxJDoG7c/KnJAB6
         oZ95GHPls689WiAa/sekuZ2mZ2eHwaqKqc2sGTJMy+j4mjtxb1/iyQuoroqmVzd+zjY2
         kzQsGrV6xs2zk2VXeZjdfzYT/cLSGs0mT6JJU1AkqwwcsJYzTy5kn2I29Tphc/uM+SCx
         puqthy23/amhUX/+GBf3IYlykJYa+4VF78Fe90g0Aa1JL7+nl4boq0gEwSr4CU5nm9ny
         zKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MNx+B+KLeYOcIo1dluHkYjzt0cmy1LxbpYKzhh1/wh4=;
        b=t6u/cWPDZHGYwoq9xNzz8fH8SkmY8cyQQDij1RplCU7A2bJpcZr6MoqS6Qb3OfYtTh
         R59vP0YABz4NnNuCwtWPwKkx00ACLGzPFFpzn+7LwG9EKAvKJblJ81Ta1VlvyQQEtXvH
         EHW34jJScmixPVaK8R3jSxAF+4xp02Jui02uG5LtMYmWIHWRqeRs2W3P/lv3hN2C1Jx7
         b+mUHUSNVa3w+XQuQtbTYJ4rGnVwR5UtaZ1sLsDgPk8RKJi9/NEnmhHM+Kd6FYPLd7cE
         ag+tAr8vqh5t7eCKBKMxgZJN1xS0q1lN2snlVCy2ygEoVsGJ5oOV8lpe7FSVAH5VoMWT
         aGDw==
X-Gm-Message-State: APf1xPC69m/2G4NFLZe66sqpo8ogG0ZYeyG9/JbvOy6uCy3q5jUOwuKg
        68CrWK7HC5c6LDdMKnMMXUNAXgZ6
X-Google-Smtp-Source: AH8x227TxXI4WllvXBflPHANHRQ0qTM4k8bs2JCt/EkD+XfXXsRAjTc4Do4ac2zYQMPoiBmttH82rQ==
X-Received: by 10.223.138.132 with SMTP id y4mr6275328wry.242.1518816435458;
        Fri, 16 Feb 2018 13:27:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v23sm17351059wmv.8.2018.02.16.13.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 13:27:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] merge: allow fast-forward when merging a tracked tag
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
        <xmqqy3jt7ty8.fsf_-_@gitster-ct.c.googlers.com>
        <CAPig+cSJKDH=_-hGZLpZUjC4WEyjMRAd2VPgo-Vd+sHpa4jQ-Q@mail.gmail.com>
        <xmqqa7w87qsn.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Feb 2018 13:27:12 -0800
In-Reply-To: <xmqqa7w87qsn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Feb 2018 10:06:16 -0800")
Message-ID: <xmqq7erc62xb.fsf_-_@gitster-ct.c.googlers.com>
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

 * As "git pull linus v4.16-rc1" does not create refs/tags/v4.16-rc1
   during fetch, and there is no way to mechanically tell the
   invocation from "git pull davem for-linus" which does not create
   refs/tags/for-linus, the new default that fast-forwards would
   kick in only when "git fetch linus" followed by possibly other
   other work and concluded with "git merge v4.16-rc1".  So we still
   need the "education" part to ensure that downstream does not make
   pointless merges with "git pull --ff-only".  

   With or without this patch, the other condition that disables the
   "when merging a tag, do not allow fast-forward" default is
   "unless --ff-only is given".  We may want to rethink it.  For
   example, shouldn't "git pull --ff linus v4.16-rc1" enough clue
   that the user _knows_ that the signature in that release tag will
   be lost if the current branch has no original development and
   explicitly _accepts_ fast-forwarding behaviour?  When the current
   branch may or may not have original development, having to say
   "pull --ff-only" while catching up to the upstream and accepting
   50% chance of seeing it fail (when we do have some original
   development hence the update does not fast-forward) smells like a
   clunky interface.

 Documentation/merge-options.txt |  3 ++-
 builtin/merge.c                 | 43 +++++++++++++++++++++++++++++++++++++----
 t/t6200-fmt-merge-msg.sh        |  2 +-
 t/t7600-merge.sh                | 38 +++++++++++++++++++++++++++++++++++-
 4 files changed, 79 insertions(+), 7 deletions(-)

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
index 30264cfd7c..532522a854 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "tag.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1125,6 +1126,43 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static int merging_a_throwaway_tag(struct commit *commit)
+{
+	char *tag_ref;
+	struct object_id oid;
+	int is_throwaway_tag = 0;
+
+	/* Are we merging a tag? */
+	if (!merge_remote_util(commit) ||
+	    !merge_remote_util(commit)->obj ||
+	    merge_remote_util(commit)->obj->type != OBJ_TAG)
+		return is_throwaway_tag;
+
+	/*
+	 * Now we know we are merging a tag object.  Are we downstream
+	 * and following the tags from upstream?  If so, we must have
+	 * the tag object pointed at by "refs/tags/$T" where $T is the
+	 * tagname recorded in the tag object.  We want to allow such
+	 * a "just to catch up" merge to fast-forward.
+	 *
+	 * Otherwise, we are playing an integrator's role, making a
+	 * merge with a throw-away tag from a contributor with
+	 * something like "git pull $contributor $signed_tag".
+	 * We want to forbid such a merge from fast-forwarding
+	 * by default; otherwise we would not keep the signature
+	 * anywhere.
+	 */
+	tag_ref = xstrfmt("refs/tags/%s",
+			  ((struct tag *)merge_remote_util(commit)->obj)->tag);
+	if (!read_ref(tag_ref, &oid) &&
+	    !oidcmp(&oid, &merge_remote_util(commit)->obj->oid))
+		is_throwaway_tag = 0;
+	else
+		is_throwaway_tag = 1;
+	free(tag_ref);
+	return is_throwaway_tag;
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	struct object_id result_tree, stash, head_oid;
@@ -1322,10 +1360,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
2.16.2-246-ga4ee44448f


