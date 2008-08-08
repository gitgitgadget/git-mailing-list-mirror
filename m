From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 11:39:39 +0200
Message-ID: <489C145B.5090400@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 11:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KROSk-0003oA-9F
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 11:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYHHJjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYHHJjo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 05:39:44 -0400
Received: from morch.com ([193.58.255.207]:57919 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbYHHJjn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 05:39:43 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 5AE64278E
	for <git@vger.kernel.org>; Fri,  8 Aug 2008 11:42:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91643>

Using my default PAGER=3Dless, git log --check exits with exit code 0,=20
contrary to documentation.

There is this old thread:
"[PATCH 1/5] "diff --check" should affect exit status"
http://thread.gmane.org/gmane.comp.version-control.git/68145/focus=3D68=
148
which seemed not to reach a conclusion.

=46or git log, I still have not been able to make it exit with anything=
=20
other than 0 - contrary to documentation.

May I propose a change to either documentation or behavior of "git diff=
=20
--check". The current one has:

--check::
	Warn if changes introduce trailing whitespace
	or an indent that uses a space before a tab. Exits with
	non-zero status if problems are found. Not compatible with
	--exit-code.

This, clearly, is not correct:

$ PAGER=3Dless git diff --check
(my default PAGER)
or
$ unset PAGER ; git diff --check
always exits with exit code 0. But

$ git --no-pager diff --check
or
$ PAGER=3Dcat git diff --check
or
$ PAGER=3D git diff --check
exits with exit code 2 on error
(curiously PAGER=3D and unset PAGER give different results)

But the --exit-code overrides any of that:

$ git --no-pager diff --check --exit-code
exits with exit code 3 on error (with or without the --no-pager).

I'm not sure about a good rephrasing. How about:
'... "git diff" exits with non-zero status if problems are found and ru=
n=20
with --exit-code.'

While this documentation string is found in diff-options.txt and=20
included in:

git-diff-files.txt
git-diff-index.txt
git-diff-tree.txt
git-diff.txt
git-format-patch.txt
git-log.txt

At least for the git-log cases, the behavior is not the same as for=20
git-diff:

$ PAGER=3Dcat git --no-pager log HEAD~20..HEAD --check --exit-code
$ echo $?
0
Though there are several check failures (red squares in output), it=20
exits with 0, even when using all the tricks that work with "git diff".

Clearly here, the documentation is "even more wrong". Hence the explici=
t=20
mention of "git diff" in the help string for the --check option.

What do you think?

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
