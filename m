From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/4] add have_git_dir() function
Date: Sat, 27 Sep 2008 12:41:50 +0400
Message-ID: <20080927084150.GA21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:43:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVOL-00042n-SZ
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYI0Il5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYI0Il5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:41:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:37148 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYI0Il4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:41:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so874383fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=A5ky6ONK1TnBj7MWlBJNyUjAY23lSPOZWi4VeQ3cp04=;
        b=kvjGvX2a0/SZdpdeIqD9rUbVp38TKvDoWbEpv+1xN1Fq0iqCKlcSEm2oOh+OAoXj7U
         gyZmu2sHBvVaPfPr0GZsLkIR/ruAt0wd4BNFyTUDltVzeFdST4vw2Dljd3JpLwecBGVe
         GoUMOjC1yzfWBFLUa/XaPb0aSdbtEMZ8Qta+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=aaRFotBFVXfST62FmqAwwLwBTeay69TJFVwVEEHwVNB0NgDMtHxIn5x/gwSUYb4dA+
         qrNoXi9S7g8XkhZFr4+sAU0uus8YUI0tIIkvt0nU7oHIexYLmyL5eccA2FDugYve6nRN
         SmtmmQOQ57/mroZTFapsmCLH01jNkJgeZgRDA=
Received: by 10.86.82.6 with SMTP id f6mr2040064fgb.73.1222504914541;
        Sat, 27 Sep 2008 01:41:54 -0700 (PDT)
Received: from localhost ( [85.141.151.122])
        by mx.google.com with ESMTPS id 12sm4858537fgg.0.2008.09.27.01.41.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 01:41:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96906>

This function is used to learn whether git_dir is already set up or not.
It is necessary, because we want to read configuration in compat/cygwin.c

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 cache.h       |    1 +
 environment.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index de8c2b6..e0e46ed 100644
--- a/cache.h
+++ b/cache.h
@@ -313,6 +313,7 @@ extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
+extern int have_git_dir(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
diff --git a/environment.c b/environment.c
index 0c6d11f..0693cd9 100644
--- a/environment.c
+++ b/environment.c
@@ -80,6 +80,11 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
+int have_git_dir(void)
+{
+	return !!git_dir;
+}
+
 const char *get_git_dir(void)
 {
 	if (!git_dir)
-- 
1.6.0.2.237.g0297e5
