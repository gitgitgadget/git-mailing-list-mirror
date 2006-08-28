From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Add git-zip-tree to .gitignore
Date: Tue, 29 Aug 2006 00:28:19 +0200
Message-ID: <44F36E03.9090802@lsrfire.ath.cx>
References: <44F17FD5.2030000@lsrfire.ath.cx>	<7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>	<44F21E0B.9010600@lsrfire.ath.cx> <7vhczxvlar.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 00:28:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHpah-0006K4-Bw
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 00:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWH1W2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 28 Aug 2006 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWH1W2U
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 18:28:20 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:3501
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964853AbWH1W2T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 18:28:19 -0400
Received: from [10.0.1.3] (p508E65C1.dip.t-dialin.net [80.142.101.193])
	by neapel230.server4you.de (Postfix) with ESMTP id 38F6D1400C;
	Tue, 29 Aug 2006 00:28:17 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhczxvlar.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26183>

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Junio C Hamano schrieb:
>>> Although it was my fault applying it already to "master" without=20
>>> asking this question first, I started to wonder how many more archi=
ve
>>> format people would want, and if it might make more sense to
>>> consolidate git-*-tree into a single frontend with an option to
>>> specify the archiver.
>>>
>>> We would obviously need to keep git-tar-tree as a backward=20
>>> compatibility alias for "git archive-tree -f tar", but doing things
>>> that way we do not have to introduce unbounded number of new
>>> git-{zip,rar,...}-tree programs.
>> That thought occurred to me, too.  I guess there are not that many m=
ore
>> interesting archive formats, though.  Can we defer adding
>> git-archive-tree until a third archive format command appears?  I wo=
n't
>> submit another one, I promise. ;-)
>=20
> I was more worried about possibly having to do --remote once in
> each for tar-tree and zip-tree in git-daemon.  The version of
> daemon currently in "pu" can allow git-tar-tree to be accessed
> from the client via git:// URL.

Good point.  And especially for net transfers a compressed format like
ZIP or TGZ (not yet implemented) would be better.

Would it make sense to have just one multiplexer command?  I.e.
something like this:

  git-archive -f <format> [extra]                <tree-ish> [<base>]
  git-archive -f <format> [extra] --upload       <tree-ish> [<base>]
  git-archive -f <format> [extra] --remote=3D<url> <tree-ish> [<base>]

[extra] stands for format specific options like the compression ratio
for ZIP.  The protocol spoken by upload and --remote would need to be
extended to be able to specify the format and any format specific optio=
ns.

While we're discussing the command line interface, would it make sense
to support path specs, like e.g. ls-tree does?  Like this:

  git-archive -f <format> [extra] [--prefix=3D<base>] <tree-ish> [<path=
>]

Personally, I don't see the need for path specs for archive creation,
but IF we want to introduce them then the best time to do it would be
now, at the same time as introducing git-archive (or git-archive-tree).

Ren=E9
