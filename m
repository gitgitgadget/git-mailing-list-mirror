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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD2C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B554620798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbhAACR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbhAACRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:23 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE77C0617A2
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q25so19272452otn.10
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jbf7hJqAU48KJoREZ8mV8+IOeQ7oY+veVx4AEOfPcq0=;
        b=tPVH/Co821UwoB4/dwRSpGHI2L5YLOWRrg15BhgEB5I4ELMLhWS+lpN72WkgMis1m4
         YC+KQPgCdMetja7IbwbHOk0s0vlHPEUR01XCxRRrEoqbX0HKxN7Z3Hldt1LDBJZf/5ih
         ykcKaBzHKvuxDt1yXNAkCGWFOnvrrRw8KiqxSgRp3rZGCsZHqiEwJfFHfKhQBN36FRSn
         7fGYFak6a2pMf0CT41BFmR/jjtW0Y1h8sbK3f8SinKK6hV10X/bHQLTmhTapclYPyyva
         1lF5J1TDqRAF6mTEfjXsLcUBYPJqLwWdIQ5EANb1UlslBrM1Vpecp1lT/KwPYDSIfe1b
         K4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jbf7hJqAU48KJoREZ8mV8+IOeQ7oY+veVx4AEOfPcq0=;
        b=P/xpt6Ah8/R6vk7CnqVoElwLYOpShxrETDJzdkBV12c1sUJxV6FAWgdar5FhBt8sUw
         //NeweDeZTx2D8CxGCJgdrX5yeBjfiT7KzgBQxq5e1wZwkDzB1rUPIa4Fc7UKfBDienJ
         KsBaOGzW1zOkuDBeT48MUg/kn9lJ+tc7YtrB0qfi6zr9FIJtMmI57sX6mdTD3yt81qWO
         0no4qqodKlMn3BZlC6RWScdgFCmUF17FilQLJ6dSGg6sXWD6jaK0SRkBfuS+Ve0MK9qm
         vZSB8RkRUrJ32wiBlN0K9fmoPz9a36SrlfwD1tb6Y4H5D1Vg+BjtnL50k7nvDv9rJyyj
         upqQ==
X-Gm-Message-State: AOAM532FilOdKicl8939n7kFj7L2Dhuln9mg2WsTC/p+x9KkPQvhapxe
        WJpm7SN72a7rsV5kOZyR6CPqQocVXnCMLw==
X-Google-Smtp-Source: ABdhPJw1WDe11NQPSQpVCMiGeMbI/g1KvoVTFMPZRUq0oyFGpd+F5+mSI6ukGA40176/bJuHg65Zkg==
X-Received: by 2002:a9d:2065:: with SMTP id n92mr42873171ota.150.1609467402621;
        Thu, 31 Dec 2020 18:16:42 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y84sm12306787oig.36.2020.12.31.18.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/47] completion: bash: get rid of any non-append code
Date:   Thu, 31 Dec 2020 20:15:46 -0600
Message-Id: <20210101021622.798041-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index b15d9d9d3c..ec62c11fe5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -300,7 +300,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -310,12 +310,6 @@ __gitcompappend ()
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
@@ -429,7 +423,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -442,7 +436,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.30.0

