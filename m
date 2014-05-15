From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 21:37:39 +0200
Message-ID: <CANQwDweFGwt5w2bJ1CesC50AAiJXBDT8uxuBEpFZ+nLbQaA_VQ@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael Wagner <accounts@mwagner.org>
X-From: git-owner@vger.kernel.org Thu May 15 21:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1U0-000800-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbaEOTiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 15:38:20 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55207 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaEOTiT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 15:38:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id n16so1853532oag.24
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yr8hRCnj1GsQ5bK1u5G3QYlwOSqV8Bxe/rIAdeXRAa8=;
        b=FoYH9Q40sS27xoniL8J1AOqi8f/9U1BKDoLTLPH54fzqGMFzx7OGSqLFZTvDJomtmY
         nKIXCjdeHymjVnXN0t51m+p5bT9g30oZiixIEam9viCMojaB2yyt0txKGbpQBRguGKK2
         ZpxHvHoDGuxNP+daf7WopvUISq2Pc32iqENLIlU//B4FWbJjTd6DL6xAn/+8KqJMtJdi
         c3cEUExAP60Suzf6aI82cuXY0hNyyeLg91ud8zJV06T+c4monHWTCIvySUlSWiRrMq/G
         w1N447wd+iA1fXFY9J1FvipItbR/0GfoRQigdoV1xigyqBvDnwuYvebAqrM31gQ63PTa
         lCyg==
X-Received: by 10.60.37.99 with SMTP id x3mr12175024oej.65.1400182699290; Thu,
 15 May 2014 12:38:19 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Thu, 15 May 2014 12:37:39 -0700 (PDT)
In-Reply-To: <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249192>

On Thu, May 15, 2014 at 9:28 PM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
> On Thu, May 15, 2014 at 8:48 PM, Michael Wagner <accounts@mwagner.org=
> wrote:
[...]
>> The subroutine "git tree" generates the tree view. It stores the out=
put
>> of "git ls-tree -z ..." in an array named "@entries". Printing the c=
ontent
>> of this array yields the following result:
>>
>> 00644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=C3=83=C2=
=BCtekriterien.txt
>>
>> This leads to the "doubled" encoding. Declaring the encoding in the =
call
>> to open yields the following result:
>>
>> 100644 blob 6419cd06a9461c38d4f94d9705d97eaaa887156a     520 G=C3=BC=
tekriterien.txt

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a9f57d6..f1414e1 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -7138,7 +7138,7 @@ sub git_tree {
>>         my @entries =3D ();
>>         {
>>                 local $/ =3D "\0";
>> -               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
>> +               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-tre=
e", '-z',
>>                         ($show_sizes ? '-l' : ()), @extra_options, $=
hash
>>                         or die_error(500, "Open git-ls-tree failed")=
;
>
> Or put
>
>                    binmode $fd, ':utf8';
>
> like in the rest of the code.
>
>>                 @entries =3D map { chomp; $_ } <$fd>;

Though to be exact there isn't any mechanism that ensures that
filenames in tree objects use utf-8 encoding, so perhaps a safer
solution would be to use

   to_utf8($file_name)

(which respects $fallback_encoding) in appropriate places.

--=20
Jakub Nar=C4=99bski
