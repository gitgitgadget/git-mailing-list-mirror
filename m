Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9573C2BBE2
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22E220659
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPuMzm0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLDHr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:47:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42807 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:47:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id l22so3203165pff.9
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vkWyVPTtrMK6GEWgIf/a1BR/PZo9PO1eeJ9G6m+Xhk=;
        b=CPuMzm0jHswvQHVuQ/D5u0DU6LJ4TVCAhpkg3782Y13IhXAlHz6ngZyHztXuCbhZ7B
         jC6Ka9Xy5+RRWXVTMFd7zTUADwhmujYCDtKxvks6JFP21oSjhGioIkzy+BFpYuGCorNv
         1S7lA2JfIgzEUA5AVJGvcwDV3aVDSj2s7WOFbzk2FNdnap68uKR/kDD1E5qziseHCero
         twqFAarPgL2VvLCO92mRuBmneF3hBaxsAHtQC6I4XqlfWPpAOWjmBgiFfYMJ1wKiCLP3
         r2J2x3cdbFYzBABUgIV+sdlOrRWCQ5VtPoRRjI9XnnR7QCMDjf82eAyK+imdZk3YM1cr
         Xydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vkWyVPTtrMK6GEWgIf/a1BR/PZo9PO1eeJ9G6m+Xhk=;
        b=TgrIf7Xd4ryeW3myf6jlhSalRIOkfbch3EeXHFZDmMcizmu9PGmMwhQER2ijsK3aQw
         PI+PySKg/eDoDXt6+60NQUho6Qa3Opgir3qQreSNVuYTEcFGF4wBqDpaI2zyWEW8VwH8
         b2RL9+VJSOgZM414LPM5/9tdWugQhFbQDQ5E31iU0c0A7C/z4tPvaSsqhEBqt7b0rtmH
         9o3RkccnQZDigVsbkFhXF2TYtDzchy2JsiEgYBXMbGjOXccpIRhTpmYtg3bX3G8EgKgJ
         CyUqDUj07tilIjF2gx0U0YHUzO2Gqs34xKEXWQXV92VNgCPSN0fdzA5SaEk+VQZMNazQ
         RjnQ==
X-Gm-Message-State: APjAAAW3yeQKk2qIDZlsLKGhN8hV7v4fNPPV8VIHTulxm1U2ySqO9OIv
        X1+PBZTF2y0Sj18R9ehOYKa5F4qe
X-Google-Smtp-Source: APXvYqwDLg/7WAc79V4nGaYToAduyDqGCFYe2RTbc5lyLmFEKyr6B2yKCXq7tdrL9/u7sDFnSSU47g==
X-Received: by 2002:a63:201b:: with SMTP id g27mr2114192pgg.56.1575445676132;
        Tue, 03 Dec 2019 23:47:56 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id g191sm6720695pfb.19.2019.12.03.23.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:47:55 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:47:54 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] format-patch: fix indentation
Message-ID: <8cfde9f98e416aa44bc27e71d200990fd4d83ae6.1575445583.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index a26f223ab4..9c44682f61 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1350,7 +1350,7 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 		string_list_clear(&extra_to, 0);
 		string_list_clear(&extra_cc, 0);
 	} else {
-	    add_header(arg);
+		add_header(arg);
 	}
 	return 0;
 }
-- 
2.24.0.578.g4820254054

