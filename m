Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C1FC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCF261260
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhIQTVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIQTVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:21:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C5C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:19:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f22so20732400qkm.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1cNLKnchj9S7z4JdOCdFz5QT02ZG5MjW5efccI7koo=;
        b=LsU/KFE8/ZSnjFdHpRe6S8pGDdjcV665ptbOuEkZhi2DyXSvTT9G1GcvsyH3cVdi7S
         oPHU3zIn7vuZPCaqfHriPcx/t8tcA+f6LiObUBCY1Yup3F6kWa/U70tC9QuwxhgOs/4U
         2ICvxZJsREHCeiOhs5eppckpUiOoPafH0CXJTZbsztnGEs0yfcw1iMOH96yQ400mpNRl
         m4W/EcsOaHcY02h2AMV09AObz1SrK/sfh34Lf4f5rhJt69UoyMB7YTQuJ2wS6DyZAkfV
         Ax8SJFtzHY//CS7guUzDduqiRm40RTbYZyy0nmlonKedQneR1z5klrzTXZ9/VpXQBQyc
         2ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1cNLKnchj9S7z4JdOCdFz5QT02ZG5MjW5efccI7koo=;
        b=QscbQeB+hj8f2IEKE4ddJouA8o+YGr3hAchk+joBPKhxpQSpzBgb7oRQSt+fF64gdY
         ZP/J53DkNetu7jTxOFsFLJDULZPzAXIamKdFKlBEropjNFBO6fSgbcMlY52bfnTanA8l
         hvVUYHRtU14f1U2JOFDl3rB5IjJxwY9yBzijC4ThVldBJiZfqEwHG1gFN17h5ehApYvi
         6xEoumw8pXZVZAp94MuNfG5HFPnIS5cKoAL13ks6nVWauifMUQE+GQaa4a7ImaKJG6oh
         kn6nk8DSxU9UhZ2PjTlI+bac7TCt06H4J/AEP/H0wI7zdV4p8J1yWl/cKj3d5uYPGF8s
         OiIg==
X-Gm-Message-State: AOAM533Fq3L/ZyCjgayKuc72niq1NG4p5gmpBu4DI2X+JWSDpmJ1TwSh
        pxX9kKC/q7bZLW2KxScToRDPnMt2DZ8=
X-Google-Smtp-Source: ABdhPJxUbcA/mB5Jb5PHG23dG4BpFUrRS/gVAWjCRnDCtfL8LyHTyjb5K+2/+fKOdYNXdyqmxqWqqA==
X-Received: by 2002:a37:2788:: with SMTP id n130mr12235881qkn.143.1631906377565;
        Fri, 17 Sep 2021 12:19:37 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q18sm4557401qtx.73.2021.09.17.12.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 12:19:37 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dev+git@drbeat.li,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] unicode: update the width tables to Unicode 14
Date:   Fri, 17 Sep 2021 12:19:20 -0700
Message-Id: <20210917191920.55944-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Released[0] after a long beta period and including several additional
zero/double width characters.

[0] https://home.unicode.org/announcing-the-unicode-standard-version-14-0/
---
 unicode-width.h | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index b50e686bae..97c851b27d 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -26,7 +26,9 @@ static const struct interval zero_width[] = {
 { 0x0825, 0x0827 },
 { 0x0829, 0x082D },
 { 0x0859, 0x085B },
-{ 0x08D3, 0x0902 },
+{ 0x0890, 0x0891 },
+{ 0x0898, 0x089F },
+{ 0x08CA, 0x0902 },
 { 0x093A, 0x093A },
 { 0x093C, 0x093C },
 { 0x0941, 0x0948 },
@@ -66,6 +68,7 @@ static const struct interval zero_width[] = {
 { 0x0BCD, 0x0BCD },
 { 0x0C00, 0x0C00 },
 { 0x0C04, 0x0C04 },
+{ 0x0C3C, 0x0C3C },
 { 0x0C3E, 0x0C40 },
 { 0x0C46, 0x0C48 },
 { 0x0C4A, 0x0C4D },
@@ -116,7 +119,7 @@ static const struct interval zero_width[] = {
 { 0x1160, 0x11FF },
 { 0x135D, 0x135F },
 { 0x1712, 0x1714 },
-{ 0x1732, 0x1734 },
+{ 0x1732, 0x1733 },
 { 0x1752, 0x1753 },
 { 0x1772, 0x1773 },
 { 0x17B4, 0x17B5 },
@@ -124,7 +127,7 @@ static const struct interval zero_width[] = {
 { 0x17C6, 0x17C6 },
 { 0x17C9, 0x17D3 },
 { 0x17DD, 0x17DD },
-{ 0x180B, 0x180E },
+{ 0x180B, 0x180F },
 { 0x1885, 0x1886 },
 { 0x18A9, 0x18A9 },
 { 0x1920, 0x1922 },
@@ -140,7 +143,7 @@ static const struct interval zero_width[] = {
 { 0x1A65, 0x1A6C },
 { 0x1A73, 0x1A7C },
 { 0x1A7F, 0x1A7F },
-{ 0x1AB0, 0x1AC0 },
+{ 0x1AB0, 0x1ACE },
 { 0x1B00, 0x1B03 },
 { 0x1B34, 0x1B34 },
 { 0x1B36, 0x1B3A },
@@ -163,8 +166,7 @@ static const struct interval zero_width[] = {
 { 0x1CED, 0x1CED },
 { 0x1CF4, 0x1CF4 },
 { 0x1CF8, 0x1CF9 },
-{ 0x1DC0, 0x1DF9 },
-{ 0x1DFB, 0x1DFF },
+{ 0x1DC0, 0x1DFF },
 { 0x200B, 0x200F },
 { 0x202A, 0x202E },
 { 0x2060, 0x2064 },
@@ -227,12 +229,16 @@ static const struct interval zero_width[] = {
 { 0x10D24, 0x10D27 },
 { 0x10EAB, 0x10EAC },
 { 0x10F46, 0x10F50 },
+{ 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
 { 0x11038, 0x11046 },
+{ 0x11070, 0x11070 },
+{ 0x11073, 0x11074 },
 { 0x1107F, 0x11081 },
 { 0x110B3, 0x110B6 },
 { 0x110B9, 0x110BA },
 { 0x110BD, 0x110BD },
+{ 0x110C2, 0x110C2 },
 { 0x110CD, 0x110CD },
 { 0x11100, 0x11102 },
 { 0x11127, 0x1112B },
@@ -315,6 +321,8 @@ static const struct interval zero_width[] = {
 { 0x16FE4, 0x16FE4 },
 { 0x1BC9D, 0x1BC9E },
 { 0x1BCA0, 0x1BCA3 },
+{ 0x1CF00, 0x1CF2D },
+{ 0x1CF30, 0x1CF46 },
 { 0x1D167, 0x1D169 },
 { 0x1D173, 0x1D182 },
 { 0x1D185, 0x1D18B },
@@ -332,6 +340,7 @@ static const struct interval zero_width[] = {
 { 0x1E023, 0x1E024 },
 { 0x1E026, 0x1E02A },
 { 0x1E130, 0x1E136 },
+{ 0x1E2AE, 0x1E2AE },
 { 0x1E2EC, 0x1E2EF },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
@@ -404,7 +413,10 @@ static const struct interval double_width[] = {
 { 0x17000, 0x187F7 },
 { 0x18800, 0x18CD5 },
 { 0x18D00, 0x18D08 },
-{ 0x1B000, 0x1B11E },
+{ 0x1AFF0, 0x1AFF3 },
+{ 0x1AFF5, 0x1AFFB },
+{ 0x1AFFD, 0x1AFFE },
+{ 0x1B000, 0x1B122 },
 { 0x1B150, 0x1B152 },
 { 0x1B164, 0x1B167 },
 { 0x1B170, 0x1B2FB },
@@ -439,21 +451,23 @@ static const struct interval double_width[] = {
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
 { 0x1F6D5, 0x1F6D7 },
+{ 0x1F6DD, 0x1F6DF },
 { 0x1F6EB, 0x1F6EC },
 { 0x1F6F4, 0x1F6FC },
 { 0x1F7E0, 0x1F7EB },
+{ 0x1F7F0, 0x1F7F0 },
 { 0x1F90C, 0x1F93A },
 { 0x1F93C, 0x1F945 },
-{ 0x1F947, 0x1F978 },
-{ 0x1F97A, 0x1F9CB },
-{ 0x1F9CD, 0x1F9FF },
+{ 0x1F947, 0x1F9FF },
 { 0x1FA70, 0x1FA74 },
-{ 0x1FA78, 0x1FA7A },
+{ 0x1FA78, 0x1FA7C },
 { 0x1FA80, 0x1FA86 },
-{ 0x1FA90, 0x1FAA8 },
-{ 0x1FAB0, 0x1FAB6 },
-{ 0x1FAC0, 0x1FAC2 },
-{ 0x1FAD0, 0x1FAD6 },
+{ 0x1FA90, 0x1FAAC },
+{ 0x1FAB0, 0x1FABA },
+{ 0x1FAC0, 0x1FAC5 },
+{ 0x1FAD0, 0x1FAD9 },
+{ 0x1FAE0, 0x1FAE7 },
+{ 0x1FAF0, 0x1FAF6 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.33.0.911.gbe391d4e11

