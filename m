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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D2D613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhFRS3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbhFRS2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE6C061226
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:36 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id h9so11531861oih.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2PFJRuW8/CqHVD8/EdwwhC7Pvllu/Ues+vPXQxZub4=;
        b=Lpc6j4gufa3jWQesLXDZqYgJamOZOPFyCmgRZ6REWcYmsz6T36oU2qaHYcFWzeTY2Z
         //X+KopiSuMgB9WN5gpkywDVATMU761FQa8UESjUkUou3Jm+U8k1BQeT0DRVsk7qAdzC
         nljUAXsY3VB54j1HIU8S3cjwgrx0rIA5aOz/uGIhNM0L7kXZ5e/CnnGfci7qmHFXesev
         mfsQEsWNos39D9vENLpbsgbZq9oWH9t7sTEyxUkWVTm4wliO2y3ofZ+7i+FQENM0mucs
         giVnrET+0VQC98+tSxaAXDTnydrF/mkTFyK1FPR36GI7wEItpZWoxF5yEFmSu++o+FfW
         25xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2PFJRuW8/CqHVD8/EdwwhC7Pvllu/Ues+vPXQxZub4=;
        b=jQAv9jXc4wFIOQSVypwM7Fbz4Fkx2GOksIegpbrZMGhd/CPXctY/dN5qhzzTZGF7RA
         M+9LEyOUVKia2m7Pmd5NRhSl2Oi5OJkBhyUfsyTLD3og/ctN4S2Jl81KNIleL3bgDBYI
         w2JtSEmogib/nTfodLl9GR1Mf+Dc1HZMQSEwoKYxer/Fvqn1WDCjLuUjuyTg2g2rJw/+
         Z9Oz9heyHPLhrAOZJMyr7peWTdUvIj90AOPkUVKXrinKjYIBAHGdGhH1XLgB3/4Gs3zi
         aY5jzvpTHQZtFPhntkPEQcERq3zB4CiGu22BbKq1Cei12zkFbbmkWDd2muhi6ZyeAB2n
         5GoA==
X-Gm-Message-State: AOAM533dGHHptyFc6GaCrCunQIoETKfi97p8WCSzD157+P+4i7HT2PuQ
        uLWlQW3yMKiwVeYXUGzkQyrhjpU2sUe8iA==
X-Google-Smtp-Source: ABdhPJz+XfGY7Db+lyJCwYobhtuYLhqEWVefvm88nEnP4zC+kji8JcNd2vQ7nHQwAnehl9GpaK2n4A==
X-Received: by 2002:aca:2102:: with SMTP id 2mr5030994oiz.122.1624040795404;
        Fri, 18 Jun 2021 11:26:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w8sm2147241otk.16.2021.06.18.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 40/45] completion: zsh: add correct removable suffix
Date:   Fri, 18 Jun 2021 13:25:13 -0500
Message-Id: <20210618182518.697912-41-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zsh has a nice feature that allows a suffix to be automatically removed
if followed by a space.

For example:

  git log --prety=

If a space is typed, the suffix '=' is removed.

But we have to set the correct prefix first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0f2f0e5eb0..d425ff1d81 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -52,7 +52,7 @@ functions[complete]="$old_complete"
 
 __gitcompadd ()
 {
-	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+	compadd -p "${2-}" -S "${3- }" -q -- ${=1} && _ret=0
 }
 
 __gitcomp ()
@@ -80,7 +80,8 @@ __gitcomp_opts ()
 
 		if [[ -z "${4+set}" ]]; then
 			case $c in
-			*=|*.) sfx="" ;;
+			*=) c="${c%=}"; sfx="=" ;;
+			*.) sfx="" ;;
 			*) sfx=" " ;;
 			esac
 		else
-- 
2.32.0

