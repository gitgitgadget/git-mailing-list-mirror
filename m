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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFDC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35B160FDA
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHTArs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhHTArq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:47:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9EC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:09 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u17so1417142qvn.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNKNlMG3qLykeMLC+/BVa7v0P20io1KL61ECPsatmv8=;
        b=OOvNLCl+tYVKsrrJu5loicM4hcnnnIPiygj0g1/FiY2ze6TMoQE0VvsdJVn4gosBZ8
         j6KcKypy3mguz3ltaPAUs+RJUPosIk9cH7/8j9hxPYADHkTLB8kHBAU2OyaBA288DqmK
         ixjcZIaA0ymkoXVqSpvXo2wmJ6B6FM6MEcYYr9aheKDGjRpERK7KjzWX/N1NX3nItC70
         Xl/S1OssZEzXa0oDd55pF6UyW9Dooaaoykevl1g+rBl8+fpqztWbyiSCPvZVCF6mBMVK
         WyP57+cELZz4X+sLx2GQYQnjOQQqtDU4xQ92oO8M9WOs6XLyz1csy+Y9iVFGOdV6sSkI
         o84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNKNlMG3qLykeMLC+/BVa7v0P20io1KL61ECPsatmv8=;
        b=nYDeSJt6otyJxd6OzrsmZTjpQw8b1ttN34BsBqoyF53odmFNNCsaF1ybQsmy+KlOaW
         /ZIBGQ2w6Wj/01Dbig3eWmqfFpxOMOKVY1sa9IS0X9JCBHb180uRVw3QdFT9Bt9ym6Z4
         GxRh2FkCDOJ4z5d6sFKLplfVMFZm+bunDFlNLhvSTiULPumzICYfMbRMus3rNzPq8wz1
         Cbxvzr9L7IpTmqovwRcDxIiq5Yxr+DX0kUwnHj8s8iE5qmIIGP7UvpTi+N6rntOFNYRi
         5PVqa93d4BY+pMHhpP1vD0TWEapde+CFzfOdz9ueRnog03QrB5TCr11gNCMPL90fobap
         KyUA==
X-Gm-Message-State: AOAM531SHdv9WPGXavdTMppFwCf/hbEpAxU4xlc9eEgWD4eB/P6zfwfw
        FazK8/dX/ePIfIgwXFokJgBZHiUbEFw=
X-Google-Smtp-Source: ABdhPJzy8B3M7vIRXUiN3onF7uTCNNtoKGO3nvhqqYJ7CVrjiaECx+9XPqVg/NdYk+fUmj2co0q7ow==
X-Received: by 2002:a0c:f286:: with SMTP id k6mr17810586qvl.50.1629420428425;
        Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id o12sm2095724qtt.94.2021.08.19.17.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH v2 2/3] send-email: move bash completions to the perl script
Date:   Thu, 19 Aug 2021 20:46:03 -0400
Message-Id: <20210820004604.9948-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820004604.9948-1-tbperrotta@gmail.com>
References: <20210820004604.9948-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as bash-completion is concerned, this refactoring is a no-op.

However, this improves `git send-email --git-completion-helper`, which
was previously printing only `git format-patch` flags, to print
`send-email` specific flags as well.

Add a completion test for `--validate` which is a send-email specific
option.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +--------
 git-send-email.perl                    | 34 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  3 +++
 3 files changed, 38 insertions(+), 10 deletions(-)

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
index e991bf333d..eec78d76c7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,6 +114,40 @@ sub usage {
 }
 
 sub completion_helper {
+    my @send_email_flags = qw/
+    --annotate
+    --bcc
+    --cc
+    --cc-cmd
+    --chain-reply-to
+    --compose
+    --confirm=
+    --dry-run
+    --envelope-sender
+    --from
+    --identity
+    --in-reply-to
+    --no-chain-reply-to
+    --no-signed-off-by-cc
+    --no-suppress-from
+    --no-thread
+    --quiet
+    --reply-to
+    --signed-off-by-cc
+    --smtp-pass
+    --smtp-server
+    --smtp-server-port
+    --smtp-encryption=
+    --smtp-user
+    --subject
+    --suppress-cc=
+    --suppress-from
+    --thread
+    --to
+    --validate
+    --no-validate
+    /;
+    print "@send_email_flags";
     print Git::command('format-patch', '--git-completion-helper');
     print "\n";
     exit(0);
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

