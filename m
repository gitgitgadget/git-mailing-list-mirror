From: larsxschneider@gmail.com
Subject: [PATCH v1 2/2] git-p4: fix Git LFS pointer parsing
Date: Tue, 19 Apr 2016 22:08:50 +0200
Message-ID: <1461096530-82448-3-git-send-email-larsxschneider@gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 22:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbxH-0005MG-Oc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbcDSUI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:08:57 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35024 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbcDSUI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:08:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id e201so27081600wme.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aZ//U6q3IUP+TW/ZOLnGsszGfJlwIvBFTA++6wgt9rA=;
        b=x8xVWiUMMNE5V2gAuNdukVuo4rqZD3FDQQ8ie1ZiU8qv0OeIYM/5/guiIM1e/9zc3I
         irgvNEHnpekp0lc5Rw2StRUdDZkhCTD/8N41hwyCIkD4deGsHAe4V/1F9xmlWwYmxMDN
         UjbqoEvUSAmYGP1W30ii2vFQZ0felWQAUTH+f1COGhKgTkoprEceo2Drxzrxd3WytyLX
         u06yS8Nfkz8bOdN2y0b21X3IH+zjegGSLKtrtgVXUIH1dqClS2FbohIjGnv6dH1SlkpR
         /e1v1TvPCYqk7jwFBjDKJ6oIUkFjl39XV0vyqnBwtdxOXAlt7M/6H65+2eY1t5ceCqsJ
         +jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aZ//U6q3IUP+TW/ZOLnGsszGfJlwIvBFTA++6wgt9rA=;
        b=KX56fGwwGT/dmiVQEsS71jC9/Dv3mtW/4fI4T7CwlqoL7m0sa8uJIJZx5YrOfJ9knI
         p6cCiYFZZ5pc7yvPlKhftdRvf9IUOjFW5vgL52J7qwz5EaPrFqZcQPAHEVBdxfi7Xh1W
         LPAPEjilx5cez5a8+ENBWK5jXIfK3emZArRLZ50vBJD7qUul0mijhL7RAvcXSqGB5E0g
         3quR4tuLeql99C/vOkv9EBFwtzwlEnBz+DOX9OAPuqRMu1dqsp2WikkrozqWAsRgtEAM
         u3rxnkOGx1yVYntmlu1QOaVuCLJ7wRiZSpJerfcUVbYibf0VmM9ktA9gx4d4wnZnS6JE
         hprQ==
X-Gm-Message-State: AOPr4FVAJYRT0nTw39GboJOp/WBG/ic+xIgCPOVe2Hes5g6+cAQlLlM84eyiT8lbewro7A==
X-Received: by 10.28.147.135 with SMTP id v129mr24747424wmd.65.1461096534998;
        Tue, 19 Apr 2016 13:08:54 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAC17.dip0.t-ipconnect.de. [80.139.172.23])
        by smtp.gmail.com with ESMTPSA id 188sm5999993wmk.6.2016.04.19.13.08.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 13:08:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291918>

From: Lars Schneider <larsxschneider@gmail.com>

Git LFS 1.2.0 removed a line from the output of the 'git lfs pointer'
command [1] which broke the parsing of this output. Adjust the parser
to the new output and add minimum Git LFS version to the docs.

[1] https://github.com/github/git-lfs/pull/1105

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 3 ++-
 git-p4.py                | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 88ba42b..b862cb9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -522,7 +522,8 @@ git-p4.largeFileSystem::
 	that large file systems do not support the 'git p4 submit' command.
 	Only Git LFS is implemented right now (see https://git-lfs.github.com/
 	for more information). Download and install the Git LFS command line
-	extension to use this option and configure it like this:
+	extension (minimum version 1.2.0) to use this option and configure it
+	like this:
 +
 -------------
 git config       git-p4.largeFileSystem GitLFS
diff --git a/git-p4.py b/git-p4.py
index 527d44b..d2be574 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1064,8 +1064,8 @@ class GitLFS(LargeFileSystem):
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
-        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
-        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
+        oidEntry = [i for i in pointerFile.split('\n') if i.startswith('oid')]
+        oid = oidEntry[0].split(' ')[1].split(':')[1]
         localLargeFile = os.path.join(
             os.getcwd(),
             '.git', 'lfs', 'objects', oid[:2], oid[2:4],
@@ -1073,7 +1073,7 @@ class GitLFS(LargeFileSystem):
         )
         # LFS Spec states that pointer files should not have the executable bit set.
         gitMode = '100644'
-        return (gitMode, pointerContents, localLargeFile)
+        return (gitMode, pointerFile, localLargeFile)

     def pushFile(self, localLargeFile):
         uploadProcess = subprocess.Popen(
--
2.5.1
