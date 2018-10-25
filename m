Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F45F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 03:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJYMAN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 08:00:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJYMAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 08:00:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so6764913wrv.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 20:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xUr8Zc1lCty2Inrh1QjEaSqMvByd47G9mktCjVeAKuM=;
        b=u37CFf7gUsYwtCiB+fRcj3UoYnkYjygBN3nwIpMOGXfaNLNtQxta15C1p6Nzx3ag4P
         SBiEJR4l6I4l/9+yKLZlVu+FMynndtoovW1kRGnq+derRK3FmmZbuGrkP5+AIatDD9Kj
         zOucNJire/vOMv4pCxBCEsFI+gAf7FWEZ2xYJZDlEypwmqGH0jOIqHzHW/B6Kfy618sZ
         jsQpF3HIqa4kmzwkTUDA5DbC9XpFApIM+OgSKGUsYdavrAz8f1E173nxmSwq9A+gy/t1
         2Ru3ONe7loMdjHtNU1K5s/OlM+CoTMTyRt/5nT/PHCri2mcRFYU7orWLoGAoS9m8RXL9
         8Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xUr8Zc1lCty2Inrh1QjEaSqMvByd47G9mktCjVeAKuM=;
        b=sVjxtDhHGD/sV01IPkiO2bRdsbXXZPoLntaG9TD9+voN/uiOVvCthfq+PY1ikJ2/eO
         mlgPMQc8qVFJDl6qfYZk4exwet6OH20O5uHVjo0PGTeDMB3luIreJyuz7cqMK/dZSBcs
         7qpOGblwVoEU4qTP7G1rrU61fgPBis6wd37o2E658AJS+e1JCIuSmDON/sVwfma19WN5
         oSp4fTZDQoemRl12f8Xh+oShMkzSHOlzWnJ4SSnPRB4qYorwXmvmrfR/ZlXj7yZ2DWwb
         jpR79kHYhqJyxZA4A9v2IxA4YFbE0n40R4OMb9ft167CRoUdOt0nYs4+ND+SBuYhTjXR
         i1ug==
X-Gm-Message-State: AGRZ1gINDCFi1mOhiruGmAp42znB5LwX6yL5KfnpXHyPKg5j7Q1Y1OGg
        nPGjouCVQ/nhE3lPxuvyqrPzUmVs560=
X-Google-Smtp-Source: AJdET5fHi0gmdTATxxNAI2IgqAMHMD9dOBFT33sbYstPToRdPI3D/fJa8xfn7Xv2ngvUc3Ow++WC+w==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15-v6mr2216374wrq.180.1540438161301;
        Wed, 24 Oct 2018 20:29:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u10-v6sm6370099wrt.59.2018.10.24.20.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 20:29:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, github@brendanforster.com
Subject: [PATCH] http: give curl version warnings consistently
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
        <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Oct 2018 12:29:19 +0900
In-Reply-To: <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 25 Oct 2018 12:18:37 +0900")
Message-ID: <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a requested feature cannot be activated because the version of
cURL library used to build Git with is too old, most of the codepaths
give a warning like "$Feature is not supported with cURL < $Version",
marked for l10n.  A few of them, however, did not follow that pattern
and said things like "$Feature is not activated, your curl version is
too old (>= $Version)", and without marking them for l10n.

Update these to match the style of the majority of warnings and mark
them for l10n.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 > I have a clean-up suggestion related to this but is orthogonal to
 > this three-patch series (after the fix-up is applied, anyway), which
 > I'll be sending out separately.

 So, here it is.

 http.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 43e75ac583..2214100e3b 100644
--- a/http.c
+++ b/http.c
@@ -834,8 +834,7 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x072c00
 		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
 #else
-		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
-			"your curl version is too old (< 7.44.0)");
+		warning(_("CURLSSLOPT_NO_REVOKE not suported with cURL < 7.44.0"));
 #endif
 	}
 
@@ -908,8 +907,7 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
 #else
-	warning("protocol restrictions not applied to curl redirects because\n"
-		"your curl version is too old (>= 7.19.4)");
+	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));
 #endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
-- 
2.19.1-542-gc4df23f792

