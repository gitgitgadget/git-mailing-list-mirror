Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D248C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3364C20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oygJPds4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfK0Tx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40956 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Tx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so11450110pgd.7
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7VPx+FtrqEcEOfcK3GddzAjZhHm6Shlg+PLWPLbqfs=;
        b=oygJPds4I5RTrUX5H4reC2aeVns6RAM6dajdgz3R6Ck+O2uoCcKx7elvrY0U/kxfpz
         wvK9V6RO8bsoG+0kaNjva1b41lX51PBt2qLuAUi9Tb6/Zd5k9LVLjOGOXucOJ3V7WuH6
         HFTFakB4iWlFR13ilYKhasXRcItNiCmU3FRlKuz0ljxHGHSzqbcvxiYSFjsaVKiBW1Kq
         qy/V7KQTQZKHE31olKlSzOJeJiiAM8btpZzHzhMdSEdgvm9gxvNb7yNQSk31RK1SCSsK
         ZM7r26xiI2ms3fqk3l/90hxUtFpQ/b18qxElV3Oj+oIt2pQ7iJflK3zI08+hgHVP01qH
         Mw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7VPx+FtrqEcEOfcK3GddzAjZhHm6Shlg+PLWPLbqfs=;
        b=OErG/noDquCKM5/0cU52evrJNbv4OvNPGekDBElIcHkm9Jhpijy01QsUFT1ClJKiVX
         ZDA0w5dBWM1+CRtI9i6W85zDYZCCgxTPxRHAM3KY8eETYPKlHy/OMD2EM4i/qKHSC1Gb
         pszKqsdK2KRtBDRBQoTpCcBpiHCw+4qfifmninq8uQmzHzUX/vz/ybFz2EKunZquFe8J
         P9R46B6xyyhMlofYGNRN0SJHaqA2sxQPwKslId5A8S9WnrrgtX8YCnWZc93vqrBgY2Gy
         aAZt4YFbXRULJFYxrklwGBJ3PCc9lXdMkXOXdxbYtO++7+glSUHHY56UbacztzHnlj3t
         rrFQ==
X-Gm-Message-State: APjAAAXrz9aDzfVO6jPZirCJJlySs9285wnlXMooMxn51u2y/DQQKfJy
        jmj+n4dz2spDyn6MD5kfQQ2em2mm
X-Google-Smtp-Source: APXvYqw/+RGR1b76PD7LQncg7QsqocAxwA8rdkwndB9HoEsK6uHkPUHA8uViHHefY0lkPkm5QhvBgg==
X-Received: by 2002:a63:f54a:: with SMTP id e10mr6436587pgk.401.1574884404270;
        Wed, 27 Nov 2019 11:53:24 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id j23sm17218641pfe.95.2019.11.27.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:22 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:20 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 08/26] t3600: comment on inducing SIGPIPE in `git rm`
Message-ID: <e3db06578df23ee6e2036c18a25e79ae6c4d46e3.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about intentionally inducing SIGPIPE since this is unusual
and future developers should be aware. Also, even though we are trying
to refactor git commands out of the upstream of pipes, we cannot do it
here since we rely on it being upstream to induce SIGPIPE. Comment on
that as well so that future developers do not try to change it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c3bf10edd..0ea858d652 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
+	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
-- 
2.24.0.504.g3cd56eb17d

