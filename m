From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Fri, 5 Nov 2010 09:02:16 +0700
Message-ID: <AANLkTimbou_seZnNu9W3akT7SabxSQ7pEJBifjH3UY1r@mail.gmail.com>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
 <1288878944-14066-1-git-send-email-pclouds@gmail.com> <4CD33968.4060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 03:02:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEBdb-0004pW-FS
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 03:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab0KECCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 22:02:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47203 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab0KECCh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 22:02:37 -0400
Received: by wwb39 with SMTP id 39so896008wwb.1
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VVW9iUWKhSdU8JIdYU/pf3tnB5vQWlZydHPPZ80Yj10=;
        b=ZFDZDDzISAhDPnBgPDYgkf1JYn01Ba5ngCCeAtMyRjmF2W5FwFHrjvSgVHOF6kTNWJ
         ySu4s8bYkYN1ypndoUqZX5ELadAhCcmHxTyqtfipdKJWqy5TDSbZ0CG1MdCADXEVcoVi
         LJth1bNNXaOZcDNBRZYlf9IAwnvt7WAI+9ml4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FnHgUtq1XLbEC8pdzqFz+l+NZ1CLWnDq1jV9XjnBZ1wljHFJgkIkFect/dBGN00I7V
         +697zGxWaugU2nvA1ssJIQYIderWM2GRJe4+3BvlJak6LKtiaMvnTJAff84WdX9bq1AG
         ePgndADh8zPheP3g2QAL01vGEvSEtT32Env3Y=
Received: by 10.227.151.202 with SMTP id d10mr1474208wbw.146.1288922556303;
 Thu, 04 Nov 2010 19:02:36 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Thu, 4 Nov 2010 19:02:16 -0700 (PDT)
In-Reply-To: <4CD33968.4060704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160797>

2010/11/5 Eric Sunshine <ericsunshine@gmail.com>:
> On 11/4/2010 9:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
>>
>> Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
>> 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces ar=
e
>> not part of the pattern and document comment syntax.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gma=
il.com>
>> diff --git a/attr.c b/attr.c
>> index 6aff695..f3063d8 100644
>> --- a/attr.c
>> +++ b/attr.c
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D cp;
>> - =C2=A0 =C2=A0 =C2=A0 namelen =3D strcspn(name, blank);
>> + =C2=A0 =C2=A0 =C2=A0 if (*cp =3D=3D '"') {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unquote_c_sty=
le(&pattern, name,&ep))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die("Broken attribute line: %s", line);
>
> The error message is perhaps a bit too generic, indicating only that
> _something_ on the line caused a problem. Mentioning that bad quoting=
 of
> 'name' was at fault would help focus the user's attention where it is
> needed.

Really.
--=20
Duy
