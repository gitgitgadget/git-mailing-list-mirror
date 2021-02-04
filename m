Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE40C43381
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DE764F51
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhBDJcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhBDJcU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 04:32:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66DC061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 01:31:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id w4so2476433wmi.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 01:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t01brVa3DPyyG5QvvLYXIclMlNeWgdfEbDYtwwEZ5z4=;
        b=q0wPmdY4RsyVHMroL/4kMMX0E3cTD/OFLkTYZvqPs+FDMkK1Swyv6MZgl8JfCW/RgP
         TchuntHZ2b9BkZy0P0Nr2ADcDtfOI4UycHeF70XhTqV2eRov0TEZ3xb+N2y4OpycXvfM
         mtdKG5r+gmPRTXiMXHS1sJDg6aw9bZGkSPifx0mqYZzZRSthcf3zx+3GksNl1oTKg4kZ
         fjyJQTH7xJ1Mz6aC/FevS01ir43A4cB8KDfuVZ4D4Siw1AACM+HeeeV9TBJPSlcEwBCg
         5rwVS6zGtQzPQZkTa9Hc+vG3+lUJDxf5f9deLcQYv1HChWJc2gWdEiYh47Rnz3vVIZcy
         rDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t01brVa3DPyyG5QvvLYXIclMlNeWgdfEbDYtwwEZ5z4=;
        b=r70C27/jfHEFPdayYwhiMNuaw8DjX69JLWx8VDgXi8ZCWGx6TnQHU+mPmD5leUe522
         jUMBDXHK1jEOui0WR1+5wyhksRzWw52eQURtcV5n6z0ckST69picmk4Z6F/9W2XGma3b
         O7le4R+U205LNqUewqSqcUmypTSJ/pwnTzIaVNDw3KmtK7tQLeo2Ach/fvBCwtMGKoyW
         HyWh9Y87F04vDvgTyjgNePcPhQqZcueOEQFO1TjkLWuADZsl1V0bHA126ycaUcFyKiSl
         wgKG1UR9uTLuKOZKOlDNcgmOqUEJw/LkQKG5+/QVEUIkUFzzbwG0KVkp/5xRgSKVj7F6
         xxeg==
X-Gm-Message-State: AOAM531aCWKIm8nGBiQqof+DHD/ULAMtljTgA8oQNh2PiP3CoOoHv2eA
        oHXawyYsI5tjCuEo+s/uNe8u/ng32EU=
X-Google-Smtp-Source: ABdhPJz7jsdJWatCTkgloaqiDN5HFfnAmprUAxGwYE48io5i4wA4qPDCENYTW6+qFzBJldy3mzUtmw==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr6828606wmf.12.1612431098693;
        Thu, 04 Feb 2021 01:31:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm7321069wro.46.2021.02.04.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:31:38 -0800 (PST)
Message-Id: <295fdc1cd32cffcef145d9dd0ac76d29580fa6de.1612431093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 09:31:32 +0000
Subject: [PATCH v4 3/3] range-diff(docs): explain how to specify commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are three forms, depending whether the user specifies one, two or
three non-option arguments. We've never actually explained how this
works in the manual, so let's explain it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 9701c1e5fdd5..14bffb272a06 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -28,6 +28,18 @@ Finally, the list of matching commits is shown in the order of the
 second commit range, with unmatched commits being inserted just after
 all of their ancestors have been shown.
 
+There are three ways to specify the commit ranges:
+
+- `<range1> <range2>`: Either commit range can be of the form
+  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
+  in linkgit:gitrevisions[7] for more details.
+
+- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
+  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
+  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.
+
+- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
+  <base>..<rev2>`.
 
 OPTIONS
 -------
-- 
gitgitgadget
