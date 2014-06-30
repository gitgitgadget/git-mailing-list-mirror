From: Paul Eggert <eggert@cs.ucla.edu>
Subject: git format-patch doesn't add Content-type for UTF-8 diffs
Date: Mon, 30 Jun 2014 02:03:25 -0700
Organization: UCLA Computer Science Department
Message-ID: <53B127DD.8000807@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 11:09:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Xag-0003bA-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbaF3JJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 05:09:30 -0400
Received: from smtp.cs.ucla.edu ([131.179.128.62]:51924 "EHLO smtp.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaF3JJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 05:09:28 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2014 05:09:28 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.cs.ucla.edu (Postfix) with ESMTP id 8CF80A60006
	for <git@vger.kernel.org>; Mon, 30 Jun 2014 02:03:30 -0700 (PDT)
X-Virus-Scanned: amavisd-new at smtp.cs.ucla.edu
Received: from smtp.cs.ucla.edu ([127.0.0.1])
	by localhost (smtp.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVwq2fhca7Xu for <git@vger.kernel.org>;
	Mon, 30 Jun 2014 02:03:26 -0700 (PDT)
Received: from [192.168.1.9] (pool-108-0-233-62.lsanca.fios.verizon.net [108.0.233.62])
	by smtp.cs.ucla.edu (Postfix) with ESMTPSA id 488A3A60002
	for <git@vger.kernel.org>; Mon, 30 Jun 2014 02:03:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252660>

I've been having trouble sending my Git-generated patches to the tz=20
mailing list.  Patches containing UTF-8 text are garbled, e.g., if you=20
visit <http://mm.icann.org/pipermail/tz/2014-June/021086.html> you'll=20
see "=C3=83=C5=93r=C3=83=C2=BCmqi" where the patch actually had "=C3=9C=
r=C3=BCmqi".

I've tracked this down to the fact that "git format-patch" isn't=20
outputting a Content-Type: line in the outgoing email.  I thought it wa=
s=20
supposed to do that; the man page implies that it does.

Here's how I can reproduce the bug with the git 1.9.3 that's shipped=20
with Fedora 20.  Notice that the patch is missing the line=20
"Content-Type: text/plain; charset=3DUTF-8" that the git-format-patch m=
an=20
page implies it should be generating, and this causes the ICANN email=20
software to misinterpret the patch's character set encoding.

$ git init
Initialized empty Git repository in /home/eggert/junk/d/.git/
$ echo x >x
$ git add x
$ git commit -m'x'
[master (root-commit) 5d0e0ce] x
  1 file changed, 1 insertion(+)
  create mode 100644 x
$ echo '=C2=A7' >x
$ git commit -am'added UTF-8'
[master 57f0669] added UTF-8
  1 file changed, 1 insertion(+), 1 deletion(-)
$ git format-patch -1
0001-added-UTF-8.patch
$ cat 0001-added-UTF-8.patch
 From 57f066927a1d8e253715b7980460d81cb549b162 Mon Sep 17 00:00:00 2001
=46rom: Paul Eggert <eggert@cs.ucla.edu>
Date: Mon, 30 Jun 2014 01:49:28 -0700
Subject: [PATCH] added UTF-8

---
  x | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x b/x
index 587be6b..3038d22 100644
--- a/x
+++ b/x
@@ -1 +1 @@
-x
+=C2=A7
--
1.9.3
