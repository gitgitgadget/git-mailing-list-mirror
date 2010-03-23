From: Eli Barzilay <eli@barzilay.org>
Subject: Re: git rev-list formatting
Date: Mon, 22 Mar 2010 21:57:46 -0400
Message-ID: <m31vfbpzol.fsf@winooski.ccs.neu.edu>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
	<4BA7A75A.6060909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 02:58:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NttNd-0006c9-S0
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 02:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab0CWB57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 21:57:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:53024 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab0CWB57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 21:57:59 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NttNV-0006VT-Or
	for git@vger.kernel.org; Tue, 23 Mar 2010 02:57:57 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 02:57:57 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 02:57:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:bvWorIdchebw5JWp2FuppdDuPPI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142983>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 22.03.2010 12:30, schrieb Eli Barzilay:
>> Possible bug -- IIUC, this:
>>=20
>>   git rev-list --pretty=3D"%w(40,2,2)%b" $rev
>>=20
>> should show all bodies wrapped as specified, but with 1.7.0.3 I see
>> only the first one wrapped, and the rest don't show up.  In one of m=
y
>> attempts to sort this, I saw all bodies, but all bodies after the
>> first were not wrapped as specified.
>
> I can't reproduce this when running this command against git's own
> repo.  Or perhaps I just fail to see it.  Is the one you're trying
> this on public?  Does it work as expected with some other version of
> git?

Sorry, I've lost track of all the different things I tried, but here's
something that I can reproduce reliably now, which seems to be a
similar problem (or at least nothing in the man page explain why it
would do what it does).  If this is helpful, I'll tar up the
repository and put it up somewhere.  This is all running in the repo
-- and it case it matters, it's a bare repo, created with 1.7.0.

  $ git rev-list --pretty=3D"%b" foo

shows one "commit <sha1>" line, then the body, and then the rest of
the commits (13 of them) with no body at all (just the "commit <sha1>"
lines).

  $ git rev-list --pretty=3D"%b" 267d60518

Same output -- 267d60518 is the commit that `foo' points to.

  $ git rev-list --pretty=3D"%b" 84482

This is for a commit that is somewhere in the middle of these commits,
the output has *only* "commit <sha1>" lines -- no body shown.

  $ git rev-list --pretty 84482

This one works fine, showing all of the commits and their log
messages.

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
