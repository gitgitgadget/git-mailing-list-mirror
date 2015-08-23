From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Sun, 23 Aug 2015 13:45:26 -0400
Message-ID: <CAPig+cSNSfpt7gOLvz7P4oDrNF5fTQ38v1pfncJU3h7a6FjMyQ@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schauer <josch@debian.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:45:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTZKm-0006CI-C1
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbHWRp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 13:45:27 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36036 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbbHWRp0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 13:45:26 -0400
Received: by ykfw73 with SMTP id w73so114658961ykf.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=sEQ7sXbe/8mzoAeE3RCDxwV5zvGmK74djmImsXvV4aQ=;
        b=gViRSU7iqq8k34dPw8vFEBS3hUeQ36CWfdabQ25n8386DaRgi/PCj9GDtZHD2wO/7h
         KmA65SgXU5p4ADq4gBDHkbRfDU7D+x+qPo8+6g3gAEQC39o7LkR2D/3D5XiIXWSCdGc6
         DYDHqlhoTDOM5vQUyjKHQy1NgIvxhzTR3g+p5XujAC+dzZPzGxa+bN0QwGYVH9uY1/Bg
         Sl8MhXScLO+ztEj0KhPTFRUjwQN7u+iG1iICKWKqt9Y4Cw1ez7sIGn3KQp6AfBiea3Bv
         s+U6JVuAA+mPnzq4w+iNuPHtWDMy0fp0kA1PfC1x/VxmL9skpCw699aG2+ebplkAf2Ra
         s/xw==
X-Received: by 10.170.172.84 with SMTP id o81mr24934209ykd.69.1440351926116;
 Sun, 23 Aug 2015 10:45:26 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 23 Aug 2015 10:45:26 -0700 (PDT)
In-Reply-To: <trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
X-Google-Sender-Auth: xIFEdmj7WTot-PViPJDy_FYfvL4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276416>

On Sun, Aug 23, 2015 at 5:29 AM, "Ren=C3=A9 Scharfe" <l.s.r@web.de> wro=
te:
> Am 23.08.2015 um 07:54 schrieb Eric Sunshine:
>> On Sat, Aug 22, 2015 at 3:06 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>> +test_lazy_prereq ZIPINFO '
>>> +       n=3D$("$ZIPINFO" "$TEST_DIRECTORY"/t5004/empty.zip | sed -n=
 "2s/.* //p")
>>> +       test "x$n" =3D "x0"
>>> +'
>>
>> Unfortunately, this sed expression isn't portable due to dissimilar
>> output of various zipinfo implementations. On Linux, the output of
>> zipinfo is:
>>
>>      $ zipinfo t/t5004/empty.zip
>>      Archive:  t/t5004/empty.zip
>>      Zip file size: 62 bytes, number of entries: 0
>>      Empty zipfile.
>>      $
>>
>> however, on Mac OS X:
>>
>>      $ zipinfo t/t5004/empty.zip
>>      Archive:  t/t5004/empty.zip   62 bytes   0 files
>>      Empty zipfile.
>>      $
>>
>> and on FreeBSD, the zipinfo command seems to have been removed
>> altogether in favor of "unzip -Z" (emulate zipinfo).
>
> I suspected that zipinfo's output might be formatted differently on
> different platforms and tried to guard against it by checking for the
> number zero there. Git's ZIP file creation is platform independent
> (modulo bugs), so having a test run at least somewhere should
> suffice. In theory.
>
> We could add support for the one-line-summary variant on OS X easily,
> though.

Probably, although it's looking like testing on Mac OS X won't be
fruitful (see below).

>> One might hope that "unzip -Z" would be a reasonable replacement for
>> zipinfo, however, it is apparently only partially implemented on
>> FreeBSD, and requires that -1 be passed, as well. Even with "unzip -=
Z
>> -1", there are issues. The output on Linux and Mac OS X is:
>>
>>      $ unzip -Z -1 t/t5004/empty.zip
>>      Empty zipfile.
>>      $
>>
>> but FreeBSD differs:
>>
>>      $ unzip -Z -1 t/t5004/empty.zip
>>      $
>>
>> With a non-empty zip file, the output is identical on all platforms:
>>
>>      $ unzip -Z -1 twofiles.zip
>>      file1
>>      file2
>>      $
>>
>> So, if you combine that with "wc -l" or test_line_count, you may hav=
e
>> a portable and reliable entry counter.
>
> Counting all entries is slow, and more importantly it's not what we
> want. In this test we need the number of entries recorded in the ZIP
> directory, not the actual number of entries found by scanning the
> archive, or the directory.

Ah, right. The commit message did state this clearly enough...

> On Linux "unzip -Z -1 many.zip | wc -l" reports 65792 even before
> adding ZIP64 support; only without -1 we get the interesting numbers
> (specifically with "unzip -Z many.zip | sed -n '2p;$p'"):
>
>     Zip file size: 6841366 bytes, number of entries: 256
>     65792 files, 0 bytes uncompressed, 0 bytes compressed: 0.0%
>
>> With these three patches applied, Mac OS X has trouble with 'many.zi=
p':
>>
>>      $ unzip -Z -1 many.zip
>>      warning [many.zip]:  76 extra bytes at beginning or within zipf=
ile
>>        (attempting to process anyway)
>>      error [many.zip]:  reported length of central directory is
>>        -76 bytes too long (Atari STZip zipfile?  J.H.Holm ZIPSPLIT 1=
=2E1
>>        zipfile?).  Compensating...
>>      00/
>>      00/00
>>      ...
>>      ff/ff
>>      error: expected central file header signature not found (file
>>        #65793). (please check that you have transferred or created t=
he
>>        zipfile in the appropriate BINARY mode and that you have comp=
iled
>>        UnZip properly)
>>
>> And FreeBSD doesn't like it either:
>>
>>      $ unzip -Z -1 many.zip
>>      unzip: Invalid central directory signature
>>      $
>>
>
> Looks like they don't support ZIP64. Or I got some of the fields wron=
g
> after all.

A >65536 file zip created on Mac OS X with Mac's "zip" command given
to "unzip" or "zipinfo" results in exactly the same warnings/errors as
above (including the bit about "76 extra bytes" and "-76 bytes too
long"), so it doesn't seem to be a problem with your implementation.

> https://en.wikipedia.org/wiki/Zip_%28file_format%29#ZIP64 says: "OS X
> Yosemite does support the creation of ZIP64 archives, but does not
> support unzipping these archives using the shipped unzip command-line
> utility or graphical Archive Utility.[citation needed]".
>
> How does unzip react to a ZIP file with more than 65535 entries that
> was created natively on these platforms? And what does zipinfo (a rea=
l
> one, without -1) report at the top for such files?

On Mac OS X, unzip does extract all the files (although complains as
noted above). zipinfo caps out at reporting 65535 for the number of
files (although it lists them all fine). With the warnings/errors
filtered out for clarity:

    $ zipinfo biggy.zip
    Archive:  biggy.zip   9642874 bytes   65535 files
    ...
