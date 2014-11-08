From: "Haim Gelfenbeyn" <haim@hageltech.com>
Subject: [Bug Report] Refresh of a repository after changing line endings behaves erratically
Date: Fri, 7 Nov 2014 20:32:58 -0800
Organization: Hagel Technologies Ltd.
Message-ID: <031d01cffb0d$129a4340$37cec9c0$@hageltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 05:40:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmxpM-0001IW-DY
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 05:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaKHEka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 23:40:30 -0500
Received: from argus.hageltech.net ([50.116.1.163]:56859 "EHLO
	argus.hageltech.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbaKHEka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2014 23:40:30 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2014 23:40:30 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hageltech.com; h=
	content-language:x-mailer:content-transfer-encoding:content-type
	:content-type:mime-version:organization:subject:subject:from
	:from; s=mta; t=1415421199; bh=N19gjC82m/utWgPUWafyCwvYxESighFEZ
	z3BiGgyQsw=; b=ohuVAqRyq9VYDG49RG23VFduYNEnf0DD7PO/LstfZgZRHdcqz
	/cUBTbgu0DHPuucDF0/wbsbscmJ4QOzUkpIGYgShBEa1nQQKShrGf0MGh5/h65By
	LnRZljW44WBApZnuaJLuuwwx2hMh47xaABSzVItFpy4X1/DZ49RkemEgAg=
X-Mailer: Microsoft Outlook 15.0
Thread-Index: Ac/7CtGoUIqh8ywDS5S5whPQeg4/DQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I found out that following steps outlined in https://help.github.com/articles/dealing-with-line-endings/#refreshing-a-repository-after-changing-line-endings results in different outcomes from one execution to another, done on the same repository repeatedly:

STEPS I TOOK:

1. Comitted .gitattributes file that sets some extensions to "text eol=crlf".
2. Did repository refresh:
rm -Rf *
git rm --cached -r .
git reset --hard

3. Expected result: files listed as "changed". Received result: sometimes it works, sometimes it doesn't: git reports "working directory clean".

HOW TO REPRODUCE:

1. Clone my repository with a committed .gitattributes, but still not-refreshed files:
git clone https://github.com/hageltech/msgit_test.git

2. Run this one liner while inside the git repository:
for i in `seq 1 100` ; do  rm -Rf * && git rm -q --cached -r . && git reset --hard -q && git status | wc -l ; done

3. You should be getting 100 lines of "71" (number of lines of output from git status), but in reality some lines will be "3", "20", etc. Git sometimes does not report all files as changed, when it should. 

For me, it happens with frequency of 3-5% with Git 2.2.0.rc1 on Linux, and with  frequency of around 40% with 1.9.4.msysgit.2 on Windows 7, on two different machines.  I initially thought this is Msysgit issue and took it to their issue tracker, where it was confirmed by other users: https://github.com/msysgit/git/issues/229  . However, it does occur with latest git version, compiled from git source, too.

Best regards

-- 
Haim Gelfenbeyn
Hagel Technologies Ltd.
www.hageltech.com
