From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 1/2] git p4: Fixing script editor checks
Date: Wed, 11 Apr 2012 21:24:40 +0200
Message-ID: <CAE5ih7-49ynPFrHDn_a0fiskSjfovS4qX2eHh9W3G08HaHHRkw@mail.gmail.com>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
	<1334157684-31402-2-git-send-email-luke@diamand.org>
	<7vpqbekx7h.fsf@alter.siamese.dyndns.org>
	<CAE5ih7_X=4gewga8fMzaEvowsJsA1Ta9PQ2bGixx5eVvykputA@mail.gmail.com>
	<7vpqbejdf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI39r-0007oX-EW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009Ab2DKTYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 15:24:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43719 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab2DKTYl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 15:24:41 -0400
Received: by wejx9 with SMTP id x9so774432wej.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 12:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=dbheimz45yuw9jiMqweZuYINvA2TiN5CSyry/hsEmrc=;
        b=grs3iSZR91guC9R+kBiLEgc8W/yhbJBTxJ4Q9P+4HvQtlFUrjo9S6GGFcddvSoGwoG
         0BwFxMbSnOxg+bYqmoez9A35vG6ZokWfS3pDsq86dT0kAwrjCBycDlZ9kt/8CXcs9SfN
         3dFjlyFxS7NsB35aLR7j59oArmylZ6MHo4LW6tvdQsyl8ZrfQ0sNKrY1cMZ2N9n1bEoL
         /a/L5WhaupMSTjyqcpsFx/eYAfRy9c8o5kddZz+ycoveJhbQggTEq5kF7D67jEf22D7N
         8Bzbt/Pa4lor5wFwxC4Fj9T48ASWAQ5OPFH0L1g7aXjquGKyxpKkIV06oPRW8Z4Q0om6
         1TVA==
Received: by 10.216.137.30 with SMTP id x30mr8914202wei.34.1334172280421; Wed,
 11 Apr 2012 12:24:40 -0700 (PDT)
Received: by 10.216.204.27 with HTTP; Wed, 11 Apr 2012 12:24:40 -0700 (PDT)
In-Reply-To: <7vpqbejdf4.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkrZMTaRKmXXAK/oMwtKg9ULI+bOimYAUyjW15Kz4336BETUFGA0jgvh2dTjqjC+Fz/K0Ay
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195243>

On Wed, Apr 11, 2012 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Luke Diamand <luke@diamand.org> writes:
>
>> On Wed, Apr 11, 2012 at 7:14 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> If P4EDITOR is defined, the tests will fail when "git p4" starts a=
n
>>>> editor.
>>>
>>> Is that a problem specific to tests, or should "git p4" itself unse=
t that
>>> environment? If it is a problem specific to tests, would it be a be=
tter
>>> fix to add "P4EDITOR=3D:" like we do for EDITOR in t/test-lib.sh?
>>
>> Yes and no - git-p4.py will run $P4EDITOR if it is set, even if it's
>> just empty. So it would need a small fix to check for an empty strin=
g.
>> I can submit a suitable patch.
>
> How does real "p4" run $P4EDITOR? =C2=A0For example, if you have:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0P4EDITOR=3D'vi -e'
>
> does it start "vi" in its "ex" mode, implying that it behaves as if t=
he
> invocation were like this in a hypothetical implementation of "p4" as=
 a
> shell script:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#!/bin/sh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... do some stuff p4 does ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$P4EDITOR file-to-be-edited
>
> Whatever it does needs to be emulated by the code in git-p4.py that r=
uns
> it, as that is the way the end users expect, and if it turns out to b=
e
> like the above, setting P4EDITOR to ':' just like we do to EDITOR in
> t/test-lib.sh should be the right thing to do. =C2=A0The always-true =
command
> colon will leave the file-to-be-edited unmodified and report success.
>
> Similarly, what happens with "p4" when $P4EDITOR is set to an empty
> string? =C2=A0If it ignores and falls back to the other usual way to =
find your
> preferred editor, you should emulate that as well in git-p4.py.
>
> Thanks.

"vi -e" =3D> vi in ex mode
":" =3D> always-true-command
"" =3D> falls back to $EDITOR, and then to vi(UNIX or Win32 if $SHELL i=
s
set) or notepad(Win32).
