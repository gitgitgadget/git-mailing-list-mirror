Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFFC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDAIs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDAIrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449A1D84C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r14so12747930oiw.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkUCxkN52MVFgiIV5B43A/xv6Tj+wASaJp8aZitiZr8=;
        b=T/IwyDul8B/meos0dUTXYmTuLjefLmolaZrOu/R/+RFXX8gJu6uebE/xpqbjiauX+W
         UFCa91v8hxGanNc5r+b2pOjMJDn7pQiYtFEO8JQPzViTIxQ1TIWEe06bLxOKNCNgCLRk
         tCyZ5igbU7NmJucs9t0RT4rxjkEfuCsFFyplexRqPk+V0rXgIbIP8kUTRn8scNWFdOni
         WSjqSZjzysJ46AeQ2eE+jKCdcrMT5wpHKEp83hScQShlJO58c8Auhv7l7A9XA51ZNZqO
         lIZbPANBYAgYd/BcKVawZ5Ye9H/0NwrjH+LRBZEZyU+2NG+d55p7mcXTqCfeduWcNHLN
         0KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkUCxkN52MVFgiIV5B43A/xv6Tj+wASaJp8aZitiZr8=;
        b=dXc+yHnZGN1Fz+j9pO03mQ/Hrbaznu8e0hCbBwv99mCXva9//V6T9rqP6PxobJZszc
         Yr8Z/RUIlOL1J6ftazmuqVAS8Z72HmpkLlPh3fMtH8pwS8m8HwiH6nwvh+nDWohZOIsI
         +vLfS7uxMTIYFmmrcdUgwc1VYtzFmmeHF0ngnUtviBCVnm4Bp6yLzHB5w42NsUK6I2BP
         j2cYkeFCJRNjhO0awsjq9O98O2YoFoPL9KNQc2iXMjKxGdcniBPd468++yY31wnAwFuO
         irZkodX2dfiz/pLo85tMzn/ELi1PaC1K6iMUcg+PhtjcSXJmdSXQBqj4Vssifh/BP9OW
         2hfw==
X-Gm-Message-State: AAQBX9eP2CLBh77geHa4q9Bywqvnlax55YMeiokW+m85umHIyRYw4Zkq
        QPnStSEoqDNAs7hBlC60I+vTfzW0U2g=
X-Google-Smtp-Source: AKy350bZI/J0b4hS2Qc65SOAj122z0wTQYuIfpqxzyTcoaJxJHhjP1pks1jrX+baKwWwYQL2bctAhw==
X-Received: by 2002:a05:6808:181d:b0:389:4bee:a525 with SMTP id bh29-20020a056808181d00b003894beea525mr10339953oib.45.1680338823835;
        Sat, 01 Apr 2023 01:47:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s12-20020a4a968c000000b0052a32a952e9sm1735306ooi.48.2023.04.01.01.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 26/49] completion: zsh: always set compset
Date:   Sat,  1 Apr 2023 02:46:03 -0600
Message-Id: <20230401084626.304356-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to set it every time.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0c8fdb584f..0b6289af0a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -73,7 +73,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	*)
@@ -92,7 +91,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	esac
@@ -102,7 +100,6 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
@@ -110,7 +107,6 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -118,7 +114,6 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -131,6 +126,8 @@ __git_complete_command ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
+
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
 	if (( $+functions[$completion_func] )); then
-- 
2.33.0

