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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0488C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8822F2245F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KphaJ68g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfKTAvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id q18so9231071pls.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNOEiwDlh6gywg3VEm4+SuBN5bCGcIPxs3rVKH+zSdI=;
        b=KphaJ68gyTD0bZgrnzKMWHT9mIg/eDiBcCmiUUvBcSqWFzx7em5rGlCAxg/BFDAxJW
         VRCd/x5dMHFGHpr/dp6Zci8o3esPFCyHtlg4Qr/DR7hRWh/2fYm2ISMDRNgtl8cDwfX6
         ZY4wb1YLF4Zb0X/fOpRMY8MvQIwiKvQBHSUaqpKcKseXrVluSfJJeyC3BCq8Yu+kBwNd
         X+HrFG4UZ/3X0VHRX6PnOMww4kbotj/98V7Ty9iNMIAQIFR0zc91PezepZCj1FrZhiX8
         DOa+LIeHD4jQWe0IFY5GQpJQBlBOo76iTtefBCC9w1sROe7nIJWfHD0TYgSAskoGgzIw
         vO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNOEiwDlh6gywg3VEm4+SuBN5bCGcIPxs3rVKH+zSdI=;
        b=rT3H39q1fvmHmkgUQQsZBj8hvjCSIdWCSQvYabnFsuUz3CVf1EqqMT/IGVJGWotGHJ
         e7PxXJJ1vXBVuCZbC4rNZBOtyryOIU04GT9I6q3Zp1hydyTjiMdWVT1n0CX0WzY7VSf2
         Jfb1yeVseXiLfNGCKuKiaRgewnIqyEyAPNVUT9oeQJiv+moCaf8f6uOHcPB9H7tllQ0C
         1YRhsgr6U0H992OXF0e8W9oxjY23UruNjJSt/6mORDr57a1akuK4JU4ZC2yQtfJRZ2EC
         CYb3FwpiGBNnxLEnDdqF9Jp9e+8+NdGdsoVsT8peWmyeQ7krvhq7CkxZWFEOmFkPX8/6
         mbVg==
X-Gm-Message-State: APjAAAUvdCs0rlBI2pT7x4eqweI7IH0cGS8PHSZXcsNcUXygrraBEttE
        snGMtkvkEgCVpdkD8Ju+cpflM1qb
X-Google-Smtp-Source: APXvYqxZLjLuBEPyPK087ZOiHc7/NhTTQpHoxqCLDDfoKBZ47Y60fWwQ0DstkJSgKWj1TJ68tiF+oQ==
X-Received: by 2002:a17:902:7290:: with SMTP id d16mr106438pll.340.1574211075919;
        Tue, 19 Nov 2019 16:51:15 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id w10sm17604169pgi.47.2019.11.19.16.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:15 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 05/11] revision: make get_revision_mark() return const
 pointer
Message-ID: <ac23c4ec4522dd2343b8147b95b2408eddba0678.1574211027.git.liu.denton@gmail.com>
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

get_revision_mark() used to return a `char *`, even though all of the
strings it was returning were string literals. Make get_revision_mark()
return a `const char *` so that callers won't be tempted to modify the
returned string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 4 ++--
 revision.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 07412297f0..2eb9ff089b 100644
--- a/revision.c
+++ b/revision.c
@@ -3934,7 +3934,7 @@ struct commit *get_revision(struct rev_info *revs)
 	return c;
 }
 
-char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
+const char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
 	if (commit->object.flags & BOUNDARY)
 		return "-";
@@ -3956,7 +3956,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 
 void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
-	char *mark = get_revision_mark(revs, commit);
+	const char *mark = get_revision_mark(revs, commit);
 	if (!strlen(mark))
 		return;
 	fputs(mark, stdout);
diff --git a/revision.h b/revision.h
index 4134dc6029..addd69410b 100644
--- a/revision.h
+++ b/revision.h
@@ -322,8 +322,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 void reset_revision_walk(void);
 int prepare_revision_walk(struct rev_info *revs);
 struct commit *get_revision(struct rev_info *revs);
-char *get_revision_mark(const struct rev_info *revs,
-			const struct commit *commit);
+const char *get_revision_mark(const struct rev_info *revs,
+			      const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-- 
2.24.0.420.g9ac4901264

