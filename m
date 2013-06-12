From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Wed, 12 Jun 2013 15:21:44 +0200
Message-ID: <CALWbr2zOkoX9NKuZGOWDHyG12xE8ASz+gCK8qwgM1Xqr+uqN7A@mail.gmail.com>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
	<CALWbr2zLTUYRnaYxbjyU80zpa3Q6WGcquTPAHqWCJnbEZ7RNPQ@mail.gmail.com>
	<7vsj0pej5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 15:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umkzm-0007HM-8D
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 15:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab3FLNVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 09:21:46 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:50206 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3FLNVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 09:21:45 -0400
Received: by mail-qa0-f45.google.com with SMTP id ci6so313746qab.11
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jHGW7OcN1P3EE7Y1fffO8T/BV+hxk8ImG+ii0arD9HE=;
        b=CRSlBrrgIg2U6N0cpS+RaIcoj43RJoufsWdO+ZAq7kKcBKIgAkcopk48Ce3ytAhymT
         sDNEANMMDEhaIrUPBUlh8EOf8BMBKgrb3bsuq6e1oeDXpW9meqecNUDZcOcbb2DhCHRz
         ubcfMJU4/Rd2tzm+alAIqhzZ1RvOj1bxL4GF9nUtOr2Muxe3u6uE1V0TEH+/gctKSJOl
         YhNR75oMrx8IM2szLJ+eFU44jZoDgsDT5f5WSmcL7vx1KX8eyV1nNiNxmeHH/5ro52Ps
         E+V7wya+lwup4p9UEVwKYl5JFJWUix9Mk88vaKt8SnxTITtThOr0dDfrhwLZZhJcvYbw
         egjA==
X-Received: by 10.224.69.66 with SMTP id y2mr15169541qai.61.1371043304713;
 Wed, 12 Jun 2013 06:21:44 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 12 Jun 2013 06:21:44 -0700 (PDT)
In-Reply-To: <7vsj0pej5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227614>

On Mon, Jun 10, 2013 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> On Sun, Jun 9, 2013 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> When any ignore blank option is used, there will be lines that
>>> actually has changes (hence should be shown with +/-) but we
>>> deliberately ignore their changes (hence, if they ever appear in the
>>> hunk, they do so as context lines prefixed with SP not +/-).  When
>>> we do so, we show the lines from the postimage in the context.
>>
>> Don't we actually use preimage (see below) ? I think using pre-image
>> allows the patch to be applicable to another tree (but ignoring the
>> space changes).

Answering to myself: OK, my package version of git is 1.7.9.5 while
the post-image is used since 1.7.10 or something. That explains my
confusion.

> But the result of such patch application is not usually what you
> want to use.  If we use postimage (which by the way was a deliberate
> design decision we made earlier), at least the review of the patch
> is easier because you would see the end result more clearly.

I've found the patch and discussion [1] about that switch from
pre-image to post-image, so I can understand the motives (and see that
you actually considered problems for applying such a patch). I always
felt confident that running "git send-email -w" would send a patch
(that can be applied) without the potential space errors/changes I
would have added.

I think it's unfortunate that Git does generate patches with git-diff
that can't be applied if any space option is used. I'm still not
really convinced by the pre-image to post-image change, and maybe I
would have made it a non-default option. What is done is done, but I'd
rather like not do the same here, if possible.

>> If we actually hide new blank lines that are in the context, it means
>> that we won't be able to apply a patch with 2 new blank lines in the 3
>> line context.
>
> Yes, but I do not think the point of --ignore-blank-lines is to
> produce a patch that can be applied in the first place.  It is to
> allow easier eyeballing.

I think it can not be applied because it's *hard* for a computer to
actually find the correct location, and it may be equally hard for the
reader to evaluate the change with removed/different context.

>> Anyway, I'm starting to think that "show blank lines changes near
>> other changes" makes sense more and more sense.
>
> Probably.

I'm glad to see how convinced you are ;)

I will send my patch and see what makes more sense.

[1]: $gmane/188305
