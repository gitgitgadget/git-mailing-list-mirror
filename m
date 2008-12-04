From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to update the tag to Git server?
Date: Wed, 03 Dec 2008 18:48:43 -0800
Message-ID: <7v1vwo7j04.fsf@gitster.siamese.dyndns.org>
References: <84437.20577.qm@web37903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Thu Dec 04 03:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L84I3-0004Xf-Ri
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYLDCsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbYLDCsu
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:48:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYLDCst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 21:48:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76EE184A5D;
	Wed,  3 Dec 2008 21:48:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C97384A5A; Wed,
  3 Dec 2008 21:48:45 -0500 (EST)
In-Reply-To: <84437.20577.qm@web37903.mail.mud.yahoo.com> (Gary Yang's
 message of "Wed, 3 Dec 2008 18:16:32 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13639A68-C1AE-11DD-912D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102324>

Gary Yang <garyyang6@yahoo.com> writes:

> I pushed code from my local repository to Git Server.
> git push git.company.com:/pub/git/training.git
>
> I, then tagged my local repository.
> git tag -u gyang@company.com RELEASE_2

git-push(1) manual page says that the syntax of the command is:

   'git push' [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
              [--repo=<repository>] [-f | --force] [-v | --verbose]
              [<repository> <refspec>...]

and its OPTIONS section explains what <refspec> means.

<refspec>...::
	The canonical format of a <refspec> parameter is
	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
	by the source ref, followed by a colon `:`, followed by
	the destination ref.
	...
        The <src> side represents the source branch (or arbitrary
        "SHA1 expression", such as `master~4` (four parents before the
        tip of `master` branch); see linkgit:git-rev-parse[1]) that you
        want to push.  The <dst> side represents the destination location.

You want to update refs/tags/RELEASE_2 on the destination side (i.e. the
public server) with the same refs/tags/RELEASE_2 on the source side
(i.e. your side), so you would want to say

	refs/tags/RELEASE_2:refs/tags/RELEASE_2

for <refspec>.  The documentation further mentions that there is a
short-hand for that:

	`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.

Hence the command line becomes:

    $ git push svdcgit01.amcc.com:/pub/git/training.git tag RELEASE_2

Note that saying "tag" is redundant these days as long as you do not have
a branch named "RELEASE_2" at the same time.  But saying "tag" never
hurts, as it is still (and will be) supported.

Note to people who teach git to new people.  The moral of the story is not
that people should learn to read the manual pages.  It is that people
should not learn "push" without remote nor refspec first.  In other words,
the first push command you teach them should be the "git push $over_there
$this_refspec" form, fully spelled.
