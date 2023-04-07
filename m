Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80921C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 02:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjDGCho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDGChm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 22:37:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A2A4696
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 19:37:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso21581743oti.8
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsoqCcKzmKEs8ThZO6t770kHy8GGFmz+ZV8IumNMDRU=;
        b=f13c62f+W/DakbAuPvayePIAg6Do0H+ldPH89io4JPYdDliC39C6qZA6NSqo1uymnR
         0qUPR17oMRnsKgfozYWmevfqsfj45PGMZlDLHDEAm0dDYV5EOcHAUaYzugo5pk8ZuMNa
         VNAsTQFNngluBDF0v6PiBrNwotwRdQIYAvF+QsXBZ/mAhfoRkHsqlY+w/gvoId4wGiq2
         m5bQMG1X/lSiXzYMzyQJirDAHTf/9qVoodNWYRCUK6+prU9xOX/DTa7deDgK6fqYmNQ1
         Sr5Gh+tLdiT4eG5/DziaSkRacLwXjIbfk4Yuo3EsFOYQU1voCuMNWCQyJFf1gDS8DjSw
         MFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsoqCcKzmKEs8ThZO6t770kHy8GGFmz+ZV8IumNMDRU=;
        b=IZUZ+c7/OTLNzePdKgQSjYS7Efr2mYiR2I4OCiRHFn4k7cwE5qYzF9xkSymRNlD4J7
         iZgHibRZPHz15qOeR8m75uddRYL1/xKwEu/UKERUD9uVaxv3IF1WMuehwcNKlUYGrcGY
         qVZ3dB4WhZHAaKYZ70/GzcyuDPVS1kyodvLP+v1dTTybjPRsWNhS5YRf+uxFj1ITE7Le
         BaKfmej82QUx21HN1HMM3dlkq0upKRweAmeX2CUXJ+cpnP7uFxOvQRScr9dDDVfdD+OH
         OaTiU/5+8j1AWsfyHvZZrP8JRuu6fnym+ugEa/uB/Oaa03wxtIHRJeymTy6BOyy0c8j8
         OucA==
X-Gm-Message-State: AAQBX9fBpt6YN6rTsJ/tcqFP3CvgpCOKysgidnBb5BIlS17gPgnIQNFo
        D2J+l/2FRe9NPjvSiS0doJUra9S+7bs=
X-Google-Smtp-Source: AKy350bX5HUJpnSKgbW//4FpLCf0kEXhyNEnqz1ZVaJcUgoLYLzxE5Mzsjl+6SH6I/0E/OT8AoAYVg==
X-Received: by 2002:a9d:6d8c:0:b0:69d:42c:6a56 with SMTP id x12-20020a9d6d8c000000b0069d042c6a56mr403013otp.36.1680835060501;
        Thu, 06 Apr 2023 19:37:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l3-20020a9d7a83000000b006a1394ea9f3sm1327319otn.30.2023.04.06.19.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:37:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] fetch: add support for HEAD update on mirrors
Date:   Thu,  6 Apr 2023 20:37:36 -0600
Message-Id: <20230407023736.49190-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230407023736.49190-1-felipe.contreras@gmail.com>
References: <20230407023736.49190-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c  | 15 ++++++++++-----
 t/t5510-fetch.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3f7b33ba78..80fcaf79c3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1594,12 +1594,17 @@ static void update_head(int fetch_missing, const struct ref *head,
 	if (!head || !head->symref || !remote)
 		return;
 
-	ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
-	target = apply_refspecs(&remote->fetch, head->symref);
+	if (!remote->mirror) {
+		ref = apply_refspecs(&remote->fetch, "refs/heads/HEAD");
+		target = apply_refspecs(&remote->fetch, head->symref);
 
-	if (!ref || !target) {
-		warning(_("could not update remote head"));
-		return;
+		if (!ref || !target) {
+			warning(_("could not update remote head"));
+			return;
+		}
+	} else {
+		ref = "HEAD";
+		target = head->symref;
 	}
 
 	r = resolve_ref_unsafe(ref, 0, NULL, &flags);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dbeb2928ae..d3f3b24378 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -845,6 +845,24 @@ test_expect_success 'updatehead' '
 	)
 '
 
+test_expect_success 'updatehead mirror' '
+	test_when_finished "rm -rf updatehead" &&
+
+	git clone --mirror . updatehead &&
+	(
+		cd updatehead &&
+
+		git config fetch.updateHead missing &&
+		git symbolic-ref HEAD refs/heads/side &&
+		git fetch &&
+		test_cmp_symbolic_ref HEAD refs/heads/side &&
+
+		git config fetch.updateHead always &&
+		git fetch &&
+		test_cmp_symbolic_ref HEAD refs/heads/main
+	)
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
2.40.0+fc1

