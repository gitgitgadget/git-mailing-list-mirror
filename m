From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 14/15] gettextize: git-revert split up "could not
 revert/apply" message
Date: Tue, 7 Sep 2010 08:47:27 +0000
Message-ID: <AANLkTinp5R+jMKpHpkMYK3MDWLuUpM7T-+KBZ+NG4g-G@mail.gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
	<1283775704-29440-15-git-send-email-avarab@gmail.com>
	<20100906185547.GF25426@burratino>
	<AANLkTi=V01_OP+6pxrUakF=cTGFL=nOv=9C5meQU2H8C@mail.gmail.com>
	<20100907053420.GR1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 10:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ostq8-0003E3-EV
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab0IGIre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 04:47:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33305 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0IGIrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 04:47:32 -0400
Received: by iwn5 with SMTP id 5so5125645iwn.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0+/PV++UkRTYgJxypyfzc6p+piQLKFAPflNAppvBGfo=;
        b=ov5+ORX8KYBTzQlJnPrdNNJVL0Aj8GuSh7YnRr4YK1Qebitikaao0RLZNTUloZQa17
         dyf/uk6jAMk/8M45REhCEwid83Il/5oKRSB7OFTeFnZmzmke0avG8dyJIQSpDL+gRF3A
         vSk1BSo47WOYXuOjqDVRjQs86ZHIRGCRzybVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JH+b1NCH99KQtOcJ14JcRSFvsqRKw5Bo0Bk0dVvNPjbhYBeXxzF9hPH3xDmwITyxE+
         dtB05/APGgmOwbVPUkn6d+iDkR6ZohNdV0hIWpPsADoXa5XAP5/IfA2yRVoD4BaloLIQ
         chhnxfh9gune/n1m60vuaWTT3S7bAm9Of7Oc0=
Received: by 10.231.160.205 with SMTP id o13mr7725193ibx.15.1283849248451;
 Tue, 07 Sep 2010 01:47:28 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 7 Sep 2010 01:47:27 -0700 (PDT)
In-Reply-To: <20100907053420.GR1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155688>

On Tue, Sep 7, 2010 at 05:34, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> to do this we'd have steal some locale.
>
> Alas. =C2=A0Thanks for explaining.
>
>> Also, the set of tests we want to skip under POISON (i.e. automated
>> garbage) is slightly different from the tests we want to skip under
>> TEST_LOCALE=3D, because some of those tests are checking for the %s =
in
>> "file failed: %s". So they'll fail under POISON, but shouldn't fail
>> under any translation.
>
> This could be fixable in the long term, no? =C2=A0e.g., under POISON =
we
> could have something like
>
> =C2=A0_ () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 perl -pe 's/(?<!%)[^%#]*/POISON/g'
> =C2=A0}
>
> to preserve commit message comments and % directives.

Yeah, but rather than do fancy stuff like that in C I just made a dumb
implementation.

It's far easier to just skip a few more tests than it is to come up
with your own parser that avoids printf directives but still poisons
the message enough that e.g. <grep "Clone" ..> won't work anymore.
