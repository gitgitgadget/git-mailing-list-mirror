From: Kenneth Lorber <keni@his.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Sat, 20 Dec 2014 07:39:16 -0500
Message-ID: <0C0299AC-0180-460D-A486-1A96E322CC5E@his.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com> <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com> <xmqqegrw7omv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 14:41:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2KHS-0004dq-Tc
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 14:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbaLTNlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2014 08:41:07 -0500
Received: from smtp-nf-106.his.com ([216.194.251.35]:52993 "EHLO
	smtp-nf-106.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbaLTNlE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 08:41:04 -0500
Received: from cuda201.his.com (cuda201.his.com [216.194.248.226])
	by smtp-nf-106.his.com (Postfix) with ESMTPS id 79596609CD
	for <git@vger.kernel.org>; Sat, 20 Dec 2014 08:40:37 -0500 (EST)
X-ASG-Debug-ID: 1419082836-061c414fbe2247730001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.248.252]) by cuda201.his.com with ESMTP id f18G7TrkGTJdZO8E; Sat, 20 Dec 2014 08:40:36 -0500 (EST)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.252
Received: from mail-sterling.his.com (mail-sterling.his.com [216.194.248.141])
	by smtp-nf-202.his.com (Postfix) with ESMTP id 43410602DA;
	Sat, 20 Dec 2014 08:40:36 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail-sterling.his.com (Postfix) with ESMTP id 2B07C3FB0008;
	Sat, 20 Dec 2014 08:40:35 -0500 (EST)
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.141
X-Virus-Scanned: amavisd-new at mail-sterling.his.com
Received: from mail-sterling.his.com ([127.0.0.1])
	by localhost (mail-sterling.his.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZThtz11Clq2; Sat, 20 Dec 2014 08:40:30 -0500 (EST)
Received: from polyhymnia.home (pool-71-246-192-220.washdc.fios.verizon.net [71.246.192.220])
	by mail-sterling.his.com (Postfix) with ESMTPSA id 8155E3FF0001;
	Sat, 20 Dec 2014 08:40:30 -0500 (EST)
X-Barracuda-Apparent-Source-IP: 71.246.192.220
X-ASG-Orig-Subj: Re: bug & patch: exit codes from internal commands are handled incorrectly
In-Reply-To: <xmqqegrw7omv.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.248.252]
X-Barracuda-Start-Time: 1419082836
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
Received-SPF: pass (his.com: domain of keni@his.com designates 216.194.248.141 as permitted sender)
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.13151
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261602>


On Dec 18, 2014, at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Kenneth Lorber <keni@his.com> writes:
>=20
>>> Bug: exit codes from (at least) internal commands are handled incor=
rectly.
>>> E.g. git-merge-file, docs say:
>>>       The exit value of this program is negative on error, and the =
number of
>>>       conflicts otherwise. If the merge was clean, the exit value i=
s 0.
>>> But only 8 bits get carried through exit, so 256 conflicts gives
>>> exit(0), which means the merge was clean.
>=20
> Wouldn't any cmd_foo() that returns negative to main() be buggy?

Absolutely.

> Your change sweeps such problems under the rug, which is not a
> healthy thing to do.

True.  But as I don=92t know the codebase it seemed the safe thing to d=
o
at least to prove the bug existed before filing a bug report.

> Expecting that the exit code can signal small positive integers and
> other generic kinds of failures is a losing proposition.  I think it
> is a better fix to update cmd_merge_file() to return 1 (when ret is
> positive), 0 (when ret is zero) or 128 (when ret is negative), or
> something simple like that, and update the documentation to match
> that, without touching git.c::main().

I agree.

It does leave open the question of whether this bit of information
is of any use and should/could be reported out in another way.  It=92s =
not
to me, so I won=92t be proposing anything to address that.

> Among the in-tree users, I notice git-cvsserver.perl is already
> using the command incorrectly.  It does this:
>=20
>            my $return =3D system("git", "merge-file", $file_local, $f=
ile_old, $file_new);
>            $return >>=3D 8;
>=20
>            cleanupTmpDir();
>=20
>            if ( $return =3D=3D 0 )
>            {
>                $log->info("Merged successfully");
>                ...
>            }
>            elsif ( $return =3D=3D 1 )
>            {
>                $log->info("Merged with conflicts");
>                ...
>            }
>            else
>            {
>                $log->warn("Merge failed");
>                next;
>            }
>=20
> which assumes $return =3D=3D 1 is special "half-good", which is not
> consistent with the documented interface.  It will incorrectly
> say "Merge failed" when there are two or more conflicts.
>=20
> And with such a "1 or 0 or -1" change, you will fix that caller as
> well ;-)

Yay! :-)

Thanks,
Keni
