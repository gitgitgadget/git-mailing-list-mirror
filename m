From: greened@obbligato.org (David A. Greene)
Subject: rebase -X subtree
Date: Mon, 30 Nov 2015 20:22:46 -0600
Message-ID: <87lh9e9abt.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 03:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3abS-00072O-7i
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 03:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbbLACXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 21:23:22 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:54320 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755040AbbLACWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 21:22:53 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a3ac6-0007Cf-59
	for git@vger.kernel.org; Mon, 30 Nov 2015 20:24:18 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281830>

Hi,

I had a particular notion of what rebase -X subtree would do but I am
apparently mistaken.  What should be the result of the script below?  I
expected commits to be replayed on top of master with their trees
adjusted to move files into a "files" directory.  In the first case, the
rebase seems to have done nothing.  In the second case I get an error:

First, rewinding head to replay your work on top of it...
fatal: Could not parse object '6c0826e4cf4b1f44ebafbd4084c1f0066a59d112^'
Unknown exit code (128) from command: git-merge-recursive 6c0826e4cf4b1f44ebafbd4084c1f0066a
59d112^ -- HEAD 6c0826e4cf4b1f44ebafbd4084c1f0066a59d112                                   

If "files" exists and I use rebase -X subtree it replays the commits,
moving trees out from under "files," as I would expect.  Is it not
possible to use git rebase to move trees under a new subdirectory?

I know that I can use filter-branch to accomplish what I want, I'm just
curious whether git rebase is expected to behave as I thought.  At the
very least, it seems a better error message in the orphan branch case
would be helpful.

Thanks for you help!

                      -David

#!/bin/bash

function addfile {
    name=$1
    echo ${name} > ${name}
    git add ${name}
    git commit -m "Add ${name}"
}

mkdir rebasetest1
cd rebasetest1
git init

addfile README

git checkout -b work

addfile file1

git rebase -X subtree=files --onto master master

cd ..

mkdir rebasetest2
cd rebasetest2
git init

addfile README

git checkout --orphan work

addfile file1

git rebase -X subtree=files --onto master --root
