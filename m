From: Crestez Dan Leonard <cdleonard@gmail.com>
Subject: [PATCH] git p4: Use git diff-tree instead of format-patch
Date: Thu, 21 Nov 2013 17:19:03 +0200
Message-ID: <528E2467.4030900@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050703040507050200030303"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 16:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjW2D-0004WN-Gd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 16:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab3KUPTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 10:19:08 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:58396 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3KUPTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 10:19:07 -0500
Received: by mail-ea0-f172.google.com with SMTP id q10so2449320ead.31
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 07:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        bh=1OkU6ZJ3SMuKlWMaKnm3hscWv7rXCN4UgKGez0+GOLM=;
        b=u3xC0SuVLCiwvGLigxigP0QRAkCLtjcx9gnLtlPoYqka1DyaMZ23xvxvY5rWa9ygIL
         1o948xlpB+rQBUbSB4m0ZsaXAoXh9zpv4hKSbl3cXlTpRpnIzEkOLQTC5Yd/abkbMigO
         SG59rcBYZCZnZ00tcEGmQMuXhpfnsdovHKl1buUFX3/i1g4Tg5ufb9YFloQaDFjGsuH4
         aXPr/HEuQh3yjnHRfPQWmWBlb9QeWkyvrUsoM/ifVzmcdlAxaKx+QJ+FoGGHxQk0fuKD
         6qbJ6RSO22hLy2SUIfaRhdIR+RJHsQQk8EaokRn/OfIHcH3SPAM2MIXScEhGqBvmhYap
         413g==
X-Received: by 10.15.34.5 with SMTP id d5mr9695656eev.20.1385047146384;
        Thu, 21 Nov 2013 07:19:06 -0800 (PST)
Received: from [10.205.20.124] ([212.146.94.66])
        by mx.google.com with ESMTPSA id u46sm71106938eep.17.2013.11.21.07.19.04
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Nov 2013 07:19:05 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238124>

This is a multi-part message in MIME format.
--------------050703040507050200030303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


The output of git format-patch can vary with user preferences. In
particular setting diff.noprefix will break the "git apply" that
is done as part of "git p4 submit".

Signed-off-by: Crestez Dan Leonard <cdleonard@gmail.com>
---
  git-p4.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)



--------------050703040507050200030303
Content-Type: text/x-patch;
 name="0001-git-p4-Use-git-diff-tree-instead-of-format-patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-git-p4-Use-git-diff-tree-instead-of-format-patch.patch"

diff --git a/git-p4.py b/git-p4.py
index 31e71ff..fe988ce 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1308,7 +1308,7 @@ class P4Submit(Command, P4UserMap):
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
-        diffcmd = "git format-patch -k --stdout \"%s^\"..\"%s\"" % (id, id)
+        diffcmd = "git diff-tree -p \"%s\"" % (id)
         patchcmd = diffcmd + " | git apply "
         tryPatchCmd = patchcmd + "--check -"
         applyPatchCmd = patchcmd + "--check --apply -"


--------------050703040507050200030303--
