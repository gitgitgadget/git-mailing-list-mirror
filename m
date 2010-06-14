From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] Add infrastructure for translating Git with gettext
Date: Mon, 14 Jun 2010 22:51:11 +0000
Message-ID: <AANLkTimpb9_91SOCR_SkA38Iwi6LQzu3ejxgtmyHe6tA@mail.gmail.com>
References: <1275846453-3805-1-git-send-email-avarab@gmail.com>
	<1275846453-3805-2-git-send-email-avarab@gmail.com>
	<AANLkTikuSTKbPkTrRtw4fvNUxlh32uhTlbq0g-q35dng@mail.gmail.com>
	<201006142356.46780.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 15 00:51:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOIUw-0001qJ-31
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 00:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219Ab0FNWvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 18:51:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33359 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080Ab0FNWvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 18:51:12 -0400
Received: by iwn9 with SMTP id 9so3823637iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M/PHIAANDglkdf8cINsdyd6DTuJ43JdzmBvUXPdeVac=;
        b=LX/N8OIOEdIpEtbzryx8Zb6PjX9uRSGz5agNoDTMk5T6Q50WPhXk85Y+HKb2eDllqA
         LyAthDeYEq0JVt3YqUZ2OhKm39wK7kbl0xfSnYuV6USk1kseYpcFNC/CtKgsGV3hS6qT
         SSqTLG6ltAh7bH5fTjX1IM9fnqp81RHtGE5PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hAkWmJ+GimlNtYW5WWu4njdTS9eskTB/oOV3BN59PYhxyJEgex5B2iudCExI+Xmxcw
         99CUHBw5xU0L64lY9tMgAiKyEYHPCQezUf5AePM+DrwhraeUJlsxChTq/jO+vtTaiPX/
         SH0pLUbDDdWC1/SikJj+qmrfqATf9er4RF5Sk=
Received: by 10.231.168.135 with SMTP id u7mr6676835iby.125.1276555871530; 
	Mon, 14 Jun 2010 15:51:11 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 15:51:11 -0700 (PDT)
In-Reply-To: <201006142356.46780.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149144>

On Mon, Jun 14, 2010 at 21:56, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> It turns out that this doesn't actually work, and I can't find a
>> workaround. In Bash and Solaris's /bin/sh this executes until "dies
>> here". The problem is that I can't use the subshell trick, since the
>> gettext.sh inclusion has to be done in the current shell (I checked,
>> tests will fail).
>>
>> =C2=A0 =C2=A0 #!/bin/sh
>> =C2=A0 =C2=A0 (. does-not-exist.sh)
>> =C2=A0 =C2=A0 echo "A subshell made it! ret =3D $?"
>> =C2=A0 =C2=A0 . does-not-exist.sh
>> =C2=A0 # dies here
>> =C2=A0 =C2=A0 echo "A real shell made it! ret =3D $?"
>>
>> Is there some clever shellscript trick that I'm missing, or will I
>> have to resort to modifying the file at `make' time for this to work
>> everywhere?
>
> Works for me in bash (4.0.35), but fails the way you say in dash (if
> only I could figure out the option that tells me the version!).
>
> This works however:
>
> =C2=A0type does-not-exist.sh 2>/dev/null && . does-not-exist.sh

Thanks. That works, I've tested the following script:

    #!/bin/sh
    type meh.sh >/dev/null 2>&1 && . meh.sh && echo "Included meh.sh"
|| echo "Didn't include meh.sh"
    echo "I've made it!"
    type gettext.sh >/dev/null 2>&1 && . gettext.sh && echo "Included
gettext.sh" || echo "Didn't include gettext.sh"
    echo "I've made it!"

On the following:

    FreeBSD: /bin/sh, bash
    Solaris: /bin/sh, /usr/bin/ksh, bash,
    Debian: dash, bash

They all make it to the last "I've made it!".

> I suspect it only works if the script is executable, as otherwise typ=
e
> would not find it (but . would). =C2=A0But at least on my system, it =
is.

With gettext.sh the assumption that it's +x seems valid, the
installation script for GNU gettext always gives it an executable bit.
