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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE92C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC40F60F45
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhH1DKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 23:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhH1DKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 23:10:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF68C061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk29so9358005qkb.8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Mk11ei7TPXq98lgKi72dVNHzXU52R+xubYtMMaA7GY=;
        b=kJZwpM96maWkn4qPhzAL+g8v3Ev77Ovi1g8iLk6h/7GcczQLVbXt03HWkEKSbK+1gJ
         I3oBDgjLcD28EKziAZDyhPSE1DBJLZth/W2NW0RIPzU6ZAEedVS6VpYMeQe3caTSI3P6
         TVD2kiffBTzl+4hYvFkD2ojwWxiIw47KntJLeaJlaShcuwqt+Ls5Bl4VYrKqcSmPxLb3
         //U7NowgzW9IcI/kHvbNhqIVpzP0tPEj6dbkaS9EtLixsf9d7ETg7ydUD+WZTvGvTORD
         W3vZDhS+Bb3Mzi+6//IMV56IiWLl56lzTIbKqGHPMBJV4VS75pGDpuZv9U3mSQhHZ+cn
         mN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Mk11ei7TPXq98lgKi72dVNHzXU52R+xubYtMMaA7GY=;
        b=RdBCt94CApoeVZ/Ev3wtuoy5mwtqwzidsPlIGOx//8KHmuU6VPmAS6rbk13u51gS1L
         AQhiWmuW/+bIFOhBmVBZcMC02SXGIiWYuOIcmaH0NZ8JL8Le7B5dti6fJhMBtLHzFeud
         UM7BfVvZr8gwBdm+bDTGPgYSIXpJuY9GTcqFbVh3FxwmqRrxNAHDibXZAtbqcLFDw+cR
         TB2pTAcrHdixhDpb9ShJYKSEaEB4zqL0vUClK8N0ZJfmm41sRcflkCdOw+x1RqlsJyh6
         CtIfVh1M1ImQSr7Q4gpqOXJgsnIRbfRuy1khzcFtZNCsoEgRQqd7ykBO3RMCuV+UKVJS
         lA9w==
X-Gm-Message-State: AOAM532wpnsCZAnxqquM8GH3APPe6HXdTa9jyDjs89mGKb4TZFq6Kapb
        vb0l45fAz3wx2BcVtphTO5kiOv5bt/4=
X-Google-Smtp-Source: ABdhPJxYXLqrevqKz6gyKxfmwOTMWbhDzQiizBk0Ki3pNZ9bAbzfkeo3zhh28NgVsVd+ldGa940CNA==
X-Received: by 2002:a05:620a:1398:: with SMTP id k24mr12077305qki.192.1630120163572;
        Fri, 27 Aug 2021 20:09:23 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id e25sm6071682qka.83.2021.08.27.20.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 20:09:23 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, tbperrotta@gmail.com
Subject: [PATCH v3 2/3] send-email: move bash completions to core script
Date:   Fri, 27 Aug 2021 23:08:38 -0400
Message-Id: <20210828030839.2989-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <xmqqmtpbub07.fsf@gitster.g>
References: <xmqqmtpbub07.fsf@gitster.g>
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
index d1731c1755..cbaefcd943 100755
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

