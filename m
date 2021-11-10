Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D2C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB46061207
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhKJBqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE6C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so4062392edv.1
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAtfKNdCTtF2HY5pW9XfukK+7SN8KwhlYcfVTdzPkQ0=;
        b=Lwnb8pxggMeI2o6obOE8udd1zATGIo1milrDzL1mxw3kVo78lwGJdjTlHcl0OVK+Xi
         3De5LjqAdgZUeAimuHpIi0HUofOJslcvuiROLoLfXIhwRdT5fZPE2i6u27nOPmYDn/SE
         8L8sGa22TkvhiBZ6/0BGg+VjcdV9j0iq1C2m4wSYNq9suyGiiFIFkJ97DbVhoFDM5fab
         ww/SxYVSFdvvxPWPipKx3VL/pNcyfMNh5O2YB+OSjX/u4x44lYj4pCZbGs3+c6I2I9ix
         cbyOcdhQgrryZ75Spexb+AC246BL/46DuIpY0FwB89pN3u1X34k9fZSj0kB2vhTy+pIh
         4AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAtfKNdCTtF2HY5pW9XfukK+7SN8KwhlYcfVTdzPkQ0=;
        b=cMu65lGCYpkSwEjwarSFh5+ldWEEDKaXB1NStJ7Qyh8hH4TBhZRJ2gwIbnaR0Bb47X
         YDV+5hr4JOCf0VNgvK86vyv6GdMHiyxghz14NYs6l2sDDxmD4Kq+EF0yiemM3Sm8jst8
         5cdhuipMPF/vxt1RPLF9j+gLL2/1ocspU25v5pNd9Bg7psAmS7U0N3CNtbATcY4jGMsV
         suTyFQ1znlz99pHTKYqkU0VqSvgEwvuOmLw/+fG6RhOKBZIQGvzSj1Y9Gdeix4pu6ySB
         1JBkOLr5bifnyo79tyQfzsk/9aNJMf9wWBbRLJK2t05HWGg9TcgXbUljHj3pIAKV1kRb
         ztEQ==
X-Gm-Message-State: AOAM532pIn8q5m6E5kYMGQvUponxGbrgHz7SiJI431lu4kobZzRDQLdT
        aIsuSvIImaYKJKMwJXrccFAd1Fm2eFGPSg==
X-Google-Smtp-Source: ABdhPJyVwtz7XjX5t6JEBfo/cmo9pz31EuyAAmzkCgP+VBQsBsknNLWDEN1f3ng5fpi4XtZ+CHEaYA==
X-Received: by 2002:a05:6402:84c:: with SMTP id b12mr16255366edz.323.1636508635023;
        Tue, 09 Nov 2021 17:43:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Wed, 10 Nov 2021 02:43:43 +0100
Message-Id: <patch-v2-1.8-1435db727ef-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.0.rc1.741.gab7bfd97031

