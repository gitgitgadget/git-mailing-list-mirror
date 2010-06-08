From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merging a commit from a distant branch, cherry-pick seems to
 fail
Date: Tue, 08 Jun 2010 07:57:28 +0200
Message-ID: <4C0DDBC8.9030909@viscovery.net>
References: <4C1009EE-3A67-4DF9-9F45-493CD463AEF9@dazjorz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Diederik van der Boor <vdboor@codindomain.com>
To: Sjors Gielen <dazjorz@dazjorz.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 07:57:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLrog-0005EI-Ic
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 07:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab0FHF5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 01:57:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43261 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0FHF5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 01:57:32 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLroX-0000BN-FN; Tue, 08 Jun 2010 07:57:29 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 32F5C1660F;
	Tue,  8 Jun 2010 07:57:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C1009EE-3A67-4DF9-9F45-493CD463AEF9@dazjorz.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148644>

Am 6/8/2010 0:46, schrieb Sjors Gielen:
> sjors@smbp:~/Projecten/kmess/git$ git log -1 --name-only --oneline f9380fd43a2c1
> f9380fd 2010-06-03 (Sjors) (noknotify branch)
> ChangeLog
> src/CMakeLists.txt
> src/notification/macnotification.cpp
> src/notification/macnotification.h
> src/notification/notificationmanager.cpp
> src/notification/notificationmanager.h
...
> sjors@smbp:~/Projecten/kmess/git$ git status
> # On branch kmess-2.0.x
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	modified:   src/CMakeLists.txt
> #	new file:   src/notification/macnotification.cpp
> #	new file:   src/notification/macnotification.h
> #	modified:   src/notification/notificationmanager.cpp
> #
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	both modified:      ChangeLog
> #	added by us:        contrib/isf-qt
> #	both modified:      src/notification/notificationmanager.h
> #
...
> I'd have expected git cherry-pick to simply take the changes in commit
> f9380fd43 and apply them to kmess-2.0.x, without pulling along history
> in 'master'. Testing and debugging in the #git channel on Freenode didn't
> show what I was doing wrong (<http://git.pastebin.com/dUntbHDV>). Now I
> could just take the patch with 'git show' and use 'git apply' to apply it,
> but that doesn't seem like the Git way to do this. So the question is:
> does any of you know why this is happening, what I'm doing wrong, and what
> I should do instead?

You did nothing wrong. If at all, there is a bug in git.

The *only* curious thing after your cherry-pick is this:

> #	added by us:        contrib/isf-qt

because contrib/isf-qt is not touched by the commit that you are
cherry-picking.

contrib/isf-qt is a submodule on branch kmess-2.0.x, but it is a regular
directory on master. I don't think that git should report it as a conflict.

To go ahead, simply resolve the conflicts in ChangeLog and
notificationmanager.h, and make sure that you do not have staged any
changes to contrib/isf-qt before you commit.

-- Hannes
