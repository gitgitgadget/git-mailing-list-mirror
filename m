Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F1C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjEAPy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjEAPyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:54:21 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF712C
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:54:02 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-555e853d3c5so24171377b3.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956442; x=1685548442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83J8iMBnkUeKwuKz06wa79htp85qJvw5LSSb2dLSpgg=;
        b=TiqTJZwv4LhRPgcqTRtN1bekf9YMKpU4W09pKeBSYIQmlRrTU0xi9T3yx0bJ4cs1bt
         cKsebGJvRrIJOSsYKrfDVsVKJ3zJJdNtfJulCwTK5okqLQ0GvnmXVIiKxMc7mDx20n8t
         ACh6SO6bmCOKoHgrX068tjZE0GNJb29Ux220lp7Dx/FxLWF1C6XVcUt5yuWXuD0DE3N/
         anMCbyHMtgKDFlhuUu+S4poXyeRWatZ00zDdBkKz7LXJtvjSS2m4bQd4vum9DKl2JSGu
         stDvE9QcS6udQgL1E1lFTJg/hg6t17kjQLXjtjnpoS7AQ/2RfEV+kkmbW8R9AHMv3AkD
         EdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956442; x=1685548442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83J8iMBnkUeKwuKz06wa79htp85qJvw5LSSb2dLSpgg=;
        b=YmMwbrLyUOU6vYEr+wxPzfRfrwDG6cu+LKvbX9bstJbshmLcZD4e+tG0SW1pvUxkP2
         jW6nh+V5lx99M5MkdpL7iIX2Sxaqz1KP7FNS9qIukCc16Zqeg4dnK2/Nlz9ve0cmtNza
         K9I7rBG5qoVfU1Xh+K1mveVafeXFRXxlaPWBwjm2sQu5nPijONXwDaYgypacW2pXwoCe
         GPvAYA3fJ3QDgXSU+oBadECsspGcrokC8gQxx5oIUUAM9TzSumGckGEam4V8mtWSNXvN
         Qj6Lwl7RBLbOCnHfFVs4O0Ur6E/r+IXypgT7Yi40VU1PGRNu4NCIjU3RuVG/X0OKSzF/
         e9hA==
X-Gm-Message-State: AC+VfDzXm/yYXiaX4gytR9C9cmyKgWkuBv1Qu2IWE1eDVDTDkGD39qoi
        D5vLskS+JXcUSCy5QvSJpCzg0csKiHGc0IujrW4gKA==
X-Google-Smtp-Source: ACHHUZ4pV1EUT9CY812/bnq0Ibbi89wofwhAXAd3GxDMVgtt3bRo8ODhVAjzccRV6Phspn+SBT0MCw==
X-Received: by 2002:a81:6584:0:b0:556:dedf:758f with SMTP id z126-20020a816584000000b00556dedf758fmr12825778ywb.48.1682956441842;
        Mon, 01 May 2023 08:54:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m66-20020a0de345000000b0054bfc94a10dsm7406981ywe.47.2023.05.01.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:54:01 -0700 (PDT)
Date:   Mon, 1 May 2023 11:54:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 5/7] contrib/credential: .gitignore libsecret build artifacts
Message-ID: <60bab84359fd453c231adaae9a11b20bb19173db.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The libsecret credential helper does not mark its build artifact as
ignored, so running "make" results in a dirty working tree.

Mark the "git-credential-libsecret" binary as ignored to avoid the above.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/credential/libsecret/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/credential/libsecret/.gitignore

diff --git a/contrib/credential/libsecret/.gitignore b/contrib/credential/libsecret/.gitignore
new file mode 100644
index 0000000000..4fa22359e2
--- /dev/null
+++ b/contrib/credential/libsecret/.gitignore
@@ -0,0 +1 @@
+git-credential-libsecret
-- 
2.40.1.452.gb3cd41c833

