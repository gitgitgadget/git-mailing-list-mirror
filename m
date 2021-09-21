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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138BC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F736120A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhIUPyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhIUPyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:54:03 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2162CC061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:35 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 93so13793780qva.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+L1/DdNSnNxESFw7TIl62MBhX7QU9oj/YRbrq3rh88=;
        b=XkU6GIK6EcAYJAglFH1Nquaz/6b/l6MhYGohVoFA3DvPFVrFl7fAJzX6YcJvFwrBxU
         Lm32a70qumXkKwcJniFybDUsNMzaP55NQOHBcZva/QX/bIurrpS01w3GuunilFWJaThi
         pyBVIl47Lv9twc6iR98f6KcecWE/0Q3mDETdmW610goa5QNODMXtRPumssyghWZs87CD
         z0hGqPJJllNpbTcRB7ULRgycGOLxg+I0vLKtP8yPT14eQUQDOQdw9nL13vDwR6/qTIMC
         4RLMxfBdpFy8eU33JBYxpc8NKnZ7bsxJL/Jfvq1eA9bSl1k46nhXrKGzCitIvBzKCYUH
         EhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+L1/DdNSnNxESFw7TIl62MBhX7QU9oj/YRbrq3rh88=;
        b=h8ct2ObQtcTWoy8EM4evh17QlZEVnwI/tT0/fYcslNloAnVUTudNOQh0Eqyi1sdOaG
         QfEoj3RYcRXDVofiM+W+oZX7Pm53woAQ+WuEEHTYCbjAKUYEikFr6ZKeMaU0/2aCJKIQ
         9axLMHs0+9T10+OLqTejD2qSwiAxEmslccktck6nPRoqW9cV5q8Zfcp8kcwM+6geJAYv
         P+G5D+TAl9nGFRwe0gx+zasQ3BB/I7WIqn+J0LTrubN7yikrWJU/NUViDdccp3U4gLOa
         /p90FO6SC9gg9nWCx5F90h9NVU2lH7EEUcEHMhZzXAZeRwUyokXNlstBtyvYl5fIV8Xu
         lWSA==
X-Gm-Message-State: AOAM530IGIVtwQdpIVogte7/JCiIUjB7dUHvmxJU0x821qQhN0fl9A1C
        rGQaFmLoQygZNjs+1EMUwdHHz6eu8BY=
X-Google-Smtp-Source: ABdhPJzYKfW02OG+Zea4DXkaJaKLNSwZBXghVSrATNc24FCqdgHwo5bBsBdGmqiTThfEWXvzgGR2gQ==
X-Received: by 2002:ad4:468c:: with SMTP id bq12mr31444674qvb.21.1632239554253;
        Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id z9sm4956124qtf.95.2021.09.21.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v4 2/3] send-email: move bash completions to core script
Date:   Tue, 21 Sep 2021 11:51:51 -0400
Message-Id: <20210921155152.4215-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921155152.4215-1-tbperrotta@gmail.com>
References: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
 <20210921155152.4215-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email --git-completion-helper" only prints "format-patch"
flags. Make it print "send-email" flags as well.

Add a completion test for "send-email --validate", a send-email option.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +----
 git-send-email.perl                    | 62 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  3 ++
 3 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc8..1b73a4dcc0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2359,16 +2359,7 @@ _git_send_email ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
-			--compose --confirm= --dry-run --envelope-sender
-			--from --identity
-			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
-			--no-suppress-from --no-thread --quiet --reply-to
-			--signed-off-by-cc --smtp-pass --smtp-server
-			--smtp-server-port --smtp-encryption= --smtp-user
-			--subject --suppress-cc= --suppress-from --thread --to
-			--validate --no-validate
-			$__git_format_patch_extra_options"
+		__gitcomp_builtin send-email "$__git_format_patch_extra_options"
 		return
 		;;
 	esac
diff --git a/git-send-email.perl b/git-send-email.perl
index d1731c1755..7139384f7a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,6 +114,68 @@ sub usage {
 }
 
 sub completion_helper {
+    my @send_email_flags = qw/
+    --8bit-encoding
+    --annotate
+    --batch-size
+    --bcc
+    --cc
+    --cc-cmd
+    --cc-cover
+    --chain-reply-to
+    --compose
+    --compose-encoding
+    --confirm
+    --dry-run
+    --dump-aliases
+    --envelope-sender
+    --force
+    --format-patch
+    --from
+    --identity
+    --in-reply-to
+    --no-annotate
+    --no-bcc
+    --no-cc
+    --no-cc-cover
+    --no-chain-reply-to
+    --no-format-patch
+    --no-signed-off-by-cc
+    --no-smtp-auth
+    --no-suppress-from
+    --no-thread
+    --no-to
+    --no-to-cover
+    --no-validate
+    --no-xmailer
+    --quiet
+    --relogin-delay
+    --reply-to
+    --sendmail-cmd
+    --signed-off-by-cc
+    --smtp-auth
+    --smtp-debug
+    --smtp-domain
+    --smtp-encryption
+    --smtp-pass
+    --smtp-server
+    --smtp-server-option
+    --smtp-server-port
+    --smtp-ssl
+    --smtp-ssl-cert-path
+    --smtp-user
+    --subject
+    --suppress-cc
+    --suppress-from
+    --thread
+    --to
+    --to-cmd
+    --to-cover
+    --transfer-encoding
+    --validate
+    --xmailer
+    /;
+    print "@send_email_flags";
     print Git::command('format-patch', '--git-completion-helper'), "\n";
     exit(0);
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 11573936d5..a4faf64184 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2139,6 +2139,9 @@ test_expect_success PERL 'send-email' '
 	--cover-from-description=Z
 	--cover-letter Z
 	EOF
+	test_completion "git send-email --val" <<-\EOF &&
+	--validate Z
+	EOF
 	test_completion "git send-email ma" "main "
 '
 
-- 
2.33.0

