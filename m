Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654AECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiH3JfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiH3Jdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:44 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D4FA7215
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:58 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f4e634072so1126595fac.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=y67mxaPhuEftXuTH0ZC/K37o+Ktly1XybGycaFlE8b0=;
        b=SMRnBKycEhFCiAR0vUCsl2LLlZxfezzSlRssAYW4QFAXX5eBWa0uaFzN9XnJycFsaG
         j7L4fqtGupQcINt3NlCd3JxQpDvPbrS5I4qqhvvclR4HWmfgRZ8UW1QRQo+//cV7l954
         VuJOfB4Eqvg7mXpeQwPoyHaPmD4GpgXDhIFn4WFlu6Uj2vzLpoHsumHrCrGOKeqCnScy
         EZSs6+XbDU4ktYiuCzur10sbv3r8UDPsqbFWf1E8Aj+oWvMdy5xHeBBJqjsPq45pD/AN
         QBW2n88VMIjG5J/BHudsJ4tCkU3JptWJfLRp0Y32LaYK+9gw3EUHiTtiaJ58zPveroRp
         Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=y67mxaPhuEftXuTH0ZC/K37o+Ktly1XybGycaFlE8b0=;
        b=m5bCWkm3jEV8420E3GVkGR64c7WhJ4jhewQ2VK/1ZyRd0XCseIztdKitSv9BkOlwvy
         5/s2hjFx6ti3xapHobUTZxm4jKH8mOQkXUjGKe+UcQ30QhdxE0G5k0M8DcsDKEAelk6x
         awc7RwEede5uq+LdNOj0ck823rXstB50el5wjeJvBlQhS75RtZttxzzpBB367X8zgnxw
         7mRqYVdRLbVpLpvqLuDA1r4KaYB/IPUZalzakGT3tTYybRNFJ3SeFlKzx85w5Zs8Mx83
         g/tTGE+63Y2wjemCV0+SRktEV4ho3N+zYDs5SJdMP2Iu/Umo4wbG8wCZZoMOY5+dXxov
         w+vA==
X-Gm-Message-State: ACgBeo3w/KyRoIquS1MjTVRBjrWCcr/BwqNmwau341pnuqWo3PrJwFi+
        p3y8TXYo9HESU3oJFgyNYpU7wUotBLA=
X-Google-Smtp-Source: AA6agR4BnrO2KMyMgTOvHwYnzOmjjYz83D832Tr+UmK1KU65f8eEemAc5eO3f27LhAMKQsmR1/5XKQ==
X-Received: by 2002:a05:6808:1488:b0:344:dc19:d7d9 with SMTP id e8-20020a056808148800b00344dc19d7d9mr8903620oiw.196.1661851974413;
        Tue, 30 Aug 2022 02:32:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0642000000b00326cb6225f8sm5873461oig.44.2022.08.30.02.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 43/51] completion: zsh: add __gitcompadd helper
Date:   Tue, 30 Aug 2022 04:31:30 -0500
Message-Id: <20220830093138.1581538-44-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to do the same over and over.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 42bf9b95eb..e66044ee89 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -50,12 +50,16 @@ COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
+__gitcompadd ()
+{
+	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+}
+
 __gitcomp ()
 {
 	emulate -L zsh
 
-	local IFS=$' \t\n'
-	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	IFS=$' \t\n' __gitcompadd "$1" "${2-}" "${4- }"
 }
 
 __gitcomp_opts ()
@@ -70,7 +74,7 @@ __gitcomp_opts ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			compadd -S " " -- "--no-..." && _ret=0
+			__gitcompadd "--no-..."
 			break
 		fi
 
@@ -82,7 +86,7 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
+		__gitcompadd "$c" "${2-}" "$sfx"
 	done
 }
 
-- 
2.37.2.351.g9bf691b78c.dirty

