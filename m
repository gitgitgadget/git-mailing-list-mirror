Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38547C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDAIsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDAIrz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:55 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE024429
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:13 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17683b570b8so25596382fac.13
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfwFwIXhHJkS69rkFWNJpSdHzFJ7j31eL9ZWSP2lRqQ=;
        b=e+zYIBQR8/nBGz9EplweRSUAF1kMfChsVEjZX9e2W1FZWfyHHjtooIiTcL3I4dbMT4
         thv3BcHsJCc63bhW98KJpaPVLjbKiscFdbVuzjFu1mo/QE4CQ1DZtl5icefLzGZ8c5G9
         vdDVaqsQvOIbW+JdZd+BSj4LLfa+3pXUmEEr4tvtWr5FQLlEk/whhHP8sXDwD6doziMR
         zHhIjpu3+MF8jDmRGmEBo6FLxULRGHp9YuvC+SjWEVfVgjmuFMttn7KivNV41+Zp8tM6
         rD+FnfdOF8rZbr4rI1dJSTW4wLINzH4sLmtNI2ygN9oS8r3USICDoATnPbrXN2P2ly4x
         rALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfwFwIXhHJkS69rkFWNJpSdHzFJ7j31eL9ZWSP2lRqQ=;
        b=kKMoKRWJWIjwDa8UxD2zJYxJ3iuYfY+dpbdNE3xMpghmTXcEC93YkKtFDw4PsZxeDw
         +kv1b/kK3QCkvo9GdTtBC/0WktdabQCrnIh0CqMA+OxATp9IPexSqk4nIGmol4a9d6pE
         tmiWNNhSZHJInjwkkgeHaFLJAmw0cBipbGpX2vqJbcjOVwmjbwv9KeLrxSi2vfhHHsAe
         xrDxXnyBJmu+A0wcwSFEops6JD6VPz3o6GNDotfWOE/XeGfm63shW0dxlIqb3x4LdZuZ
         KO/jloDQQZZYhmWH+owg5/+Wwj6CeslQkZ/4MhBBg9nEkZcnT/jsprivPj/P5HSgHdXp
         uGSw==
X-Gm-Message-State: AAQBX9fCTH8BJeJ4Q8/xISclqExkpj82SwkRSuOgqfwL0C0jPDVvk6SW
        cFiEcOayyJF9YfiydaGjS1edIm3/u7E=
X-Google-Smtp-Source: AKy350bcXUd5cqznhbvGk5uNIS5L+SFgTkaot9UGW7eMkw9TknAZnhl+rYUgzNlWFlwu/Zig9E2RzQ==
X-Received: by 2002:a05:6870:b506:b0:178:4453:8020 with SMTP id v6-20020a056870b50600b0017844538020mr17757890oap.19.1680338831529;
        Sat, 01 Apr 2023 01:47:11 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g22-20020a9d6b16000000b006884c42a38asm2136095otp.41.2023.04.01.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 32/49] completion: improve __gitcomp suffix code
Date:   Sat,  1 Apr 2023 02:46:09 -0600
Message-Id: <20230401084626.304356-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in adding a suffix after a suffix.

If a suffix is provided: we add it, if not: then the default heuristic
is used.

There's no functional change since most callers don't specify a suffix,
and the ones that do, use an =, which by default doesn't add an
additional suffix.

The only exception is __git_complete_config_variable_name, so make sure
we pass the correct suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 +++++++++++--------
 contrib/completion/git-completion.zsh  | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63a3235544..eb7be6aa6c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -345,7 +345,7 @@ __gitcomp ()
 		return
 	fi
 
-	local c i=0 IFS=$' \t\n'
+	local c i=0 IFS=$' \t\n' sfx
 	for c in $1; do
 		if [[ $c == "--" ]]; then
 			if [[ "$cur_" == --no-* ]]; then
@@ -358,12 +358,15 @@ __gitcomp ()
 			break
 		fi
 		if [[ $c == "$cur_"* ]]; then
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			COMPREPLY[i++]="${2-}$c"
+			if [[ -z "${4+set}" ]]; then
+				case $c in
+				*=|*.) sfx="" ;;
+				*) sfx=" " ;;
+				esac
+			else
+				sfx="$4"
+			fi
+			COMPREPLY[i++]="${2-}$c$sfx"
 		fi
 	done
 }
@@ -2606,7 +2609,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 04265bcb22..290fd0252d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -58,7 +58,7 @@ __gitcomp ()
 
 	[[ "$cur_" == *= ]] && return
 
-	local c IFS=$' \t\n'
+	local c IFS=$' \t\n' sfx
 	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
@@ -66,12 +66,16 @@ __gitcomp ()
 			array+=("--no-... ")
 			break
 		fi
-		c="$c${4-}"
-		case $c in
-		*=|*.) ;;
-		*) c="$c " ;;
-		esac
-		array+=("$c")
+
+		if [[ -z "${4+set}" ]]; then
+			case $c in
+			*=|*.) sfx="" ;;
+			*) sfx=" " ;;
+			esac
+		else
+			sfx="$4"
+		fi
+		array+=("$c$sfx")
 	done
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
-- 
2.33.0

