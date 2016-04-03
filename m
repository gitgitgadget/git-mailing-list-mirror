From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.8.1 (and call-for-help to "make rpmbuild" users)
Date: Sun, 03 Apr 2016 12:21:49 -0700
Message-ID: <xmqqtwjiebw2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Apr 03 21:22:10 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1amnb7-00082H-Sc
	for glk-linux-kernel-3@plane.gmane.org; Sun, 03 Apr 2016 21:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbcDCTVy (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 3 Apr 2016 15:21:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbcDCTVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2016 15:21:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4414B52FA9;
	Sun,  3 Apr 2016 15:21:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	WhWh22AucIJsYvUZhDsVQE/Y1g=; b=xlTf/njGJvP9vJSyKIUe/EburKLKUr+Hm
	FJCHNUoEiFoC4WI0czOnKkEyegMpXmYLyjuNL+As4zFG6oY1CclM7kI1cIQ75Mgl
	dnENTgTqhYgJ8G/MNc6zYMHmuNkdF4xdg9r35SU/n0PfDgNo349F7dDt7B1Tb6CZ
	Ds2BaAhu8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=en6QIFQby0IHgy6lNZ9poZa2yRWl/RC0dTa92hMa0ehFVYm4/TvaxbMv
	iQ+iIeER8fWiGwDfBH1ffz8pMxsugA3byODt28E7CgHskaSUDyn+YM07WtsrTSgB
	vqJwWo0xzL1IdlsDOFZG/0AqnPzN1Gek8AyuSsm0DeObwAdFHO8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B9B652FA7;
	Sun,  3 Apr 2016 15:21:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE6F452FA6;
	Sun,  3 Apr 2016 15:21:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51030DB4-F9D1-11E5-96A2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290647>

If you do not build RPM binary packages from our pristine source,
you can safely ignore this release and stop reading this message.

Now that the audience of this message has been limited to a narrow
target, before I make an announcement, here is a call-for-help to
you.

Git v2.8 removed README file and added a corresponding README.md
file.  The change however did not adjust git.spec.in that still
referred to README, causing "make rpmbuild" to fail.  The breakage
was not noticed by anybody who tested v2.8.0-rc0 and later release
candidates, and ended up in the final v2.8 release, and we saw a
handful of bug reports on the list after the release happened.

This maintenance release is to correct this bug for those who run
"make rpmbuild". It has no other changes.

It is clear that nobody who relies on being able to "make rpmbuild"
ever tried any of the 5 release candidate snapshots that happened
during Feb 26-Mar 28.  We had a whole month and nobody noticed?

This incident clearly shows that something needs to happen, if
people want "make rpmbuild" to keep working.  Even though this
maintenance release may fix this single bug, breakages similar to it
that only affect "make rpmbuild" users are guaranteed to appear in
future releases, unless those who can prevent them from happening
start helping to test at least release candidate snapshots.

It is even more preferrable if they can test the tip of 'next'
branch regularly, in order to prevent such breakages from hitting
the 'master' branch to be included in the next release, which is
what the other parts of the system aims at.

The other obvious option is for us to stop pretending that "make
rpmbuild" does anything useful to do and drop the build target and
the unmaintained git.spec.in file on which nobody in the active
development community keeps eyes.  I do not mean this as a threat
"help us or else"; there is a precedent.  We used to ship our own
debian/rules and friends for those who wanted to debbuild from the
source, but the Debian packagers wanted to have their own proper
ones and ours ended up confusing the users, and we made the world
a better place by removing our copy.  If "make rpmbuild" people want
us to take this route, that is also OK for us.

So that's the call for help.  Now to the announcement.

The latest maintenance release Git v2.8.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.8.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.8.1 Release Notes
========================

Fixes since v2.8
----------------

 * "make rpmbuild" target was broken as its input, git.spec.in, was
   not updated to match a file it describes that has been renamed
   recently.  This has been fixed.

----------------------------------------------------------------

Changes since v2.8.0 are as follows:

Junio C Hamano (1):
      Git 2.8.1

Matthieu Moy (1):
      git.spec.in: use README.md, not README
