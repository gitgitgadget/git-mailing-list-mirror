From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] mailmap: remove redundant check for freeing memory
Date: Tue, 20 Aug 2013 16:18:00 +0200
Message-ID: <1377008280-17230-1-git-send-email-stefanbeller@googlemail.com>
References: <52137A63.3010609@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Tue Aug 20 16:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmlA-0001M9-43
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab3HTOSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:18:06 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:33062 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3HTOSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:18:03 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so237390eek.14
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nT4eK3K7YkYC0nkkS2WIApgPSJjRcw6uLR9wmwFgYbU=;
        b=XJtIyK0N5+j4Pc14mnkrpgm13sz1qXjN0tIhjq54AOdjSp9Wwc6/iv1UPyx9c4eniA
         QOx7fmNxs1UMM/9mBCVkoyItsDhPHadu+n000VE6BxMhZ3WB+iw6F2XN6fKj1V8xlfWO
         vmyaYQaWIRe4jmeCZnlZ/0PQ31XhTvm8CIYqIbEq5LgUYc7DysS8H9ns5H2w5EBXL0EY
         jycx54BcsSy0dMR2EwEwpfhzIAVuY8yR7xkqS5xVl4oeVjxiVX6XgCGJlAugy0u+uW1V
         O5AaadMqb8TDvenUVDZ81Aoc/G7gWdjl28942C1vHaVHCDLr0aRpuxmUFraggJIYkyZS
         z66g==
X-Received: by 10.14.110.72 with SMTP id t48mr103820eeg.89.1377008281972;
        Tue, 20 Aug 2013 07:18:01 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i1sm2763211eeg.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 07:18:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <52137A63.3010609@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232601>

The condition as it is written in that line has already been checked
in the beginning of the function, which was introduced in
8503ee4 (2007-05-01, Fix read_mailmap to handle a caller uninterested
in repo abbreviation)

Helped-by: Jeff King <peff@peff.net>
Helped-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 mailmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 44614fc..7d5caa6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -153,8 +153,7 @@ static void read_mailmap_line(struct string_list *map, char *buffer,
 		if (!strncmp(buffer, abbrev, abblen)) {
 			char *cp;
 
-			if (repo_abbrev)
-				free(*repo_abbrev);
+			free(*repo_abbrev);
 			*repo_abbrev = xmalloc(len);
 
 			for (cp = buffer + abblen; isspace(*cp); cp++)
-- 
1.8.4.rc3.1.gc1ebd90
