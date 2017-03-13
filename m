Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98DA820373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbdCMVoc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:32 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34090 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754051AbdCMVoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:02 -0400
Received: by mail-pg0-f52.google.com with SMTP id 77so70564094pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3jTfB7/LYVsRfi99Hv9/FJB3vvpDkg7M3d/Uspxw0Ko=;
        b=YUWTZ/a7BFnb/Q2x7PNBSVS0R6b4wKMKpWTpBGh4hXkfzVkG//KXCSzwYxIS7YhNob
         e+gJDQDOslhNvah833q2xWSg34JXbe+gRks/Hvy3kDIr68g669/ovJV5YFqcgvoBN+Kp
         b36+fquOh9BMVASVO5BPUgssMeuY6a48XulP0fGERKaQi8cqhFTIpsWpFfSvwUS1HYgQ
         4N/+DwOI5qbCbKpPyv0VqjZegyuYqwP1WI0x+barJWA/eTKCOjXtZGDx/HAbQS2Wp/P2
         fpM3tefMcwRnpMgmwtQKEc4tLdczw4DGNX6ZfRz0HO29ey3TzmDqFx1VsU0PBrdf4o5B
         irAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3jTfB7/LYVsRfi99Hv9/FJB3vvpDkg7M3d/Uspxw0Ko=;
        b=TXMHgoRdAbaHKWm4k0phU+KW8xeB9byw9ReIBV0aQ6xCA6pEyMl5GycXgGpIpXHe5R
         VBjjWKmz2+riAHd1x0IH51jwTAPY3slWuED3ItviWb/FCcMJ8hn3dmNp5XDFcf6GTj9L
         VF6rHEu2SAMv6MDuO/9rGM4hLKy5ifxBRXe3G0cXS5E+GtekQRzdfVl7UX/rTRx8llR2
         ewnSrDRLWWfRMYEVr9cDKoxeUKy9dCNVaq03ymDnATVAsVeU0pm7uGEQ+QL3jwCpBPcg
         G9xXWtBPffyjQDtjrzXUqNbPdp6uQ0IDQfbxDDgSKhfKyNTAIdC/YBE/J74AX1ivZl4B
         A1UA==
X-Gm-Message-State: AMke39lT6JcyhRaGMlo3A79/+xZnUREZv7gpmALJ96k679QQ4QuSHm99b4XAj2QBYn5H4MO4
X-Received: by 10.84.138.129 with SMTP id 1mr50895812plp.37.1489441440615;
        Mon, 13 Mar 2017 14:44:00 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 10/10] submodule add: respect submodule.active and submodule.<name>.active
Date:   Mon, 13 Mar 2017 14:43:41 -0700
Message-Id: <20170313214341.172676-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to adding submodule.<name>.url to the config, set
submodule.<name>.active to true unless submodule.active is configured
and the submodule's path matches the configured pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh               | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3c7da08aa..2c510038d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -278,6 +278,18 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+
+	if git config --get submodule.active >/dev/null
+	then
+		# If the submodule being adding isn't already covered by the
+		# current configured pathspec, set the submodule's active flag
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			git config --add submodule."$sm_name".active "true"
+		fi
+	else
+		git config --add submodule."$sm_name".active "true"
+	fi
 }
 
 #
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index c41b899ab..865931978 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -15,6 +15,12 @@ test_expect_success 'setup' '
 	test_commit -C super initial &&
 	git -C super submodule add ../sub sub1 &&
 	git -C super submodule add ../sub sub2 &&
+
+	# Remove submodule.<name>.active entries in order to test in an
+	# environment where only URLs are present in the conifg
+	git -C super config --unset submodule.sub1.active &&
+	git -C super config --unset submodule.sub2.active &&
+
 	git -C super commit -a -m "add 2 submodules at sub{1,2}"
 '
 
@@ -83,4 +89,19 @@ test_expect_success 'is-active with submodule.active and submodule.<name>.active
 	git -C super config --unset submodule.sub2.active
 '
 
+test_expect_success 'is-active, submodule.active and submodule add' '
+	test_when_finished "rm -rf super2" &&
+	git init super2 &&
+	test_commit -C super2 initial &&
+	git -C super2 config --add submodule.active "sub*" &&
+
+	# submodule add should only add submodule.<name>.active
+	# to the config if not matched by the pathspec
+	git -C super2 submodule add ../sub sub1 &&
+	test_must_fail git -C super2 config --get submodule.sub1.active &&
+
+	git -C super2 submodule add ../sub mod &&
+	git -C super2 config --get submodule.mod.active
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

