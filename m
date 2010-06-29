From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Tue, 29 Jun 2010 10:33:51 +0200
Message-ID: <AANLkTinXCkX2tXFTlOSLShXMpsnpaNX0LoYGaml0sgN5@mail.gmail.com>
References: <c4c9797a4cbea89f1f0fb0501e6a03912b598b17.1277595284.git.tfransosi@gmail.com>
	<de7ad1688930aa47515736885b7d8438118e7aa1.1277595923.git.tfransosi@gmail.com>
	<7vbpawifwa.fsf@alter.siamese.dyndns.org>
	<AANLkTim14fh1RRSoYFK5uIqi8OrkB2zHahInDpO80gws@mail.gmail.com>
	<7v4ogmcs1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 10:34:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTWGi-0000aT-H4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab0F2Id4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 04:33:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:46913 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0F2Idx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 04:33:53 -0400
Received: by ey-out-2122.google.com with SMTP id 9so188076eyd.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2GcDCiyYOMFxuS87iVb04BgnkFSrqti7SLPnhYNavE4=;
        b=ERYqIPXHRW8CuEcwDl+eF4+UF0XpgqBdqcip52lIO2Ede0LwipNxHCRgAapaipXfh/
         fJiBV2Uef8dgdFKzzS7XJp1bggWVHErh3Hh3J819tk6Tn3IA9SEn6Kv6/3iN+TXfQ2FJ
         km4UclBoHCV0c2KpZpKgvq4invJBGXI182a2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=drL6K6YjQ8p0Z+sr2zS4Msqx+yZIHzC134dWX8UcahKyOD/ASA9Yv1eBDsaGCHwuJs
         egDLb3Sf/MRomTozNkoBzUtWI3gu6Oa0AQrJXNflcWO6XAv/qyiUZA7uAaa1LnhuWgBq
         SkG4lI+GeTC1BEnYRQoO/qtx3L6yjn7vnkUwM=
Received: by 10.213.66.11 with SMTP id l11mr1508993ebi.36.1277800431294; Tue, 
	29 Jun 2010 01:33:51 -0700 (PDT)
Received: by 10.213.105.148 with HTTP; Tue, 29 Jun 2010 01:33:51 -0700 (PDT)
In-Reply-To: <7v4ogmcs1u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149893>

On Tue, Jun 29, 2010 at 07:43, Junio C Hamano <gitster@pobox.com> wrote=
:
>>>
>>> =C2=A0 =C2=A0#define STRING_LIST_INIT(pleasedup) { NULL, 0, 0, (ple=
asedup) }
>>
>> This begs for using strdup(string-to-dup) in the macro argument, whi=
ch
>> will not compile with ancient compilers which don't allow code in an
>> initializer.
>
> Err, one of us must be confused.
>
> I was suggesting to rewrite things like these, found in builtin/remot=
e.c
> (add and rm):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct string_list track =3D { NULL, 0, 0,=
 0 };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct string_list branches =3D { NULL, 0,=
 0, 1 };
>

That must be me, again. Didn't bother to check the string_list definiti=
on
and naively assumed the pleasedup was for an initialization string. I
thought that depending on usage the caller may wish to either copy it
or leave the string_list referncing the original. Which cannot be the c=
ase
with string_list, indeed.

BTW, now that I took a look at it... The iteration over string_list
items looks a little overengineered. At least from the point of
view of the existing users of the feature. Wouldn't a simple loop
be just as simple to use (if not simplier) and faster (no uninlineable
function calls and argument preparation and passing needed)?

#define string_list_foreach(item,list) \
	for (item =3D (list)->items; item < (list)->items + (list)->nr; ++item=
)
