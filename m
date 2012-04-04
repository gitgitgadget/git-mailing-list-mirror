From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Thu, 5 Apr 2012 08:55:30 +1000
Message-ID: <CAH3AnrrE9Fbs_p_=ETRns4vyz8J879-m+KDF5K4j7vDdTh9bEg@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
	<CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
	<CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
	<4F7BEA9F.3060805@viscovery.net>
	<7vpqbna0cd.fsf@alter.siamese.dyndns.org>
	<7viphf8cqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFZ7M-0001O4-GT
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 00:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350Ab2DDWzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 18:55:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61188 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab2DDWzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 18:55:32 -0400
Received: by wibhq7 with SMTP id hq7so735059wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xN4r5RzBMTfHbAkSjDnoYoBRxeou6wcr21zV1eVerEw=;
        b=QJIhQpLTHeZFqbQA+5OkVvY569iLGyyeqNDC6bvDj65HYqoxHQLSnJ/HM4ll7ywXXE
         +CdDXO+MGFWIJGJsWrPtseS5us7bD2/zwp+JYdCCOza4f+pMfp8q79LO5zRrzCMRcz8c
         y8+kMgHFqS0igQeSgxK17b/h32r+A2qDPsKKl2uYk10I2l7SyIkInoIB8VbWKcX5b1UV
         ypaHAx+Jy3CQqxTi0jwwBfPOnm9Gm5/pOKbyY41zUReDjDaxeUvXAtCnT4gLXYiQHoVA
         kimsMwiIEywqyMWYigM+GbByNdBmnpOllIcHSf4akDWrPmtoi8QdXeZ0S7Sp7F/ayZLR
         zMJg==
Received: by 10.216.135.102 with SMTP id t80mr189450wei.59.1333580130821; Wed,
 04 Apr 2012 15:55:30 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Wed, 4 Apr 2012 15:55:30 -0700 (PDT)
In-Reply-To: <7viphf8cqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194751>

On Thu, Apr 5, 2012 at 6:26 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> IMO, it is a sub-optimal implementation of rebase -p that it attemp=
ts to
>>> redo the merge. A better strategy is to just replay the changes bet=
ween
>>> the first parent and the merge commit, and then generate a new merg=
e commit:
>>>
>>> =C2=A0 =C2=A0git diff-tree -p M^ M | git apply --index &&
>>> =C2=A0 =C2=A0git rev-parse M^2 > .git/MERGE_HEAD &&
>>> =C2=A0 =C2=A0git commit -c M
>>>
>>> This would side-step all the issues discussed here, no?
>>
>> Or cherry-pick the change made by the merge to its first parent, i.e=
=2E
>>
>> =C2=A0 =C2=A0 =C2=A0 git cherry-pick -m 1 M
>
> Err, that was a confusing unfinished message. =C2=A0I meant the step =
to replace
> the part that uses pipe to "git apply", more like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-parse M^2 >.git/MERGE_HEAD &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit -m 1 M &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -c M
>
> The primary difference is that, because "apply -3" is not implemented=
 yet,
> this will help when the base has drifted too much from the correspond=
ing
> blob recorded in M^.
>

Ah, not so impossible after all :-).

Yeah, I know, you were talking specifically about the approach
suggested in my thought experiment.

It does seem like such an approach would yield an outcome much closer
to J Robert Ray's expectation.

Good suggestion, Hannes! Are there any flaws, I wonder?

jon.
