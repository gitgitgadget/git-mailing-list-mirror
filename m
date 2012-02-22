From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Wed, 22 Feb 2012 01:15:17 -0800
Message-ID: <CAJDDKr72rPqp1z-12Ht3Q2UaeUVFutKwoOgkD1G+SbhsBs+p1A@mail.gmail.com>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
	<7vd397g8ic.fsf@alter.siamese.dyndns.org>
	<CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com>
	<7vbooregj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 10:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S08IO-0001ad-MN
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 10:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab2BVJPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 04:15:24 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57923 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab2BVJPS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 04:15:18 -0500
Received: by ghrr11 with SMTP id r11so3297305ghr.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 01:15:17 -0800 (PST)
Received-SPF: pass (google.com: domain of davvid@gmail.com designates 10.236.154.165 as permitted sender) client-ip=10.236.154.165;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davvid@gmail.com designates 10.236.154.165 as permitted sender) smtp.mail=davvid@gmail.com; dkim=pass header.i=davvid@gmail.com
Received: from mr.google.com ([10.236.154.165])
        by 10.236.154.165 with SMTP id h25mr22288482yhk.34.1329902117584 (num_hops = 1);
        Wed, 22 Feb 2012 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3OhCOpqs0Bw98ke2jw7bdA6ovxrym5VbXZGngziaGk0=;
        b=TplNhC/P/Uh3kkVFsVGz13vp97Zn8RFcIa65r+6fHnWf0H98PSyNyeyiYjJb+4U38l
         BlErMax9I6DjQRfBLoFPCY3euhdgpJXlNLout1scKL3HuHoRtvI7jaHAtOfRGHA0lloo
         84NSEGUgipFnH+5VahEOWJrpt4qaPN4l+g7zk=
Received: by 10.236.154.165 with SMTP id h25mr17598396yhk.34.1329902117529;
 Wed, 22 Feb 2012 01:15:17 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Wed, 22 Feb 2012 01:15:17 -0800 (PST)
In-Reply-To: <7vbooregj6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191241>

On Tue, Feb 21, 2012 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> There is no specific reason it must be bash. =C2=A0I changed from
>> "#!/bin/sh" to "#!/bin/bash -e" due to a bug report from a user on
>> Ubuntu [1]. =C2=A0The user reported that:
>>
>> =C2=A0 =C2=A0 "If you use /bin/sh on ubuntu you get the dash shell i=
nstead of bash shell.
>> =C2=A0 =C2=A0 This causes git_merge_tool_path to fail. The error isn=
't trapped,
>> so it exits
>> =C2=A0 =C2=A0 without displaying anything and without cleaning up."
>>
>> Given that all the other scripts distributed with git use /bin/sh, I
>> will change this script to match.
>
> You need to dig back to that bug report deeper and find out what exac=
tly
> is causing the "failure", before blindly allowing /bin/dash to be use=
d.
>
> I think the above function name is a typo of get_merge_tool_path that=
 is
> borrowed from git-mergetool--lib.sh, but nothing in the function jump=
s as
> a blatant bash-ism at me from a quick reading.
>
> David, any idea on this?

I don't see any bash-isms there myself, either.  We should keep this
stuff without bash-isms.
I haven't had time to read these patches in depth yet but will try to
read the re-roll.

Can we ask the github user to elaborate on what exactly was erroring ou=
t?
Does dash not handle || inside $()?  We can only make wild guesses
without their help.

The only hint from the pull request is "silent exit with no results".
Do we do that?
There are a few code paths where we do "exit 1" but that's only under
error conditions.

We haven't had any reports about git-mergetool/difftool, which use
these functions...
are we certain the problem was not some other bash-isms in the script?
--=20
David
