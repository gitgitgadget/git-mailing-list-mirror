Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F2C43215
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86E82245C
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjsrJEl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKTAvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so12435967pgh.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIydUo/IYcAoJOOuGNsGUXxD6F3x1J5VPQmxcbKlAFA=;
        b=hjsrJEl6KLLFbAo9WTwaHqS0m2fl7hrV3pgxlHEwRHAwEvdFUQ44n2VAGy3BxgHsxp
         dxJamQOqyNjsCtopdCI4i7+9k8pEk3Mf4rU2oRUcfMahNiyC2aiQYe5dfnw9v6i+or3j
         CUvJahPM872iFbfHhoB9PvUeafNgTfJ6T9thizKfnCT5kciKgiscirBsLrfRIgeEgwAK
         HCKgDPW20sS/wAWS19429cSFgWUEieK6Uuo4MbnLn403M9C5yMmTzBrDU1QJAlxA/fpW
         8hE5gt/ia6zRzpLp0Pj4rGYjSm0veS8d9cf23UB6V7Wa/im3N/RMRbGdBvx4eRM/B7rp
         nUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIydUo/IYcAoJOOuGNsGUXxD6F3x1J5VPQmxcbKlAFA=;
        b=ohnped4uvqNBhkFJJ/W1bGv9Bqmb57XtCmOk3y+DUe5vNIGdhZTHK5JrhrFTsJbfxI
         +QtBRGuqskItM7/LlqAMIx21HDJoo7JoOVJvAPnUpBp8o6V6glPIclY1BLFezw13WgrG
         ZLx4y756tpP5JG8IRtKDLG6hMDRxWZZBUvZwLZOXz+fdH8bmKzkJOY3Da97ElcrCWE2Q
         qtYDM3dV49kX2gShqTNG/vJYWcYyfszRg+jRL6ybBhM9ObEzGb25YPC29whG+POoQ9y8
         ufKfwHLthiqDZs7PL2xqYZhOlygjhvT6MgulQN9Eo2c7U75Po/5ol5888wnMbDEy/nED
         rEhw==
X-Gm-Message-State: APjAAAVvG9UqQmpFJCbFjE5AWD/BGCHG2yrBFOlVN3oz01e4AMs2Esk3
        adrUJi6d1Ks9R0THxgjhzjve16mF
X-Google-Smtp-Source: APXvYqxvJio6vm6Ljbm+Mc2g8ium+GC1xuX8H0UvOhM0oyisElvtBz22OZCPIqYYDiOW7gOZ+UTbxA==
X-Received: by 2002:a62:fcd2:: with SMTP id e201mr620113pfh.52.1574211090477;
        Tue, 19 Nov 2019 16:51:30 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id b5sm28379764pfp.149.2019.11.19.16.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:29 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 11/11] SubmittingPatches: use `--pretty=reference`
Message-ID: <1281927cb3f03f17d71abfce7f559df8e02306be.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git was taught the `--pretty=reference` option, it is no longer
necessary to manually specify the format string to get the commit
reference. Teach users to use the new option while keeping the old
invocation around in case they have an older version of Git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a1aad13384..af9fb356ca 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -153,6 +153,12 @@ The "Copy commit summary" command of gitk can be used to obtain this
 format (with the subject enclosed in a pair of double-quotes), or this
 invocation of `git show`:
 
+....
+	git show -s --pretty=reference <commit>
+....
+
+or, on an older version of Git without support for --pretty=reference:
+
 ....
 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
-- 
2.24.0.420.g9ac4901264

