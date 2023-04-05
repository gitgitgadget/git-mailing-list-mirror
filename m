Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B8DC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 01:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDEB1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjDEB1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 21:27:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52FA30F8
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 18:27:47 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so18320194oti.13
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680658067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjs0Eyk2JJATu++uEBzMxyKzsqLBqt5SMaD17Naw2Vg=;
        b=VuQVaQrS+dtedQYEleiVVku7+/yzBLhitHfGhIb9G7WmtnB3DZqaiEWPjUBlnm9N8t
         fQlCxeTSxCyABZi6xm9qeIOpHuZ6lrXacfrHPYaw+kBVgIBUBWsttrK8jiiuE8/8zY/D
         2OgPXQ7TCPXXN3O0ykSuQjEGPucqzOEZw9LE4V7H2hyPLWQ3t7355hqUW+/7ZO6m+icO
         D2h6p75Hk4VxVmBus3ERwCPzRU4ESxPajtnDoVdmh7dUPXCvQuMoQAbPqZb5VUfBhXgB
         CO50ZOyEUuxgE0L+VgpSQ53TrzRimgPYzRWfzpxG7xLzAN6EXjzLi+rSMwLH01pSCVvC
         /kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjs0Eyk2JJATu++uEBzMxyKzsqLBqt5SMaD17Naw2Vg=;
        b=Sl2qq+mhsYk9fkeaZfngEReCFRpZhujl6zKaNV1m2SLcNn2FB3/XnInCf9wNB+TaGl
         sg5NvaLyD/0fnG9I+I853hiIsD8mdidmcpIn+1SgT8jPOg0FmD19h7OhRm9oeddc/+R4
         j8JTfDtWhbVabcZuCW8vjhFgVW9nAr9a+A2L9UAAloUm2sMN/IRewObeKnv515djmp98
         NYcxUhjSh4vl+vYi/YXD0TYoNNLdiXb2A26eSLVj6/f8/3qT8flOKrN7GJ3Kpc0730em
         q58QXbNKQLV0hnaycplpduM30QXw+zD8LkVGVD25/asPtwcanIws4MEITfwglkmqgfyh
         VTXw==
X-Gm-Message-State: AAQBX9cx4O8RehYrIMNjBrl/dLgSG9y8eaiYSqFcTOJWJpW2BOfFIM0Z
        vb63EnLJNhQb5l+hEChsDPn7DYScyxE=
X-Google-Smtp-Source: AKy350btRbaP6wLh3ZhyAD3TddNMeIXb0oRiPWsYPnYgIFjqAn1ZFBH1tdFTg7QtFIue20Ip6Qyq+Q==
X-Received: by 2002:a9d:73cd:0:b0:694:4f92:e7db with SMTP id m13-20020a9d73cd000000b006944f92e7dbmr2199749otk.13.1680658066686;
        Tue, 04 Apr 2023 18:27:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b006a144b97e73sm6212387otm.74.2023.04.04.18.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 18:27:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] fetch: add support for HEAD update on mirrors
Date:   Tue,  4 Apr 2023 19:27:42 -0600
Message-Id: <20230405012742.2452208-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230405012742.2452208-1-felipe.contreras@gmail.com>
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
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
index 7e93a1aa46..6bf147b012 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1593,12 +1593,17 @@ static void update_head(int config, const struct ref *head, const struct remote
 	if (!head || !head->symref || !remote)
 		return;
 
-	ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
-	target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);
+	if (!remote->mirror) {
+		ref = apply_refspecs((struct refspec *)&remote->fetch, "refs/heads/HEAD");
+		target = apply_refspecs((struct refspec *)&remote->fetch, head->symref);
 
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

