From: Michael Brade <brade@kde.org>
Subject: git stash save -u deletes ignored files without stashing them
Date: Sat, 12 Dec 2015 23:51:09 -0800
Organization: K Desktop Environment
Message-ID: <566D236D.5090904@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 09:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a81gt-0000PF-Pj
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 09:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbbLMIHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 03:07:31 -0500
Received: from mail.sambodha.org ([46.16.75.125]:59503 "EHLO mail.sambodha.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbbLMIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 03:07:30 -0500
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Dec 2015 03:07:30 EST
Received: from private.kjun-chen.de (UnknownHost [98.125.178.93]) by mail.sambodha.org with SMTP;
   Sun, 13 Dec 2015 08:51:15 +0100
Received: from [192.168.99.1] (unknown [192.168.99.1])
	by private.kjun-chen.de (Postfix) with ESMTP id 6422C2041518
	for <git@vger.kernel.org>; Sat, 12 Dec 2015 23:51:09 -0800 (PST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282324>

Hi,

and it does so if .gitignore has not been committed yet. This is with
git version 2.6.3. To reproduce:

mkdir test
cd test
git init

echo "test" > test
echo "something.txt" > .gitignore

git add test .gitignore
git commit -a -m "init"

mkdir node_modules
echo "something" > node_modules/file.txt
echo "node_modules" >> .gitignore

git stash save -u

Now node_modules will be deleted even though it was ignored at the time
of the "git stash save -u". Apparently .gitignore is reverted first,
then the cleanup is done taking the new state of .gitignore into account
where node_modules is now untracked and not ignored anymore, thus
deleting it.

I think this should be considered a bug that can cause data loss, even
if only in rare cases.

thanks,
  Michael

PS: I'm not subscribed.
