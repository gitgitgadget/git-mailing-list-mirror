Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C48C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379286AbiFQAUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiFQAUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:20:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385C63397
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so2575499plg.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0QSefGXXoFrr5BOk+VAbukMNpouQe55+rS3+IlB/5U=;
        b=DvGJpSBX04bd7HA/BwbLRaqnWZsAYoiY2kjfPa0S+8PLlvYsUr+9oFeT3cqTaZjC2X
         u1vr0HbkzpEnvodUJ0ZkU+T6QZxw/fY8m1o3fu1APkWweXIfZVPGUtZeqF9i+r/O6Uk8
         YVj+DnDe8oo3Vz3iJFR8SMbtOuVVNdgq4y2WYZAspSceQP6/8sUi9Yni5WyK4MFxEYd1
         kmoAIwwV+vWT3HwnnAhLQrZsn0Z5S1JpfdGaTg4yFjt+1ESdEO9iFWIpub+WEHWEFW9M
         nDBewEruRxabFe0lsJyryhin5H1ylANE4PH64tD1HF0CsN68HIs3J0HjfA6L0IPvaEd0
         YTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0QSefGXXoFrr5BOk+VAbukMNpouQe55+rS3+IlB/5U=;
        b=Iu/3ruwiefoymy43jgldpW/Y4C4ZzILe9xjRohzQ9C0p40apqIrRRu/5S4Mr4RzgGv
         zTk1QrnzIy67WY8JqNl/mcPqsIA1xxTF+fl1Q1He2OyGzWOx4B5LWzsRKxWXt2xsw9Yf
         uAlzh21tSk4ZO3+OHqw6mdLitPUb4cTXolMvDDrT7Sol3J8oQS5hnT16BYI9ky/RidM/
         TKfcYCOrY8OBjVaIvYZ40rIz4Xki/oVzBYrWyq8lun/DXuloj18YxBuZryWM7EhUrJa4
         CPXHepbfgZ271gLJIX9SbHFM0vp5XZ9PXwvZNQELBbHp/eCB5oJc6k27eEuYYDoHXI0J
         ukag==
X-Gm-Message-State: AJIora8QWVNtrduZU1V5Llual+iocHDpcwgPhWKShKmVC3wdUZ734lo1
        XcEdxuqa5yXVbySoZYX46x6MwN9sZWo=
X-Google-Smtp-Source: AGRyM1u9okhJ9MuJL/wzlvdv2V3CJmOG3CjFxFLAN/OuQu0NlOlCZbIs/jDQgqD1uSmdnpneJGPDKQ==
X-Received: by 2002:a17:903:216:b0:167:921c:6590 with SMTP id r22-20020a170903021600b00167921c6590mr7141673plh.83.1655425242822;
        Thu, 16 Jun 2022 17:20:42 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001663165eb16sm2260623plh.7.2022.06.16.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:20:42 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 4/6] tests: only automatically unset matching values from test_config
Date:   Thu, 16 Jun 2022 17:20:34 -0700
Message-Id: <20220617002036.1577-5-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617002036.1577-1-jacob.keller@gmail.com>
References: <20220617002036.1577-1-jacob.keller@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

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
 t/test-lib-functions.sh | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e518b89bf128..9957eb2e6c30 100644
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
+	fixed=
 	config_dir=
 	while test $# != 0
 	do
@@ -526,6 +529,9 @@ test_unconfig () {
 		--global)
 			global=--global
 			;;
+		--fixed-value)
+			fixed=--fixed-value
+			;;
 		-*)
 			BUG "invalid test_unconfig option: $1"
 			;;
@@ -535,7 +541,20 @@ test_unconfig () {
 		esac
 		shift
 	done
-	git ${config_dir:+-C "$config_dir"} config $global --unset-all "$1"
+
+	case "$#" in
+	1)
+		# Only enable --fixed-value if we have two parameters
+		fixed=
+		;;
+	2)
+		;;
+	*)
+		BUG "test_unconfig requires 1 or 2 positional arguments"
+		;;
+	esac
+
+	git ${config_dir:+-C "$config_dir"} config $global $fixed --unset-all "$1" "$2"
 	config_status=$?
 	case "$config_status" in
 	5) # ok, nothing to unset
@@ -575,7 +594,18 @@ test_config () {
 		esac
 		shift
 	done
-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} $global '$1'" &&
+
+	case "$#" in
+	1)
+		;;
+	2)
+		;;
+	*)
+		BUG "test_config requires 1 or 2 positional arguments"
+		;;
+	esac
+
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value $global '$1' '$2'" &&
 	git ${config_dir:+-C "$config_dir"} config $global "$1" "$2"
 }
 
-- 
2.36.1

