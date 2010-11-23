From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 18:30:43 +0100
Message-ID: <1290533444-3404-6-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiy-00043t-4c
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab0KWRbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:35 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43105 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0KWRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:34 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so2584583ewy.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m8bFPhwmCjy29/gjtNDXAWczBkLmEZwh5FopV2mOK3I=;
        b=KgS11cT7LIYPwAkMN/7d0cx8JiqBilxq2HbV5nI0AxW7DCylhBma+4xi1dWEKEWH8D
         pZVGtDVvZEPMBXweJXRa8ZSfB557Yyv0KXvCUbrHbCQhsTvDsq/VWIYEWsTSc6ktAmpr
         P9xigNxCubRPZIVns2+yX7M4jJzu7YHljvTe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nKvfLbqg5Fprl9WMRJTqZk6i2N7v/ZjugkWAj8wWCxCYGo1FhrXcaAN4qLRkqGQYm2
         Xr0P9yisoKCxo9vy6pZ66mFdWa5seBwRNBLF/kPUET2zqcntAUnf3OOwlzPiYC6DUIfU
         KL0vqOL4Rc6O+LC5lvFFDrwH3CNRsOHQo5Cgs=
Received: by 10.213.11.12 with SMTP id r12mr7351126ebr.91.1290533490371;
        Tue, 23 Nov 2010 09:31:30 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm6008313eeh.8.2010.11.23.09.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:28 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161990>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index 8417fd3..29fd877 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -23,6 +23,8 @@ DIR *opendir(const char *name)
 
 	/* check that the pattern won't be too long for FindFirstFileA */
 	len = strlen(name);
+	if (is_dir_sep(name[len - 1]))
+		len--;
 	if (len + 2 >= MAX_PATH) {
 		errno = ENAMETOOLONG;
 		return NULL;
-- 
1.7.3.2.493.ge4bf7
