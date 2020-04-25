Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B7DC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 23:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BDD206BF
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 23:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSjWwoh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYX56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYX55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 19:57:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E2C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 16:57:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so200725ljg.12
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lyEZHvm7hIIGPz+F1xZE54dZisKu5eEJRv0WE6jIFQ=;
        b=NSjWwoh9lesSuklBaUUiVbFWT6wfIkXsg3EELWfvuwQpZ/lFxkzGmtIgDjbPlGXBTQ
         g8IcmJn6kWY7NM1ZECzXhHn1NNDOiWHkT8b/0PepEx/4Bo2F4PfDFRgR4tDeoNzSGHOY
         Jt4FOs+JjA0a53sqU8Y3nSM4NK5gX/7asWRsukkayrELWJ7uJcBUdr79h3Vt/vspBcv4
         p8J6Bz+Z9wf2dC+k3m3alvlB/jdaFkORy2Dcr5OGrAychK7Z8qOBa55eoRDA933CLR5W
         jZgGsGsvbZFTQCSW1WBhTXgnZ0U9/nW5PMne0jRgkfCO7o5+ChjBG/YV83fxVekzugCp
         VE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lyEZHvm7hIIGPz+F1xZE54dZisKu5eEJRv0WE6jIFQ=;
        b=hXoVgCJo643+wtwETCRpHjH62I/7DLij0q0t5/IrGZTunk8u2oF5fW6fDqMXJq0hWL
         8FyzeXMVzfNt1NXQEr1IDxR1Pr48Wq0VYzvOvyKjG97+C7EYlzTaR/3gN92D/8K0Pujo
         qpz0cHvaWd9Ls8W914ep1/xke8YgT0pYN88g0oNZFTJObNqXvEr6z1xBPew/gvyg6FhY
         z7rEvWlO7adhcCSnuTyClEA23a+A7HFtyYlWQU5KofPGlOG5eYqb0JnMPY2YiCLYjnr9
         eL5u6ZMCeBsu1btIE3JLZlS9tHO67P44hzjayRADrQF5xDCC9Q5YPiH7BCe2B1uEx7BO
         6BhA==
X-Gm-Message-State: AGi0PuY1DnPPA81cuc3RKFvhY5yAywI5sERjebK2QkJGaJG3oHh8IYYg
        A3PXnai7yvY3D9XotlAXMy0HDai8yj1wIQ==
X-Google-Smtp-Source: APiQypLLEYnsNQ46AWuW4hXMv8O5BEEcOtWDJpXGC8FVPwKH+n6AZSiHgY9urhCpGUyqVzD3DQwZSw==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr10179254ljf.233.1587859074089;
        Sat, 25 Apr 2020 16:57:54 -0700 (PDT)
Received: from leopardus.tobiasz.memleak.pl ([2a02:a31a:a043:8cf0:ca8:e44f:8895:44f4])
        by smtp.gmail.com with ESMTPSA id 16sm7099123ljr.55.2020.04.25.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 16:57:53 -0700 (PDT)
From:   =?UTF-8?q?Mateusz=20Nowoty=C5=84ski?= <maxmati4@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, mattr94@gmail.com, bwilliams.eng@gmail.com,
        =?UTF-8?q?Mateusz=20Nowoty=C5=84ski?= <maxmati4@gmail.com>
Subject: [PATCH] config: use GIT_CONFIG in git config sequence
Date:   Sun, 26 Apr 2020 01:57:16 +0200
Message-Id: <20200425235716.1822560-1-maxmati4@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there is no way to use config file other then ~/.gitconfig.
This can cause a problem, for example, when running tests of software that
depends on git. In such a case user's gitconfig may contain settings that
are incompatible with tests.

This commit expands existing GIT_CONFIG environment variable, that is
currently used only by git config, that it is used also in other commands.
When it is set it's the only config file that's being used.

Signed-off-by: Mateusz Nowotyński <maxmati4@gmail.com>
---
 Documentation/git.txt |  4 ++++
 config.c              |  3 +++
 t/t0007-git-var.sh    | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d6769e95a..c92411b8d9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -882,6 +882,10 @@ standard output.
 	adequate and support for it is likely to be removed in the
 	foreseeable future (along with the variable).
 
+GIT_CONFIG::
+	Take the configuration from the given file instead of using typical
+	resolve mechanism.
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/config.c b/config.c
index d17d2bd9dc..811b4e2186 100644
--- a/config.c
+++ b/config.c
@@ -1754,6 +1754,7 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	const char* env_config = getenv(CONFIG_ENVIRONMENT);
 
 	if (opts->respect_includes) {
 		inc.fn = fn;
@@ -1776,6 +1777,8 @@ int config_with_options(config_fn_t fn, void *data,
 		return git_config_from_file(fn, config_source->file, data);
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
+	else if (env_config)
+		return git_config_from_file(fn, env_config, data);
 
 	return do_git_config_sequence(opts, fn, data);
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 1f600e2cae..74ed80f5ca 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -46,4 +46,24 @@ test_expect_success 'listing and asking for variables are exclusive' '
 	test_must_fail git var -l GIT_COMMITTER_IDENT
 '
 
+
+cat > config_file << EOF
+[ein]
+	bahn = strasse
+EOF
+
+test_expect_success 'respect GIT_CONFIG' '
+	GIT_CONFIG=$(pwd)/config_file git var -l >actual &&
+	echo strasse >expect &&
+	sed -n s/ein\\.bahn=//p <actual >actual.bahn &&
+	test_cmp expect actual.bahn
+'
+
+test_expect_success 'GIT_CONFIG leads to not existsing file' '
+	test_when_finished "sane_unset GIT_CONFIG" &&
+	GIT_CONFIG=$(pwd)/not_existsing_config_file &&
+	export GIT_CONFIG &&
+	test_must_fail git var -l
+'
+
 test_done
-- 
2.24.1

