Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C813C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356444AbiFOXgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiFOXgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF81EAF0
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h19so14037975wrc.12
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rn9MUwmdpTYqKTHIEnRekJCNC83tRUHfChU0KJbXcrk=;
        b=gEsc1UvI0voufIfjYfzH3MOb6ozpUFooL6OYYHod5Bp+eFSS9gsaznr55EV2HvDGOu
         uwmqhMp9OYrzoymWbyxlYq5bPdnZm5njwqX18IFvsQ2ajT5TYBSI10Wod9r6QC3d6mCs
         4geqFYgir3S+ytRxXNZASScyi2KWsKBzpZ/hutEh9Jx2BXC2i/TMTGenN1NQs6qBXulG
         RFg+zWIJng8yBMEM5c8VpfWWz3vZQoXYKrZQGXBnGhG6YM7ZSQJh7sKaUPKYenuyndY6
         Ce1he9Dm+ogIIhvHi927GM6MfQ6PmGtRn4WBxDzLf93uqVXM7FKxrYJ7msXAxn6hi8LH
         X9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rn9MUwmdpTYqKTHIEnRekJCNC83tRUHfChU0KJbXcrk=;
        b=A5LMU+oKUyALmhxJ5uQqTh92Sa+n0PgjYsusuDoL5qoDWplvUhUCNis+fhrMZIhGSn
         RlFeBgMsRQAc8T4DiK+wLWIfSvqdVBIM6IZfNkh4Xh2pMoNzcoFRIm8peCsQTuZMybfA
         ZEMoPUBdYSRXm3p6vMplyNF4JCoIZxqQuN5gD9RU8sKorckwtYJuF/IxWLCRmttQlyvx
         vHO+S8CH5Pb8GCj6C2vVo/oeEl20u60c4McMieslSpfRn//uv66XGoM47N9xZcTL5Wzq
         u3acNDtZf+nyHgREQnkXShU7lCLVSiRACl0FA0Cj30LqA5Lax4ags+y8wa1uxbY7nJsd
         JoJQ==
X-Gm-Message-State: AJIora+RF+u51k44u1FaiiiPMho3ZDkIUOjepKqKrikyDAFI4r8bcPEp
        vYXNx29t1qmbiYVCqxMWPiv5Wos08L8g0A==
X-Google-Smtp-Source: AGRyM1ugFHcSlX9R5GqvLsQLVDXEnfFoDt7eJCQB8jQhYgnMwCS/MPID6+eVQ/+kFTacM2sMWDHfrg==
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id g7-20020a5d64e7000000b0021856267e7fmr1973050wri.245.1655336164464;
        Wed, 15 Jun 2022 16:36:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a7bc105000000b003976fbfbf00sm315101wmi.30.2022.06.15.16.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:36:03 -0700 (PDT)
Message-Id: <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:44 +0000
Subject: [PATCH 10/11] relative_url(): fix incorrect condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 63e95beb085c (submodule: port resolve_relative_url from shell to C,
2016-04-15), we added a loop over `url` where we are looking for `../`
or `./` components.

The loop condition we used is the pointer `url` itself, which is clearly
not what we wanted.

Pointed out by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 9b9bbfe80ec..bded6acbfe8 100644
--- a/remote.c
+++ b/remote.c
@@ -2846,7 +2846,7 @@ char *relative_url(const char *remote_url, const char *url,
 	 * When the url starts with '../', remove that and the
 	 * last directory in remoteurl.
 	 */
-	while (url) {
+	while (*url) {
 		if (starts_with_dot_dot_slash_native(url)) {
 			url += 3;
 			colonsep |= chop_last_dir(&remoteurl, is_relative);
-- 
gitgitgadget

