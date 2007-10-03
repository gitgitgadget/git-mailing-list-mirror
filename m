From: Bruno Haible <bruno@clisp.org>
Subject: making "git stash" safer to use
Date: Wed, 3 Oct 2007 23:31:41 +0200
Message-ID: <200710032331.41385.bruno@clisp.org>
References: <200709301421.52192.bruno@clisp.org> <200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 23:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBpi-0002XP-N0
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777AbXJCVcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbXJCVcA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:32:00 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:53413 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbXJCVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:31:58 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (fruni mo21) (RZmta 13.4)
	with ESMTP id 602d76j93JoNNu ; Wed, 3 Oct 2007 23:31:48 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <47023699.3080606@byu.net>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59887>

Hi,

Through a simple typo I lost modifications to 20 files:

> >>>     $ git stash
> >>>     $ git pull
> >>>     $ git stash apply
> >>>     $ git stash clean              # typo!
> >>>     $ git stash clear              # fatal correction to typo!

It is just too easy to lose your modifications by using "git stash".

Eric Blake further says:

> While we're at it, I wish 'git stash clear' would take an optional
> argument that says which stash(es) to clear, rather than blindly clearing
> the entire stash.

It would help if git would store which of the stashes were applied since
they were created and which were not. A stash that was not yet applied must
be considered "precious", whereas a stash that was applied is redundant,
right?

According these lines, how about
  1) changing "git stash clear" to remove only the redundant stashes,
     (or alternatively: let it fail if there is at least one precious stash),
  2) adding an option -f, so that "git stash -f clear" clears all stashes,
     including the precious ones.

The rationale is that humans are bad at remembering the state of something.
Therefore instead of having a command that is commonly used in one state
and dangerous in the other state, better have two different commands - one
for the common case, and one for the dangerous one. Like "rm" and "rm -f".

Bruno
