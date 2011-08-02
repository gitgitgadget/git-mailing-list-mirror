From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Tue, 2 Aug 2011 11:15:46 +1000
Message-ID: <CAH3AnrrrvX64s3p_=5mrVcwx5FeO0iT8uX47remyCuCwPpOo=A@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
	<CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
	<201107301619.51438.chriscool@tuxfamily.org>
	<7v39hmkkth.fsf@alter.siamese.dyndns.org>
	<CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
	<7vvcuhhw96.fsf@alter.siamese.dyndns.org>
	<CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
	<7vaabshfmb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 03:15:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo3aK-0004rd-41
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 03:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1HBBPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 21:15:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47413 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1HBBPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 21:15:47 -0400
Received: by vws1 with SMTP id 1so4909967vws.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IP3OyEe0O8AeR3rRrx+pZdYFM+xms6lYSrSJtIwwd0Y=;
        b=GkqZ0yNyfA8ZaY0O2c+00bWk4TjxQ28qNqZByDDtA7/51u1XRJLkbI213BMAOgZr9M
         6YNbIQQDFblcVGXW5fvbpqc1ieQhyG7VgMOUoZjk8gvdXRqt1YkofumWnP7oT/BNFGy8
         ixf1zMML1EtGNm0IG3uhuVAC+8+tHgnSE0+Wo=
Received: by 10.52.22.19 with SMTP id z19mr5064005vde.499.1312247746128; Mon,
 01 Aug 2011 18:15:46 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Mon, 1 Aug 2011 18:15:46 -0700 (PDT)
In-Reply-To: <7vaabshfmb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178430>

On Tue, Aug 2, 2011 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> On Tue, Aug 2, 2011 at 3:33 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Jon Seymour <jon.seymour@gmail.com> writes:
>>>
>>>> It might become more important if someone ever writes a tool that =
does
>>>> a bisection on the user's behalf. In this case, aborting the tool
>>>> might leave the HEAD in, what appears to the user, a confused stat=
e.
>> ...
>> In this hypothetical additional series, are you happy for
>> --no-checkout to become a synonym for --update-ref=3DHEAD in the man=
ner
>> of v8? From a technical perspective, it doesn't seem necessary to
>> duplicate the state variables and parameters.
>
> Well, from a technical perspective, which ref is to be updated is an
> option that is valid _only_ under no-checkout mode, and no-checkout m=
ode
> could be using HEAD, so I think you would need two variables. One for
> "what mode are we running", and the other that is only valid under "w=
e are
> in no-checkout mode" that says "we update BISECT_HEAD".
>
> If no-checkout mode _never_ updates HEAD, because the normal mode _al=
ways_
> updates HEAD, you could reduce them into a single variable (i.e. if w=
e are
> updating HEAD then we are in normal mode, otherwise we are in no-chec=
kout
> mode). =C2=A0I actually have a mild suspicion that the no-checkout mo=
de may
> turn out to be too confusing for people if it by default updates HEAD=
, and
> we may want to have it update something that is not HEAD by default (=
or
> forbid --update-ref from specifying HEAD), so if that turns out to be=
 the
> approach we are going to proceed, we _might_ end up needing only one
> variable, but I do not think we know it just yet. =C2=A0At least I do=
n't.
>

How about in the current series, I change the option parsed by
bisect--helper.c to be:

    --bisect-mode=3Dcheckout|update-ref

The porcelain option can still be --no-checkout (or should it be
--bisect-mode too?). The porcelain will maintain a state variable
called (rather than BISECT_NO_CHECKOUT).

     BISECT_MODE

Then, the next series can add a --bisect-head option (instead of
--update-ref) to allow the head to be varied (defaulting to
BISECT_HEAD) if not specified.

Sound ok?

jon.
