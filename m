Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E731ECAAD8
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH2Viw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiH2Vim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 17:38:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7781B28
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x23so9234808pll.7
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date;
        bh=1n6L7d08RFYkk44tzzGfXzVIq5piqiUIfxM2dcOtShE=;
        b=aSVnW9aqmTi8PiCSOcZx3tHuL3AUrt6bsYunMVpiswKW6XeRtTckbrfAC1W7wdDmEF
         TvdSS9DXlFtiPQ7uiz2iimYmosXvY0blBoUGClXKRYbGLwklj9wP3VnbVimuGOkbtYvu
         OY70UAViNC7uM2KVuWqzOf2kTAMzFKB06ouHRPFo0gJXSl7L03TY5kKZKlQnSWluvcjm
         Kdbc0l4+triV/XZ6uz1rcNNxvMDPuLQ7SActqboynlsCZnGKsauidG3Hn2l/1aholHe0
         ez3VZmAICo8TK/Ks4XvTgcQiRCgKYOUmF7e08EM8Q7ZV782gh4UCqvpzSvOL0N6FB+C7
         fJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date;
        bh=1n6L7d08RFYkk44tzzGfXzVIq5piqiUIfxM2dcOtShE=;
        b=wvoX4b+VrJVpiITg8wnLeWZKdzWxH+/xwsOIKF5pIm799nf7mQZUX0O4aiyt2erzse
         u1QJ9bV9uwAAq9ASefJO7/a2xOHA+UEkcGvWS3aJ+opnHvNP4iGUNVFjw/LDDh5ITMnE
         1Zkf3Smf0gN4dX8SylH0VpTExHWz1pgiRYF0sZ28PHLm0FViETU1Q4Pm3XOn+JzLY6qe
         Y8aCj9f/dlmG7KQELdnnBGmPT1nQAxmuf3W4y7qUhmDmZM+FWHyQPTwzJQOXjtHnnodq
         NoY9y+ATjH9gRDFcmwnMMitHr8xn8reJkbnx9HSXRR3W+9NF2lo/c/LexakRdTiW7JeU
         mQCA==
X-Gm-Message-State: ACgBeo2rm3YdKHyxd4/Z1b+vreSUDZHP9wNnKHN1ZbVwlDF+PoK3BbMO
        u3dj8JUp8wvBY7uoeXnnMAk1bpLIDgQ=
X-Google-Smtp-Source: AA6agR5JhPfJAT8mHIS/A6Qbr+eTWR/vWPLpn2LlBma9cMIRfeLoU9FkcfHtvslwRa4OauV2pFq0sQ==
X-Received: by 2002:a17:902:8ec8:b0:173:12cb:e6c1 with SMTP id x8-20020a1709028ec800b0017312cbe6c1mr18131107plo.64.1661809120753;
        Mon, 29 Aug 2022 14:38:40 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b0017509940418sm631736plg.79.2022.08.29.14.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:38:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/3] format-patch: learn format.forceInBodyFrom configuration variable
Date:   Mon, 29 Aug 2022 14:38:37 -0700
Message-Id: <20220829213837.13849-4-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-621-gd3a800faf0
In-Reply-To: <20220829213837.13849-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
 <20220829213837.13849-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the need to use the "--force-in-body-from" option primarily is
tied to which mailing list the mails go to (and get their From:
address mangled), it is likely that a user who needs to use this
option once to interact with their upstream project needs to use it
for all patches they send out.

Add a configuration variable, suitable for setting in the local
configuration file per repository, for this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/format.txt    |  4 ++++
 Documentation/git-format-patch.txt |  2 ++
 builtin/log.c                      |  4 ++++
 t/t4014-format-patch.sh            | 24 ++++++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index fdbc06a4d2..c7303d8d9f 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -15,6 +15,10 @@ format.from::
 	different.  If set to a non-boolean value, format-patch uses that
 	value instead of your committer identity.  Defaults to false.
 
+format.forceInBodyFrom::
+	Provides the default value for the `--[no-]force-in-body-from`
+	option to format-patch.  Defaults to false.
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7c7f244e57..dfcc7da4c2 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -283,6 +283,8 @@ feeding the result to `git send-email`.
 	the in-body "From:" is added even when the sender and the
 	author have the same name and address, which may help if the
 	mailing list software mangles the sender's identity.
+	Defaults to the value of the `format.forceInBodyFrom`
+	configuration variable.
 
 --add-header=<header>::
 	Add an arbitrary header to the email headers.  This is in addition
diff --git a/builtin/log.c b/builtin/log.c
index 78ccd37bd9..776bc9afdb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1007,6 +1007,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			from = NULL;
 		return 0;
 	}
+	if (!strcmp(var, "format.forceinbodyfrom")) {
+		force_in_body_from = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.notes")) {
 		int b = git_parse_maybe_bool(value);
 		if (b < 0)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 347f7f7f35..ad5c029279 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1413,6 +1413,30 @@ test_expect_success 'with --force-in-body-from, redundant in-body from is kept'
 	test_cmp expect patch.head
 '
 
+test_expect_success 'format.forceInBodyFrom, equivalent to --force-in-body-from' '
+	git -c format.forceInBodyFrom=yes format-patch \
+		-1 --stdout --from="A U Thor <author@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
+	test_cmp expect patch.head
+'
+
+test_expect_success 'format.forceInBodyFrom, equivalent to --force-in-body-from' '
+	git -c format.forceInBodyFrom=yes format-patch --no-force-in-body-from \
+		-1 --stdout --from="A U Thor <author@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success 'in-body headers trigger content encoding' '
 	test_env GIT_AUTHOR_NAME="éxötìc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
-- 
2.37.2-621-gd3a800faf0

