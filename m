From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Mon, 1 Aug 2011 15:27:48 +1000
Message-ID: <CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
	<CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
	<201107301619.51438.chriscool@tuxfamily.org>
	<7v39hmkkth.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 07:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnl2g-0004cS-IO
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 07:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab1HAF1u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 01:27:50 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48840 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab1HAF1s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 01:27:48 -0400
Received: by vxh35 with SMTP id 35so3905761vxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ut5U0gZU5MaVg0syz313yYYLDuH70lkISr+pHkH+iLo=;
        b=gPWD3Ecl59Vh5jwQoaV65oMaCwM3wYIABjGz8mUU7C9Em2PMIvrKahvsvzklt2qC1H
         x/XHm1cZksPFwWwpYtV8/13ynEbtIx8zxDUBXir6mqVbbXdlA6aNMkgiSpEapz6aMSBE
         yUEBDkcTFwZjL7XPGbL3lyo8xVJaOKxzNKjVs=
Received: by 10.52.21.194 with SMTP id x2mr3204890vde.39.1312176468232; Sun,
 31 Jul 2011 22:27:48 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 31 Jul 2011 22:27:48 -0700 (PDT)
In-Reply-To: <7v39hmkkth.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178322>

On Mon, Aug 1, 2011 at 11:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> On Saturday 30 July 2011 15:58:16 Jon Seymour wrote:
>>> On Sat, Jul 30, 2011 at 11:48 PM, Christian Couder wrote:
>>> >
>>> > Sorry but I didn't reply to your previous email when you asked ab=
out a
>>> > "--no- checkout[=3D<ref>]" compromise. I thought that Junio would=
 reply
>>> > and then I forgot about it.
>>> >
>>> > My opinion is that if you really want to be able to use another r=
ef, then
>>> > there should be a special "--update-ref=3D<ref>" or "--use-ref=3D=
<ref>"
>>> > option that is different from "--no-checkout".
>>> >
>>> > "--no-checkout" looks like a boolean argument. And
>>> > "--no-checkout[=3D<ref>]" may make the user think that this optio=
n will
>>> > not checkout <ref>, and then it leads to the confusing question "=
but why
>>> > would it checkout this f&#@ing ref in the first place?".
>>>
>>> Good suggestions.
>>>
>>> So, to confirm that I understand:
>>>
>>> =C2=A0 =C2=A0 use --no-checkout to control (no-)checkout behaviour =
and
>>> --update-ref to specify a ref other than HEAD?
>>
>> Yeah, I think it would be less confusing like this.
>
> When used without "--no-checkout" option, "bisect" need to check-out =
the
> candidate version. What good would it do if it does _not_ update HEAD=
 when
> it does so?
>
> While you are correct to point out --[no-]checkout is a boolean optio=
n,
> this "we do not update HEAD but update this other thing" is not ortho=
gonal
> to the option. It does not make sense when we actually touch the work=
ing
> tree.
>
> My preference is not to play games with "we can specify a ref other t=
han
> HEAD" until somebody can demonstrate why it is a feature "because we =
need
> to be able to do so in such and such times", not merely "because we c=
an".
>

Conceptually, I do think HEAD and "state of current bisection" are
different concepts and so it wouldn't hurt to be able to use  a
different reference for this purpose.

The main argument I have is the one that you raised earlier regarding
potential user confusion that would result from the somewhat
"spurious" (from the point of view of the naive user) differences that
might arise between the working tree, index and HEAD during the course
of the bisection process.

Of course, we can explain this in the documentation of the
--no-checkout option, so this needn't be a huge concern.

It might become more important if someone ever writes a tool that does
a bisection on the user's behalf. In this case, aborting the tool
might leave the HEAD in, what appears to the user, a confused state.
It would probably simplify error handling and abort processing in this
case if the tool never had to touch the HEAD reference at all.

That said, such concerns are hypothetical for now and for my primary
use-case for tree-less bisection (e.g. inspecting a damaged repo) I
can live with using HEAD for this purpose.

So, I will re-roll with references to --update-ref omitted.

Expect a v11 to the list, in the next half day or so.

jon.
