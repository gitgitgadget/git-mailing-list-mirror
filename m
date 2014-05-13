From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/8] unix-socket: stub impl. for platforms with no unix
 socket support
Date: Tue, 13 May 2014 14:03:27 +0200
Message-ID: <CABPQNSayUdjgby7Pp7rGD0Vn9qb7rGOXfC8neM-4g-Lu7aAQzw@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-4-git-send-email-pclouds@gmail.com>
 <CABPQNSZAxyWJucyJbO0ND2X5V+cnCFCGLZPfFhygi2tUVQCXYg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:04:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBRP-0002Vn-AY
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 14:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbaEMMEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 08:04:09 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:51566 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbaEMMEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 08:04:07 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so5059354igq.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=M2U7xfZNmhKgLmnnMIA+r+2b5QHtmHU+r1jMKva25o0=;
        b=IOI1Z9eoEvoTujB4x8PykXoaQyQFh/EzJkG3l7jndQ82NufXsTKcXdMgtMexumSraA
         AIxS+lM9T/33ig6h1WJXx9dHKGkoi0e8i+liWajbKXlRfg/J683n9a4yRFutQ85ImKA4
         H45wzUV22Gk6/ij1CEFrnFVKWFKVibGB4u77aFKuo3EuXJmNs49nHUuikJPgdYCJ3HrN
         aQWe7FI3fLfy0BCuyV59g1kNEXla0OskJOOnMQoK8g/stWvWmFjYkli64Xq+N5o48L4v
         EX/eJqTYqRzqgns4gy5NsbypkgPjQ7kAiLBBmVw+dn++1P0BU8Eb7DDGVgeQASR0wg6W
         OpDQ==
X-Received: by 10.50.154.73 with SMTP id vm9mr56359899igb.14.1399982647213;
 Tue, 13 May 2014 05:04:07 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 05:03:27 -0700 (PDT)
In-Reply-To: <CABPQNSZAxyWJucyJbO0ND2X5V+cnCFCGLZPfFhygi2tUVQCXYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248776>

On Tue, May 13, 2014 at 1:59 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> With this we can make unix_stream_* calls without #ifdef.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Makefile      |  2 ++
>>  unix-socket.h | 18 ++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 028749b..d0a2b4b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1417,6 +1417,8 @@ ifndef NO_UNIX_SOCKETS
>>         LIB_H +=3D unix-socket.h
>>         PROGRAM_OBJS +=3D credential-cache.o
>>         PROGRAM_OBJS +=3D credential-cache--daemon.o
>> +else
>> +       BASIC_CFLAGS +=3D -DNO_UNIX_SOCKETS
>>  endif
>>
>>  ifdef NO_ICONV
>> diff --git a/unix-socket.h b/unix-socket.h
>> index e271aee..f1cba70 100644
>> --- a/unix-socket.h
>> +++ b/unix-socket.h
>> @@ -1,7 +1,25 @@
>>  #ifndef UNIX_SOCKET_H
>>  #define UNIX_SOCKET_H
>>
>> +#ifndef NO_UNIX_SOCKETS
>> +
>>  int unix_stream_connect(const char *path);
>>  int unix_stream_listen(const char *path);
>>
>> +#else
>> +
>> +static inline int unix_stream_connect(const char *path)
>> +{
>> +       errno =3D ENOSYS;
>> +       return -1;
>> +}
>> +
>> +static inline int unix_stream_listen(const char *path)
>> +{
>> +       errno =3D ENOSYS;
>> +       return -1;
>> +}
>> +
>> +#endif
>> +
>>  #endif /* UNIX_SOCKET_H */
>
> OK, so I missed this before my other two comments. But still... in
> what way does errno=3DENOSYS make this *work*? Won't we end up compil=
ing
> lots of non-functional tools on Windows in this case?

ENOSYS makes git-credential-cache.c just die with the message "unable
to start cache daemon", and git-credential--daemon.c die with "unable
to bind to <socket_path>".
