Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B413120323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbdCRKeb (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33230 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdCRKeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id g10so12229440wrg.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UE4DQzRE3BSQyVC9gb4uIHAP9hw/RGXkscp6zMxZPhE=;
        b=GP0O62Od57orkz3CxUDLnwn3tk/lGNpSJIJOA9f4Fq5toPAOWZCsqNGOIyp7zkcu/x
         diJUV8hehPp3Y6s5xZbUHqmX9VOGZDmKTk9pHIQ8FwWWGhU2qXrMqO3XSu7pkxRG5K1T
         QA9JZt0mlzr13MXVR5pFAaBykyXG1X4NqPH3564ObLzXm+2ViW4DEtHrAomvvx//0mMh
         zOTcvDFxhC/Ga/su+3F7yccxusHSd6FriTjNBSit65zf4wfTwzRCz8M8p9DUgEzdxcZK
         L/oBRl5gR2gUPghwgQ721ZziYd5wH05pmBTBSNDOlN8E7J6ogc/ls2OOkV3VcMw+E839
         kz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UE4DQzRE3BSQyVC9gb4uIHAP9hw/RGXkscp6zMxZPhE=;
        b=c7EQt51ZWgUYHsLSM+g1NLQ5CQ35oHJGzkpcgCf1QnzKG2YcrdqpNwcIv/Y1QXWoPH
         YU+SOwJ3eZrVmIHMgVVzASU0OAF1OiGWtJN+sYYrggC1EMSTO6MAhFcTrUtfNqe/E+qh
         dZwycU3xvK5s3jdmx21mRMaJDWKkt/LGMElk0V2YkAZb6Y5iM5kanjek6V03OSdCim7U
         N3lDt2eNuC9R6ZVPW6hveq6RFHO08PoHesC3GovN7UM9RWqkdq7fsZCbRsaoI+0ML2H+
         qyJRDDjuYeGbFtC5jNIkNG33tn8lAAlDDTASHnhVvvXef9wMJ6lwOETgtbW0cnG8Df+P
         Rn5Q==
X-Gm-Message-State: AFeK/H2zlzRXVroa55nhyNP6SilJ9f+HYDr17ECZsG4ZPiWPmz2xmORackeS/ngpHgK1yg==
X-Received: by 10.223.129.230 with SMTP id 93mr16520665wra.41.1489833223979;
        Sat, 18 Mar 2017 03:33:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] tag: Implicitly supply --list given the -n option
Date:   Sat, 18 Mar 2017 10:32:53 +0000
Message-Id: <20170318103256.27141-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "tag" command to treat the "-n" invocation as a list-like
option in addition to --contains, --points-at etc.

Most of the work for this was done in my preceding "tag: Implicitly
supply --list given another list-like option", but I've split off this
patch since it's more contentious. Now invocations these invocations
will be synonymous:

    git tag -n 100
    git tag -n --list 100

Whereas before the former would die. This doesn't technically
introduce any more ambiguity than change to the other list-like
options, but it does introduce the possibility for more confusion
since instead of the latter of these dying:

    git tag -n100
    git tag -n 100

It now works entirely differently, i.e. invokes list mode with a
filter for "100".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt |  9 +++++----
 builtin/tag.c             |  2 +-
 t/t7004-tag.sh            | 17 ++++++++++++++++-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 2acd3b6beb..e7793afad1 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -82,10 +82,11 @@ OPTIONS
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
-	are printed when using -l.
-	The default is not to print any annotation lines.
-	If no number is given to `-n`, only the first line is printed.
-	If the tag is not annotated, the commit message is displayed instead.
+	are printed when using -l. Implies `--list`.
++
+The default is not to print any annotation lines.
+If no number is given to `-n`, only the first line is printed.
+If the tag is not annotated, the commit message is displayed instead.
 
 -l::
 --list::
diff --git a/builtin/tag.c b/builtin/tag.c
index 3483636e59..2da28a5ce6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -457,7 +457,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!cmdmode && !create_tag_object) {
 		if (argc == 0)
 			cmdmode = 'l';
-		else if (filter.with_commit || filter.points_at.nr || filter.merge_commit)
+		else if (filter.with_commit || filter.points_at.nr || filter.merge_commit || filter.lines != -1)
 			cmdmode = 'l';
 	}
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 5c94932f0f..ba1ab1f21c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -639,6 +639,11 @@ test_expect_success \
 	git tag -n0 -l tag-one-line >actual &&
 	test_cmp expect actual &&
 
+	git tag -n0 | grep "^tag-one-line" >actual &&
+	test_cmp expect actual &&
+	git tag -n0 tag-one-line >actual &&
+	test_cmp expect actual &&
+
 	echo "tag-one-line    A msg" >expect &&
 	git tag -n1 -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
@@ -652,6 +657,17 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
+	>expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual &&
+
+	git tag -m "A msg" 100 &&
+	echo "100             A msg" >expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
@@ -1495,7 +1511,6 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a -s -m -F &&
 	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
-	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
-- 
2.11.0

