From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 17:53:51 -0800
Message-ID: <7vlkjl700g.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<45BCB273.7010601@lsrfire.ath.cx>
	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
	<7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
	<45BD40AE.9020603@lsrfire.ath.cx>
	<7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
	<45BE520A.6050906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 30 02:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBiC4-00015G-Oj
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 02:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbXA3Bxx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 29 Jan 2007 20:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbXA3Bxx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 20:53:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35827 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbXA3Bxw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jan 2007 20:53:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130015352.ZLKY19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Mon, 29 Jan 2007 20:53:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HDuB1W00V1kojtg0000000; Mon, 29 Jan 2007 20:54:12 -0500
In-Reply-To: <45BE520A.6050906@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of
	"Mon, 29 Jan 2007 20:59:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38119>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> [PATCH] git blame --progress
>>=20
>> With  --progress option, the command shows a fairly useless but=20
>> amusing eye-candy while making the user wait.
>
> Nicely done, I like it.  Well, then again, I used to watch the progre=
ss
> of filesystem defragmentors as a kid.  Ahem. :-P
>
> The problem here is, of course, that we don't know how beforehand muc=
h
> work needs to be done.  The indicator could be full of stars long bef=
ore
> the start of history is reached.
>
> This could be helped somewhat by having three states instead of two:
> unblamed (.), blamed (o) and just-now-blamed (*).  Each time new star=
s
> are written you'd demote the other stars in the field to o's.  This w=
ay
> you'll at least see something moving until the end, no matter how oft=
en
> blame is pushed further down for already blamed lines.
>
> This increases terminal bandwidth usage and on-screen activity, but n=
ot
> necessarily the usefulness of this thing. :)

I do not know if this is working as you intended.

If somebody wants to really do this, the first clean-up to be
done is to remove the two loops that goes back and forward to
find the continguous guilty range.  That was done only because I
was lazy and did not want to count the boundary to deal with a
half-dot problem (a displayed column on the screen can represent
N lines -- what happens when the blame entry whose origin is now
known covers only partially?  You need to either draw it as a
half-done, or you make sure to paint it only when all of the N
lines are blamed).  The output from my original will repaint the
whole thing at the end of the blame because at that point
spot_lo and spot_hi would cover the entire range -- which shows
how lazy I am ;-).
