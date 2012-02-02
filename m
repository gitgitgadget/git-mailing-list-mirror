From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 09:10:06 +0100
Message-ID: <jgdgcv$h8n$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 09:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrkW-0005Av-VI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab2BBIK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:10:27 -0500
Received: from plane.gmane.org ([80.91.229.3]:52441 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2BBIKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:10:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RsrkL-00056S-Uh
	for git@vger.kernel.org; Thu, 02 Feb 2012 09:10:21 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 09:10:21 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 09:10:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189588>

Hi there,

a colleague of mine happened to produce a bad merge by unintenionally 
picking the version of the remote branch ("R") for all conflicting 
files. Effectively, he eliminated a whole bunch of bugfixes that were 
already on his local branch ("L").

Obviously this was a mistake on his side, but hey: everyone makes 
mistakes. The real problem is to find this problem afterwards, possibly 
weeks later, when you suddenly realize that a bug that you had fixed 
suddenly reappears.

A "git log" on the whole repository shows both branches R and L.
A "git show" on the bugfix commit shows the bugfix as you expect it.

BUT:
A "git log" on the file itself shows neither the problematic merge nor 
the bugfix commit. Git considers the merge of this file trivial because 
the content is identical to that of parent R. Therefore, whatever 
happened on branch L is not considered relevant history of the file.

FURTHERMORE:
A "git show" of the merge itself does not show the conflicting file 
either. Obviously, "git show" on a merge decides which files are 
relevant not based on conflicts but based on resolutions.

To sort out what happened, you first need to have a suspicion and then 
dig fairly deep in the manuals to set the correct options to show what 
happened.

I think, both "git log" and "git show" should by default be a bit more 
conservative in hiding "insignificant" merges:
* In "git log" a branch should only be hidden if it never touched the file.
* In "git show" a merge should display all files that did have a 
conflict independent of the resolution. (I am open to discuss whether 
auto-resolvable conflicts should be displayed by default. Non-trivial 
conflicts definitely should)

Greetings,
Norbert
