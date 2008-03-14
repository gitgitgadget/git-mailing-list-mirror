From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 13:28:57 +0100
Message-ID: <47DA6F89.3080609@users.sourceforge.net>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <m3lk4ly3vy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja997-0005bk-Gx
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYCNMfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYCNMfP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:35:15 -0400
Received: from dorado.et.put.poznan.pl ([150.254.11.146]:58799 "EHLO
	dorado.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYCNMfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:35:14 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by dorado.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m2ECU49u026664;
	Fri, 14 Mar 2008 13:30:26 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.75] (pc1075.et.put.poznan.pl [150.254.11.75])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m2ECSvm23834;
	Fri, 14 Mar 2008 13:28:57 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <m3lk4ly3vy.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.14.51600
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_REFNUM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77215>

* Jakub Narebski [14 III 2008 11:52]:
 > Lets check what git does in each of scenarios. Let's assume that
 > current branch is named 'master'.
 >
 > At beginning we have:
 >
 >    1---2---3---4---5    <--- master <--- HEAD
 >
 > HEAD contents is "ref: refs/heads/master"
 >
 > 1. Now, "git checkout 3...", which is equivalent to "git checkout 3",
 > detaches HEAD because commit '3' is not a head (is not a branch), so
 > we have:
 >
 >    1---2---3---4---5    <--- master
 >            ^
 >             \
 >              \-------------- HEAD
 >
 > HEAD contents is "<sha1 of 3>"
 >
 >
 > 2. If we did "git reset --hard 3" we would rewind the history,
 > resulting in the following situation:
 >
 >    1---2---3           <--- master <--- HEAD
 >             \
 >              \-4---5   <... master@{1}, ORIG_HEAD, HEAD@{1}
 >
 > and now commits 4 and 5 are referenced only by reflogs, and by the
 > (temporary) "last position of HEAD" reference named ORIG_HEAD.
 >
 >
 > 3. Now, if you have published 1..5 history you would not want
 > (usually) to rewind published branch. If you do the following:
 >
 >   $ git revert --no-commit 5
 >   $ git revert 4
 >
 > you would get the following:
 >
 >    1---2---3---4---5---(5^-1 4^-1 => 3)  <--- master <--- HEAD
 >
 > git-revert applies reversal of changes in given commit, in the
 > "patch -R" ("patch --reverse") sense. Using '--no-commit' option
 > allows to squash reverting two commits into one commit. The ordering
 > of reverting ensures that there are no merge conflicts.
 >
 >
 > 4. Or you can just put the _contents_ of revision 3 into your working
 > tree, either using plumbing command git-read-tree, or by checking out
 > or resetting to top tree: "git checkout 3^{tree}", or
 > "git checkout 3 -- .", or equivalent git-reset invocation.
 >
 > This way you would get exactly
 >
 >    1---2---3---4---5---3   <--- master <--- HEAD
 >
 > but the relation of 5---3 parentage is unclear: you would have to
 > explain it in the commit mesage.

I suggest one should add the above nice explanation to FAQ or some wiki 
material.

BR,
/Adam

-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
