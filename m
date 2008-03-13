From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] git-p4: Use P4EDITOR environment variable when set
Date: Wed, 12 Mar 2008 19:03:24 -0500
Message-ID: <1205366604-12970-2-git-send-email-shawn.bohrer@gmail.com>
References: <>
 <1205366604-12970-1-git-send-email-shawn.bohrer@gmail.com>
Cc: simon@lst.de, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 01:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZawA-00035V-3X
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 01:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYCMAD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 20:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYCMAD7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 20:03:59 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:47653 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYCMAD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 20:03:58 -0400
Received: by an-out-0708.google.com with SMTP id d31so755158and.103
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cJRKjmPPwAyvSrz7tG1xLfnvuevFH2U8rbD5tzyIZIQ=;
        b=YsH2I90nPxgAQ6xAgDGu/AezMV1j59XBHXBxia57U4gvlh9KzVj+VfX88Bcow9c8HzMAxN5lUsc+nQL2pZtPBQhjBCvbse8sGOxFgx/csbPI/1jnrWyhDBCYs78UvQKvAcqf53uaUlnPY6wsaClmsZL7vQ6k49nLndLeTJ9r6qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tEnO2PgAVoUkidI/yoZsVJVrUO/x5uT6x64rcUnK+ROdlQVoBd++G21LETpm9AzzScu0zDr6r3WamYLlLNjuylAFYjTpbmGvQDWkJZsKlvSbvonM3tdj6tKUOM8MmfR2l/EStza3ZMlTGvjrE4rSCVgzelFZ9TrCLWT8qEoO1sg=
Received: by 10.100.214.15 with SMTP id m15mr17605555ang.78.1205366636884;
        Wed, 12 Mar 2008 17:03:56 -0700 (PDT)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id s54sm1271328rnb.14.2008.03.12.17.03.52
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Mar 2008 17:03:54 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Wed, 12 Mar 2008 19:03:30 -0500
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1205366604-12970-1-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77030>

Perforce allows you to set the P4EDITOR environment variable to your
preferred editor for use in perforce.  Since we are displaying a
perforce changelog to the user we should use it when it is defined.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 contrib/fast-import/git-p4 |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 0b46084..55e38ff 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -652,7 +652,10 @@ class P4Submit(Command):
             defaultEditor = "vi"
             if platform.system() == "Windows":
                 defaultEditor = "notepad"
-            editor = os.environ.get("EDITOR", defaultEditor);
+            if os.environ.has_key("P4EDITOR"):
+                editor = os.environ.get("P4EDITOR")
+            else:
+                editor = os.environ.get("EDITOR", defaultEditor);
             system(editor + " " + fileName)
             tmpFile = open(fileName, "rb")
             message = tmpFile.read()
-- 
1.5.4.3
