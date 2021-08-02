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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CAC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD83D60F48
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhHBUvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhHBUvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:51:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8CC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 13:51:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m11so12589855qtx.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6u/BvtDZfZ4t00VRGIHzFhVpSldzI3KpZcgQ6WQtKX8=;
        b=VtMwPSko1gTMNnFMLSDQgckRLdpCgJVxWfPs5qrP2o7+6So0xv945mZcA6sw3Cm5f5
         mxuP7Uy6OT39fgj5ASmSNd8/IkO0GDu5bJ6wc4Z1CuouV6VpfuIokviWvV4F/2TQwogj
         s7m7OSvppuOIPMl8BiIyAPIBD4sF54uThPUVDjfEUaxTd6ThwE/0MXSRyZz9OOizRcOE
         /0moDnPpQVNOmz69v3LJ2xcsJUYSZykX4uCEyDCcEQUSelU/Eu6zenOqawc3FcqezzW6
         oJ3MiXZXJHgTA0kYBwpyAExezRy7EIFtaUZfSgvyqejO4uWgkmvntE3ru0o4TkImmH9b
         jnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6u/BvtDZfZ4t00VRGIHzFhVpSldzI3KpZcgQ6WQtKX8=;
        b=bq86L2+bZxKZg0StR9IlTtJNVG0TbgmtTayulIs2Rk+bsBWzo/x4L4U/8rpJLCiI0Y
         hq5aJ7eNtG8TYUgoghplsduBwL1hub2ihSKU6GTkuM+pSlWJASfKQmT/vWGB8bLUkiwn
         cy+ckmjuPxLzhBnyYMX9lRuo2H5r2jBo8PRPMR+igStO6Ur1IGh+p8GlLPhpYVw1xGIE
         IPizN6kgnvQ5u+sW//jjIBITAxxtczb1QvDD0NQRMIv+icrtwsPL9ssLzW/jqGVuer9l
         kNf8ujbjmPgWxDjwe3Djpmc52EUCscklCq7aMvKCtaK6cYdzwTc3FxOcCmNJLSddV8fn
         2Otg==
X-Gm-Message-State: AOAM532dhBm5Lkq6B58b1YPixfCklQE2hJDt0g7WIMYN15N491Bw74ma
        mVAKm23iSAmZ6ULZUOX/zgqoVcZgi5Q=
X-Google-Smtp-Source: ABdhPJwXMWvTk+O7wjNL+aTI/s2V0LLhuQk79t/loOre2EyzyPxwIRQ7yPWG7AF9dRbglsOWJ5tKNQ==
X-Received: by 2002:ac8:584c:: with SMTP id h12mr15892384qth.95.1627937485750;
        Mon, 02 Aug 2021 13:51:25 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm6539073qkh.39.2021.08.02.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:51:25 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH 2/3] Move bash git-send-email completions to original script.
Date:   Mon,  2 Aug 2021 16:49:52 -0400
Message-Id: <20210802204953.229867-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802204953.229867-1-tbperrotta@gmail.com>
References: <20210802204953.229867-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as bash-completion is concerned, this refactoring is a no-op.

However, this improves `git send-email --git-completion-helper`, which
was previously printing only `git format-patch` flags, to print
send-email specific flags as well.

Add a completion test for --validate which is a send-email specific
option.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +--------
 git-send-email.perl                    | 34 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  |  3 +++
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27d..1b73a4d 100644
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
index e991bf3..eec78d7 100755
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
index 1157393..a4faf64 100755
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
2.32.0

