From: Gelonida N <gelonida@gmail.com>
Subject: share object storage for multiple clones of different repositories
Date: Sat, 05 Nov 2011 00:10:18 +0100
Message-ID: <j91rcq$1uo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 00:10:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMSuH-00081U-Qa
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 00:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963Ab1KDXKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 19:10:36 -0400
Received: from lo.gmane.org ([80.91.229.12]:56074 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab1KDXKg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 19:10:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RMSu7-0007xJ-31
	for git@vger.kernel.org; Sat, 05 Nov 2011 00:10:31 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 00:10:30 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 00:10:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184808>

Hi,

(Thunderbird frozewhile sending my previous message so here a resend)


I wondered whether it is possible, that all of my git repository clones
share the same object storage whether they are cloned from they same
remote repository or not.

In my case this might save a lot of diskspace and accelerate cloning
as some huge files are part of several repositories' history and as I'd
like to clone the same repository multiple times in order to have
parallel working directories for parallel tests on different versions /
branches / tags

Further this might reduce clone times.



My goal would be to:
- reduce disk space
- reduce clone time, as objects would be taken from the existing shared
  object storage

If possible it would be great if also all new created shared objects
would end up in the new object storage.


If git doesn't support this natively, then would following approach work
for reducing the disk space (clone time would not be reduced though)



SHARED_STORAGE=$HOME/shared_storage
mkdir $SHARED_STORAGE

git clone remotehost1:repo1
cd repo1
rsync -av .git/objects $SHARED_REPO
rm -rf .git/objects
ln -s $SHARED_REPO/objects .git/


git clone remotehost2:repo2
cd repo2
rsync -av .git/objects $SHARED_REPO
rm -rf .git/objects
ln -s $SHARED_REPO/objects .git/

Thanks for any feedback or other suggestions.
