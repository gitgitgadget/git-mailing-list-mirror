From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/20] remote-bzr: fix branch names
Date: Thu, 25 Apr 2013 20:07:58 -0500
Message-ID: <1366938488-25425-11-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAs-0003xY-AR
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809Ab3DZBJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:55 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44607 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3DZBJw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:52 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta17so3030615obb.40
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=glJ+smFRb+PbL+r9MyANm6UnJJ0yZozMhMf3N4NnQjw=;
        b=qyuzoeDqrkT4+7PfHTpPa4XbsQMPPMX8NzG5YDYqJIzqcfKRjpnB5r/IO6u5sBPLAx
         gn0A2fos6Ha56dDSMIyN2EHU6WP38uy3R7MtmGtSMml+fJ/mucX5YGNnumY4rBMqYsWt
         v3kCRv5CQX5uApTY8+ms6XnTgEQFEkcUBIGFBQ4QgGLhFru2/lG1GoqbcFv0NbLPiCi7
         +sFWC2sB71RWITxInG7kRhlDKTjcJV7fOG358f+GioOpZhYsxIA8We3CLszv8AQ5TzGs
         qZ5xAA7aCH64vaR3B6KlNQL6rEeyMe7AH3gkTLpvUkyzMCkWzqW0jrfb4h1ITwyinYoo
         kX8A==
X-Received: by 10.60.179.42 with SMTP id dd10mr22245684oec.51.1366938591855;
        Thu, 25 Apr 2013 18:09:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm5863426obc.1.2013.04.25.18.09.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222493>

When branches have '/' in their name (aka. sub-branches), bazaar seems
to choke while creating the new directory.

Also, git cannot have both 'foo' and 'foo/bar'.

So let's replace slashes with a plus sign.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3b33061..38cec07 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -781,6 +781,7 @@ def get_repo(url, alias):
 
             name = repo.user_transport.relpath(branch.base)
             name = name if name != '' else 'master'
+            name = name.replace('/', '+')
 
             if not is_local:
                 peers[name] = branch
-- 
1.8.2.1.884.g3532a8d
