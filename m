From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2 2/3] blame: honor core.abbrev
Date: Wed,  6 Apr 2011 11:20:51 +0900
Message-ID: <1302056452-5387-2-git-send-email-namhyung@gmail.com>
References: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 04:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7IN2-0004UH-R2
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 04:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab1DFCVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 22:21:06 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59876 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1DFCVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 22:21:01 -0400
Received: by yia27 with SMTP id 27so415297yia.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=cSQZx5zzroYLpvoyMErqLgm7znB/4gTo0MxZfaR/2Cs=;
        b=GS8+cEdLDb5YOqta3VLauTjBqVNgF4qUjohMfVn0lM/mWbxD6LLH4X3vBoPRg4j6tN
         61sxkK8517wkUpKTa81l+SAQ0XJL7WGrgas4B8rwb1dFYRaDhdfquoIVpVdX/F54ZGfo
         6zHvVB/gU71PIXt/GWSrJaXqtmw2RMtYGXgD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h92OUuxfuniokZm90xc6kpfKdakqePnfv8dME++KMVL/vQmnngwPFiAotq2KufcoBF
         mtUs8Jx3U81/wgA0errTsovZ/x9dmB1o5N+qB/yYfnxjdOyHFCZ0Hw+SDVfTERj0HbxM
         aW/TfuBh/7Bqek/NYsWMF4N3RoR1Ii/yoERxI=
Received: by 10.150.147.15 with SMTP id u15mr1396640ybd.327.1302056461265;
        Tue, 05 Apr 2011 19:21:01 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.173])
        by mx.google.com with ESMTPS id p23sm443416ybk.24.2011.04.05.19.20.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 19:21:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170949>

If user sets config.abbrev option, use it as if --abbrev was given.
This is the default value and user can override different abbrev
length by specifing --abbrev=N command line option.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 253b480..4639788 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -41,7 +41,7 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts;
-static int abbrev = 8;
+static int abbrev = -1;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -2347,6 +2347,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (abbrev == -1)
+		abbrev = default_abbrev;
+	/* one more abbrev length is needed for the boundary commit */
+	abbrev++;
+
 	if (revs_file && read_ancestry(revs_file))
 		die_errno("reading graft file '%s' failed", revs_file);
 
-- 
1.7.4
