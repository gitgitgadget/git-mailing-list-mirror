From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Tue, 17 Sep 2013 16:24:13 +0800
Message-ID: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de>
	<5231F839.3080208@kdbg.org>
	<xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
	<CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com>
	<xmqq7gelmfm5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 10:24:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLqa5-0000kd-RD
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab3IQIYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 04:24:17 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:51105 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3IQIYP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Sep 2013 04:24:15 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so4131977wgh.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m5xwkyWdzyoGNghoUS2baNb9rZk3Qp4o+eFnJLDPU8g=;
        b=kqw9Mt5TYgDcFL5EYyS4qoTibDG7ZR+cpsB6mEdxDizssoo8kN/HBljqyqd1AWB3G5
         JZSBcLDTeHrT5b5x/Vd9pPznZI5I5Itx1M15zlrDjD4EmaCjWX85wtagRjnxnC7ewu4G
         7LpuWhxvE/3WVHy4BFitjkzunWp6fsbWcafPfVl2wewamdYTxllkxQr9b7vY7p195+Wz
         wjN5Mm1DlNvt35HQhr8rV1t/OIxfefxSlvtG6CaL15/gDsTNAAaRySM/lyEEkBAaorvx
         paviY+G6kXBoOUXiruAlmVViFaRmKlBlyUkvN/NrCWmdjYm472EdEmiEsGbksdK8Ky17
         TwAw==
X-Received: by 10.194.201.168 with SMTP id kb8mr48900wjc.63.1379406254017;
 Tue, 17 Sep 2013 01:24:14 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Tue, 17 Sep 2013 01:24:13 -0700 (PDT)
In-Reply-To: <xmqq7gelmfm5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234860>

2013/9/13 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> 2013/9/13 Junio C Hamano <gitster@pobox.com>:
>>>
>>> For systems that need POSIX escape hatch for Apollo Domain ;-), we
>>> would need a bit more work.  When both path1 and path2 begin with a
>>> double-dash, we would need to check if they match up to the next
>>> slash, so that
>>>
>>>  - //host1/usr/src and //host1/usr/lib share the same root and the
>>>    former can be made to ../src relative to the latter;
>>>
>>>  - //host1/usr/src and //host2/usr/lib are of separate roots.
>>>
>>> or something.
>>
>> But how could we know which platform supports network pathnames and
>> needs such implementation.
>
> Near the end of
>
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.ht=
ml#tag_04_12
>
> is this:
>
>     If a pathname begins with two successive <slash> characters, the
>     first component following the leading <slash> characters may be
>     interpreted in an implementation-defined manner, although more th=
an
>     two leading <slash> characters shall be treated as a single <slas=
h>
>     character.
>
> Two points to note are
>
>  (1) Only paths that begin with exactly two slashes are special.
>
>  (2) As it is "implementation-defined", we are not even allowed to
>      treat that //host1/usr/src and //host1/usr/lib as sharing "the
>      same root", and make the former to ../src relative to the
>      latter.
>
> So in the strictest sense, we do not have to bother. As long as we
> make sure we do not molest anything that begins with exactly two
> slashes.
>

I have checked the behavior of UNC path on Windows (msysGit):

* I can cd to a UNC path:

    cd //server1/share1/path

* can cd to other share:

    cd ../../share2/path

* and can cd to other server's share:

    cd ../../../server2/share/path

That means relative_path(path1, path2) support UNC paths out of the box=
=2E
We only need to check both path1 and path2 are UNC paths, or both not.

So, funciton =93have_same_root" will write like this:


+static int have_same_root(const char *path1, const char *path2)
+{
+       int is_abs1, is_abs2;
+
+       is_abs1 =3D is_absolute_path(path1);
+       is_abs2 =3D is_absolute_path(path2);
+       if (is_abs1 && is_abs2) {
+               if (is_unc_path(path1) ^ is_unc_path(path2))
+                       return 0;
+               return tolower(path1[0]) =3D=3D tolower(path2[0]);
+       } else {
+               return !is_abs1 && !is_abs2;
+       }
+}


--=20
Jiang Xin
