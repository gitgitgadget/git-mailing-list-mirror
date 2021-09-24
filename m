Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB1C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BE0610CB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbhIXCsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbhIXCsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 22:48:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6EC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d8so8236558qtd.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVOwwDczM6Vn8RAtA2u7joWtPRFEkTXqVyOW/jgrTm8=;
        b=n/WxyMyMnYo7KR6r6J4idXYmhrEIeLHdzuIRlYyyzRd8D48jO+d7EtL1MpvlPEUe+W
         isK93cBJp+LgduMLofiBYsljmWRFc2x46mIBLk5x1hO6rrPEYeFHUydZSI74zp7kVDTM
         pjvckSGi7UkTerNDegNNVqZHpGNFSjFCN36Hu2WfyAOGPTz2rKKRV736rj1iC1fn0rBE
         SAoMw4s+gWYB3b3HUH6DJ9py1FxjYZEu+jHXY00PjBIZ43PDyAxoNOh3OX9yB72Y5zBc
         OXaAinNFmi2DKgsoVM55HsBgheRlJ4ZSP0gSfyjzgN3auqHDQIbI1Gx1GAiVX1f8T+Zi
         61Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVOwwDczM6Vn8RAtA2u7joWtPRFEkTXqVyOW/jgrTm8=;
        b=piSaHLmbMGumJl9hE1b8o3aMtg6O69uumTYkD5tfl4tkodUO+pTgSHQqjxp38EHU/H
         2ldYSMpjd2gU0nBGfKClw4k87H0WAO6lNPQTm8xWdrJKYbdTVSaQA8HPOtkofu7bYm2x
         zTuWjmrKtTo69DQzaNSZfBJZbudRDdeB8afFe5nkPBdoaCLQbVflFDLfpVc/d0D604wB
         E410X2rBvQNVXQTpXiG8LWbZO43t9xUNa171k1xLKfz/7DRR4LiRJfUGW95xxMwjg8lk
         x0WxClBmZYDgZODDuUzmFEn1qtdYlUpUZGhLfJ33uGNVPbWKX1IIHqftUspVUNQSOjgG
         6i6w==
X-Gm-Message-State: AOAM5310EJBC72w9Dzk7TRsd5OCY339A0ykHm90qT+3T6tpEG8OETqcI
        QFjiPlZBbkWNbPG/fCnRBgg=
X-Google-Smtp-Source: ABdhPJzs9WwBAwFIwlBrgzEnc68s2QDxBj7Knnd8VwuCRO5LS9nj6UUrI0+mOXizG3L0Am7Jt22p7g==
X-Received: by 2002:ac8:4d87:: with SMTP id a7mr1987957qtw.260.1632451624033;
        Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm5698011qkh.17.2021.09.23.19.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:47:03 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v5 2/3] send-email: programmatically generate bash completions
Date:   Thu, 23 Sep 2021 22:46:05 -0400
Message-Id: <20210924024606.20542-3-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <87zgs34ccx.fsf@evledraar.gmail.com>
References: <87zgs34ccx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-email --git-completion-helper" only prints "format-patch"
flags. Make it print "send-email" flags as well, generating them
programmatically from the usage.

Introduce a uniq subroutine, otherwise --dump-aliases would show
up twice in the flags.

Add a completion test for "send-email --validate", a send-email option.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +----------
 git-send-email.perl                    | 21 +++++++++++++++++----
 t/t9902-completion.sh                  |  3 +++
 3 files changed, 21 insertions(+), 14 deletions(-)

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
index d1731c1755..3d4836aa48 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -38,9 +38,8 @@ sub readline {
 package main;
 
 
-sub usage {
-	print <<EOT;
-git send-email [options] <file | directory | rev-list options >
+my $USAGE = <<EOT
+git send-email [options] <file | directory | rev-list options>
 git send-email --dump-aliases
 
   Composing:
@@ -110,11 +109,25 @@ sub usage {
     --dump-aliases                 * Dump configured aliases and exit.
 
 EOT
+;
+
+sub usage {
+	print $USAGE;
 	exit(1);
 }
 
+sub uniq {
+    my %seen;
+    grep !$seen{$_}++, @_;
+}
+
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper'), "\n";
+    my @no_only_flags;
+    push @no_only_flags, "--$1", "--no-$1" while ($USAGE =~ /--\[no-](\w+(?:-\w+)*)/g);
+
+    my @all_flags = uniq($USAGE =~ /--\w+(?:-\w+)*/g, @no_only_flags);
+
+    print "@all_flags", Git::command('format-patch', '--git-completion-helper'), "\n";
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

