Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D20C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F9F61163
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhINH1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhINH1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 03:27:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51265C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:18 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id g11so7850407qvd.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h15GclacXx9jbQTt9uwS3uPiMb/zWgUkYcoDZpnt9m4=;
        b=l+Y37duo4oJu8HdNRc1ZGApyKkgph7GUVgAua6o8ICi3nVSKNQxe5xyOjFZ2UpI1Od
         7KHopxVHDVXO5Crcko7OBWmThchWFM8e4+u5TGBFYTnbRve3ViVN69lwAsPN6pzRGFbE
         Ud+KFCJNotMOB1UQ+4Bx+yu3v7oQYUgjSRtCHSFb+31PfLH2VQLrr5g4FOpGM162f8yl
         JfMmt9ASqWVVrTv3tWuzGU2Kbnh5Qm1UxVEw3nA+dmCQiSmt1jHmwBvfnBMHRoQYdVn8
         YahHl7qKg6JN2ttOrbV/V+Ibv9U1WY8Zu/g+a93N8pYFb7k/ZAwHTa0lplcMTsc4Je/A
         /DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h15GclacXx9jbQTt9uwS3uPiMb/zWgUkYcoDZpnt9m4=;
        b=0cuqq5Jt3Fl5kKyinc9/L4ShbvgVWrSTpycIwVutlyZQbc156JtWKAt77DWvS7ZPzQ
         hPOCxg35Bm6wIlQrDVzmGTHN1gt1cyt+L5ISwDlzyTkmoi/kHiWSkSjEtKqvibcdOEYd
         SuYDRFw/U1F0hUnpV1r6/KRKDAwFD1fstx3D2IMtS4CZ66fTycmR3ERC5NXiKfJ52I9/
         LWNptgkX7VIYjd67qCdZ/F2wLw4BEbfkmroVEGOTF03XIN7/dTEOKWFFNoEQuO8ofxVm
         Wb+OzwHggVjqe5Tw6g/j7KarqjPDin8VHWGKQScT4Zm9/1X4wH3r261g57lQaD1ICYVz
         Y5Yg==
X-Gm-Message-State: AOAM532nXbgHF7JCJOXH+eulTvg9HQO3sYmwiW6nVPX8UgHtkRsqOBnD
        RgTKq/m6PRjGbwao3QyuflU6AcR3IKc=
X-Google-Smtp-Source: ABdhPJygRtWMmW7s3aDLt4bfAnAnulKm1AN02fcz8q3HyjAc4ID5vzcCfpKh66Zd2oWEXBjUMKINpQ==
X-Received: by 2002:ad4:5569:: with SMTP id w9mr3942352qvy.52.1631604377184;
        Tue, 14 Sep 2021 00:26:17 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o12sm5486554qtt.94.2021.09.14.00.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:26:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/3] windows: allow building without NO_UNIX_SOCKETS
Date:   Tue, 14 Sep 2021 00:25:57 -0700
Message-Id: <20210914072600.11552-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210913085600.35506-1-carenas@gmail.com>
References: <20210913085600.35506-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventhough NO_UNIX_SOCKETS was specifically added to support Windows,
it might not be necessary in the future, because Windows added support
for Unix Sockets in late 2017.

The implementation of Unix Sockets, uses an internal NTFS mechanism
and is therefore not visible at the filesystem layer, like it is in
UNIX, but seems to be good enough to allow to build and run the
`git credential-cache` and its daemon, with not many changes.

Additional testing to confirm trace2 (which builds and doesn't fail any
tests) is functional will be also needed.

Interestingly, Cygwin has its own implementation of Unix Sockets that
are visible as such even in the Git Bash environment, but that are also
incompatible with the native ones.

V3 Changes the commit messages as suggested and fixes the original ugly
implementation of the workarounds for the first patch and shoule apply
cleanly as a reroll of cb/unix-sockets-with-windows.

Carlo Marcelo Arenas Belón (3):
  t0301: fixes for windows compatibility
  credential-cache: check for windows specific errors
  git-compat-util: include declaration for unix sockets in windows

 builtin/credential-cache.c  | 30 ++++++++++++++++++++++++++++--
 git-compat-util.h           |  3 +++
 t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 10 deletions(-)

-- 
2.33.0.481.g26d3bed244

