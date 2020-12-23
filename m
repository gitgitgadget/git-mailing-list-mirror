Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90CC43333
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4942256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgLWBjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgLWBjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECAC0611C5
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so16956726wrv.8
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUrXl2XJbdqyOwY08CmNy7Ii29MN9dy5DXV9S7otN3c=;
        b=nMcU1H2LVP+JoQDLgBedd1YAThnYS0CWoKOgBWYmMM6CbSw7ckSb51ouOP3JCVhmyE
         8VIhPu2Glhsmf7D+7rSD7yEtOEmpJwCCWhOyDNL41zfdLDRH27yx+iOsoFeN7UuILBdq
         tzjiCN7FdXjiMGCDiK9zs1319u1lf+ksP7ivud/NByCgAYoFSkT8oPFmoG5bkSv7Wzpo
         jKxEP3jP6MwsEHiBDb86aF5X2W4H6L4/Fpd7NCDtkRdsYBJsH2Tv2lBPS89TUQvnEdui
         cAeT7cjcNKviWbUu1ODXJqetRJ9ZPSftPBECQlKAJTkxbPWFR5cXvj7ohGxmRJJKseMG
         tT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUrXl2XJbdqyOwY08CmNy7Ii29MN9dy5DXV9S7otN3c=;
        b=pnZrfFAQwE3jqC7fVKhwF0NlgjorCyfHriQOtVGs716NO6rYxzzSWmELsqj5Z8eqfs
         o+/AbVaEN6xZKTgj505MpVThVpguLdT3ZczPMBvV6rSLUuleTk1ccG8LpJ3NitCztLBK
         RSNEC82cnl7szqalTNiVSIFn2JhNjiYmbMJY9ykZH7JedW412mjWeVxgnY3e042awMSR
         yOPRB0qyrFRXn14AXOdkM7yHaxRw9xmgk9Sl6wzGHca6CYDQZp/bNTp9IH1ZZ1R3U0ln
         Zza56zqYqu/XNTMkL/HAuWnQjqR4I2wBb1YWrNl6eUZqKnarIlTHChXkYgZHs4u2/HOC
         M4Mg==
X-Gm-Message-State: AOAM5327TAkmDmFcNJbrCBVt5HyLm5ZUX8ZUStW7Yi364F1+so5gdWX6
        gwvUzTvgcKkoxArT5hxZevLqOMF681cs/A==
X-Google-Smtp-Source: ABdhPJyoxvmggfLsna3pihhqtYwS8ertJDPhFKGGiCzFQ9Iw9v0SQ8MkGEqt9yxO0HiXvIhFNIzI6w==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr16742643wre.408.1608687471367;
        Tue, 22 Dec 2020 17:37:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/20] mktag tests: stress test whitespace handling
Date:   Wed, 23 Dec 2020 02:35:54 +0100
Message-Id: <20201223013606.7972-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for various whitespace edge cases around the header/body
boundary, such as two newlines separating the header and body, a space
at the end of the "tagger" line before the header etc.

Add a test showing that we insist that an empty body must be preceded
by an empty line. This test for a long-standing regression which goes
against the command's documented behavior. It'll be addressed in a
follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index b6dcdbebe6..f339321be8 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -372,6 +372,54 @@ EOF
 check_verify_failure 'detect invalid header entry' \
 	'^error: char.*: trailing garbage in tag header$'
 
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
+
+this line comes after an extra newline
+EOF
+
+test_expect_success 'allow extra newlines at start of body' '
+	git mktag <tag.sig
+'
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
+EOF
+
+test_expect_success 'allow extra newlines at end of headers' '
+	git mktag <tag.sig
+'
+
+space=' '
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500$space
+
+EOF
+
+check_verify_failure 'extra whitespace at end of headers' \
+	'^error: char.*: malformed tag timezone$'
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+EOF
+
+check_verify_failure 'disallow no header / body newline separator' \
+	'^error: char.*: trailing garbage in tag header$'
+
 ############################################################
 # 24. create valid tag
 
-- 
2.29.2.222.g5d2a92d10f8

