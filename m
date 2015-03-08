From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] git-instaweb: use @SHELL_PATH@ instead of /bin/sh
Date: Sat,  7 Mar 2015 21:05:38 -0800
Message-ID: <42064c37a546290187a4a33869526c6@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTPW-00061j-4d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbbCHFFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:05:44 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42920 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbCHFFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:05:43 -0500
Received: by padfa1 with SMTP id fa1so63256033pad.9
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rNbJQR1C9Kxfmq31DJL3L1rRkmjZEDfjF+XA7B9iWmM=;
        b=ZzjqgpGh0qvW19b2FfEa+Xs/fQTGvNCcdGvGxMKPUV3ogpPalvz2hqHXPWEUItehMH
         agqI+XSP1xNFjgkpxuFpXLzw2xBqJ2e4bgaBtpuI9RPmBqFMlabFY/jEtZqzGicR9W7N
         agm6ELf4hEUK46KZCrrXS6tu84shib9+axFguOXOFqOnNn8Pra8J+h0ZcTRbtcBxDv+e
         +dDiBlvMPqjEv5xGSOzikFU8Oki7W4GwWhr8/SXfDGygAJoGuepa8uCdcPt3oXpREybY
         xAZ8xMdD1fMcCNY3dMsH0mmAzkmXnETrF9jS4CekXDjzaZpn/d/NkyX5UclhAl9HUKjB
         RYSQ==
X-Received: by 10.70.91.75 with SMTP id cc11mr40055735pdb.150.1425791143303;
        Sat, 07 Mar 2015 21:05:43 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fm3sm13857205pab.29.2015.03.07.21.05.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 21:05:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265027>

If the user has configured a value for SHELL_PATH then
be sure to use it for any generated scripts instead of
hard-coding /bin/sh.

The first line of the script is handled specially, but
the embedded #!/bin/sh line in the here document will
not be automatically updated unless it uses @SHELL_PATH@.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 git-instaweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 513efa66..7b6ba2bc 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -204,7 +204,7 @@ webrick_conf () {
 	# actual gitweb.cgi using a shell script to force it
   wrapper="$fqgitdir/gitweb/$httpd/wrapper.sh"
 	cat > "$wrapper" <<EOF
-#!/bin/sh
+#!@SHELL_PATH@
 # we use this shell script wrapper around the real gitweb.cgi since
 # there appears to be no other way to pass arbitrary environment variables
 # into the CGI process
---
