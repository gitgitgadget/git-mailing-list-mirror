From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Tue, 12 Oct 2010 16:14:10 +0400
Message-ID: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 14:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5dkK-0001GT-Mv
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 14:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298Ab0JLMOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 08:14:15 -0400
Received: from mail.intellij.net ([213.182.181.98]:57036 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab0JLMOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 08:14:15 -0400
Received: (qmail 2997 invoked by uid 89); 12 Oct 2010 12:14:13 -0000
Received: by simscan 1.1.0 ppid: 2964, pid: 2988, t: 0.0172s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 12 Oct 2010 12:14:12 -0000
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158831>


Hi all,

The behavior of ls-files is inconsistent in Windows and Mac.

I want to see which files were changed in the specific directory of my working tree, so I call ls-files:
> git ls-files -douvm --exclude-standard -- MYDIR

On Mac (and probably on Linux) git inspects the content of MYDIR and gives me the status of not-indexed changes in this directory.
On Windows git gives the same result (only changes in MYDIR), but it scans the whole repository!

I noticed it because it took a long time to scan a small directory, and then I confirmed it by using monitoring tools:
on Windows I used Process Monitor, on Mac I used FileMon - both give the list of accessed files in the real time.

To narrow the search scope to MYDIR I have to add "/**" and thus call:
> git ls-files -douvm --exclude-standard -- MYDIR/**
This works as expected - scans only MYDIR.

But I can't call it with several directories:
> git ls-files -douvm --exclude-standard -- MYDIR/** ANOTHERDIR/**
This doesn't work as expected and scans the whole repo.
So to scan two directories I have to call ls-files twice.

Looks like a bug. Maybe a bug of porting Git to windows, but the behavior is the same on msys-git and cygwin-git. 
It was tested with Git 1.7.1 on Mac, 
MsysGit 1.7.3.1 and 1.7.0.2,
CygwinGit 1.7.0.4.

Thanks.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
