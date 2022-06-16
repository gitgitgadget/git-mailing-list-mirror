Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378680AbiFPUzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378498AbiFPUzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:55:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C95FF06
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 31so2264654pgv.11
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXhA/QhnHWrmWmO3vOyANQgmRjJh+L05ssX8VX3Gwuw=;
        b=XjZHBBKiDKWu9wcE+M/PtcxV6AJpj6uZdFVP2nu76AXDL6poqvv51xDj2CgmgCbW0q
         fDKfIyWDqn1303PzfJucWVmkH5oM8EFQxpCVxvBmQf3bR6V+cPrUK7uq7/nnQ9+KZCed
         gcyEg4SkRKJJAzfcsS5yiE30yrXzpwg17+DyeW8HGCRWXcwempUHYlVitnQybbjJsCZw
         ySJyLb4zmP9H1kqIMf2iMJNLWg0DtvF38G4ZLlwNWaZh410x2XsIaASkNjArHkjkLI2f
         0wfDykcePGwjmKqykjSCAKMskqMogaZ5VY+3xwy17nNe+eGf8PrHtufAB8r3c6hgWa8A
         VhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXhA/QhnHWrmWmO3vOyANQgmRjJh+L05ssX8VX3Gwuw=;
        b=YMEiTN+tH0NnN755LyO9Gn6O8pK8USRwjzf3Lm3At7uDkUl12P0b6eR5XN8e9t5jvL
         nJpNYwNr01xbAQXjkJJoPl/8ucJutDTkE8RMuN/X3t0n8b8WDrktm+whxL8Wv5w786xr
         xXNTD2uxVU/mAuOvQivj3Xzy+6w2dx/2qRiUtZTcc8TAoHDftt3tKe73a9OONyHhAvPr
         TeDlrkgbrPFaMBTD4kwW7MKIScRv5R1hUL3Qq68N+RvxAUS/G/MvbVi4oQHWpYjG+sFQ
         tGxutJHZZidXOCexPYi/1TnTyVOtnThSSL1AZJRHzTZavOFTglZHutt5Tzm1Ts5yWOUb
         RzFg==
X-Gm-Message-State: AJIora95G4LD2KTMU0K4KvQCfCsaYu7N2qaTxpdPG0As4exBSoHdn3v7
        Qu4PYUUhR6fhcLq0ZRWcPN3RZDxRNzk=
X-Google-Smtp-Source: AGRyM1sOf68XIQJv7h217AJuyjYafAaibFhusYhOC/A0eVIglMRaKqu+TfncUYm9XctNceUf//+6gA==
X-Received: by 2002:a05:6a00:16c6:b0:522:7ed2:4ff0 with SMTP id l6-20020a056a0016c600b005227ed24ff0mr6558905pfc.9.1655412898745;
        Thu, 16 Jun 2022 13:54:58 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id j4-20020aa783c4000000b0051b9e224623sm2249165pfn.141.2022.06.16.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:54:58 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
X-Google-Original-From: Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 3/5] tests: only automatically unset matching values from test_config
Date:   Thu, 16 Jun 2022 13:54:54 -0700
Message-Id: <20220616205456.19081-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616205456.19081-1-jacob.e.keller@intel.com>
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_config function is used to set a configuration value and then
ensure that its unset at the end of the test using test_unconfig. This
currently unsets all configurations with the specified name regardless
of whether they match a value.

The git config command can optionally only unset keys which have
specific values. Add support for this by using the 2 argument form, and
add handling for the --fixed-value option.

Pass --fixed-value and both the key and value to the test_unconfig call
from test_config. This ensures that test_config will only setup a
trigger to remove the matching values instead of removing all
configurations of the specified key.

Directly using test_unconfig will still unset all values by default,
unless a 2nd value-pattern parameter is provided. This matches the
behavior of git config and allows some control over the behavior.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 t/test-lib-functions.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2e160aa61233..0057b42988a4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -506,15 +506,18 @@ test_modebits () {
 			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
 }
 
-# Usage: test_unconfig [options] <name>
+# Usage: test_unconfig [options] <name> <value-pattern>
 #   -C <dir>:
 #	Run all git commits in directory <dir>
 #   --global:
 #	Modify the global configuration instead of repository.
+#   --fixed-value:
+#	Match the value pattern as a fixed string instead of a regex.
 #
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
 	global=
+	fixedvalue=
 	config_dir=
 	while test $# != 0
 	do
@@ -526,6 +529,9 @@ test_unconfig () {
 		--global)
 			global=yes
 			;;
+		--fixed-value)
+			fixedvalue=yes
+			;;
 		-*)
 			BUG "invalid test_unconfig option: $1"
 			;;
@@ -535,7 +541,12 @@ test_unconfig () {
 		esac
 		shift
 	done
-	git ${config_dir:+-C "$config_dir"} config ${global:+--global} --unset-all "$1"
+	# Only enable --fixed-value if we have two parameters
+	if test $# < 2
+	then
+		fixedvalue=
+	fi
+	git ${config_dir:+-C "$config_dir"} config ${global:+--global} ${fixedvalue:+--fixed-value} --unset-all "$1" "$2"
 	config_status=$?
 	case "$config_status" in
 	5) # ok, nothing to unset
@@ -575,7 +586,7 @@ test_config () {
 		esac
 		shift
 	done
-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${global:+--global} '$1'" &&
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value ${global:+--global} '$1' '$2'" &&
 	git ${config_dir:+-C "$config_dir"} config ${global:+--global} "$1" "$2"
 }
 
-- 
2.36.1

