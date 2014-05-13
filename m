From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 19:01:29 +0700
Message-ID: <CACsJy8DD3c+bsGfUBm3Lm7okqRzwV2oSbZ5k0u92MXS2KjYr_A@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
 <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:02:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBPK-0007Od-2L
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 14:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760040AbaEMMCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 08:02:00 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:37971 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759939AbaEMMB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 08:01:59 -0400
Received: by mail-qc0-f173.google.com with SMTP id i8so237498qcq.32
        for <git@vger.kernel.org>; Tue, 13 May 2014 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Sf2r69XAaO87ZUSyuiGlzdXwL5kkcRs/eP//ngxdXEI=;
        b=QTLqDVQnBDhoANFDqjtvo2ZbirYBw6o7PWNvCEKDyuAEyUbLZMavJSGudx3kqyHQZq
         7la9pLR8AGZD11c1CDaAaIHyer8UAgN57R1KOFl7RdIWO5EHVDAnDZ3FVhBUovBT1ehX
         nQI5sObKzQQaUm2QaZyF2LYR728EybZqqP+omKbNyEa2J3d8Dy/qQWlbpmMSuUCj2QO7
         VfxbQ2V2/X1nPQoWPhUFk/9PlJb5YrOt8XTeF9EWWoY/RI61vCyk7SyFKLsCzQRb0pQF
         I+U3SVDAgbXazXVM+RquSgGQvfvlmceLvp91pBpsQuHBLhj7Jpnh4lxJw1JxJ79q9DPI
         RPEQ==
X-Received: by 10.224.138.3 with SMTP id y3mr47088232qat.78.1399982519314;
 Tue, 13 May 2014 05:01:59 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 13 May 2014 05:01:29 -0700 (PDT)
In-Reply-To: <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248775>

On Tue, May 13, 2014 at 6:52 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> diff --git a/Makefile b/Makefile
>> index 028749b..98d22de 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1502,6 +1502,12 @@ ifdef HAVE_DEV_TTY
>>         BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
>>  endif
>>
>> +ifdef HAVE_SHM
>> +       BASIC_CFLAGS +=3D -DHAVE_SHM
>> +       EXTLIBS +=3D -lrt
>> +       PROGRAM_OBJS +=3D read-cache--daemon.o
>> +endif
>> +
>
> I think read-cache--daemon will fail in case of NO_UNIX_SOCKETS.
>
> But, read-cache--daemon.c only gets compiled if we have shm_open...

Portability is something to be sorted out.Ideally we should not build
this unless we have both unix socket and shared memory support. On
Windows, I'm not sure how much code can be shared, or it'll be a
completely different program. In that case maybe this program should
be read-cache--daemon-posix (at least the .c file name, the binary may
be still git-read-cache--daemon) or something and the Windows version
read-cache--daemon-windows..
--=20
Duy
