From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 15:44:23 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807231544.23472.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 10:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLZyc-0002k8-Pv
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 10:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbYGWIoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 04:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbYGWIoh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 04:44:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8528 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYGWIog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 04:44:36 -0400
Received: by ug-out-1314.google.com with SMTP id h2so468899ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:mime-version:content-disposition:message-id
         :content-type:content-transfer-encoding;
        bh=jhBdmxZnFyzWvxr9eF/nbNPJiz898Lw8aUpf8D1h6+s=;
        b=mHD+ymCfSzqmmpRGmpKtWdQLqIoKLVTmvlmpYuH9319AremfQ5yFcO0dKQZFq5tXVy
         CYO09c6Z5yahpGoLkCvazcMKSfE5CaWv+0/g86EcJ9uGw1n1RfjFcl10Akws+XMz1tvD
         l5mgLmF365oqeYw3CmqWUM94IC/4SW7oIMnbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=W7158ygC8d1BSQbBIorayII3+d4LzHen3rjhZ854NGvDZj0jTUo0seObwzRrY09IyF
         OZm892Qg5QbyXqZVTlgmfzF/ZkJwz0rF+6KJk2WEO6Y2Jq9Qt5X1dGCEnz/pOIvdGDNm
         yi2/AGNfk/UGTtXwy2z6DwhUgPP8k/gxIvJJ8=
Received: by 10.67.121.14 with SMTP id y14mr46304ugm.10.1216802674039;
        Wed, 23 Jul 2008 01:44:34 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id 29sm1253380uga.42.2008.07.23.01.44.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 01:44:32 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89611>

Hello list.

In short: I can't clone svn repo into git when crlf convertion is activated.

Long story.
I use latest git: 
$ git version
git version 1.5.6.4

For a long period of time I use git at work. Main repo is svn-powered and I 
use git-svn for linking git and svn. The project itself is a windows cpp 
project. I use git under Linux machine (Debian etch with manually backported 
git from sid) and work with linux-hosted project thru samba. From the begin I 
did not enable crlf convertion and broke crlf notation in files one by one 
during my commits. My co-workers does not like this and finally I decide to 
try to use autocrlf feature of git. So I take a copy of my git repo and 
convert all text files to unix LF line endings:

git filter-branch --tree-filter "find -type f \( -iname '*.h' -or \
-iname '*.cpp' -or -iname '*.vcproj' -or -iname '*.sln' -or \
-iname '*.h.tmpl' -or -iname '*.bat' -or -iname '*.mp' -or \
-iname '*.txt' -or -iname '*.nsi' -or -iname '*.def' -or \
-iname '*.rc' -or -iname '*.ini' -or -iname '*.inf' -or \
-iname '*.skin' -or -iname '*.c' -or -iname '*.dsp' \
-or -iname '*.dsw' \) -print0 | xargs -r0 dos2unix" \
`git branch -a | sed 's/^..//'`

It finished succefully. After fish I have added  .git/info/attributes like 
this:
*               -crlf
*.h             crlf
*.c             crlf
*.cpp           crlf
and so on...
and add set core.autocrlf to true and safecrlf to false. Also I cleared all 
git-svn's caches:
rm -rf .git/svn

As I understand I got pure repo that is capable to work with crlf convertion. 
Lets update it (on branch forked from trunk): git svn rebase
<.. some long list of revs during migration to new git-svn layout..>
Done rebuilding .git/svn/trunk/.rev_map.f1f59411-8b2e-0410-9ee3-aa470c928bf2
        M       FindHistory.cpp
Incomplete data: Delta source ended unexpectedly at /tmp/g/bin/git-svn line 
3856

Oops ! Whats this ? I am not able to update. I can update other branches but 
not trunk.

So I have to try my old original repo without crlf convertion enabled. It was 
updated succeffuly, I cant show log it was lost and I was not able to 
reproduce it.



Is there any way to fix this problem ?

P.S. I can't even clone that svn repo from scratch with crlf convertion 
enabled.
