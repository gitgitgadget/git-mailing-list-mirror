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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185EC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A82E611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhFRS2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhFRS2B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB5C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:48 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10577291otk.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdJ93B8GfAGhZuLUWGWa4Bvy7t6axrPT6YYr9b1BB6c=;
        b=Qye7Fx8Gv4l7vyP4cHjYK+AuaM3cXxj5O2dmefbBJc1SfsLdGMIboHaTWRRylO0m0l
         iSIQXCluUzo7g6mtKbJGNcg1pZoYLhAI3T1jNxpWlrhfNT4Ieta0Y8Ip7GodHoP1XwzT
         Eyj2OhgKoGKG7bUnTAciWyxZVdmaQSaiW4yGTvuxk1j3vdhIdf6R9mlO/a/I35faEcie
         OZwPgEmcDZ15UEE4DKyYz3ElTqAd/hMQVD930FZkEcz9UapKl9oJSZ+23tNSIskIUV3h
         StmZtbqXJXKN/u029c8tcuqiIYzbUCJp4wYPbQ2l+CKktOW80f/3R/eDGF0vgD9TvDTd
         JW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdJ93B8GfAGhZuLUWGWa4Bvy7t6axrPT6YYr9b1BB6c=;
        b=fAFwLhU+ltWeE5NYQ4+erojPFvEW9SqXWp44i4m2rqDwjV5CnFGAMc3hZwkWBuxhoa
         date41sjbfIhMNxUmmjecfDptW6xLl57dU4xyzaWpSqEkZLieGST1enfWVu5MPXWc8RO
         9VPOuvhZw2TpENszXyOmnOsSXMDmWTi6MWzFNbv+J1wFOQrFXxEw2680nwa8zhEE6Ixb
         lXMw4O2y948zBkF4pQDkPTj/ar+KcvCVahuygKRx1c0GV+uqPRd1d0imWL50w2GqxHV8
         4fcgoj9HPhpNYh3X05O7MjMohKzLtsg4r8sknXRXX2ME8tBNxqPRsrM8PuaB1XlafQu3
         fYxg==
X-Gm-Message-State: AOAM532umqte/A50tnLcaZJ+hNovhR9p1Nr5vh+bRZaJ4WLXI4p2oOlR
        84+7SEBle7Dut+6ZpQfMOUzKxOqdwpxj6A==
X-Google-Smtp-Source: ABdhPJwKp/AqdeG5orAZWHk48fPSqtAeooHRA94iFPPJrFqSRDFwYJLbw7FLvglKLoVHukhy32NHUw==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr10674497otr.62.1624040747388;
        Fri, 18 Jun 2021 11:25:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm2151937otm.57.2021.06.18.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/45] completion: bash: get rid of any non-append code
Date:   Fri, 18 Jun 2021 13:24:47 -0500
Message-Id: <20210618182518.697912-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3ea5261fb..366f255dfc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -309,7 +309,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -319,12 +319,6 @@ __gitcompappend ()
 	done
 }
 
-__gitcompadd ()
-{
-	COMPREPLY=()
-	__gitcompappend "$@"
-}
-
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -438,7 +432,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -451,7 +445,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.32.0

