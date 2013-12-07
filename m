From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-hg: avoid buggy strftime()
Date: Sat,  7 Dec 2013 07:09:40 -0600
Message-ID: <1386421783-27781-2-git-send-email-felipe.contreras@gmail.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Cc: jcb91 <joshuacookebarnes@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHl4-0003Ei-1P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab3LGNRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:17:16 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54633 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab3LGNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:17:15 -0500
Received: by mail-oa0-f54.google.com with SMTP id h16so2046278oag.41
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CdHRLyEFYgZ1rIzDAo6AiUALXhP4yQ9p5UPMBrsOsk=;
        b=RWho5qY8U2OGIPVV61S0IbkRzonLZDbN+dKDyTm7eQ0BaAoVm0bVvxtww13uJnIXUK
         XeHlJWuGi7gWdUi8NoXaTjXQYsnfgLenN1b3cV9Wg2oPgk9Tjhl8ulnWOuEFHho3YlWL
         Qgs2Y04QFECTEsB8AKSsH6mCTPAJIEADWPbGcVwyeSZ6cP4jX/ITjBmPmvlA0GXPzd1U
         qUZHCR94bMES9iCZPZsj2IsUjYGp4SI+NCR+58OPP6D3w2MxNL9WEP9HFcOCxOlJDTKl
         WkJJXbjqaICiCQ1+7MkDi9HWXpsfKxjZUinunmckIVkByluu486l5V4O9zeWNsgcF8Lv
         IxdA==
X-Received: by 10.182.144.136 with SMTP id sm8mr244292obb.63.1386422234705;
        Sat, 07 Dec 2013 05:17:14 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm5255287oep.2.2013.12.07.05.17.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:17:13 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238980>

From: jcb91 <joshuacookebarnes@gmail.com>

  error on pull: fatal: Invalid raw date "" in ident: remote-hg <>

Neither %s nor %z are officially supported by python, they may work on
some (most?) platforms, but not all.

removed strftime use of %s and %z, which are not officially supported by python, with standard formats

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6026b9..a81d59e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -538,7 +538,7 @@ def export_ref(repo, name, kind, head):
 
         print "commit %s" % ref
         print "mark :%d" % (note_mark)
-        print "committer remote-hg <> %s" % (ptime.strftime('%s %z'))
+        print "committer remote-hg <> %d %s" % (ptime.time(), gittz(ptime.timezone))
         desc = "Notes for %s\n" % (name)
         print "data %d" % (len(desc))
         print desc
-- 
1.8.4.2+fc1
