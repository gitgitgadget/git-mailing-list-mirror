From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Sun, 08 Apr 2007 16:21:02 -0700
Message-ID: <7virc68nc1.fsf@assigned-by-dhcp.cox.net>
References: <esc64d$d2u$1@sea.gmane.org> <4618DFEE.8080707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Williams <njw@jarb.freeserve.co.uk>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hagh3-00075x-Hn
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbXDHXVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Apr 2007 19:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXDHXVG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:21:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57138 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbXDHXVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2007 19:21:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408232102.HLTQ24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Apr 2007 19:21:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id knM21W00i1kojtg0000000; Sun, 08 Apr 2007 19:21:03 -0400
In-Reply-To: <4618DFEE.8080707@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sun, 08 Apr 2007 14:28:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44012>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Nick Williams schrieb:
>> git-archive only archives the current working dir (and sub dirs) eve=
n
>> when no paths are specified. For example, if I do
>>=20
>> git archive --format=3Dtar --prefix=3Dgit-1.5.0.2/ HEAD > ~/test/tes=
t.tar
>>=20
>> from with in the Documentation dir, then I only get part of the tree=
=2E
>>=20
>> Is this the intended behavior?
>>=20
>> The reason I ask is that from my (mis)reading of the man page I expe=
ct
>> to get all of the tree unless paths are specified.
>
> Sorry about the late reply.  Would these two additional manpage lines
> clear things up for you?

While the updated description reflects what the command does
more accurately, I am not sure if it is a desired behaviour.
=46or one thing, --format=3Dtar (by the way, maybe we would want to
make this the default when none is specified?) adds the comment
that is readable by get-tar-commit-id that claims the tarball
contains the named commit, giving a false impression that it is
the whole thing.  Since people who _really_ want a subtree can
just say "git archive --format=3Dtar HEAD:Documentation", I
suspect we may be better off not doing "current directory only"
by default.  This changes the behaviour, but (1) it affects only
people who run from a subdirectory, (2) it is counterintuitive
that your location in the working tree matters when you say "I
want a tarball of that commit", and (3) it is an undocumented
behaviour anyway.

So my suggestions are:

 (1) When no pathspec is given, archive the whole tree, even
     when you are in a subdirectory.

 (2) When a pathspec is given, produce a partial tarball limited
     to the named spec like we do now, but do not say it is a
     tarball of the named commit (i.e. get-tar-commit-id would
     say empty).

An alternative to (2) would be to say "$commit:Documentation"
instead, but that has a little issue of what to do when more
than one pathspecs are given.
