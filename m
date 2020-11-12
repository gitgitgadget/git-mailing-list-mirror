Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE79C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABA12085B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKGIU61M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKLWez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgKLWez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:34:55 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65AC0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:34:54 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y22so7200273oti.10
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=HfipEYFfvwpvhUhrcQy7V0KmJuBV2w2NOhvYLrKZhvA=;
        b=JKGIU61MMAtDSM2Jb0vwtPwCr+mD02RLGzj0eaE9lUvWsS+Ww/p5wxQTGZyvJbSdPo
         nqg9Zc/mgvJ8aulmEyap7zq87PDRrATeRSLtSitKo07RNa6iNWNF/wrIMOUT5dbsDRMN
         8VrgAexjalYggOMY8JfyFTzUySMDkHu4kusdj4CcPG16XedelgvaqhADuNPIkr2is0yY
         EgaKNIDYW8Tkdpyc5HwklQyE0Z4sK5qZ1iPXZ8j/D5DbDzHrPWBmTgYq5Fgo7xxTzo0s
         bKj7nR2VM/TZ0XjDy6bUtla3cIixJi0tutV3dvs81FmJG/5lehbJwp9W+em1Krd8KGpo
         HwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=HfipEYFfvwpvhUhrcQy7V0KmJuBV2w2NOhvYLrKZhvA=;
        b=Ev2Lab58TXJDokj70nkOm0kcn6F4BbZ+dmHaI1wuFZafVSYafXdNTc17kjPYevtqjJ
         R09WGzywoxc1s+4B3Kz0G8Z1tsk2wWjOUlCzo8GMCy6Zi0LH0M8v0PxWhg/uhJOVd/QH
         dSCpzE2r8OE1YJo/7hTmozDrYcwHnTqnmm6SsVJZ5ecW18WM3AQaTvq1w6O/2trlLmfw
         fQV8hzpZCKYiNFk7ZFhbENRJ3cE4AKJ6cq/qpcY1psN932faRCIQbxWcJdTaIm2Ht/wm
         RxKF1Oo9kBhEwWcz1nP9oEv1BT8vM/5Cm5g0wJvzMIM/iiiF7jKjmEiSn2HluTUiNZZx
         cqww==
X-Gm-Message-State: AOAM532VSOPBF42KLCCyQJklIOqOk69zgkiyOM9kc710eIG5SlgerZ1V
        lg3Bycje0zs6OWWMr+WAff1asKfQRbkS7w==
X-Google-Smtp-Source: ABdhPJxkyHAB3yup0d8jfGmt4gakYnlJGoRkzTEtkeoFWeK16/V/6ibYATk+oHg/pdP3mrl9PdTYsQ==
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr1055029otf.118.1605220494109;
        Thu, 12 Nov 2020 14:34:54 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e127sm1434577oia.12.2020.11.12.14.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:34:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: bash: improve alias loop detection
Date:   Thu, 12 Nov 2020 16:34:52 -0600
Message-Id: <20201112223452.1526315-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
Reply-To: 20201112100204.GC4270@szeder.dev
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible for the name of an alias to end with the name of another
alias, in which case the code will incorrectly detect a loop.

We can fix that by adding an extra space between words.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ce0dc1e0f8..cd2a02bafd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,16 +1121,17 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local cur=$1 list word cmdline
+	local cur=$1 last list word cmdline
 
 	while [[ -n "$cur" ]]; do
-		if [[ "$list" == *"$cur "* ]]; then
+		if [[ "$list" == *" $cur "* ]]; then
 			# loop detected
 			return
 		fi
 
 		cmdline=$(__git config --get "alias.$cur")
-		list="$cur $list"
+		list=" $cur $list"
+		last=$cur
 		cur=
 
 		for word in $cmdline; do
@@ -1154,7 +1155,7 @@ __git_aliased_command ()
 		done
 	done
 
-	cur="${list%% *}"
+	cur=$last
 	if [[ "$cur" != "$1" ]]; then
 		echo "$cur"
 	fi
-- 
2.29.2

