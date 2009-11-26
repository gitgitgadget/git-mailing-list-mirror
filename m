From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Thu, 26 Nov 2009 17:05:23 -0500
Message-ID: <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> 
	<905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> 
	<cover.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> 
	<7vr5rlerqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 23:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmTG-0007pb-2m
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 23:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZKZWFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZKZWFi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 17:05:38 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60257 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbZKZWFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 17:05:38 -0500
Received: by ywh12 with SMTP id 12so1143379ywh.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 14:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iGVfW9ZhQL0PlyIs0isx0COXoe2UfOZt13cZ50ICOZ0=;
        b=I8TXer4kAxIi+hhRPl2C0HlfSie/VHhvEVHG1T120Q7QaU2tW1UB+t4nu+tN9hNNTn
         8nrK6LlfybU8L5hFRWOOPLkJmc/F2X0ifFz9u6oDvNDw6vUj3YnIM2tck5YvMolqb86p
         WjxYISw/nk/ffJggImN98419eJt484mPDnYnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aQL2xscew6d5PECs6GhZSrhl8BGbmpijb+OSiEf+4o3F9tFzJDlRm3Be+hBMLR2t4p
         8J1D8+SPpb4KO8kx2NyGaMdYrGv59+z4ELu6eohPWq4k/YX8nOtnXssg3oVooH0BC4V1
         2uRilsacpqp65skvrEOpVbrrwvYdRH8E2Oh6Y=
Received: by 10.150.40.2 with SMTP id n2mr528733ybn.122.1259273143115; Thu, 26 
	Nov 2009 14:05:43 -0800 (PST)
In-Reply-To: <7vr5rlerqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133843>

On Thu, Nov 26, 2009 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =A0- The original series was done over a few weeks in 'pu' and this
> =A0 intermediate step was done before a better alternative of not usi=
ng
> =A0 these two extra merge strategies were discovered ("...may have be=
en an
> =A0 easy way to experiment, but we should bite the bullet", in the ne=
xt
> =A0 patch).
>
> =A0 As the second round to seriously polish the series for inclusion,=
 it
> =A0 would make much more sense to squash this with the next patch to =
erase
> =A0 this failed approach that has already been shown as clearly infer=
iour.

ok.

> =A0- I think we should avoid adding the extra argument to ll_merge_fn=
() by
> =A0 combining virtual_ancestor and favor into one "flags" parameter. =
=A0If
> =A0 you do so, we do not have to change the callsites again next time=
 we
> =A0 need to add new optional features that needs only a few bits.
>
> =A0 I vaguely recall that I did the counterpart of this patch that wa=
y
> =A0 exactly for the above reason, but it is more than a year ago, so =
maybe
> =A0 I didn't do it that way.

You did do that, in fact, but I had to redo a bunch of the flag stuff
anyway since a few other flags had been added in the meantime.

I actually tried it both ways (with and without an extra parameter),
but I observed that:

- There are more lines of code (and more confusion) if you use an
all-in-one flags vs. what I did.

- Several functions have the same signature with all-in-one flags vs.
their current boolean parameter, so the code would compile (and then
subtly not work) if I forgot to modify a particular function.

- When we go to add a third flag parameter, it wouldn't be any harder
to join them together at that time, and because it would *again*
modify the function signatures (from two flag params back down to
one), the compiler would *again* be able to catch any functions we
forgot to adjust.

If you think this logic doesn't work, I can redo it with all-in-one
flags as you request.

Avery
