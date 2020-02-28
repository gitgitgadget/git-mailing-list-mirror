Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086AFC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAEF246AE
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3kKQo+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgB1Kh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:37:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38317 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgB1KhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:37:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id n64so1311970wme.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lisyLE2I9CMCX8tBnWtVcL0Iq/w7qM5N5Cich4o/I70=;
        b=Z3kKQo+RkYO0NNcMyqWo1JW6DrR1f29Ae8ANDZPR6biXndzEokZeAJMZ+7zVpHGFzp
         l20Ld5w7bkeewtH4+gF+Juh6/VgU2T2hUNvPWAWMjlRnVkhNu31vbnswRkIVL7EyR9fy
         WFhNDRImS4xEOPgPsPae4sd5cHJ08/Vu0OQpaIFyZg5Ip39FfxPN9/UZibmdFzqcveud
         BThJkbx/IG1uTTx7GKCYAGdC+LY7Z0L+mWjEGvc9WBfP6oFKiU4TV4PpXNYywdsfWBmY
         bYvbfuOGkZk85jPeWKdHOksiAt9SI6PU0Fem4p2Rk5NXns9bopbJM5zxCGLWcC+6HLxN
         0cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lisyLE2I9CMCX8tBnWtVcL0Iq/w7qM5N5Cich4o/I70=;
        b=YO/3jc0ObHLZoNKXo7i78ZlszJ99wwB6RHizBzOpuMkAxzQp78PMjyV1jbtV03FXGa
         aspYFKNWFBlUI8xLFOgGIa8/PEXJzPv+5oY2ctkSZ7BYN3UApg1mK11FyBYRjadush9k
         JLFeGaKQMC5aWQJPc3K+CcYhtwSg9/s2rI1Y+0hr8IKmdIWnlVyuhcHqhSsCNDkJ+ki5
         wFiVw7+CvZYru9OEjEfO26s4UNcBqTZqOlNSm7vcnBxUm7pb9Y8QLDWwo8cLAgn+oE2L
         FmC/SuD0D6NiFfuUfuXEeokPxkw2uCnsrJL3Jr+YdBAUoerEpdIsI14LXHXPYMUw3aYK
         LfYA==
X-Gm-Message-State: APjAAAXMsbH0Vr9wtxGlRAAgowyxK9wjuG49ej3WR+0MQdvDj9I/3gsJ
        /9OxT9RyIZW+iJq2Eu6Yag20azU15p0=
X-Google-Smtp-Source: APXvYqxJDCpljlBVSc/Uyco96MXJ1cbUxf9KeFXNiB29qbBBNEizBcj/w1LXXu85gI+cNZObBjJxKw==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr4182630wmj.59.1582886243061;
        Fri, 28 Feb 2020 02:37:23 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c9sm12089032wrq.44.2020.02.28.02.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:37:22 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 4/4] doc: be more precise on (fetch|pull).recurseSubmodules
Date:   Fri, 28 Feb 2020 11:35:58 +0100
Message-Id: <20200228103558.1684937-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default value also depends on the value of submodule.recurse

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/fetch.txt | 6 ++++--
 Documentation/config/push.txt  | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index f11940280f..8f716809f9 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -2,10 +2,12 @@ fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
 	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
+	recurse at all when set to false. When set to 'on-demand', 
+	fetch and pull will only recurse into a populated submodule
 	when its superproject retrieves a commit that updates the submodule's
 	reference.
+	If not set, it fallbacks to the value of `submodule.recurse`, and
+	if both are not set the default value is 'on-demand'.
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 54871f8213..2a5250cf5c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -112,3 +112,6 @@ push.recurseSubmodules::
 	is 'no' then default behavior of ignoring submodules when pushing
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
+	If not set, it fallbacks to the value of `submodule.recurse` (where
+	a 'true' value means 'on-demand'), and if both are not set the
+	default value is 'no'.
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

