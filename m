From: Frank Ammeter <git@ammeter.ch>
Subject: wrong handling of text git attribute leading to files incorrectly reported as modified
Date: Fri, 11 Apr 2014 22:20:47 +0200
Message-ID: <E8A9F28E-FF68-4899-B02C-DB7A2C66F38A@ammeter.ch>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYhwZ-0004ZN-T2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbaDKUUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2014 16:20:53 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:16169 "EHLO
	mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842AbaDKUUw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:20:52 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
	by mxout012.mail.hostpoint.ch with esmtp (Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WYhwQ-000ElX-Lg
	for git@vger.kernel.org; Fri, 11 Apr 2014 22:20:50 +0200
Received: from [91.190.10.159] (helo=[192.168.0.105])
	by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.82 (FreeBSD))
	(envelope-from <git@ammeter.ch>)
	id 1WYhwQ-0002xX-Jd
	for git@vger.kernel.org; Fri, 11 Apr 2014 22:20:50 +0200
X-Authenticated-Sender-Id: git@ammeter.ch
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246141>

I=92m not a git expert and this might be the wrong place to ask this qu=
estion,
so please send me somewhere else if I=92m in the wrong place.

I asked the same question on stack overflow, but didn=92t get any respo=
nse:
http://stackoverflow.com/questions/22823004/files-incorrectly-reported-=
modified-git-attributes-buggy-leading-to-inconsist

If a file is committed with crlf line endings with the text attribute u=
nset in the working tree, but the text attribute is set in the repo, th=
e file will be incorrectly shown as modified - for all users checking o=
ut the file.
Resetting or manually modifying the file will not help - The only remed=
y is to commit the .gitattributes with the text attribute set for the f=
ile.

Wouldn=92t it be better to only consider the checked-in gitattributes i=
nstead of the attributes in the working tree?
Is this a bug in git handling gitattributes or is this wrong usage? If =
it is wrong usage, is it documented anywhere?

The following shell script demonstrates the problem:

#!/bin/bash
# creating a git repo "repo"
rm -rf repo
mkdir repo
cd repo
git init
# committing gitattributes with text attribute set for all files
echo "* text" > .gitattributes
git add .gitattributes
git commit -m "added .gitattributes"
# add a file with CRLF line ending with text attribute unset
echo -e "crlf\r" > crlffile
echo "* -text" > .gitattributes
git add crlffile
git commit -m "added crlffile"
git checkout .gitattributes
# now "crlffile" shows as modified, even though it isn't.
# only way to resolve is to modify .gitattributes  =20
git status crlffile
# crlffile shown as modified.
git checkout crlffile
git status crlffile
# crlffile shown as modified.
git reset --hard
git status
# crlffile shown as modified.
# git diff will report the CR as the difference
git diff=20
# but external diff reports no differences.
git difftool --extcmd=3Ddiff --no-prompt

Thanks for your help
=46rank Ammeter