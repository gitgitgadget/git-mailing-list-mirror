From: Kenneth Lorber <keni@his.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Wed, 17 Dec 2014 21:15:47 -0500
Message-ID: <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 03:16:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1QdI-0000lQ-3M
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 03:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaLRCP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2014 21:15:57 -0500
Received: from smtp-nf-106.his.com ([216.194.251.35]:41557 "EHLO
	smtp-nf-106.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaLRCP4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2014 21:15:56 -0500
Received: from cuda201.his.com (cuda201.his.com [216.194.248.226])
	by smtp-nf-106.his.com (Postfix) with ESMTPS id 11DE960C52
	for <git@vger.kernel.org>; Wed, 17 Dec 2014 21:15:55 -0500 (EST)
X-ASG-Debug-ID: 1418868953-061c41405e119bf10001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.248.252]) by cuda201.his.com with ESMTP id 40eAZKLkoINM9VHQ for <git@vger.kernel.org>; Wed, 17 Dec 2014 21:15:53 -0500 (EST)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.252
Received: from mail-sterling.his.com (mail-sterling.his.com [216.194.248.141])
	by smtp-nf-202.his.com (Postfix) with ESMTP id E8A9460152
	for <git@vger.kernel.org>; Wed, 17 Dec 2014 21:15:52 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail-sterling.his.com (Postfix) with ESMTP id D4CCC3F80008
	for <git@vger.kernel.org>; Wed, 17 Dec 2014 21:15:51 -0500 (EST)
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.141
X-Virus-Scanned: amavisd-new at mail-sterling.his.com
Received: from mail-sterling.his.com ([127.0.0.1])
	by localhost (mail-sterling.his.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1b4ng4ZdBEz; Wed, 17 Dec 2014 21:15:47 -0500 (EST)
Received: from polyhymnia.home (pool-71-246-192-220.washdc.fios.verizon.net [71.246.192.220])
	by mail-sterling.his.com (Postfix) with ESMTPSA id 783583F80004;
	Wed, 17 Dec 2014 21:15:47 -0500 (EST)
X-Barracuda-Apparent-Source-IP: 71.246.192.220
X-ASG-Orig-Subj: Re: bug & patch: exit codes from internal commands are handled incorrectly
In-Reply-To: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com>
X-Mailer: Apple Mail (2.1878.6)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.248.252]
X-Barracuda-Start-Time: 1418868953
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
Received-SPF: pass (his.com: domain of keni@his.com designates 216.194.248.141 as permitted sender)
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.13036
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261516>

The situation is actually slightly more complex than I stated previousl=
y.  From the docs:
  The exit value of this program is negative on error,
But there=92s no such thing as a negative error code under Unix, so (at=
 best) that will be exit(255).

No patch, because this is getting painfully close to needing someone wi=
th a global view of the code to fix.

Thanks,
Keni

On Dec 16, 2014, at 2:28 PM, Kenneth Lorber <keni@his.com> wrote:

> (Apologies if I=92ve missed anything here - I=92m still climbing the =
git learning curve.)
>=20
> Bug: exit codes from (at least) internal commands are handled incorre=
ctly.
> E.g. git-merge-file, docs say:
>        The exit value of this program is negative on error, and the n=
umber of
>        conflicts otherwise. If the merge was clean, the exit value is=
 0.
> But only 8 bits get carried through exit, so 256 conflicts gives exit=
(0), which means the merge was clean.
>=20
> Issue shows up on:
> git version 1.8.5.2 (Apple Git-48)
> build from source (git version 2.2.0.68.g64396d6.dirty after patch be=
low applied)
>=20
> Reproduce by:
>=20
> Put the following test program in an empty directory as buggen.pl
>=20
> TEST PROGRAM START
> open OUTB, ">basefile" or die;
> print OUTB "this is the base file\n";
> close OUTB;
>=20
> open OUT1, ">bfile1" or die;
> open OUT2, ">bfile2" or die;
>=20
> $c =3D shift;
>=20
> while($c > 0){
>        print OUT1 "a\nb\nc\nd\nchange $c file 1\n";
>        print OUT2 "a\nb\nc\nd\nchange $c file 2\n";
>        $c--;
> }
> TEST PROGRAM END
>=20
> Do these tests:
>=20
> perl buggen.pl 0
> git merge-file -p bfile1 basefile bfile2
> echo $status
> 0
>=20
> perl buggen.pl 1
> git merge-file -p bfile1 basefile bfile2
> echo $status
> 1
>=20
> perl buggen.pl 256
> git merge-file -p bfile1 basefile bfile2
> echo $status
> 0       <=3D=3D=3DOOPS
>=20
> Proposed patches:
> diff --git a/git.c b/git.c
> index 82d7a1c..8228a3c 100644
> --- a/git.c
> +++ b/git.c
> @@ -349,6 +349,8 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const
>        trace_argv_printf(argv, "trace: built-in: git");
>=20
>        status =3D p->fn(argc, argv, prefix);
> +       if (status > 255)
> +               status =3D 255;   /* prevent exit() from truncating t=
o 0 */
>        if (status)
>                return status;
> diff --git a/Documentation/git-merge-file.txt b/Documentation/git-mer=
ge-file.txt
> index d2fc12e..76e6a11 100644
> --- a/Documentation/git-merge-file.txt
> +++ b/Documentation/git-merge-file.txt
> @@ -41,7 +41,8 @@ lines from `<other-file>`, or lines from both respe=
ctively.  T
> conflict markers can be given with the `--marker-size` option.
>=20
> The exit value of this program is negative on error, and the number o=
f
> -conflicts otherwise. If the merge was clean, the exit value is 0.
> +conflicts otherwise (but 255 will be reported even if more than 255 =
conflicts
> +exist). If the merge was clean, the exit value is 0.
>=20
> 'git merge-file' is designed to be a minimal clone of RCS 'merge'; th=
at is, it
> implements all of RCS 'merge''s functionality which is needed by
>=20
> Open questions:
> 1) Is 255 safe for all operating systems?
> 2) Does this issue affect any other places?
>=20
> Thanks,
> Keni
> keni@his.com
>=20
