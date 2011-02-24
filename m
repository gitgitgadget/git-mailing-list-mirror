From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 03:55:04 +0100
Message-ID: <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<20110223234828.GA7286@elie>
	<7vd3mi44gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 03:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsRMH-0003RR-Ic
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 03:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab1BXCzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 21:55:07 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab1BXCzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 21:55:06 -0500
Received: by fxm17 with SMTP id 17so135146fxm.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 18:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UEUitGgn47Ym0SWjqll64U2fgpYSA+yNr9xhgvOC5Yw=;
        b=ZcuW+FLBOj9qC1ny8xYxgS7njTQ75vw2u421+LGalbVLTUdooPipqz2Rs/9SXR46Wp
         Sfa8315rLF/Wz3r3/I2udgxDIpAiu+8P6T8yuVoTHd4C1mfzPOkDFfLST0YrFZJ/8Ejh
         R7BgiVSoc4u88e8Nj+N2O4s01/9ZdpJfk5db4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LHF4y2SDIbQ+wD6oBg7QmKKkM24UFi/31Ey520fpx8sGAZNeu/PDGNMtQtndQzZzdd
         xcu6DX0M2vuqH+hvKGp3QPbFCiu3Fp9bwjIEyDzQXxW1o1kR5ovF4fkksLuZDHlMj284
         MQLNbwxLBkam9TGrcoIaBPoNjowgY/T6kzcwc=
Received: by 10.223.111.137 with SMTP id s9mr281766fap.98.1298516104663; Wed,
 23 Feb 2011 18:55:04 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 23 Feb 2011 18:55:04 -0800 (PST)
In-Reply-To: <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167769>

On Thu, Feb 24, 2011 at 02:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> The commit message for the second one seems to have been mangled:
>>
>> =C2=A0 =C2=A0 =C2=A0 i18n: add GETTEXT_POISON to simulate translated=
 messages unfriendly translator
>
> Yeah, I think I was fooled by the header folding while fixing things =
up
> inside the mailbox.
>
>> I still don't like the #-sign business in this commit. =C2=A0Couldn'=
t it
>> be split into a separate patch, not to be applied until just before
>> the strings in commit/tag/wt-status are marked for translation?
>
> That might be a sensible thing to do. =C2=A0 =C3=86var what do you th=
ink?

It could, but I don't want to spend time on it. I think it's fine that
the choice of string is documented in the commit that introduces it.

>> There is also a patch out there to make this use rot13, which I am
>> somewhat fond of. =C2=A0Unfortunately, it leaks (because it is not c=
lear
>> how long translated strings are supposed to last).
>
> Yeah I would imagine it would leak. =C2=A0Also blindly running rot13 =
to turn %d
> into %q is probably not what you want.

Gettext gives you a pointer to the string inside a mmaped .mo file,
effectively, so the caller doesn't have to care about it. So you can't
write something that doesn't leak memory unless you preserve that
characteristic.

But it's a debugging mode, it doesn't matter IMO if it leaks memory.

Anyway, to be blunt I really don't see the point of fiddling around
with this bit so much. Whether it's a `"GETTEXT POISON"` constant or
`rot13(msgid)` the same tests will fail. So it's not functionally
changing what the feature was for in the first place, just adding more
complexity.

Of course there might be cases where a test will fail because it's
supposed to end in \n but the poison string doesn't, but since none of
them did I didn't worry about that.

And even if one did I'd probably just mark it as C_LOCALE_ONLY
anyway. Since the intent is to make the person doing the i18n work not
break plumbing, not to perfectly annotate our test suite. I'd much
rather have a few more tests skipped under this poison mode than 20
extra lines of C code that effectively give us nothing to maintain.

If someone else wants to do the work I don't care. I just think
there's more important things to worry about.
