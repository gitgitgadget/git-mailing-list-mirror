From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Wed, 16 Feb 2011 00:02:27 +0100
Message-ID: <AANLkTimZUhxkxuUMubmPxjd8MG0Pu=9mrLoPqi=MpPWZ@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
	<1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
	<20110215221832.GA826@elie>
	<7v4o84nbuh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:03:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTvB-0004TI-4S
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab1BOXCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 18:02:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40413 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab1BOXC2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:02:28 -0500
Received: by wyb28 with SMTP id 28so733224wyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4WTZNEuQxKNamVXUvvl9M/Zd0IuvHH0xBzSHOo5vlmk=;
        b=F+Sc3nyY6bk/M32TOV/JQqTT4lIhi64CRo4ll9z+aGy8G8mMO3nBKETNVtv6nKasrc
         rpC5KF4SYCOwktMrpayuLGTxoVbIgQy7cgcLmknBmXUNRSTu5oRNXC4SUM+EfnNv8cEt
         OfMgqDKgWb0wrWmf+J2UaRM0vABWzIzTZeoKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ohC8i06nxvAtkLR95RkCiShGmpaequ4uwGuF6o/6xrUAj++XbCVmfOMxyyvz1ya468
         Q1E/oOBGPlX160pV823Xz/fffuUeBTwkwWyp8IP+XojL3vkynQ2MG+79DXZa0aH+cHJu
         75/XCLnsO/U+6QuRIBd5LtWhHsEXawWQBJa94=
Received: by 10.227.152.149 with SMTP id g21mr4206339wbw.20.1297810947178;
 Tue, 15 Feb 2011 15:02:27 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Tue, 15 Feb 2011 15:02:27 -0800 (PST)
In-Reply-To: <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166894>

On Tue, Feb 15, 2011 at 23:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I wonder if cherry-pick shouldn't also write MERGE_MSG or similar so
>> that gets taken care of automatically? =C2=A0That would also allow o=
ptions
>> like -x and -m to work better.
>
> Hm, that probably is a good idea.
>
>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-c=
herry-pick.txt
>> index 749d68a..e8db99b 100644
>> --- a/Documentation/git-cherry-pick.txt
>> +++ b/Documentation/git-cherry-pick.txt
>> @@ -16,6 +16,25 @@ Given one or more existing commits, apply the cha=
nge each one
>> =C2=A0introduces, recording a new commit for each. =C2=A0This requir=
es your
>> =C2=A0working tree to be clean (no modifications from the HEAD commi=
t).
>>
>> +When it is not obvious how to apply a change, the following
>> +happens:
>> +
>> +1. The current branch and `HEAD` pointer stay at the last commit
>> + =C2=A0 successfully made.
>> +2. The `CHERRY_HEAD` ref is set to point at the commit that
>> + =C2=A0 introduced the change that is difficult to apply.
>> +3. Paths in which the change applied cleanly are updated both
>> + =C2=A0 in the index file and in your working tree.
>> +4. For conflicting paths, the index file records up to three
>> + =C2=A0 versions, as described in the "TRUE MERGE" section of
>> + =C2=A0 linkgit:git-merge[1]. =C2=A0The working tree files will inc=
lude
>> + =C2=A0 a description of the conflict bracketed by the usual
>> + =C2=A0 conflict markers `<<<<<<<` and `>>>>>>>`.
>
> What happened to the `=3D=3D=3D=3D=3D=3D=3D`? =C2=A0I thought you wer=
e copying and pasting
> from the said section.

I think this is clear enough, else you would need to mention the
'|||||||' and conflict_marker_size too.

Bert
