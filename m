From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Tue, 7 Jun 2011 21:09:38 +0200
Message-ID: <BANLkTik3ywV91UtLSR_Dydjqg=pva+b0qg@mail.gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com> <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
 <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com> <7v39jm8fs0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=eC37opWnN4nmC5AP66M+m5nZ86Q@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theo Niessink <theo@taletn.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1fV-0000AI-Dl
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363Ab1FGTKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 15:10:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52317 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab1FGTKS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 15:10:18 -0400
Received: by pzk9 with SMTP id 9so2692428pzk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Hb9RzLNXHnsriXF3ws3Em2BWLAzGt5I87EV/oPeSP9E=;
        b=JX5/Uoib4y3/JWFqmscExmvWXliqlNz4IKo1Wo/aI1D0Ttyymy1AJq4aVljrg/PQrw
         cbNLpwkM59C2xL1Bx4J0hkXOxnaCQ2GBmVDec22RuDTQMFhEeYneI9963WP3L6Chux9T
         onGrImqMHaqk238yP8WTdyq1yxjnjxSs2DmYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=K0j6XBVNq818BU9RvrO29z8yl+P9uaafwkXDGmmIJg5y7e4W/HKfqnWKqhZHFY117z
         gRgghTz38JiUxMqwwypwtTfjScimQac1TioaPdgh6WVPyNEz9Nx9FGm7VNdxgnGUlGlp
         OxHhSqOhnifICD+FpNQEFOlPVh2hycTsFdIT0=
Received: by 10.68.55.3 with SMTP id n3mr341199pbp.517.1307473818127; Tue, 07
 Jun 2011 12:10:18 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Tue, 7 Jun 2011 12:09:38 -0700 (PDT)
In-Reply-To: <BANLkTi=eC37opWnN4nmC5AP66M+m5nZ86Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175251>

On Tue, Jun 7, 2011 at 12:07 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Tue, Jun 7, 2011 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>>> Nitpick: If you already know that c !=3D '\0' and !is_dir_sep(c), =
then why do
>>>> continue? It will check for '\0' and is_dir_sep(c) again, but you =
already
>>>> know that both ifs will be false. So you could just as easy jump s=
traight to
>>>> c =3D *path++, which IMHO also makes the code easier to follow:
>>>
>>> Very good point, thanks for noticing. I just rewrote the logic from
>>> switch/case to if/else, but with the rewrite these redundant compar=
es
>>> became more obvious. I think your version is better, indeed.
>>
>> Let's not add an unnecessary goto while at it. =A0How about this on =
top
>> instead?
>>
>> =A0read-cache.c | =A0 13 +++----------
>> =A01 files changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 31cf0b5..3593291 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -784,16 +784,9 @@ int verify_path(const char *path)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_dir_sep(c)) {
>> =A0inside:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (c) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 contin=
ue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '/': case '\0':
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '.':
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ve=
rify_dotfile(path))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((c =3D=3D '.' && !=
verify_dotfile(path)) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_dir_sep(c) =
|| c =3D=3D '\0')
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D *path++;
>> =A0 =A0 =A0 =A0}
>
> This change the "c =3D=3D '.' && verify_dotfile(path)"-case to eat th=
e '.'
> character without testing it against is_dir_sep, which is exactly wha=
t
> we want. The other cases return 0, as they used to. Good.
>
> Indeed, this is a cleaner approach. Thanks!
>

I forgot to ask; do you want me to resend? I would imagine the commit
message should be updated to reflect this change as well...
