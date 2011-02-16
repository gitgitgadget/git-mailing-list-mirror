From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] git.c: binary-search builtin commands
Date: Wed, 16 Feb 2011 10:46:30 +0700
Message-ID: <AANLkTi=xnM+ejrDMCNBr21BtnqwD5TXXoLZbE7uPMhR0@mail.gmail.com>
References: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org> <1297739344-28961-1-git-send-email-pclouds@gmail.com>
 <1297739344-28961-2-git-send-email-pclouds@gmail.com> <7v4o85njjz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:47:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpYM9-0001Ow-Mg
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1BPDrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 22:47:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55038 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab1BPDrC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 22:47:02 -0500
Received: by wyb28 with SMTP id 28so916482wyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 19:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=CRrbNV/jPqWWbUImra6suuyjiEBFuBvUSnhBifLRqO0=;
        b=F6W3FgLCYUZH/nXaMBMR5IyHx8IRtlQgd7MrVsgfmZR6O7TLb8eEKTrSp7hRNLANWq
         HLvXiwtETXGrUWfRV/ImzZT5gv/zrwF3SHHBPVCspZkOJYTrk1es9Iv2j76AXI9JEh9E
         22aJzNhJy6nnWPBkjo9iLz1RZI+dUCVIzZZyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oOqLjTF85mrTN34cJRI2ub9Inj5FEKTPRi5eF4sB1wKxHzNyt1AOQYY8h0SXWHVcJ+
         4NncpwtKCyPAX7GSoJaESBFRJjq7ISepIRTb97wusbdY080LoWGfhGrkDqbEKBUdWJMG
         ezaMnYnVyZcoyExt1DmHVVugPYCqBOdJpBFXs=
Received: by 10.216.89.71 with SMTP id b49mr59803wef.28.1297828020864; Tue, 15
 Feb 2011 19:47:00 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Tue, 15 Feb 2011 19:46:30 -0800 (PST)
In-Reply-To: <7v4o85njjz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166923>

2011/2/16 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0 2011/2/15 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0 > I did this myself the other day, as I think it simply is a =
good project
>> =C2=A0 > hygiene. =C2=A0If this were 1/2 of a series followed by 2/2=
 that runs binary
>> =C2=A0 > search in the table, that would make it make more sense ;-)
>>
>> =C2=A0 I did think the array was binary-searched and nearly claimed =
"git-stage
>> =C2=A0 won't work because it's in wrong order".
>
> Heh, that "binary search" was a tongue-in-cheek comment. =C2=A0I am s=
orry that
> you took it too seriously.
>
>> =C2=A0 This patch won't give any performance gain, but it would forc=
e
>> =C2=A0 people to keep the array in order :-)
>
> That is exactly why I discarded what I did the other day. =C2=A0Witho=
ut an
> active mechanism to force the orderedness, such a change simply intro=
duces
> a downside of letting a mistake go unnoticed, without any real upside=
 (as
> you measured and saw no performance gain).
>
> A better project hygine is a good thing to aim for, and I would imagi=
ne
> that you could add "--verify-builtin-command-table" as an unadvertise=
d
> option to "git" wrapper, and make t/t0000-basic.sh call it to minimiz=
e the
> downside risk. =C2=A0But without such an active measure to prevent mi=
stakes, we
> would be relying on somebody getting caught on a ticking bomb and
> reporting it, which is not a good tradeoff between risk and reward.

Ah, OK. Just drop this patch. I don't think doing binary search gains
us much anyway.
--=20
Duy
