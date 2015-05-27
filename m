From: Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] p4: Retrieve the right revision of the UTF-16 file
Date: Thu, 28 May 2015 01:14:39 +0200
Message-ID: <1432768479-7894-1-git-send-email-miguel.torroja@gmail.com>
References: <CAPc5daW=BEPiGn6BGbN+JHczV-cPTW7WbZmr8vRRdpb1JL_aLQ@mail.gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Miguel Torroja <miguel.torroja@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 01:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxkXH-0006EA-T2
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 01:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbbE0XOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 19:14:51 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34761 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbbE0XOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 19:14:50 -0400
Received: by wgv5 with SMTP id 5so22088074wgv.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O28vcFRyodfENBjJkzkxlNsliwsvQzskIWl2npLktYI=;
        b=Z3V46XjqZZ4DeC3tyT/O4mgbNyFdHEBE/obn16NUWja5er7B+ZO3OslCUsavUnDvQh
         ToqQsZPQ26pSNdEUUC+6C+8zxe1MUv0y+wWy8zu8AhQ1qM6DvwXIMC4HtiwPcbtwvHqD
         LUTiXcY+ENPhoEXktIfjO5s9nzR1jcfNj/5PkREAk4HFw2l6NfAc8ytUFdOkukD5f0eq
         ePrMV2IQ1cRwR1X2Mb3L9aOXONg5a8F7LUe9B1+StB8yhs9BFy52NhaD9nkKJSm2XrNG
         RbzE4BRVgpB5GDMIgaFmw0fzIix0PLFsB0A1yz/XI3/Hgiv2q6aQRA1HmI9gZHCj/GKK
         6KTQ==
X-Received: by 10.194.82.167 with SMTP id j7mr22018073wjy.123.1432768489493;
        Wed, 27 May 2015 16:14:49 -0700 (PDT)
Received: from localhost.localdomain (98.Red-2-139-52.dynamicIP.rima-tde.net. [2.139.52.98])
        by mx.google.com with ESMTPSA id x3sm5776765wiy.20.2015.05.27.16.14.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 16:14:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <CAPc5daW=BEPiGn6BGbN+JHczV-cPTW7WbZmr8vRRdpb1JL_aLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270118>

Fixing bug with UTF-16 files when they are retrieved by git-p4.
It was always getting the tip version of the file and the history of the
file was lost.

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cdfa2df..be2c7da 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2098,7 +2098,7 @@ class P4Sync(Command, P4UserMap):
             # them back too.  This is not needed to the cygwin windows version,
             # just the native "NT" type.
             #
-            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
+            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
             if p4_version_string().find("/NT") >= 0:
                 text = text.replace("\r\n", "\n")
             contents = [ text ]
-- 
1.7.10.4
