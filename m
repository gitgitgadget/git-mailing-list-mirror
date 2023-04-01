Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A89C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDAIth (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDAIs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606B1EA27
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:27 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso13144516otb.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AvC3KavAHRh1VoplO51Hhsj9alfG8K6BA/hYxExGNE=;
        b=AUZvnlPpD6370N7e9LLEEgfJlIb5vl48R4mb+RhaofK6ApqiJlJy88oFZfEVoyspgJ
         KZGKVaf9yUNIfLWEXWwFw/3qk7kSj24oXR6SFJLd49P2zUeW09nPrP1JNdVRc3/6V2wQ
         jBfjhoD6qJiGhh5eeLvpPcGnDL/jv4P5HHSJffY9N8LJLtr1otauQCH1SZJZY+TOSRfi
         yyzNoA5vosvm+QllbEZbKT+ss/mK8JGxlYfKuE8bq/Ntlu6drHJU9NHFg/Y0dLYyx7F8
         Rs+IfUExVmwRY0qSJw++TMemRHxdoQmmB8S5yYGuFoHvMOHsMS9fLADdTlzphQJS771i
         NRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AvC3KavAHRh1VoplO51Hhsj9alfG8K6BA/hYxExGNE=;
        b=1pucm+NS342ARdxJVFFgPSxA5DU3yp1Q742lwKIFZSpQnWQJkga+ro0uZhwPJNyV39
         qQAHJ9PzlmKCKG4Al2ZIf7iDaQi/Q2OviKBjdm0nNUJfCn2ciVOn46KtZef3Aif3BZbf
         sWI/IsPqLzcB1BScwrcYt/3831N2I+DkdD4b7fQM/GM6cOB+avpaI7JuCoQsoL28W6ga
         XpVXIjl+41FCsgO32wq+qGSZHjMhnXBKOsm7bnHVspzcPh6Ofjv/DAJDuRnXB8aG4mr9
         Tgm6wPHVvO5jnB77q5Xo6jbXa3lxPc2NZmD7y3x9Wyn7sY3lrjxKkCqd2r5uQGhojZfM
         my2w==
X-Gm-Message-State: AAQBX9eTohGzdV/D9KKqd93ZghiVPC1RPJXBs8l7ihg7tCEPsRDN3+1Q
        Rs3vhzQqgfVMDqHc79n8bNCr+QjwhaA=
X-Google-Smtp-Source: AKy350Z9yFXPM1gyjbUcllNMeSSJX+ysBK9A1tfnImSgm1Dmdlv0xF0s+DjoM8oFjUOSpQwV28h8pg==
X-Received: by 2002:a9d:6ca:0:b0:69d:1f1d:4629 with SMTP id 68-20020a9d06ca000000b0069d1f1d4629mr6078492otx.6.1680338846756;
        Sat, 01 Apr 2023 01:47:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id xy9-20020a05687123c900b001718e65a5d0sm1187738oab.57.2023.04.01.01.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 43/49] completion: zsh: add __gitcompadd helper
Date:   Sat,  1 Apr 2023 02:46:20 -0600
Message-Id: <20230401084626.304356-44-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index ba7b0a7dbc..522b59cf5b 100644
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
2.33.0

