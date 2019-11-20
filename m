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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15860C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01692245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEXXImQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKTAvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:16 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46908 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so12397572pgu.13
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eO8aQz4Zy5uE+LAgsGkV/hTDdYEKdzGW21yh6yxvbSg=;
        b=MEXXImQNHo9/xkPMyCauUDjp3yNUbC6W+JMNSgkqqvihhdw6Q0+rJFwYHerjqAXAYu
         YMdTVWS5gGncgygH7RLXDfuejm4QvtNmNtbbmg3rqrtDxtAVQf+Xr64DPiFT1D/XY1Sy
         T4dwatoxx01fi7oiTUEaK5FYI1I5WM3k/IzmlxjzrKJ8BikzU5ZHjGaBKL69txk9BMwI
         IYxuBmXvseYYAhijHS+lGc324wL77C/tSTEM1laHVkKT99tNqhByLcC3qPl66QYJW2T4
         Hw/gzz6UnOTkidhHqq5LzRG4RcX3Mn02SRCrSZuESXVvdZBxAtyh+ZmSi35P/BSyuvbZ
         XZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eO8aQz4Zy5uE+LAgsGkV/hTDdYEKdzGW21yh6yxvbSg=;
        b=tY1TKqrRcHGjQZcvY2JB3lhY+jKS4yjUD4hRAd/ISCxqzrUz21u1sm54Te0I4d0Wsz
         BEC56L5mr/h+TeXobBeNTXW3WCkrxJKeePv5U9CeJ+Xs2ofNVl2Z1ATH3rvuyHqUjrUE
         Cqdh/rejfcU99tsNGn/8kHCnO+113KBJeBntx9pHvNs9yR4yQnCVuZNzuvkipNV7PojZ
         P7mJtlEmPlwI5jvioFHK6Dzd5txQU7P6bg7wamMcUxwzmOfZYsBu6fzlmaXuN25+edxN
         jmjHs7ibXR5jJUL9SROOh2ufsAMSRHTz+czHigG/b/LwsTs+eS8hpL99wk4mZ3qUOilL
         uYeg==
X-Gm-Message-State: APjAAAWzo2bD+FdOeOhQFrH6FJ1pfNvKifQy6bFDH8ZVLJXLdvHMZTxM
        eQ5dleJhhFgUgH3vZoiizK+iePol
X-Google-Smtp-Source: APXvYqx8gFeRsgjupP9twD4/wIinuglZz0e/X8nNap2d6npTaIoESa7HRf+zPfNtQXDoYh1Byaur2A==
X-Received: by 2002:a63:ee44:: with SMTP id n4mr18271pgk.137.1574211073446;
        Tue, 19 Nov 2019 16:51:13 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h9sm10943578pgk.84.2019.11.19.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:12 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 04/11] completion: complete `tformat:` pretty format
Message-ID: <2baa7f8d3d8aaaa348014d4ce611d372e3d3a210.1574211027.git.liu.denton@gmail.com>
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

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..6bf91ab154 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1737,7 +1737,7 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format: mboxrd"
+__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
-- 
2.24.0.420.g9ac4901264

