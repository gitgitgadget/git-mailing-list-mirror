From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Fri, 27 Jan 2012 10:18:24 +0100
Message-ID: <CANQwDwcZNy8DDwqj+C4sjdvObKiNhqc7R3DVL6BpwweQdBBkCw@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqhxM-0003bp-GW
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab2A0JSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 04:18:47 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63490 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2A0JSp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 04:18:45 -0500
Received: by eaal13 with SMTP id l13so158044eaa.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9f/+fnv5ngddOwOjP2UjEq+ikZU3erZBuxOSast5hok=;
        b=FkJHOYFmj4Pl8ZaGoHbDBN+ofYTRfHmbCwz7JaVh+a9Iw5sGDkSHQ01tyacshwNHFp
         5laffJLnxNXyIBQcRgVQBTsV7Nqr3LIHNbkqE86WuD4/G4bng4nO5lpBktqrLN119+KY
         Q9+SNiTrsC6VeTP2miLOcaRxe8fyu0MZuz25I=
Received: by 10.213.9.4 with SMTP id j4mr996006ebj.100.1327655924208; Fri, 27
 Jan 2012 01:18:44 -0800 (PST)
Received: by 10.213.13.1 with HTTP; Fri, 27 Jan 2012 01:18:24 -0800 (PST)
In-Reply-To: <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189207>

On Mon, Jan 23, 2012 at 10:42 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth <h.b.furuseth=
@usit.uio.no> wrote:
>>
>> t9500-gitweb-standalone-no-errors fails: Git 1.7.9.rc2/1.7.8.4, RHEL
>> 6.2, Perl 5.10.1. =A0Reverting 3962f1d756ab41c1d180e35483d1c8dffe51e=
0d1
>> fixes it. =A0The commit expects Time::HiRes to be present, but RedHa=
t
>> has split it out to a separate RPM perl-Time-HiRes. =A0Better add a
>> comment about that, so it doesn't get re-reverted.
>>
>> Or pacify the test and expect gitweb@RHEL-users to install the RPM:
>>
>> --- git-1.7.9.rc2/t/gitweb-lib.sh~
>> +++ git-1.7.9.rc2/t/gitweb-lib.sh
>> @@ -113,4 +113,9 @@
>> =A0 =A0 =A0 =A0test_done
>> =A0}
>>
>> +perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
>> + =A0 =A0 =A0 skip_all=3D'skipping gitweb tests, Time::HiRes module =
not available'
>> + =A0 =A0 =A0 test_done
>> +}
>> +
>> =A0gitweb_init
>
> [Adding Jakub to CC]
>
> This doesn't actually fix the issue, it only sweeps it under the rug
> by making the tests pass, gitweb will still fail to compile on Red
> Hat once installed.
>
> I think the right solution is to partially revert
> 3962f1d756ab41c1d180e35483d1c8dffe51e0d1, but add a comment in the
> code indicating that it's to deal with RedHat's broken fork of Perl.
>
> However even if it's required in an eval it might still fail at
> runtime in the reset_timer() function, which'll need to deal with it
> too.

I'll try to send a fix today.  Time::HiRes is needed only for optional =
timing
info.

--=20
Jakub Narebski
