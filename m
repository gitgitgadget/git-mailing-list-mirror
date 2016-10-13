Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F7B209AE
	for <e@80x24.org>; Thu, 13 Oct 2016 05:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbcJMFhp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 01:37:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56596 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754650AbcJMFhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 01:37:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5bVPb006669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 13 Oct 2016 07:37:31 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9D5bVQT025132;
        Thu, 13 Oct 2016 07:37:31 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
        <vpq8tttr2ps.fsf@anie.imag.fr>
        <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
        <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net>
Date:   Thu, 13 Oct 2016 07:37:31 +0200
In-Reply-To: <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 12 Oct 2016 19:13:22 -0400")
Message-ID: <vpqmvi8n71g.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 13 Oct 2016 07:37:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9D5bVPb006669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476941851.83676@KJini3Kh1+KruivUZQbzAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. Drop everything after the trailing ">". This gives a valid rfc2822
>      cc, and people can pick the "# 4.8" from the cc line in the body.

That would work for me, but it's inconsistent with Mail::Address and I'd
really like to avoid having a behavior depending on libraries installed.

Plus, consistency with Mail::Address gives us consistency with any other
program using Mail::Address.

>   3. Rewrite
>
>        A <B@C> D
>
>      into
>
>        A D <B@C>
>
>      regardless of what is in "D". This retains the information in the
>      rfc2822 cc.

There's another one I considered:

   4. Consider '#.*' as a comment when parsing trailers (but not in
      other places where we parse addresses)

This is much harder to define properly because of

Cc: "Foo # Bar" <email@example.com>

=> we'd need to handle the ".*" syntax when stripping comments. And
again, that wouldn't be consistent with Mail::Address.

So, I ended up implementing 3., which actually isn't hard, and gives
code IMHO cleaner than it used to be.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
