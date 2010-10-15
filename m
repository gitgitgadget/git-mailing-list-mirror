From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2 3/5] grep_cache: check pathspec first
Date: Fri, 15 Oct 2010 16:26:42 -0700
Message-ID: <1287185204-843-4-git-send-email-judge.packham@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tgT-0001CE-1w
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab0JOX1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:27:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:41151 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab0JOX1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:27:11 -0400
Received: by pxi16 with SMTP id 16so197015pxi.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9fPpEUg3fc0t3YHf1DF8pbGTlLRQg60FHsHLBUw8wjE=;
        b=p7m10nqZvzXpjLzrLLxa0qGQZEkPHaoyzHsAojk/oRoAzlEImPXQr0NB84gObbzHWJ
         bLY42ihbegPD3zA+/PZPwVWTCsuhI4W8ORD5hKTHe1VJdwKwWjfMIK06HR6w4/vDxO5o
         Yyy+hQ1H8O/L/46xdHVuYo5VMo5SqF6fhoaus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nvQ4rkysLyT06uMRKOUPA19D2xjbpQFYH/+brBQuUn0qohgQ0BJRB2oY75b865gl/r
         25q3xXZLh7yVzp/LDduIXV06f7NVVnRHAGyb1GFYrywlch9C5jC/6GTl/s66fyL4gCt0
         kkfXHQCtEcExxi763q7jEninNO9Rrg5G743wQ=
Received: by 10.142.140.14 with SMTP id n14mr1184488wfd.21.1287185228352;
        Fri, 15 Oct 2010 16:27:08 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.27.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:27:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159148>

This makes grep_cache consistent with grep_tree.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
In addition to consistency, moving the pathspec check up allows the
addition of a simple if clause for submodules later.

 builtin/grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a51eb2c..251c4e7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -595,10 +595,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ce->ce_mode))
-			continue;
 		if (!pathspec_matches(paths, ce->name, opt->max_depth))
 			continue;
+		if (!S_ISREG(ce->ce_mode))
+			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
 		 * are identical, even if worktree file has been modified, so use
-- 
1.7.3.1
