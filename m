From: Ivan Shirokoff <shirokoff@yandex-team.ru>
Subject: git diff --word-diff problem
Date: Thu, 12 Jan 2012 13:05:01 +0400
Message-ID: <4F0EA23D.3010603@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 10:12:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGhw-0002NW-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2ALJMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 04:12:25 -0500
Received: from archeopterix.yandex.ru ([93.158.136.52]:9446 "EHLO
	archeopterix.yandex.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2ALJMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 04:12:21 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jan 2012 04:12:21 EST
Received: from [95.108.173.102] (dhcp173-102-red.yandex.net [95.108.173.102])
	by archeopterix.yandex.ru (Postfix) with ESMTPS id 95CF659D93E
	for <git@vger.kernel.org>; Thu, 12 Jan 2012 13:05:01 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1326359101;
	bh=0OUNmb/Y4PO92ImPCgMrv1KXUvJQJFnKARySFxHRRtU=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=W/pblXUk33Vr5/eWs/ILqJhrpBUoUoGLY2aSGL6jUzKzSgbWA1LTTI3R96266bdhk
	 NxZ7j/TXkTjdP4GO/kEdVsNoNF4UdAi79BBcktmq+9EsaNIPCng1Fy1SY65A9KphmC
	 Vlh8t+rff3bBAYECewwghKFkvNVPeSKKyVa38L3E=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Thunderbird/3.1.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188436>

Hello.
I've got a couple of generated files with obfuscated code.
I want to word-diff them just to make sure that everything is right.

The thing is when word-diff gets oneline file without newline at the end 
it compares it with regular line by line diff.

Here is an example. Two one line files generated with perl -e "print 'a 
'x10" > file

git diff --word-diff=plain file1 file2
diff --git a/file1 b/file2
index 3526254..0515a63 100644
--- a/file1
+++ b/file2
@@ -1 +1 @@
[- a a a a a a a a a a-]
  No newline at end of file
  {+a a a a a ab a a a a+}

Git shows that the whole line is different.
And if I add newlines to that files everything works just as expected

git diff --word-diff=plain file1 file2
diff --git a/file1 b/file2
index 1756d83..1ec45b9 100644
--- a/file1
+++ b/file2
@@ -1,2 +1,2 @@
  a a a a a [-a -]{+ab +}a a a a

Is that a bug or I've missed explanation in docs?

-- 
Ivan Shirokoff
