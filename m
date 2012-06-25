From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] i18n: leave \n out of translated diffstat
Date: Mon, 25 Jun 2012 18:17:22 +0700
Message-ID: <CACsJy8De_Toy+7jvsBueYZpcuakTxZupmwLYZVm29Ni3+1QuMw@mail.gmail.com>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <20120624160411.GA18791@burratino> <7vzk7shvd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7It-0005I8-Av
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab2FYLRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 07:17:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58490 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab2FYLRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 07:17:53 -0400
Received: by wgbdr13 with SMTP id dr13so3994983wgb.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Wx2+rwYoz2ylnSMzQ531rk5/gXf6B1hVjUkoO4gXROY=;
        b=FfiVBQeFAd/XtapeRJFnF9kMk0nSbohO5Lsbsmz+OusZ3hWfepw4vOMqcN9sevmM/1
         PLnJT+WeQbNDI86kmGNe6qr/N0+3aZeoFQyNq3OXDVcAui42wQMGm8cfgAFYkkNVW9ha
         80UOuFlxsiOmInTUYy0nRp70JRq4g0fYdkpU9sF8IsM1FArQheLRtqgUYH8zhcJ+DAsk
         otdwL6M59+qQXWuem3rhSDLGl9mPx19TSMyNmJLTXQlEXXbsrE5A+98IwxRwQIhRVV/O
         fqTwie7nb9Gd8xOaxTYi2O2JpbfutDPqxIM7taM7juSbZTEdRSZnLOS4AyAJpPM6/4Q2
         S1eQ==
Received: by 10.216.194.196 with SMTP id m46mr6502541wen.197.1340623072613;
 Mon, 25 Jun 2012 04:17:52 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Mon, 25 Jun 2012 04:17:22 -0700 (PDT)
In-Reply-To: <7vzk7shvd0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200566>

On Mon, Jun 25, 2012 at 11:24 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Hi,
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>>> GETTEXT_POISON scrapes everything in translated strings, including =
\n.
>>> t4205.12 however needs this \n in matching the end result. Keep thi=
s
>>> \n out of translation to make t4205.12 happy.
>> [...]
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, i=
nt insertions, int deletions)
>>>
>>> =C2=A0 =C2=A0 =C2=A0if (!files) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(insertions =3D=
=3D 0 && deletions =3D=3D 0);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fputs(_(" 0 files=
 changed\n"), fp);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fprintf(fp, "%s\n=
", _(" 0 files changed"));
>>
>> More importantly, this makes the string more similar to other
>> translated strings in the same file and saves translators from havin=
g
>> to remember to worry about appropriate whitespace at the end of the
>> string.
>>
>> Actually, it should be possible to make their lives even easier. =C2=
=A0How
>> about this?
>>
>> diff --git i/diff.c w/diff.c
>> index 1a594df4..c53eea50 100644
>> --- i/diff.c
>> +++ w/diff.c
>> @@ -1395,11 +1395,6 @@ int print_stat_summary(FILE *fp, int files, i=
nt insertions, int deletions)
>> =C2=A0 =C2=A0 =C2=A0 struct strbuf sb =3D STRBUF_INIT;
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>>
>> - =C2=A0 =C2=A0 if (!files) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(insertions =3D=3D=
 0 && deletions =3D=3D 0);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fputs(_(" 0 files=
 changed\n"), fp);
>> - =C2=A0 =C2=A0 }
>> -
>> =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&sb,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Q_(" =
%d file changed", " %d files changed", files),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files=
);
>
> Yeah, I think that is going in the right direction.

That prints "0 files changed, 0 insertions(+), 0 deletions(-)" instead
of "0 files changed". Two more changed lines to make it the latter. I
don't mind either way, just checking which way you two and the list
prefer before I submit another patch.
--=20
Duy
