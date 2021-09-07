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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05506C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 00:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9D660E76
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 00:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhIGAR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIGAR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 20:17:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94FC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 17:16:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s15so6609859qta.10
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Al0TCxPW16s+1IkFF3a40ox0W+es9TT5GE/VQ+yhE/M=;
        b=SEokR7l3thBc6FmbcqBhH++Q9iAwLgbSsvKyXUo/7YLUZCSzU7IMdoqIDNweuxS3M7
         G9tmxxMWPhH5QIASIPanCV93UbUbtlamUj1mXMYIxIwEuLLv1WDorn7UYoUTrvo1rjCa
         LmeQ3fn2mWMsi/Fm52QWc9MoPQZFCxbynvi6XdBON0siqWRUoACinc/uQ0Szh5apGdiT
         CzxCRInHBlY7Hmu3BaE1ch76+n/XdBHeXeYeESutXg5SMZvCuTgcaKZcTYGhHUCVka0B
         MzGXhmugvbIx2bCvcUHI94Dsv341D9wu5uSqYCP5yHF+VNjq16JeRYwaLnVr9sw/UfTR
         WfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Al0TCxPW16s+1IkFF3a40ox0W+es9TT5GE/VQ+yhE/M=;
        b=aT5axXM73bmYqq/cHSM4QsmqevkfYLeIvwRJqy5hxDcRFP3d5O+5ydIR1F+OgCGNFM
         IE41FTrLf25QMArib7HZsBR9KQfYtSmxpCGX8ZolA3n/zCpIUsfj2XGA/7hiyazGnYnH
         LeU2gMC2cJ+4LUJs42aEe9a9yZlF5xtehXSrh+6N5ZqqZg5zkddvEnzARmxjCcO5GcEZ
         qCZBw+xXX0w4GEnw0qzpDpUpZwqnQ1/dKyCLf4juJ9WMmu6oDVp+jlcZ7Z56E5Q44AGm
         QSC4M0NQv2rrpMcZGnqa/IPBGgouyoybzHwSOjsP80vKquA+oDA6EK8y6PgvczyAmzDq
         ZO6Q==
X-Gm-Message-State: AOAM531f1ng7YKXJqdK2GWID/NWupXrI2e1mGfGLpHcHoc3vCelRO5oa
        iQ23CtdBT3TXPQiDtco9o6hdxfYximc=
X-Google-Smtp-Source: ABdhPJyK+Ee3giFqsq3P459bJ5ikJpCxPqaSa+wlo8llh1N8ZgMCS8c/hRnmEiCpM7vEQx4hWTZ/gw==
X-Received: by 2002:ac8:5848:: with SMTP id h8mr13297624qth.254.1630973809427;
        Mon, 06 Sep 2021 17:16:49 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id 75sm7650548qko.100.2021.09.06.17.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 17:16:49 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, tbperrotta@gmail.com
Subject: [PATCH] send-email: move bash completions to core script
Date:   Mon,  6 Sep 2021 20:16:09 -0400
Message-Id: <20210907001609.156105-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAPUEsphYPqaZueCcZ-SJx9HabuesSyx8MJOhkEjAJjWGGrzxEw@mail.gmail.com>
References: <CAPUEsphYPqaZueCcZ-SJx9HabuesSyx8MJOhkEjAJjWGGrzxEw@mail.gmail.com>
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
Hi Carlos,

Good catch. Initially I had only moved the options from the script.

I am working on another patch (attached) that exhaustively adds all
options. At this time, it's still manual, I agree that generating the
flags programatically would be even better, but I didn't want to
complicate this series too much.

Let me know how you would like me to proceed here, I see 3 options:

1. drop the second part of the patch (v3 2/3) completely, only keep the
  other ones (1/3 and 3/3), which just adds the newline and touches the
  man page - leave automated flags for another series
2. send v4 with the attached - which exhaustively adds all send-email
options to the perl script, while removing the completions from the bash
completion script
3. send v4 with the attached and do not touch the current bash
completion script (keeping caching as is)

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

