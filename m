From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Tue, 1 Sep 2009 09:55:39 +1000
Message-ID: <d2e97e800908311655t553d6c4bo6ed45fe37819c1d8@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com> 
	<7vfxb7y2h3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGjH-0007I1-6W
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbZHaXz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 19:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbZHaXz5
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:55:57 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:4080 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbZHaXz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 19:55:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so5433757and.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nyMq82aLyZ6lU5nOeQj1i9ZeBz/jvqVYWSfpbFDv2Ig=;
        b=jnx1XKNvgKsNw3JzjnoCnQb4bfbZyVw09E2cD+pY1MKXSGnLQFW3np4Z5IThlUYSHT
         5VTg1qyetdqMwMnr1CAiqDDbNr2chuiUA2kxCl5GLIUrhcdzW4NM/WXPERQ44L6jCh7v
         Wn+dNSJBX/hh1PFp7WU63JhehTYv0VQAeIjB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Sz8TYVZCxC0Uo76MV/gnk5pKfEavCgd5/joKtq4KyKg9rrunqKTNNY+gcawYzanE85
         S1C0EeqqBVRqs9jxiEbXAOoOiCvQYHiW8IbN6Ca9cGY5+1fGMNW62St/kn/ZD4qUkcwx
         DnSgFigOp790HYKhZYut+i4GDBv81omGcJ3ig=
Received: by 10.101.87.4 with SMTP id p4mr6581071anl.68.1251762959069; Mon, 31 
	Aug 2009 16:55:59 -0700 (PDT)
In-Reply-To: <7vfxb7y2h3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127511>

2009/9/1 Junio C Hamano <gitster@pobox.com>:
> Michael Wookey <michaelwookey@gmail.com> writes:
>
>> gcc 4.3.3 (Ubuntu 9.04) warns that the return value of strtoul() was=
 not
>> checked by issuing the following notice:
>>
>> =C2=A0 warning: ignoring return value of =E2=80=98strtoul=E2=80=99, =
declared with attribute
>> warn_unused_result
>>
>> Provide a dummy variable to keep the compiler happy.
>>
>> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
>> ---
>> =C2=A0fast-import.c | =C2=A0 =C2=A05 +++--
>> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fast-import.c b/fast-import.c
>> index 7ef9865..1386e75 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1744,10 +1744,11 @@ static int validate_raw_date(const char *src=
,
>> char *result, int maxlen)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 const char *orig_src =3D src;
>> =C2=A0 =C2=A0 =C2=A0 char *endp;
>> + =C2=A0 =C2=A0 unsigned long int unused;
>>
>> =C2=A0 =C2=A0 =C2=A0 errno =3D 0;
>>
>> - =C2=A0 =C2=A0 strtoul(src, &endp, 10);
>> + =C2=A0 =C2=A0 unused =3D strtoul(src, &endp, 10);
>
> Isn't this typically done by casting the expression to (void)?

I originally tried that - the compiler still complains.

> Otherwise a clever compiler has every right to complain "the variable
> unused is assigned but never used."

 I get no other warnings, so does that make gcc less than clever? ;-)
