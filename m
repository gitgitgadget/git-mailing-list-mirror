From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 12:22:21 -0800
Message-ID: <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
	<1450224252-16833-3-git-send-email-sbeller@google.com>
	<56731715.9000509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9f4E-0004pD-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbbLQUWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 15:22:23 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35183 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbbLQUWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 15:22:22 -0500
Received: by mail-ig0-f177.google.com with SMTP id to4so20939864igc.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Vzj6rlFrbrm0Ap6iZwYYQqUGXgAIHQ5Brd9ptwpsY1E=;
        b=DQVblH43slNI/WVKf5NPuAIiHauNi/obdv40u4A92oW4ye70nSCL8uLAA9OdXGyh6g
         JjCrIdZk/GioA7M7PFnxZSAFRUOx847KosWCHAW7T2AmTtfmftgKqIe5Wlycwthv6Adt
         Q8WwelKZFaJvYgWt2K3lGfJZZCP5S7MWzDOtGeoTNMWFhjqclsAUSp6drPkV3EjpfDaX
         XB/JNPpS2dbA0z+6H65fCrulQcjHfh0I8l2RigzVsQJ7W7MGUdrtgXCmubAbwr+UUAD3
         rRBAvSZBsiwwr6L5Byf0cqOMvOZ1akiJOiZwFHdID2TYrWL/4nNC/ZxTOX/ZSQ+0Hdsf
         2X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vzj6rlFrbrm0Ap6iZwYYQqUGXgAIHQ5Brd9ptwpsY1E=;
        b=Zz862V+r7ujznPcpkK6V38NajPxk1+uMZsaH7Cdyt8yOaHYnpTNYCsrbi8IwSIGdXq
         8sOmYnY+i3KRxd2ykoyUdwptn319Yf88CujlQpE1iFDdmUX8+hYmr2XWw7EEmwWji46a
         5mZLuzR5i8OhCLbV0wwTdxDh7lX/ZaXT7NBAglWRGpiJEVhGaR42kcID1Eg/AkTLV/nf
         dojCpF0KmMryImU0dAy7t7/0SJJixAnFmlZIP0bf9x8gUBWMPLZM+D5SJklrAwfafAHl
         12+vcibt1bMTiW1FwpfogVmFWCH7ds0jGVF2fEkTYQYJBPSNgJerFfDZcfM6mS84qe0Y
         vH3w==
X-Gm-Message-State: ALoCoQmZHaKvhSZNjidldomne68cYm9rG74/5uFvcAw4z4FnyrtWwIf9PuVTRc4PI9n8T2mTm8QdH2J4OcueHxS/jvtPFBVoZuLte0+G0Ihdl1M/uK7ywsQ=
X-Received: by 10.50.88.97 with SMTP id bf1mr393384igb.94.1450383741489; Thu,
 17 Dec 2015 12:22:21 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 17 Dec 2015 12:22:21 -0800 (PST)
In-Reply-To: <56731715.9000509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282672>

On Thu, Dec 17, 2015 at 12:12 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 16.12.15 01:04, Stefan Beller wrote:
>> The man page of read(2) says:
>>
>>   EAGAIN The file descriptor fd refers to a file other than a socket
>>        and has been marked nonblocking (O_NONBLOCK), and the read
>>        would block.
>>
>>   EAGAIN or EWOULDBLOCK
>>        The file descriptor fd refers to a socket and has been marked
>>        nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-=
2001
>>        allows either error to be returned for this case, and does no=
t
>>        require these constants to have the same value, so a portable
>>        application should check for both possibilities.
>>
>> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
>> As the intent of xread is to read as much as possible either until t=
he
>> fd is EOF or an actual error occurs, we can ease the feeder of the f=
d
>> by not spinning the whole time, but rather wait for it politely by n=
ot
>> busy waiting.
>>
>> We should not care if the call to poll failed, as we're in an infini=
te
>> loop and can only get out with the correct read().
> I'm not sure if this is valid under all circumstances:
> This is what "man poll" says under Linux:
> []
>  ENOMEM There was no space to allocate file descriptor tables.
> []
> And this is from Mac OS, ("BSD System Calls Manual")
> ERRORS
>      Poll() will fail if:
>
>      [EAGAIN]           Allocation of internal data structures fails.=
  A sub-
>                         sequent request may succeed.
> And this is opengroup:
> http://pubs.opengroup.org/onlinepubs/9699919799//functions/poll.html:
> [EAGAIN]
>     The allocation of internal data structures failed but a subsequen=
t request may succeed.
>
> read() may return EAGAIN, but poll() may fail to allocate memory, and=
 fail.
> Is it always guaranteed that the loop is terminated?

In case poll fails (assume a no op for it), the logic should not have
changed by this patch?

Looking closely:

>>       while (1) {
>>               nr =3D read(fd, buf, len);
>> -             if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D E=
INTR))
>> -                     continue;
>> +             if (nr < 0) {
>> +                     if (errno =3D=3D EINTR)
>> +                             continue;
>> +                     if (errno =3D=3D EAGAIN || errno =3D=3D EWOULD=
BLOCK) {
>> +                             struct pollfd pfd;
>> +                             pfd.events =3D POLLIN;
>> +                             pfd.fd =3D fd;
>> +                             /*
>> +                              * it is OK if this poll() failed; we
>> +                              * want to leave this infinite loop
>> +                              * only when read() returns with
>> +                              * success, or an expected failure,
>> +                              * which would be checked by the next
>> +                              * call to read(2).
>> +                              */
>> +                             poll(&pfd, 1, -1);

Or do you mean to insert another continue in here?

>> +                     }
>> +             }
>>               return nr;
>>       }
>>  }
>>
>
