Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E7E2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdBWXtA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:00 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35751 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f50.google.com with SMTP id b129so2725053pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8uCejwKXUpDggvgM+VNAU6j15u2h4GopmWjUSiLz1mY=;
        b=TS0roEAODhuMC0gopLNFe0jdGDEFRejHi7+38bvf1EWGszxvrTR0iu5a3w2xo0kvgE
         eVg4Ykm8Q20rOKL7H13jz5FLF/t5J6md9WPK6EPVNIrSD4TuKtw7ZBiG0W0ok0Vl28BB
         QT35PjeyTyitemqN+uVx4aDH3oNwjqCWZz/gC7xT+Zy8iaN9d4kUGm+hp4NpNP6FtviD
         Aod1+rM+F6OfS50GJCzBdxzIod1CCOrKMqGA2ZiwWBEa+EEHmgRU3N0JhEbgu8nn6EGY
         wH9+IlQLAllh88cxsXjBmOZHN2t/9xib3LuGk9dtmcXlrIGqtKyeL0oOs4aVozlToE9B
         i4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8uCejwKXUpDggvgM+VNAU6j15u2h4GopmWjUSiLz1mY=;
        b=SsU4/PjqhkFIUi4xoxsZ5AT39CUc/0EdGMXQDzhaPz0FmEt+svGVdA8RG2CLXgB3mA
         ABCeF78efUvMEo1Q+/u80g+WKdMbIvUcQlV99jfLTYqGcdrIs1eaSugSrjRqgJqG7fU2
         YKGei+Us7ORXnr0HFtcw+ZOFe8NP8dWK/KrPasnnWJ2XuSxnH8WM8yxOY9t0x50BEX76
         v4crhxBdWhQnsw7br3lqaGP0m3g2bxZQ1QVzOCqjTdFdpnoOE4fKcOc2XXZkDIuTTbZp
         A4ZUlWKqpIXjfz4tnFDg4e+R8T5Yv34kXr5dWytqQY4Ft06O+Ll0dJIySzd/dhkoeZPV
         lwag==
X-Gm-Message-State: AMke39l3RiyCFE0tsavvce/lnUzAEzOLQqH1eP/TQaBqhmkGYKcHuP9tJqlHeB3cz/X6ucG1
X-Received: by 10.98.150.70 with SMTP id c67mr49278754pfe.84.1487893667768;
        Thu, 23 Feb 2017 15:47:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/10] submodule add: respect submodule.active
Date:   Thu, 23 Feb 2017 15:47:24 -0800
Message-Id: <20170223234728.164111-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submodule.active is configured, in addition to adding
submodule."<name>".url to the config, add the path of the added
submodule if it isn't already covered by the current config values.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh               | 11 +++++++++++
 t/t7413-submodule-is-active.sh | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index e5b9a8920..4633a4336 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -271,6 +271,17 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+
+	if git config --get submodule.active >/dev/null
+	then
+		# If the submodule being adding isn't already covered by the
+		# current configured pathspec, add the submodule's path to
+		# 'submodule.active'
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			git config --add submodule.active "$sm_path"
+		fi
+	fi
 }
 
 #
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 683487020..8a519163b 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -60,4 +60,26 @@ test_expect_success 'is-active works with exclusions in submodule.active config'
 	git -C super config --unset-all submodule.active
 '
 
+test_expect_success 'is-active and submodule add' '
+	test_when_finished "rm -rf super2" &&
+	git init super2 &&
+	test_commit -C super2 initial &&
+	git -C super2 config --add submodule.active "sub*" &&
+
+	cat >expect <<-\EOF &&
+	sub*
+	EOF
+	git -C super2 submodule add ../sub sub1 &&
+	git -C super2 config --get-all submodule.active >actual &&
+	test_cmp actual expect &&
+
+	cat >expect <<-\EOF &&
+	sub*
+	mod
+	EOF
+	git -C super2 submodule add ../sub mod &&
+	git -C super2 config --get-all submodule.active >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.11.0.483.g087da7b7c-goog

