Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDABC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736BE2071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNmD10Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVS7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:59:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43511 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVS7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:59:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so3723733pgq.10
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnFNJ0MYhYflrcSj1X4V9eUwo3JGpoLhuOe1w4GoLck=;
        b=uNmD10LjlYdpG0rTIK+2Q8yPoDqVsWp340q3nG5cY+9/2hm/RDQT5Bjj5G37DVXeb6
         MXPLN2/xF8S8nEEtpyHhIlVFGRKp4M4Xek6005trJKlfsAofhuXLle4zjj03Ig8yHOWu
         CXdLgg5rPh3UbUGzSfBFgLi0OodFXRIYakMVQFbgr772HgDChbwSgO3j3Yy3wqluZM6Z
         NFsv9OyL6dRKDs+ErSWHXrhP58phfSWY69l7BFD1/zHagP+GwMQBxTHctlxvR2aRab5W
         A40PoeZ+gp1/q8hlcJFfgC5XGnxTa9FInVxsoo+OEbDfgBZxU3oTE+7JLLx+Ci4pkTvg
         FuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnFNJ0MYhYflrcSj1X4V9eUwo3JGpoLhuOe1w4GoLck=;
        b=SWm4bX+N0KAwupWXC+GuYlRad/KhwTzJ718fSuJ2KT4cr+zOlU6ASUeKRLtmnroGR/
         DehCGA5XPbpunsqxMKpLoJB34bxOzqTM+/e/MPBI8Xids6plJ5jA3q/T1q/Vehu/kkuk
         pJ5/Rxfv6TbaWpeMztpgzE9uULnN5P9qiLuLidDof/BRj0qB8roKcuNJ+A7u3dMVQ5t3
         sPULX4nBswVJKciuew73lyZgQ+r/V5LnW8rO7jiYW9tCdKVe0dlMkyDZNfM68RtckRyC
         DRR9crkxfT7hDv9AnWhLpJ8Z8gWRXPzj/Qbl0a5Z8zKSFv0rDWm1am31sp0aCME5BYbr
         uuJQ==
X-Gm-Message-State: APjAAAVLFamFh9Lamd+hIyf7WL2T4c1EGzR36Eh8uyfzBR+AdkKq3Sgm
        1PLL/1mmt0ixnBp5h6EbkgWPiSzG
X-Google-Smtp-Source: APXvYqycL4xcn5rgtOy8501cR42enTWew6TSTtb6+NPqrsb1a2gvuYYsCOtLux8oIy+GxO3ocuNkuA==
X-Received: by 2002:a62:ae17:: with SMTP id q23mr19703848pff.2.1574449189401;
        Fri, 22 Nov 2019 10:59:49 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id m14sm7579152pgn.41.2019.11.22.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:48 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:47 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 02/22] apply-one-time-sed.sh: modernize style
Message-ID: <1fddaab7011dae7cdd15dee83a94b021085f6703.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert `[ ... ]` to use `test`.

Move the `then`s onto their own lines so that it conforms with the
general test style.

Instead of redirecting input into sed, allow it to open its own input.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-httpd/apply-one-time-sed.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd/apply-one-time-sed.sh b/t/lib-httpd/apply-one-time-sed.sh
index fcef728925..3e9a615311 100644
--- a/t/lib-httpd/apply-one-time-sed.sh
+++ b/t/lib-httpd/apply-one-time-sed.sh
@@ -7,11 +7,13 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if [ -e one-time-sed ]; then
+if test -e one-time-sed
+then
 	"$GIT_EXEC_PATH/git-http-backend" >out
-	sed "$(cat one-time-sed)" <out >out_modified
+	sed "$(cat one-time-sed)" out >out_modified
 
-	if diff out out_modified >/dev/null; then
+	if diff out out_modified >/dev/null
+	then
 		cat out
 	else
 		cat out_modified
-- 
2.24.0.497.g17aadd8971

