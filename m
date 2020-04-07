Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA20C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763D620747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVWzwymH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgDGOL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39432 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDGOL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so4065686wrt.6
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=yZQKuA7Qt81dHh+4vojOLtWIoYh4Fli4/BHDBYJwKcQ=;
        b=OVWzwymHA7SfNSlN1+19BPQkLV4Q+CRjBuuw6gjZxDrSS06/jG0o59HHa9HHcEFnUP
         KcYG7J/0ccn0ejkUk+HSGI+hq+YFaYyl17Us2J80L+94aMKvdieCs+fgLfbfH39I26uv
         +nU+6e0dq0MlN+/53UfhiSTFKrdGKZZBjw9uHo7RSadutXIOrHi+lTEQYFlymWfK1CNj
         tXiBz0BwLBFEB5/BFZhgnli87ayEmN91TmiwUspPxEjge/z+zw5ohMp1oYEcGL7vfp2O
         0tJlb7pEOWmhoto0YIiYL+wa0/vhR8akoGU8Mtzm5+1Fqp7V2brTAhshoLSYZpppeq9L
         LTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=yZQKuA7Qt81dHh+4vojOLtWIoYh4Fli4/BHDBYJwKcQ=;
        b=VRviQ6aCPB82bSnxya1NBSNPSe4WEykDjLdGtt9DN9IErn9RcZAlfxYJE5tJ7/dLjF
         ypW2uqQ9We5Nmpmxyf5aV9Xogc6qBq8KQhj09IoHZxDszA2aoFI1FQoQxTCXSwT/a0X0
         aTwg9HxUcMnOYYEboLK02t3PIlE8zU/e1csjWdwc/dRhkd3Ccun2ww5LHsfsPtbREzya
         lvOEsTLTCuqL5R2FFdfuGVlMZQDQcqEgKlAXgWtGnCMkfSnSynqQA5qAFvC5SNO7S5u4
         QOUrWTZxBgZ7F5YMuL+nQ9xhX0JRCE1S3B+fvhuU+R7RUTdagAwwZeyDuuVNpFcCuHHV
         cXQA==
X-Gm-Message-State: AGi0PuZAPCvyX9+j/ab7rphjI+xsLaWkk6Ve6c3MqnZk7ggzqOofJzHQ
        NAKvEd4X4bZKGLH3vqcBkwBgJ18l
X-Google-Smtp-Source: APiQypIy4Uk/5eK3ZfPQkWcPP6PmIm3a6sPPY6do/XhrzY3XzUfLt3VNK7yXTBJ8Dac7Wjfs/3DZ2w==
X-Received: by 2002:adf:a347:: with SMTP id d7mr2968993wrb.21.1586268714928;
        Tue, 07 Apr 2020 07:11:54 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:54 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 6/6] t3433: improve coverage
Date:   Tue,  7 Apr 2020 15:11:25 +0100
Message-Id: <20200407141125.30872-7-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add tests to check --ignore-whitespace and --ignore-date are remembered
when running `rebase --continue` and to check
--committer-date-is-author-date with --ignore-date gives the expected
result.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3433-rebase-options-compatibility.sh | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 8247d01442..a13c341301 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -7,6 +7,8 @@ test_description='tests to ensure compatibility between am and interactive backe
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
 export GIT_AUTHOR_DATE
 
@@ -70,6 +72,22 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
 	test_cmp expect file
 '
 
+test_expect_success '--ignore-whitespace is remembered when continuing' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1" &&
+		export FAKE_LINES &&
+		git rebase -i --ignore-whitespace main side
+	) &&
+	git rebase --continue &&
+	test_cmp expect file
+'
+
 test_expect_success '--committer-date-is-author-date works with am backend' '
 	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
 	git rebase --committer-date-is-author-date HEAD^ &&
@@ -135,6 +153,16 @@ test_expect_success '--ignore-date works with interactive backend' '
 	grep "+0000" authortime
 '
 
+test_expect_success '--ignore-date works after conflict resolution' '
+	test_must_fail git rebase --ignore-date -i \
+		--onto commit2^^ commit2^ commit2 &&
+	echo resolved >foo &&
+	git add foo &&
+	git rebase --continue &&
+	git log --pretty=%ai >authortime &&
+	grep +0000 authortime
+'
+
 test_expect_success '--ignore-date works with rebase -r' '
 	git checkout side &&
 	git merge --no-ff commit3 &&
@@ -143,4 +171,31 @@ test_expect_success '--ignore-date works with rebase -r' '
 	! grep -v "+0000" authortime
 '
 
+test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+	test_must_fail git rebase -i --committer-date-is-author-date \
+		--ignore-date --onto commit2^^ commit2^ commit3 &&
+	git checkout --theirs foo &&
+	git add foo &&
+	git rebase --continue &&
+	git log -2 --pretty=%ai >authortime &&
+	git log -2 --pretty=%ci >committertime &&
+	test_cmp authortime committertime &&
+	! grep -v "+0000" authortime
+'
+
+test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
+		git rebase -i --strategy=resolve --ignore-date \
+		--committer-date-is-author-date side side &&
+	git log -1 --pretty=%ai >authortime &&
+	git log -1 --pretty=%ci >committertime &&
+	test_cmp authortime committertime &&
+	grep "+0000" authortime
+ '
+
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
2.26.0

