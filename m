From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 02 Jul 2006 19:40:45 +0200
Message-ID: <44A8051D.6040605@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net> <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org> <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net> <20060702094938.GA10944@lsrfire.ath.cx> <Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 19:41:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx5wV-0002l9-7C
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 19:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWGBRlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Jul 2006 13:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWGBRlB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 13:41:01 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:17051
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751621AbWGBRk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 13:40:59 -0400
Received: from [10.0.1.3] (p508E49B6.dip.t-dialin.net [80.142.73.182])
	by neapel230.server4you.de (Postfix) with ESMTP id 8C0E91229C;
	Sun,  2 Jul 2006 19:40:57 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23109>

Linus Torvalds schrieb:
>=20
> On Sun, 2 Jul 2006, Rene Scharfe wrote:
>> Due to popular request ;-), change get_merge_bases() to be able to
>> clean up after itself if needed by adding a cleanup parameter.
>=20
> Btw, I think the symmetric thing is still wrong.
>=20
> Try this:
>=20
> 	git rev-list ^HEAD~1 HEAD...HEAD~2
>=20
> which _should_ return just HEAD ("HEAD...HEAD~2" should basically exp=
and=20
> into "HEAD HEAD~2 ^HEAD~2")
>=20
> I haven't actually tested your patch, but I think it returns HEAD and=
=20
> HEAD~1.
>=20
> The reason? You clear UNINTERESTING as part of clear_commit_marks(), =
so=20
> HEAD~1, which was marked thus by the user, gets cleared of its mark a=
s=20
> part of the get_merge_bases() invocation.
>=20
> I suspect the only way to fix that is to make "get_merge_bases()" not=
 use=20
> UNINTERESTING at all, but instead just explicitly use something like

No and yes.  Patch 1 in the 3+1 series changes the flags used in
commit.c to not conflict with the ones in revision.h[*].  So we have tw=
o
different UNINTERESTINGs, and get_merge_bases() doesn't mess up the
show/no-show markings.

Ren=E9


[*] That fix was the one which reportedly made Dscho break a table.
Sorry for that by the way. :-P
