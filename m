Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CBC433E1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BDD22CA0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miMc7r7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgHETuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgHEQxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:53:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8522C0A54D6
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 06:34:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so6384454wmb.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GTth7ZlgfEQKOaHMOM4OTwa7f0ezvsrKyYbwytkK8Xg=;
        b=miMc7r7EyAQ1pNLDMOoaBMqRAWIPuMn6rcBrR3kLiahzW4MydJPl3j1CPuShRKdEFB
         2YcQDN6m32MNHvbkp7vAsyzwSNcmookuz/dET1PgiwU0ih6+lIFo6fNQgVljxVx5TmeP
         pQx5IL7v/EkK4840m109a+7hss8ksONVAQrbxPg1/kD/6ByFimgRaWpZ4g3J/WW2e3Cx
         3hfvWiIUan5qztWUXM1A/+wkTqdeUh2Z3O61g3E3FuU8beI2EK25/banmtxK9i6yKdzY
         YqiJ5w+w9STeIA8ikSVYC/ae7UkF3n3kgvt0L2OY1mmdfh+XDll7fxZFPu8csYZQ/6eu
         eKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GTth7ZlgfEQKOaHMOM4OTwa7f0ezvsrKyYbwytkK8Xg=;
        b=CXpOGeg8eHLv+4xUyB9pYlHRvyhzD+89FgtpVTX3GSZ+iV8i4c/HMIDNh9s1ueSor3
         1+Xiylhlr7KXIoQHHdCirxC9WiIb9M03fOcIYqNoQxuNteF82H/W4G9np8JM/6l9oNmV
         geDkGs3gF+u5KQLDmVF4aqukdJccF2D7ukmX8S2h01Hnt7WXXG86/J9KaQzBFlcOTAwm
         ESNlMoM9tDuUIbbNo2fuOhr3whuhLq8Y7GD4Lp5+HPwGilRrNjP/1HS0XbQUFeHRsttV
         G3j68I61YMrMO6kMzDPi8ce6CDICtnckzkYRKCtam1KHlDp5vEZAiOG7hT7bUkaRJk5t
         fkaA==
X-Gm-Message-State: AOAM5313JITbo3goCM/kXcw3mFI9l1wn7CXt9wg4JPvR+sMNB+HMh7Zy
        kjAe703AwkFtM0UY+GynwzNv8pZC
X-Google-Smtp-Source: ABdhPJzDkUvQTSRubF2DHSE4SQy87svbuzezCN8oUXRrEKd1RwBNxLG3Z3aBgCBN4K43qYQsIJ+l+A==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr3294876wml.48.1596634466100;
        Wed, 05 Aug 2020 06:34:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm2619557wrr.71.2020.08.05.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:34:25 -0700 (PDT)
Message-Id: <66a026ae678341fe7e93a89e22f76e24282cebaa.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.git.1596634463.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 13:34:21 +0000
Subject: [PATCH 1/3] mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

To list merge tool candidates we used to use a private GNOME env
variable (GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago
and removed as part of GNOME 3.30.0 release [1].

So, git should instead check the XDG_CURRENT_DESKTOP env variable, that
is supported by all the desktop environments.

Since the variable is actually a colon-separated list of names that the current
desktop is known as, we need to go through all the values to ensure
we're using GNOME.

[1] https://gitlab.gnome.org/GNOME/gnome-session/-/commit/00e0e6226371d53f65

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
 git-mergetool--lib.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..be28fe375f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -266,6 +266,19 @@ run_merge_cmd () {
 	fi
 }
 
+is_desktop () {
+	IFS=':'
+	for desktop in ${XDG_CURRENT_DESKTOP}
+	do
+		if test "$desktop" = "$1"
+		then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
 list_merge_tool_candidates () {
 	if merge_mode
 	then
@@ -275,7 +288,7 @@ list_merge_tool_candidates () {
 	fi
 	if test -n "$DISPLAY"
 	then
-		if test -n "$GNOME_DESKTOP_SESSION_ID"
+		if is_desktop "GNOME"
 		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
 		else
-- 
gitgitgadget

