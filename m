Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF20C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDAItv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDAIsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F525444
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r17-20020a05683002f100b006a131458abfso10560201ote.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5THhBzqZa9EofGWOAyZV8jWlNg5vf4MHIUNurWOd0JQ=;
        b=GG+uooKBEhthhB+uT1IYBzzbESihZhmglIeal9XU8u6X30wba1RGOHGzavKNcCWTw5
         m+taT8ShadKWBAVSMBuCQTjeFkLQITscz3RBEl2acV1hFwjrYMM5L+uLj6N8W/ax8H6/
         lhuN8fQcc/mfHWFXEBWlij9myrmQjGqLkFZjvVS1WJn+pZewyS6N1U2Zq/8Ez2f2ybX6
         NHR9jnlsBvmmb7QYYv+Buvjbx8A2+NvjBZU28UQRj0PQEUdgnvXcBUncm8QjLG/fFz1R
         6xk/Jt5doR6qT2EP/PMIYyHdR5DzYg70iexwkzwYt8o9FdwK8FU4lbIcTui8amVoQSHq
         tVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5THhBzqZa9EofGWOAyZV8jWlNg5vf4MHIUNurWOd0JQ=;
        b=gWLJxIwQLP3D/2m57TncRYIMROfHrVNj+5q2fAo9v3A0PaI71A3gZpSwExyehadqME
         /2KtnNXd+yFlIoDgtEijJPPmQY1ZelITluYfoMtaQzclZwLNvPas4FTUmFAfvRBrDZUC
         7au+zHQFsl321kHNgmT707Tks7f5du3e/FYq9O1WZHmfDlzDK+7D+RtVmvhtrBnzuU0d
         p7N1TbLgdw29Cb9D+Nt+taw4vTdx2BknXIa++8PiVK95Ah4709BWVbjRuAH0RoVKi13s
         7qjWd+JzMd0AJvceGzYMYBRLv8shZZop4u871bfIfjYiT/Iot44nEvCP4kT6UyScfUkD
         VeYQ==
X-Gm-Message-State: AO0yUKVwAUtF397vr7RuFdJRmJIQbnRaXzHew9QGyhtklep3A3SJ48bE
        RE48xdO+bVWmrjeAWokM7p+YuQqQzm4=
X-Google-Smtp-Source: AK7set/CarITfiahfdgQkPZYPf7veF2ySus4XPeF24sYq86kqTXD72b9OK+QJdpMLhDLyIVyf9850w==
X-Received: by 2002:a05:6830:1659:b0:69f:b247:6da5 with SMTP id h25-20020a056830165900b0069fb2476da5mr14078982otr.4.1680338852244;
        Sat, 01 Apr 2023 01:47:32 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e2-20020a0568301e4200b0069dc250cb24sm2074087otj.3.2023.04.01.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 47/49] completion: bash: cleanup _get_comp_words_by_ref()
Date:   Sat,  1 Apr 2023 02:46:24 -0600
Message-Id: <20230401084626.304356-48-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove temporary variables.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63a9409b0e..1b594f01cb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -361,14 +361,13 @@ __git_dequote ()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local words_ cword_
 	local exclude i j first
 
 	# Which word separators to exclude?
 	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword_=$COMP_CWORD
+	cword=$COMP_CWORD
 	if [ -z "$exclude" ]; then
-		words_=("${COMP_WORDS[@]}")
+		words=("${COMP_WORDS[@]}")
 	else
 		# List of word completion separators has shrunk;
 		# re-assemble words to complete.
@@ -388,9 +387,9 @@ _get_comp_words_by_ref ()
 					((j--))
 				fi
 				first=
-				words_[$j]=${words_[j]}${COMP_WORDS[i]}
+				words[$j]=${words[j]}${COMP_WORDS[i]}
 				if [ $i = $COMP_CWORD ]; then
-					cword_=$j
+					cword=$j
 				fi
 				if (($i < ${#COMP_WORDS[@]} - 1)); then
 					((i++))
@@ -399,17 +398,15 @@ _get_comp_words_by_ref ()
 					break 2
 				fi
 			done
-			words_[$j]=${words_[j]}${COMP_WORDS[i]}
+			words[$j]=${words[j]}${COMP_WORDS[i]}
 			if [ $i = $COMP_CWORD ]; then
-				cword_=$j
+				cword=$j
 			fi
 		done
 	fi
 
-	cword=$cword_
-	cur=${words_[cword]}
-	prev=${words_[cword-1]}
-	words=("${words_[@]}")
+	cur=${words[cword]}
+	prev=${words[cword-1]}
 }
 fi
 
-- 
2.33.0

