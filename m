Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB64FC2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39A206B8
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YszyC5E7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgDEPuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:50:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39883 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgDEPuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:50:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id a43so15803589edf.6
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DgWMUrbRC5zIbygwDHF/h5O1x30/0Ts6z+r7/UHDy2c=;
        b=YszyC5E7RmJS2jNu4MvdLZSefzpUqw2YE0OYeNFSZdXc+BUJtQBVXGkIHSm8C3s/HQ
         gKCa2+BTiLNzfKyyp1irSDzJPmsSVKs0goss2NUmELktbJ6CvUgOGclTGYBjLk4BLT+J
         5ZZmxdzT7ot49mqvwneO4BiA0gIsKHkQWsCen2DxGHEHYTtokQFptTBSd5Lhgoa2S+VA
         dX38bwHtIzcL3e4RnQBUHCDsGfA42AWHvSr9bFUtd3WXX913P4l3ST6/ux89rdrJJt/6
         /g+5dGLkFCrq+uDFLaMfNdMqgYL86hiEP3riayObCECKGC6qVaZ9WqS8vNvdoTTos5X1
         F8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DgWMUrbRC5zIbygwDHF/h5O1x30/0Ts6z+r7/UHDy2c=;
        b=aeRgMXK3PUkluKNj9JYDxWYqt+X+MeU24l7K+R8xCUInwxlCDlKejQNmOrWHhxvTGs
         qoZFzY2L7gayRpk5H3FbLo0mVTfSoC+Zwr3CgDzt07Q+FdkiPtQpiqrTQEUJpDDsIy7p
         YoQBaO+qAKkw/mUaKMs7dhMUpgiJuwPDCMnJGukt6viMNlhNMOOWOjJMcAhPQi1PK1rV
         Lge/CNf8hkL6WUQjYU2Oj9zkXFGIEpqCRg2Y4dWP7e0wgMmKq20WyQGUC/MMt3d8Ltqc
         L8/6IZCIwt4r3g59p11VyI5z1IMilDIGbiykfM5VsRhc6wbyxlzhpFztJmuPPZbDWyaF
         b3yA==
X-Gm-Message-State: AGi0PuaHqRuwkpKL0uxhcvZQsDdTJF3Cuib+jD8/oq1hujoqHclLKnMI
        T6RzJ07rVrmWIcx51G3Q6+Oxtv8U
X-Google-Smtp-Source: APiQypJtQ9CDUe7ftkQNhLNrL6JQYt6EbSqd0zBufi1qQbLeRYspW2vO9aBM74i9ycVkAClnVoNhKw==
X-Received: by 2002:a17:907:aab:: with SMTP id bz11mr17145251ejc.311.1586101821977;
        Sun, 05 Apr 2020 08:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id rk25sm2669186ejb.14.2020.04.05.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 08:50:21 -0700 (PDT)
Message-Id: <46365925d22d31feae7618614dd7872a19bebeef.1586101819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
References: <pull.751.git.git.1586101819.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 15:50:19 +0000
Subject: [PATCH 2/2] pull doc: correct outdated description of an example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since f269048754 (fetch: opportunistically update tracking refs,
2013-05-11), the underlying `git fetch` in `git pull <remote> <branch>`
updates the configured remote-tracking branch for <branch>.

However, an example in the 'Examples' section of the `git pull`
documentation still states that this is not the case.

Correct the description of this example.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-pull.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b83..21e10905fa2 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -229,9 +229,9 @@ branch.<name>.merge options; see linkgit:git-config[1] for details.
 $ git pull origin next
 ------------------------------------------------
 +
-This leaves a copy of `next` temporarily in FETCH_HEAD, but
-does not update any remote-tracking branches. Using remote-tracking
-branches, the same can be done by invoking fetch and merge:
+This leaves a copy of `next` temporarily in FETCH_HEAD, and
+updates the remote-tracking branch `origin/next`.
+The same can be done by invoking fetch and merge:
 +
 ------------------------------------------------
 $ git fetch origin
-- 
gitgitgadget
