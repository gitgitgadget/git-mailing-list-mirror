From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/3] repack: improve warnings about failure of renaming and removing files
Date: Sun, 15 Sep 2013 17:33:22 +0200
Message-ID: <1379259202-5042-3-git-send-email-stefanbeller@googlemail.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 15 17:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLEKD-0006cc-EF
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 17:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab3IOPdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 11:33:18 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:38714 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3IOPdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 11:33:17 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so1497178eaj.25
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHYDFH3HjqyxN0n3yQu8FgCIkZ3tkCK3QG9SUVp5nLk=;
        b=yUu6Ebq6jJU2jt0L0/rlhYgGqfnkDFs/OLQP7+2zSxhN54JKhtMrySxHoEfiQzNXMA
         bJtdYFP1kuf5AMF6oAX6wzy5/hQ9VERhwelL36KeBvJZjs4Qyhza9WQoCzFEBnBl0/Cp
         cRwlG0l5y8EXIAPwpBgXDDmSMvkM0GkcPtJ2cYfAYjqR2/FVRGfl+ePf/KQNcRtD7Dj2
         lNL/3jjjQpJIImqBnHj1s1JS67xPAHbC8ErWaZVFS4Byu68YE3JAZu2cNY0aeedPgPyj
         H1faBDXPpt3lv8i7/zEfgtpoxn2IEwzm6EKwg7HafOBzVvXdR66b4PSgXgZi3ONd7DgB
         HW6w==
X-Received: by 10.14.183.130 with SMTP id q2mr35998873eem.5.1379259195280;
        Sun, 15 Sep 2013 08:33:15 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm33695854eeg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 08:33:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.273.ga194ead
In-Reply-To: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234820>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d345d16..f7e91bf 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -327,7 +327,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				chmod(fname_old, statbuffer.st_mode);
 			}
 			if (rename(fname_old, fname))
-				exit(errno);
+				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
 			free(fname_old);
 		}
@@ -341,7 +341,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					packdir,
 					item->string,
 					exts[ext]);
-			remove_path(fname);
+			if (remove_path(fname))
+				warning(_("removing '%s' failed"), fname);
 		}
 	}
 
-- 
1.8.4.273.ga194ead
