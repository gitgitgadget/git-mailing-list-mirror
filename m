Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9462095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757468AbdCUNBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33408 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757195AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so2788868wma.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLyBgozTSAqyiAqIgShmJsbuxvo8j2cFi8cqdraT4lg=;
        b=Upzb1IO5FkAwcO0Isjq7sROdkiTVFE9u5PbclvMjB5Q/4+27qzyW0A2EeH5rD//zqx
         T4YrP0SAtcprO66BYrg24/j3w7RN/edwrIAEoHRb1rr5+rixFOBuk5j0q7OO7BU74OW+
         K2kTuScJxnoLcr6n273+m2Mij1Am+GBk1FBNoxOEArGenEU7FnXV3eW0G4jjFK9BeEzw
         i7BCL3xnSw0Z7segd6zU4JkwG31kE8cEDHPpG7dIV8fl/uiBOlEMG6yE7psxg2WINsu8
         o155nj0k0P9P78Eg0ur3ZAeXST9cx6JlYVbMSJyEuUKNwLPckZHTEEDCbRliFXPw+tcQ
         9HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLyBgozTSAqyiAqIgShmJsbuxvo8j2cFi8cqdraT4lg=;
        b=eLXJ/z9Q6503V3jx4bpFqdjXOARiWI/PBWE181k5kJgSrp0aKQhjHLAYFEjpwNQZWL
         b/BxSUMa87kg1Q7qsVGbOtia/nylT9SOY4rTGpMnjmTc4CR/JkY92gMAPCNAcKvOtzAj
         SjVLHJRUL50b+yRQtq+zQVM05ZoOJpBI/jetrwlabM1UQDE9M+vLeAmD20uQ9SIdy+2R
         6DVLUBMQQw3L/jIcHsEI1DnTSebCpZK9FCJePJDpPrGQ2HANCcAS0af3firoVVMUlkfy
         KsLAcBVsDGwbzn95VG5epCngnsrYadqqrFht52hXWBMRskPO7RajCnPu/ZIPQJw29MZL
         ZfJg==
X-Gm-Message-State: AFeK/H3N2hKSmSQyCSfr6o316fIYz3vU5TgFw4nExcQXBLn5rQijeEDnBLSuvg5kCI8rzg==
X-Received: by 10.28.135.149 with SMTP id j143mr2648076wmd.19.1490101243589;
        Tue, 21 Mar 2017 06:00:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:42 -0700 (PDT)
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
Subject: [PATCH v2 12/16] tag: change --point-at to default to HEAD
Date:   Tue, 21 Mar 2017 12:58:57 +0000
Message-Id: <20170321125901.10652-13-avarab@gmail.com>
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

Change the --points-at option to default to HEAD for consistency with
its siblings --contains, --merged etc. which default to
HEAD. Previously we'd get:

    $ git tag --points-at 2>&1 | head -n 1
    error: option `points-at' requires a value

This changes behavior added in commit ae7706b9ac (tag: add --points-at
list option, 2012-02-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 3 ++-
 builtin/tag.c             | 3 ++-
 t/t7004-tag.sh            | 9 ++++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b9dffc4128..baf96944ae 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -139,7 +139,8 @@ This option is only applicable when listing tags without annotation lines.
 	commit (`HEAD` if not specified), incompatible with `--merged`.
 
 --points-at <object>::
-	Only list tags of the given object. Implies `--list`.
+	Only list tags of the given object (HEAD if not
+	specified). Implies `--list`.
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin/tag.c b/builtin/tag.c
index ec987ae3c7..dde05beb31 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -431,7 +431,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
-			N_("print only tags of the object"), 0, parse_opt_object_name
+			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_object_name, (intptr_t) "HEAD"
 		},
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index dd793e43aa..b45ea8f5ac 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1513,7 +1513,8 @@ do
 	"
 	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
 		git tag -n $option HEAD HEAD &&
-		git tag $option HEAD HEAD
+		git tag $option HEAD HEAD &&
+		git tag $option
 	"
 done
 
@@ -1525,6 +1526,12 @@ test_expect_success '--points-at can be used in non-list mode' '
 	test_cmp expect actual
 '
 
+test_expect_success '--points-at is a synonym for --points-at HEAD' '
+	echo v4.0 >expect &&
+	git tag --points-at >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--points-at finds lightweight tags' '
 	echo v4.0 >expect &&
 	git tag --points-at v4.0 >actual &&
-- 
2.11.0

