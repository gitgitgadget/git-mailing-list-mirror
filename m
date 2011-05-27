From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 1/3] A Windows path starting with a backslash is absolute
Date: Fri, 27 May 2011 18:00:38 +0200
Message-ID: <1306512040-1468-2-git-send-email-kusmabite@gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPzTC-0000SD-Q5
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab1E0QAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 12:00:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34670 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab1E0QAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:00:50 -0400
Received: by ewy4 with SMTP id 4so679469ewy.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=l6vNHpgp1jHEWe8jkEEIb7RBUe3ghuUXzU9+HMvOL3w=;
        b=eOo0O0p883PtwIDowcQ+BPbhXlwV/kY4/LN35P4cS5y+e+JyfC2bBjSNyljYqQowUQ
         sHReyMISBQgxEz2LMrMXH92MQGBA7bxwG4Rikj4rzhCpsEJMfiI48J2Cik/VG+16M/V/
         JmfmR6P+MfYnKlPehFk6JMAyJEjYn3MYdQMIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hafVddZTnIBmD4vDnl+aXKxfsSqb67wbpAcnjhH18EBHGvmPkFNCoxxwsyptlwHyrq
         48ciaGZye7DAf3Yfnasmxw5LEacaFiEYcoUnaUAVMd/VJJRLVbERWuF5WCX5ewo6b6EA
         6QOBDGCPCOh5GW8BctFN/MYGhQt2dd3OiawKw=
Received: by 10.14.4.209 with SMTP id 57mr841424eej.87.1306512048765;
        Fri, 27 May 2011 09:00:48 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id c46sm1340524eei.17.2011.05.27.09.00.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 09:00:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3775.ga8770a
In-Reply-To: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174626>

From: Theo Niessink <theo@taletn.com>

This fixes prefix_path() not recognizing e.g. \foo\bar as an absolute path
on Windows.

Signed-off-by: Theo Niessink <theo@taletn.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index dd34fed..555bf7f 100644
--- a/cache.h
+++ b/cache.h
@@ -734,7 +734,7 @@ extern char *expand_user_path(const char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
-	return path[0] == '/' || has_dos_drive_prefix(path);
+	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
 const char *real_path(const char *path);
-- 
1.7.5.3.3.g435ff
