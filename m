From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"
Date: Sun, 29 Jan 2012 03:21:17 +0100
Message-ID: <CACBZZX7M83PAdLPXLYoBtcihf=5AHruk9=JZo7mh+uNyLtaOhg@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 <201201271845.39576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 03:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrKOl-0006U0-Va
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 03:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2A2CVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 21:21:39 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62678 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab2A2CVi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 21:21:38 -0500
Received: by lagu2 with SMTP id u2so1633822lag.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 18:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QfuL0X19OK3xCI8OTGwBLdmNIIfo6lXOTT4ZvOhWf+M=;
        b=Ig7Cty0AYTe1vt1Azd5Vdmwn6pxjJvU/JnnDpTsoD5KjZ0kdPo98B+KE/C/lIXG+XE
         9WoqHD0l714YFu1tdmihjeWEGx29KU9Vfe5haaiMnSt2DIcieUsuGdJxFjZqJoLWmxOG
         4/li47x5aS6DtZJ07M2BtvO32pM0gMXlSOoAA=
Received: by 10.112.9.3 with SMTP id v3mr3191282lba.36.1327803697283; Sat, 28
 Jan 2012 18:21:37 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Sat, 28 Jan 2012 18:21:17 -0800 (PST)
In-Reply-To: <201201271845.39576.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189272>

On Fri, Jan 27, 2012 at 18:45, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 23 Jan 2012, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Jan 23, 2012 at 05:50, Hallvard Breien Furuseth <h.b.furuset=
h@usit.uio.no> wrote:
>> >
>> > t9500-gitweb-standalone-no-errors fails: Git 1.7.9.rc2/1.7.8.4, RH=
EL
>> > 6.2, Perl 5.10.1. =C2=A0Reverting 3962f1d756ab41c1d180e35483d1c8df=
fe51e0d1
>> > fixes it. =C2=A0The commit expects Time::HiRes to be present, but =
RedHat
>> > has split it out to a separate RPM perl-Time-HiRes. =C2=A0Better a=
dd a
>> > comment about that, so it doesn't get re-reverted.
>> >
>> > Or pacify the test and expect gitweb@RHEL-users to install the RPM=
:
> [...]
>
>> This doesn't actually fix the issue, it only sweeps it under the rug
>> by making the tests pass, gitweb will still fail to compile on Red
>> Hat once installed.
>
> I think you meant "fail to run" here.

I mean fail to compile, "use" statements are executed at compile time,
if it was a "require" outside of BEGIN-time it would fail at runtime.

I realize though that you probably thought I meant fail in Git's
Makefile-driven compilation phase, but no, it'll install just fine,
however the perl interpreter won't compile it.

>> I think the right solution is to partially revert
>> 3962f1d756ab41c1d180e35483d1c8dffe51e0d1, but add a comment in the
>> code indicating that it's to deal with RedHat's broken fork of Perl.
>
> I have added comment in commit message, but not in code. =C2=A0I wond=
er if
> it would be enough.
>
>> However even if it's required in an eval it might still fail at
>> runtime in the reset_timer() function, which'll need to deal with it
>> too.
>
> It shouldn't; everything else related to timer is protected with
> 'if defined $t0', which is false if Time::HiRes module is not availab=
le.

Correct, I didn't look carefully enough.
