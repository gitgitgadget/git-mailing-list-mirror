Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0EC4332F
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A8461181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhJFKEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbhJFKE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8B7C061765
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so7061804wrv.9
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NyFKyVnHCqw4XdUcSmJBVzDDnnykS+lfVTAXF54LJQ=;
        b=T2YkS3qhE3D8YXCPL2FvMeeLTHjf8UQQcJTBEvVv+OSViyc1uMG2pPdxyfO0YF3NpF
         TLC4SN8LGvoz4F/8Li43hMD0wTKGL/uu8PvEE2VdbAiWA9iwaserXmykE1g6WyunRnrX
         M2XXrB2y7bb4L7qBRZItI58JUcJSGd5av2uUii5POszmItciLNO+HSF56/2PRH7PwFcP
         T8dHiWIi5cpRK8rv/fDpQIWrJMX1V0T4I3N1Ko1po5CwHgdSDtgzzP0KZ9KFDXqk+iAC
         +83zA1d9qpYiee8KsonjN2y5eY4q+BxFfHNXZpvC24fgXZnjGZryTfd0/86NtVA5FR5T
         n4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NyFKyVnHCqw4XdUcSmJBVzDDnnykS+lfVTAXF54LJQ=;
        b=bML0E1Qlwap2+BkgZKTOZtw+5tVSO15S0psl6crc/GvvpSx3Ux2CsyQaw1XKjapHuw
         5pHdgOGwJasFCGcekiDJw+u9pQgp37jSCNANDliRWisQlXEXBs2ciUkT1oirzmT57Z23
         n1QEFiBXjKN+iejk8uXdSnxAK6URfkotTu3l1ZwU9MlwjJzGnQpxAO7gkiarT3L+se6r
         pJwg4VPFUnaJD7Ymdjc4wUNopVvlGNKA3FmcjHueRDQCryzxrGJQ4hUB2qmtNIM+EhfS
         0LC+Jd/1oxdCy/AylBlOxOLwZW5Kn1sV2uLoMMykG75Z2qwpsV3tP5niUZjc0gkw/11e
         UHFQ==
X-Gm-Message-State: AOAM533Fk1EQlCy8uJmh2Rnn+knBXDF/ljeHTNs+Zu6DAk9p2kHvdT6x
        n343gwjWXhexqs48q52TOuKbj3KsQO7IDw==
X-Google-Smtp-Source: ABdhPJzlzSmwbELN/21tLazxe4MHXztZS5w2NlYsqIZqOYdq1WbgFZsbhy2btNhB9/CQ2MampsN36g==
X-Received: by 2002:adf:bb08:: with SMTP id r8mr18173580wrg.247.1633514550365;
        Wed, 06 Oct 2021 03:02:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] tests: fix a memory leak in test-parse-options.c
Date:   Wed,  6 Oct 2021 12:02:20 +0200
Message-Id: <patch-2.7-c24e115aa49-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-parse-options.c, we were not
freeing the allocated "struct string_list" or its items. While I'm at
it move the declaration of the "list" string_list the
cmd__parse_options() function.

In c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
the "list" variable was added, and later on in
c8ba1639165 (parse-options: add OPT_STRING_LIST helper, 2011-06-09)
the "expect" was added.

The "list" variable was last touched in 2721ce21e43 (use string_list
initializer consistently, 2016-06-13), but it was still left at the
static scope, it's better to move it to the function for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-parse-options.c | 7 ++++++-
 t/t0040-parse-options.sh      | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a282b6ff13e..48d3cf6692d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -14,7 +14,6 @@ static int dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
-static struct string_list list = STRING_LIST_INIT_NODUP;
 
 static struct {
 	int called;
@@ -107,6 +106,8 @@ int cmd__parse_options(int argc, const char **argv)
 		NULL
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
@@ -185,5 +186,9 @@ int cmd__parse_options(int argc, const char **argv)
 	for (i = 0; i < argc; i++)
 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
 
+	expect.strdup_strings = 1;
+	string_list_clear(&expect, 0);
+	string_list_clear(&list, 0);
+
 	return ret;
 }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index da310ed29b1..ed422a1a616 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -5,6 +5,7 @@
 
 test_description='our own option parser'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<\EOF
-- 
2.33.0.1441.gbbcdb4c3c66

