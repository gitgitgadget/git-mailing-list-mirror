Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077E7209AE
	for <e@80x24.org>; Thu, 13 Oct 2016 05:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbcJMFdX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 01:33:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38304 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754650AbcJMFdV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 01:33:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5WQOd018454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 13 Oct 2016 07:32:26 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5WQhX025041;
        Thu, 13 Oct 2016 07:32:26 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
        <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
        <vpq8tttr2ps.fsf@anie.imag.fr>
        <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 13 Oct 2016 07:32:26 +0200
In-Reply-To: <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 12 Oct 2016 13:53:52 -0700")
Message-ID: <vpq1szkolud.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 13 Oct 2016 07:32:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9D5WQOd018454
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476941547.55047@S0QsB0MHKXnTs02OxNuIww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> People write things like these
>
>     Cc: Stable <stable@vger.kernel.org> # 4.8
>     Cc: Stable <stable@vger.kernel.org> [4.8+]
>
> in the trailer part in the body of the message.  Are these lines
> meant to be usable if they appear as Cc: headers of an outgoing
> piece of e-mail as-is?

I think this is not the right question. The relevant one is: should
these lines be accepted by git and turned into something usable if they
appear as Cc: headers of an outgoing piece of e-mail?

I.e. "Be liberal in what you accept, and conservative in what you send".

If you have Mail::Address installed, this is already possible. With
pre-2.6, I did not re-test, but I think it was using the addresses
as-is, which probably worked but AFAICT created non-RCF-compliant
emails.

> "error: unable to extract a valid address from:" is followed by
>
>     Stable <stable@vger.kernel.org#4.8>
>     Stable <stable@vger.kernel.org[4.8+]>
>
> which is not ideal.

I'd actually even say "broken" ;-). If we decide to reject these, we
should at least give a sensible error message.

> If I were to issue a decree, I would say that people should stop
> suggesting to put RFC-bogus things on the Cc: line.  As you
> mentioned, things like:
>
>     Cc: Stable (4.8+) <stable@vger.kernel.org>
>     Cc: "Stable 4.8+" <stable@vger.kernel.org>
>
> are perfectly readable alternative that are still RFC-kosher.

I do support those, but if there's an established tradition of using
# ... trailer, then I don't think we should be the ones forcing it to
stop.

> Things may have appeared to work by accident, and things may still
> work by accident, depending on the vintage and availability of
> Mail::Address package (which seems to be the case), but it is not
> worth risking random breakages that depends on what other people
> use in the first place, no?

The "depending on the availability of Mail::Address" is what bothers me
most. Suppose we make a strong statement here that this # 4.8 should
stop. Then some users will listen to that statements, but others won't
read the thread, test with their own git that it works, and recommend it
to users for whom it doesn't.

> That is, even though people seem to expect "send-email --cc" to
> somehow be able to judge that " # 4.8" and " [4.8+]" are cruft not
> meant as part of a valid address, I do not think it is a realistic
> expectation.  How would it know "Cc: Stable <add@re.ss> 4.8, 4.9"
> has garbage " 4.8, 4.9" that needs to be stripped, while "Cc: Stable
> <add@re.ss> 4.8, torvalds@linux-foundation.org" has two valid
> addresses that need to be CC'ed and " 4.8" is the only thing that is
> unwanted?

We clearly can't guess, but we can be consistent with Mail::Address, so
that git's behavior depends less on its availability.

Patch follows doing that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
