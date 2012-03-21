From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Strange effect merging empty file
Date: Wed, 21 Mar 2012 11:54:45 +0100
Message-ID: <4F69B375.5050205@in.waw.pl>
References: <4F69AD3C.4070203@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ralf Nyren <ralf.nyren@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 11:55:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJBz-0006PB-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 11:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430Ab2CUKyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 06:54:53 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56014 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab2CUKyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 06:54:52 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAJBr-00009m-3p; Wed, 21 Mar 2012 11:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <4F69AD3C.4070203@ericsson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193566>

On 03/21/2012 11:28 AM, Ralf Nyren wrote:
> Hi,
>
> I found a "strange effect" when merging from a branch containing a
> change of a previously empty file. The change is added to another empty
> file in the current branch by the merge.
>
> I guess git sees it as a renamed file which is logical from a
> content-perspective.
>
> Not sure what to do with this, I would not say it is a bug really...
It does seem like a bug. An unrelated file is clobbered.

> Reproduce as follows (should be cut-n-paste friendly):
Here's a slightly simplified version that is actually cut-n-paste 
friendly after recent changes to always edit merge comments...

# Start with a new repository
git init
echo Readme file >README
git add README
git commit -m 'Initial commit'

# Setup the branch to be merged
git checkout -b import
touch empty.txt
echo hello world >hello.txt
git add empty.txt hello.txt
git commit -m 'Import 1.0'
echo This file is no longer empty >empty.txt
git commit -m 'Import 1.1' empty.txt

# Setup master branch
git checkout master
touch .gitignore
git add .gitignore
git commit -m 'Static web content'

# Merge import 1.0 and remove the empty file
git merge  --no-edit import^
git rm empty.txt
git commit -m 'Remove empty file'

# Merge import 1.1 and watch empty.txt contents show up in .gitignore
git merge --no-edit import
cat .gitignore


Regards,
Zbyszek
