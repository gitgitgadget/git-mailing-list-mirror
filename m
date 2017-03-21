Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072132095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757466AbdCUNBJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36642 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757172AbdCUNAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so2780083wmf.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1Ac9DVjihJIURv1JCfXWVZysULtWwTCuWv2S/luDgU=;
        b=JApdOA9+w1zMX17wnBN5gbXBpB+xieUx92QhUT/rBerY+3rSL4psh7JpV5dGNaXbtz
         V0sVh2GVzvXl+/u4HsBZf9V/mW7Gyahbcy5n+UnxhXdQ6lpyZ8PPiw0LOAdtin64XHNL
         ljTlvOYiODKSPggwfJ3fI195UYB9M8nx2pzAmdrcMOyFeMBCLhCR7xj/kthAo5+lCDsB
         paC98Pc0Sj/aJzIyhG68JlLVEOfMS98vp2KJ/jY1zMjxCK71TTxZbUdH8delr2c8lLFk
         bZFr8Il0vCy/XJrWOjdByqwfNxwAFRpXWvlKDPdiX9rZD8OsHLwY0CXRlcwXv85FujyX
         GeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1Ac9DVjihJIURv1JCfXWVZysULtWwTCuWv2S/luDgU=;
        b=md0+hRkbrgN5lVopQRJ7v5loqlZk5LPp9Qz/dfWgAT7xp9hvNi/IrsIK7nYFXQzipL
         SCAXWQyiyEovl+vJI5WFmspPn30waYf0mLBWZntT1VwuiZdHr6slii4QGNUYCQGzl+bi
         QCGM7m5VEwPF6cGArLjUOTn6X22d/xweX0mvLgjb1bz0qKA+tj9L1DXBsDkE0VQk8Zns
         2j0qshMgIAjjZhnMTAM7ve99BHZWjwm6/ErsG0Q3aXFnsvLFtqWbcqIbUpdFEYQTaEcj
         tivActZAnblpfPVAuX1fBh4Fi7XfA52fTqHtn4qkE2i80OJwNXXdmpoMAZn8a4AXaVpt
         0qbQ==
X-Gm-Message-State: AFeK/H21/Hoyqo3L+Y3IFVBzsPqfvkcdywZCvl1VKxjAv66FnSmiWNlTjtsu89cqEYOwzg==
X-Received: by 10.28.36.84 with SMTP id k81mr2633496wmk.114.1490101238809;
        Tue, 21 Mar 2017 06:00:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/16] tag: implicitly supply --list given another list-like option
Date:   Tue, 21 Mar 2017 12:58:56 +0000
Message-Id: <20170321125901.10652-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "tag" command to implicitly turn on its --list mode when
provided with a list-like option such as --contains, --points-at etc.

This is for consistency with how "branch" works. When "branch" is
given a list-like option, such as --contains, it implicitly provides
--list. Before this change "tag" would error out on those sorts of
invocations. I.e. while both of these worked for "branch":

    git branch --contains v2.8.0 <pattern>
    git branch --list --contains v2.8.0 <pattern>

Only the latter form worked for "tag":

    git tag --contains v2.8.0 '*rc*'
    git tag --list --contains v2.8.0 '*rc*'

Now "tag", like "branch", will implicitly supply --list when a
list-like option is provided, and no other conflicting non-list
options (such as -d) are present on the command-line.

Spelunking through the history via:

    git log --reverse -p -G'only allowed with' -- '*builtin*tag*c'

Reveals that there was no good reason for not allowing this in the
first place. The --contains option added in 32c35cfb1e ("git-tag: Add
--contains option", 2009-01-26) made this an error,. All the other
subsequent list-like options that were added copied its pattern of
making this usage an error.

The only tests that break as a result of this change are tests that
were explicitly checking that this "branch-like" usage wasn't
permitted. Change those failing tests to check that this invocation
mode is permitted, add extra tests for the list-like options we
weren't testing, and tests to ensure that e.g. we don't toggle the
list mode in the presence of other conflicting non-list options.

With this change errors messages such as "--contains option is only
allowed with -l" don't make sense anymore, since options like
--contain turn on -l. Instead we error out when list-like options such
as --contain are used in conjunction with conflicting options such as
-d or -v.

This change does not consider "-n" a list-like option, even though
that might be logical. Permitting it would allow:

    git tag -n 100

As a synonym for:

    git tag -n --list 100

Which, while not technically ambiguous as the option must already be
provided as -n<num> rather than -n <num>, would be confusing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt |  8 ++++++--
 builtin/tag.c             | 17 +++++++++++------
 t/t7004-tag.sh            | 39 +++++++++++++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d534c57156..b9dffc4128 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -96,6 +96,10 @@ OPTIONS
 Running "git tag" without arguments also lists all tags. The pattern
 is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
 patterns may be given; if any of them matches, the tag is shown.
++
+This option is implicitly supplied if any other list-like option such
+as `--contains` is provided. See the documentation for each of those
+options for details.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
@@ -124,7 +128,7 @@ This option is only applicable when listing tags without annotation lines.
 
 --contains [<commit>]::
 	Only list tags which contain the specified commit (HEAD if not
-	specified).
+	specified). Implies `--list`.
 
 --merged [<commit>]::
 	Only list tags whose commits are reachable from the specified
@@ -135,7 +139,7 @@ This option is only applicable when listing tags without annotation lines.
 	commit (`HEAD` if not specified), incompatible with `--merged`.
 
 --points-at <object>::
-	Only list tags of the given object.
+	Only list tags of the given object. Implies `--list`.
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..ec987ae3c7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -454,8 +454,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
 
-	if (argc == 0 && !cmdmode)
-		cmdmode = 'l';
+	if (!cmdmode) {
+		if (argc == 0)
+			cmdmode = 'l';
+		else if (filter.with_commit ||
+			 filter.points_at.nr || filter.merge_commit)
+			cmdmode = 'l';
+	}
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -485,13 +490,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		return ret;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed with -l."));
+		die(_("-n option is only allowed in list mode"));
 	if (filter.with_commit)
-		die(_("--contains option is only allowed with -l."));
+		die(_("--contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed with -l."));
+		die(_("--points-at option is only allowed in list mode"));
 	if (filter.merge_commit)
-		die(_("--merged and --no-merged option are only allowed with -l"));
+		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
 	if (cmdmode == 'v') {
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1de7185be0..dd793e43aa 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1472,6 +1472,11 @@ test_expect_success 'checking that initial commit is in all tags' "
 	test_cmp expected actual
 "
 
+test_expect_success 'checking that --contains can be used in non-list mode' '
+	git tag --contains $hash1 v* >actual &&
+	test_cmp expected actual
+'
+
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
@@ -1491,6 +1496,7 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
 	test_must_fail git tag -n 100 &&
+	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
 	test_must_fail git tag -v -s &&
@@ -1498,10 +1504,25 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag --contains tag-blob
 '
 
+for option in --contains --merged --no-merged --points-at
+do
+	test_expect_success "mixing incompatible modes with $option is forbidden" "
+		test_must_fail git tag -d $option HEAD &&
+		test_must_fail git tag -d $option HEAD some-tag &&
+		test_must_fail git tag -v $option HEAD
+	"
+	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
+		git tag -n $option HEAD HEAD &&
+		git tag $option HEAD HEAD
+	"
+done
+
 # check points-at
 
-test_expect_success '--points-at cannot be used in non-list mode' '
-	test_must_fail git tag --points-at=v4.0 foo
+test_expect_success '--points-at can be used in non-list mode' '
+	echo v4.0 >expect &&
+	git tag --points-at=v4.0 "v*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--points-at finds lightweight tags' '
@@ -1778,8 +1799,13 @@ test_expect_success 'setup --merged test tags' '
 	git tag mergetest-3 HEAD
 '
 
-test_expect_success '--merged cannot be used in non-list mode' '
-	test_must_fail git tag --merged=mergetest-2 foo
+test_expect_success '--merged can be used in non-list mode' '
+	cat >expect <<-\EOF &&
+	mergetest-1
+	mergetest-2
+	EOF
+	git tag --merged=mergetest-2 "mergetest*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--merged is incompatible with --no-merged' '
@@ -1803,6 +1829,11 @@ test_expect_success '--no-merged show unmerged tags' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-merged can be used in non-list mode' '
+	git tag --no-merged=mergetest-2 mergetest-* >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ambiguous branch/tags not marked' '
 	git tag ambiguous &&
 	git branch ambiguous &&
-- 
2.11.0

