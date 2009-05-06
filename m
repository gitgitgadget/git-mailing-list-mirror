From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 16:43:19 +1000
Message-ID: <fcaeb9bf0905052343s7388d057j3d2b219aecc2faeb@mail.gmail.com>
References: <20090506055913.GA9701@dektop> <7vljpaycwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 08:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1arD-00053g-Ar
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 08:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZEFGnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 02:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZEFGnk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 02:43:40 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:52861 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZEFGnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 02:43:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so8318437and.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HSPxtnpRzlbHLnesDpSj0O5K9QoXO4zAQrxMs0Ppe5Y=;
        b=kXt4r3OCueAyRvYJA8+2rbRJt1ZSA2d6Dx64uY3Cmdb75+JdnDLGWhmawDEG7mZmgU
         2pPuvH4w9l0jV2fAW3LNbnkXjkXOMUCs/VSg1VPLtxnDIvsp4ZHGntOzHLHPHcPMLzAX
         vxVs7WXhrpTcReDrrjNLIH4uvX/kiVX6w1Bjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i2HGP9deRsE0cZEA2Xqj6y4SnziLvjIKUs0hIcrgmksqGlJCCKQ4aJDXdHh1AeKFzS
         MPDU6qN0KsYMkykhBqJyKrzUT6cmBYP6zzA/YWvH7TIPrDy9xiD3C64prIGTicpM4ZX7
         9O7mzG4BZI54KTM1Q4qbg/hBKvh60k1mPcyGA=
Received: by 10.100.12.17 with SMTP id 17mr619622anl.2.1241592219248; Tue, 05 
	May 2009 23:43:39 -0700 (PDT)
In-Reply-To: <7vljpaycwg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118326>

On Wed, May 6, 2009 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
>> index b68ab11..61ccdee 100755
>> --- a/t/t4200-rerere.sh
>> +++ b/t/t4200-rerere.sh
>> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git merge first
>> =C2=A0'
>>
>> -sha1=3D$(sed -e 's/ =C2=A0 =C2=A0.*//' .git/MERGE_RR)
>> +sha1=3D$(cut -f 1 .git/MERGE_RR)
>
> I do not know why you need this one. =C2=A0It shouldn't hurt, though.

Well because it wouldn't work without it. But on the other hand, I
grepped "sed.*\t" through and found many of them. Still wondering
while only this fails. I will look at it again when I have time.

>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index e2aa254..9a916d3 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -315,7 +315,7 @@ test_expect_success 'unpacking with --strict' '
>> =C2=A0 =C2=A0 =C2=A0 head -n 10 LIST | git update-index --index-info=
 &&
>> =C2=A0 =C2=A0 =C2=A0 LI=3D$(git write-tree) &&
>> =C2=A0 =C2=A0 =C2=A0 rm -f .git/index &&
>> - =C2=A0 =C2=A0 tail -n 10 LIST | git update-index --index-info &&
>> + =C2=A0 =C2=A0 tail -10 LIST | git update-index --index-info &&
>
> I do not know why your "head" apparently accepts -n (see the context)=
 but
> not your "tail"; as POSIX frowns upon head/tail -$number, this one is=
 a
> regression.
>

Hey, it's Sun's magic. head manpage mentions -n and it works (I
checked) while tail does not accept it. GNU tail's manpage does not
mention that it supports [+-]N syntax but it seems to work.
--=20
Duy
