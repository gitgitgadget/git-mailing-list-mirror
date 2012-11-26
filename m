From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: Re: Multiple threads of compression
Date: Mon, 26 Nov 2012 08:23:47 +0100
Message-ID: <20121126072347.GA25752@localhost>
References: <loom.20121125T171702-64@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 23:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7dC-0001hw-Di
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab2KZW6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2012 17:58:11 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:39914 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab2KZW6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:58:10 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 4422C1F54961
	for <git@vger.kernel.org>; Mon, 26 Nov 2012 23:57:39 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <Sebastian.Leske@sleske.name>)
	id 1Tct2h-0006uQ-EA
	for git@vger.kernel.org; Mon, 26 Nov 2012 08:23:47 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20121125T171702-64@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210508>

Hi,

[Thorsten Glaser <tg@debian.org>, 2012-11-25 17:27]:
> On a multi-core machine, the garbage collection of git, as well
> as pack compression on the server side when someone clones a
> repository remotely, the compression is normally done automatically
> using multiple threads of execution.
>=20
> That may be fine for your typical setups, but in my cases, I have
> two scenarios where it isn=E2=80=99t:
>=20
> =E2=93=90 The machine where I want it to use only, say, 2 of my 4 or =
8 cores
>   as I=E2=80=99m also running some VMs on the box which eat up a lot =
of CPU
>   and which I don=E2=80=99t want to slow down.
=20
> =E2=93=91 The server VM which has been given 2 or 3 VCPUs to cope wit=
h all
>   the load done by clients, but which is RAM-constrained to only
>   512 or, when lucky, 768 MiB. It previously served only http/https
>   and *yuk* Subversion, but now, git comes into the play, and I=E2=80=
=99ve
>   seen the one server box I think about go down *HARD* because git
>   ate up all RAM *and* swap when someone wanted to update their clone
>   of a repository after someone else committed=E2=80=A6 well, an ~100=
 MiB large
>   binary file they shouldn=E2=80=99t.

unfortunately I can't really speak to the git side of things, but both
of these cases just sound like standard resource starvation. So why
don't you address them using the usual OS mechanisms?=20

If you want to prevent git from sucking up CPU, nice(1) it, and if it
eats too much RAM, use the parent shell's ulimit mechanism.

Granted, this might also require some changes to git, but wouldn't that
be a simpler and more general approach to solving starvation problems?
