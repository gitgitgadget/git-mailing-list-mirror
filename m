From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH] builtin-clone.c: no need to strdup for setenv
Date: Wed, 1 Apr 2009 15:52:25 +0430
Message-ID: <20090401112225.GB2237@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 13:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoyYn-0005f7-IU
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 13:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbZDALXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZDALXO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 07:23:14 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:33017 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZDALXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 07:23:13 -0400
Received: by ewy9 with SMTP id 9so3018987ewy.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=9qKI/rW8FYnLr35JwSmJla0RK1JFFinkQIqgEQ/c5jo=;
        b=KoaPt8yJutmiScgiriV+yVVd1xz6nLCLfpwWaqdiTepXtWmraVy8u5nUORAsjqHhKZ
         idLEPLG4AQUzEGRQTdCxIYX60sjKk3PeToQ3OrBT7OI6glZKxWp6EzA7RDZ/B2L6YrG3
         XBQP8XBH+3TXl2TWYQ7KU61XeMF+Bo4OIM6d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Vn6Ck5Lbld9Ldc//EURSMYqCHmYBhtQyG4Wc3ZVQCA/pHdZtbNDyygLAFNnQc6DWBr
         jSP/A7TxL7GOwGkjSX7InPEMQuK9Gxbzwfu5dM+8YSup5AG1V6qMBWYwRjFvjUJBj3Oj
         wJ/FXSNRytECcXCU1pW/lp8z8Nz+FqGjSSMkg=
Received: by 10.216.73.79 with SMTP id u57mr2518891wed.40.1238584990020;
        Wed, 01 Apr 2009 04:23:10 -0700 (PDT)
Received: from localhost ([85.185.70.254])
        by mx.google.com with ESMTPS id 28sm4163436eye.14.2009.04.01.04.23.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 04:23:07 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115371>

The setenv function makes a copy, itself.

Signed-off-by: Ali Gholami Rudi <ali@rudi.ir>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 0031b5f..28d15bb 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -406,7 +406,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
 
-	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
+	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
 
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die("could not create leading directories of '%s'", git_dir);
