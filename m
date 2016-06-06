From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Coccinelle for automated refactors
Date: Mon, 6 Jun 2016 13:38:13 -0700
Message-ID: <CA+P7+xqszc-BRBYo7vaiQBFy8c9MMJwTY3sLrX5gOFZc21Mm8Q@mail.gmail.com>
References: <20160605205518.GA153578@vauxhall.crustytoothpaste.net> <xmqqy46iw3ih.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:38:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA1IE-0003DI-DF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbcFFUif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 16:38:35 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34975 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcFFUie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 16:38:34 -0400
Received: by mail-yw0-f180.google.com with SMTP id o16so151563585ywd.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hPf5M5diBWLkKPHzVNeffba36rUDjB9BoY/C2BU2Bq8=;
        b=sJ5ajoRNJSZqXTxXigrqdZLXDGaJpd4gTmzmXu+Jm1Xe4KOsV8in0CB+hYRDt179hI
         WsmB5VgJ2CJKMFfDabS4KtCXZVOyfZWeEgb686c7LmIeGKc/d9OVxJ4rTByaN1zW4VU9
         R6lwEI5UAb6FCWJeuPDAjjW0cVJJWM1gfCyYAznhszTlgNI+aYtxYMttr1pd/lNPPAr/
         bbqQ8TLnze7GoqoP4e8k4k3vwVUdCqQ6IrabMFRmPTuyMvfrynumB/le8z0bVstj5JYg
         MZBIC7Orp1LkkQC8iz2xVjxJSwG4SokHUYgGqVjvgMDnvHkmTjlPnB31Y2GqpxPwgxgb
         ssnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hPf5M5diBWLkKPHzVNeffba36rUDjB9BoY/C2BU2Bq8=;
        b=h0jfGybDO1iDUwEdhqxjcNVboOstWZXrgsTlCabk+5up541F8V1n8BzCna9DbzQ8u5
         rkrrzEEiswnes0qh2q8ZGY0y9dz3jF9hedJa2CUPjvbHZj65Mr8Lev0rjkqjfO8fdcSl
         Qgm/0aU9ESMk4RX5vHwcLWCfA4cQZx9ZWRGJI/BOIIRFgxrrZ/YiEd8Sb0ACJ/BOeKg/
         2YprRtTIJIvI+ZSlncSlwKt+nLp0PaXnuT/nXkMREI6JVeaLeGy+fMtBXDTDqGTL52tJ
         hzjEB2pYMyQEYPO05zMsOrANYN9v2/9FPB97YlA7KNUiW+jfz1d9iDUwNT7FAtBDJajJ
         aoJQ==
X-Gm-Message-State: ALyK8tJlp6RxEBRzMrQds1cUO+aRGc5WT8BfHuSPqPJvlqmExH8+exbW9vfhw+5fBa5Sec/xagJa2RG5lMX0XA==
X-Received: by 10.129.57.5 with SMTP id g5mr12783355ywa.237.1465245513049;
 Mon, 06 Jun 2016 13:38:33 -0700 (PDT)
Received: by 10.37.42.132 with HTTP; Mon, 6 Jun 2016 13:38:13 -0700 (PDT)
In-Reply-To: <xmqqy46iw3ih.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296563>

On Mon, Jun 6, 2016 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> An example semantic patch looks like this:
>>
>> @@
>> expression E1;
>> @@
>> - is_null_sha1(E1.hash)
>> + is_null_oid(&E1)
>>
>> @@
>> expression E1;
>> @@
>> - is_null_sha1(E1->hash)
>> + is_null_oid(E1)
>>
>> This does what you think it does: transforms calls to is_null_sha1 that
>> use the struct object_id hash member into calls to is_null_oid.
>>
>> I'd like to use this for some of the struct object_id work if others
>> think this is a good idea.  I feel it's likely to reduce the reviewing
>> overhead and allow people to better reason about the quality and
>> behavior of the sent patches.  Of course, I would still review the
>> patches manually for errors and improvements, and would still accept
>> responsibility for the content of the patches.
>
> Is the plan for such a "refactor" patch to compose such a series as
> two patch series:
>
>  [1/2] automatic refactor
>
> which gives the "semantic patch" in the proposed log message as part
> of its description, and the automated result (with possible
> misconversions that may have come from bugs in the automated tools),
> with a separate
>
>  [2/2] manual fixups
>
> that corrects what was misconverted and what was missed?
>
> As long as [2/2] can be kept to the minimum (and an automated tool
> that is worth using should make it so), I think that is a good way
> forward.  Another possibility would be to send the end-result as a
> single patch, with description on the manual fixups in the proposed
> log message, but it would be a lot more work to generate and review
> such a patch, I would think.
>
>> If there's interest, I can send a patch with a set of basic object_id
>> transforms to make it easier for others to make those changes when
>> they're doing work elsewhere in the codebase.
>>
>> [0] http://coccinelle.lip6.fr/
> --

I've used coccinelle before on the Linux Kernel, and I've found that
it works quite well without producing any incorrect changes,
especially if you keep the semantic patch small and simple. I'd
definitely go with the 1/2 2/2 approach but I suspect in most useful
cases 2/2 would be very minor if at all.

Thanks,
Jake
