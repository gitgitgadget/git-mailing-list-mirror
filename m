From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Fri, 29 Feb 2008 08:14:39 +0100
Message-ID: <200802290814.39366.chriscool@tuxfamily.org>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org> <200802290200.m1T2023x017992@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUzNk-00067k-2r
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbYB2HJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 02:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbYB2HJR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:09:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54640 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757877AbYB2HJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 02:09:00 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E870C1AB2B6;
	Fri, 29 Feb 2008 08:08:57 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9581D1AB2F4;
	Fri, 29 Feb 2008 08:08:55 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200802290200.m1T2023x017992@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75507>

Hi,

Le vendredi 29 f=E9vrier 2008, Xavier Maillard a =E9crit :
> Hi,
>
>    Note that "emacsclient" is used with option "-e" to launch "woman"
>    on emacs and this works only on versions >=3D 22.
>
> I tested and it did not want to work at first. I modified it a
> little bit and now it works with GNU Emacs 23.0.60 (CVS TRUNK).
> Dunno if emacsclient has changed between 22 and CVS but it seems
> it is printing onto stdout now. I will have to check that.

In fact on my main development machine there is only Emacsclient 21 and=
 it=20
outputs its version on stderr and exits with code 1. Emacsclient 21 als=
o=20
does not accept "-e" option.

I just checked with Emacsclient 22 and it outputs its version on stdout=
 and=20
exits with code 0. But it accepts the "-e" option.

I will need to get Emacs 23 from CVS but from what you say I guess it w=
orks=20
like Emacs 22.=20

So my "check_emacsclient_version" function works only with emacsclient =
21=20
and may be earlier versions.

I used:

	/* emacsclient prints its version number on stderr */
	memset(&ec_process, 0, sizeof(ec_process));
	ec_process.argv =3D argv_ec;
	ec_process.err =3D -1;
	ec_process.stdout_to_stderr =3D 1;

I hoped the above line would redirect stdout to stderr and I could read=
 both=20
from "ec_process.err" below, but it seems it doesn't work like that. I =
also=20
just checked using "ec_process.stdout_to_stderr =3D 0;" but it still do=
esn't=20
work.=20

	if (start_command(&ec_process)) {
		fprintf(stderr, "Failed to start emacsclient.\n");
		return -1;
	}
	strbuf_read(&buffer, ec_process.err, 20);
	close(ec_process.err);

I will be offline this week end but I hope I can debug this next week.

Thanks,
Christian.
