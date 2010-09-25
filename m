From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when
 using dash
Date: Sat, 25 Sep 2010 17:24:05 +0000
Message-ID: <AANLkTimdUC++Lq1z4i5E8cw5ej7nQhZ6hcNoffQ1tM9i@mail.gmail.com>
References: <4C98EF25.4070700@ramsay1.demon.co.uk>
	<7viq1xsi7a.fsf@alter.siamese.dyndns.org>
	<4C9E2CA6.2070805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzYTt-0007EK-G5
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab0IYRYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 13:24:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61405 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab0IYRYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 13:24:06 -0400
Received: by iwn5 with SMTP id 5so3348396iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5blHzX1RkODKabULz2mJsIezxPtc6/xrSIev6ioxh3Y=;
        b=UAEs+tKGuCu9rg4vzHkSlotbzcOrkelpZo+6qP0u9+a+ajs+af/coe7HLCy+/lk8nV
         J6a9EBpLYaKGDEGPnBw3d0/cxx4bEs7ju3NHcCd2dc2D0E1h3DwBatyEycZi94dZf1DZ
         gnRySaaezRpFvr79PnGPXz7Yzg9ijoVEJmSbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I7P3uVE3/cudNuTXZoNkQ55au4EgInXyL2/P9eoW2FDhZ+QDhCuSg3s4BUVuKUr9h0
         hUi4f83t6VXnY3guYigP5fDm+DtYqFwDLhKY+qwkPfMMYCKR34hEkxWr/b/g3MvWMtsY
         rC1Ke1Ca9ywRBxGR7Y8lQjyP7sisPy/RRLBLk=
Received: by 10.231.167.80 with SMTP id p16mr5928240iby.119.1285435445855;
 Sat, 25 Sep 2010 10:24:05 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 10:24:05 -0700 (PDT)
In-Reply-To: <4C9E2CA6.2070805@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157170>

On Sat, Sep 25, 2010 at 17:08, Ramsay Jones <ramsay@ramsay1.demon.co.uk=
> wrote:
> Junio C Hamano wrote:
>> POSIX wants shells to support both "N" and "$N" and requires them to=
 yield
>> the same answer to $((N)) and $(($N)), but we should aim for portabi=
lity
>> in a case like this, especially when the price we pay to do so is so
>> small, i.e. a few extra dollars.
>
> Indeed
>
>> By the way, on my box, I get this:
>>
>> =C2=A0 =C2=A0 $ ls l /bin/dash
>> =C2=A0 =C2=A0 -rwxr-xr-x 1 root root 104024 2008-08-26 02:36 /bin/da=
sh*
>> =C2=A0 =C2=A0 $ dpkg -l dash | grep '^ii'
>> =C2=A0 =C2=A0 ii =C2=A0dash =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00.5.4-12 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0POSIX-compliant shell
>> =C2=A0 =C2=A0 $ /bin/dash -c 'N=3D20 ; echo $(( N + 3 ))'
>> =C2=A0 =C2=A0 23
>
> Ah, yes, I should have checked for this... particularly since I now
> vaguely remember reading that this had been "fixed"... *blush*
> Sorry about that.
>
> For the record, on my system I get:
>
> =C2=A0 =C2=A0$ ls -l /bin/dash
> =C2=A0 =C2=A0-rwxr-xr-x 1 root root 80500 2007-03-05 06:00 /bin/dash*
> =C2=A0 =C2=A0$ dpkg -l dash | grep '^ii'
> =C2=A0 =C2=A0ii =C2=A0dash =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.5.3-5=
ubuntu2 The Debian Almquist Shell
> =C2=A0 =C2=A0$ /bin/dash -c 'N=3D20; echo $(( N + 3 ))'
> =C2=A0 =C2=A0/bin/dash: arith: syntax error: " N + 3 "
>
>> I just left it vague by saying "e.g. older dash" in below, but we ma=
y want
>> to be more precise in the documentation.
>
> I found a bug report:
>
> =C2=A0 =C2=A0http://bugs.launchpad.net/ubuntu/+source/dash/+bug/92189
>
> which had a post against it which implied that this was fixed in
> version 0.5.4-3. I went over to packages.debian.org to read the
> ChangeLog for this version, but I could not conclude anything
> from that text. :(
>
> Do we need to be more precise?

If you want to spend the effort to track it down that would be
great. There's a dash git repository on kernel.org you can probably
bisect:

    http://git.kernel.org/?p=3Dutils/dash/dash.git;a=3Dsummary
