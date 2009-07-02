From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace 
	differences
Date: Thu, 2 Jul 2009 21:28:47 +0200
Message-ID: <cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org> <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 21:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMRyA-0001ZU-3N
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbZGBT3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZGBT3F
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 15:29:05 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61630 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbZGBT3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 15:29:04 -0400
Received: by fxm18 with SMTP id 18so1721332fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=736Mc9NmniMsoMvyvoEIpym7/GRUzIWMyWF21gONOsc=;
        b=hnKHEPxCyFMWUsI4fVAymtOKjWvKonIna712lrF+Ml5uHI7qXbqXZmr4gcAAxP6Gx6
         V/cf/zwwvmVurCoEtKyrVJRtmlTGn5S0Z6E4lNa5uCKHPzyN7CnhBTjs7mfwKXXJyPWJ
         IBtZ2akNkmv7kjxJWVs9s8IXlh/h/rk580ggE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pcJqg2YnxpC52gMLbR5lRSXLGdybjFseahqTkx/BTcnXjUQLU0+zUvJRMa32cENNpj
         Pq1rOrAjGtm5GWUmhZkIAK0OIOu4aiT+dnVydc7qLOE/IDpADNJRMIV+vRgScsaNEMUo
         1sqFDnqW8IaUJv/eBGqpGU+9gclOQelNHqLIs=
Received: by 10.204.69.66 with SMTP id y2mr376402bki.49.1246562947124; Thu, 02 
	Jul 2009 12:29:07 -0700 (PDT)
In-Reply-To: <cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122666>

On Thu, Jul 2, 2009 at 9:02 PM, Giuseppe
Bilotta<giuseppe.bilotta@gmail.com> wrote:
> On Thu, Jul 2, 2009 at 8:27 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
>>> +/*
>>> + * Returns true if the given lines (buffer + len) match
>>> + * according to the ignore_whitespace setting
>>> + */
>>> +static int lines_match(const char *s1, size_t n1, const char *s2, =
size_t n2)
>>> +{
>>> + =A0 =A0 if (ignore_whitespace)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return !memcmp_ignore_whitespace(s1, n1, =
s2, n2);
>>> + =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return (n1 =3D=3D n2) && !memcmp(s1, s2, =
n1);
>>> +}
>>> +
>>
>> I think this still is an abstraction at the wrong level. =A0For one =
thing,
>> if ignore-whitespace is set, you do not even need nor want to do the=
 "fix
>> only the ws breakages we are going to fix anyway according to the ws=
_rule"
>> transformation applied to the preimage.
>
> I've thought some more about this, and you are right. We still want t=
o
> ws fix the postimage, but that's done elsewhere.

Sorry for repying to myself here, but I'm not convinced again. Or to
be more specific: I think this kind of refactoring is totally out of
the scope of this patch. So although I agree with you in priciple, if
you don't mind I'll keep the first two patches simpler and less
invasive. I'll look into the refactoring as a third step.

--=20
Giuseppe "Oblomov" Bilotta
