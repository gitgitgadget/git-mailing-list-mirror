From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace 
	differences
Date: Thu, 2 Jul 2009 21:02:02 +0200
Message-ID: <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 21:02:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMRYF-0008Ib-4T
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 21:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZGBTCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 15:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZGBTCU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 15:02:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64532 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZGBTCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 15:02:19 -0400
Received: by fxm18 with SMTP id 18so1706245fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JtJO7r2UpjwPlbLWC466J9vUGwlbvwMQvkrqPF2aGlo=;
        b=XXFKXZ0vB7ZuLHJiXlYKo8PZ/y+VL8rM0dT4GUCG2xXbhSbPt9i8lt5TF6eRpiXJ93
         eLPGeZHFdEawF6B+qcxKWl+RewKUEV3BCy+6S76a3TIBbl4WkOoNpkq+PdDCffyJsl1a
         8ZTs9dsZx7Py7zhiHrsl6xWokzBsswt7xkGos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OPuDl3Etdp/0kahGChSMZM8mYBYzZi961Gvw73bofzmDfS5S0xdgS38R/ZeEWxoVbX
         UzUjyL+II5FojJ8TH1D4tdabkg13oZGPM0xvHxNh/SVmUqjebG0GJwerovgH2wrFIHDH
         wT3R4FLQxFhbv5eL/z56stOPBgnQ5tMZAWVGg=
Received: by 10.204.103.145 with SMTP id k17mr363458bko.10.1246561342143; Thu, 
	02 Jul 2009 12:02:22 -0700 (PDT)
In-Reply-To: <7vvdmb6ium.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122665>

On Thu, Jul 2, 2009 at 8:27 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> +static int memcmp_ignore_whitespace(const char *s1, size_t n1, cons=
t char *s2, size_t n2)
>> +{
>> + =A0 =A0 const char *stop1 =3D s1 + n1;
>> + =A0 =A0 const char *stop2 =3D s2 + n2;
>> + =A0 =A0 int result;
>> +
>> + =A0 =A0 if (!(n1 | n2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (isspace(*s1) && isspace(*s2)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (isspace(*s1)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s1++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (isspace(*s2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s2++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Check here instead of in the while beca=
use
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the whitespace discarding might hav=
e moved us
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0past the end */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((s1 >=3D stop1) || (s2 >=3D stop2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> If s1 is longer than s2 (or vice versa) but one is a prefix of the ot=
her,
> you will return "they match", because previous round compared *s1 and=
 *s2
> and found them the same?

Yes. Actually, more specifically, now that I think more about this,
that's the reason why my previous code was fine: when we compare the
lines in the preimage against the image, we only look for a match
which is as long as the preimage, we don't care what ELSE is there in
the image. So it makes sense to pass a single length parameter, the
preimage length.

However, my first version should be fixed so that the order of the
parameter becomes significant, and the early bailout is only done if
the preimage length has been totally consumed.

>> +/*
>> + * Returns true if the given lines (buffer + len) match
>> + * according to the ignore_whitespace setting
>> + */
>> +static int lines_match(const char *s1, size_t n1, const char *s2, s=
ize_t n2)
>> +{
>> + =A0 =A0 if (ignore_whitespace)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return !memcmp_ignore_whitespace(s1, n1, s=
2, n2);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return (n1 =3D=3D n2) && !memcmp(s1, s2, n=
1);
>> +}
>> +
>
> I think this still is an abstraction at the wrong level. =A0For one t=
hing,
> if ignore-whitespace is set, you do not even need nor want to do the =
"fix
> only the ws breakages we are going to fix anyway according to the ws_=
rule"
> transformation applied to the preimage.

I've thought some more about this, and you are right. We still want to
ws fix the postimage, but that's done elsewhere.

--=20
Giuseppe "Oblomov" Bilotta
