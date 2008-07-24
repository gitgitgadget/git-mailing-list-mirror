From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Thu, 24 Jul 2008 14:44:40 +0200
Message-ID: <48887938.3060406@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org> <4884917A.1060005@free.fr> <7vk5fdiheh.fsf@gitster.siamese.dyndns.org> <488722F5.9030602@free.fr> <7v1w1ke9k5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM0Cg-0002TA-By
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYGXMop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 08:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbYGXMoo
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:44:44 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:54349 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYGXMoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:44:44 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 47EA412B6E1;
	Thu, 24 Jul 2008 14:44:42 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 098B712B6CF;
	Thu, 24 Jul 2008 14:44:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v1w1ke9k5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89876>

Junio C Hamano a =C3=A9crit :
> Olivier Marin <dkr+ml.git@free.fr> writes:
>=20
>> Junio C Hamano a =C3=A9crit :
>>>> diff --git a/git-am.sh b/git-am.sh
>>> ...
>>>> @@ -202,8 +202,15 @@ then
>>> ...
>>>> +	case "$skip,$abort" in
>>>> +	t,)
>>>> +		git rerere clear
>>>> +		git read-tree --reset -u HEAD HEAD
>>>> +		orig_head=3D$(cat "$GIT_DIR/ORIG_HEAD")
>>>> +		git reset HEAD
>>>> +		git update-ref ORIG_HEAD $orig_head
>>>> +		;;
>>> ...
>> I add reset to unstage paths with no conflict that are left behind.
>=20
> Does removing the last three lines (1) change the behaviour?  (2) bre=
ak any test?
>=20
> If the answers are "Yes and No", we would need a few more tests in th=
e
> testsuite.

The answers are "Yes and No" and test case update follow.

-- >8 --
=46rom: Olivier Marin <dkr@freesurf.fr>
[PATCH] update test case to protect am --skip behaviour

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 t/t4151-am-abort.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index f45ab0a..7d86cdf 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -17,6 +17,8 @@ test_expect_success setup '
 	for i in 2 3 4 5 6
 	do
 		echo $i >>file-1 &&
+		echo $i >otherfile-$i &&
+		git add otherfile-$i &&
 		test_tick &&
 		git commit -a -m $i || break
 	done &&
--=20
1.6.0.rc0.44.gd618.dirty
