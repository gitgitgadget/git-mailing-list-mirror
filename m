Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A45320989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbcJMQI7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:08:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51434 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753729AbcJMQI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:08:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9DG5SBJ020466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 13 Oct 2016 18:05:28 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9DG5Uwi007971;
        Thu, 13 Oct 2016 18:05:30 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
        <vpq8tttr2ps.fsf@anie.imag.fr>
        <xmqqtwch2srj.fsf@gitster.mtv.corp.google.com>
        <20161012231321.ar2csdmvhdya2q7r@sigill.intra.peff.net>
        <20161013153317.GA1698@ikke.info>
Date:   Thu, 13 Oct 2016 18:05:30 +0200
In-Reply-To: <20161013153317.GA1698@ikke.info> (Kevin Daudt's message of "Thu,
        13 Oct 2016 17:33:17 +0200")
Message-ID: <vpqtwcg9qut.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 13 Oct 2016 18:05:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9DG5SBJ020466
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476979530.81062@m4xeDBKfQEqOSYMYzjL0og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Wed, Oct 12, 2016 at 07:13:22PM -0400, Jeff King wrote:
>
>> I think the answer is pretty clearly no. It's just that historically we
>> have auto-munged it into something useful. I think the viable options
>> are basically:
>> 
>>   1. Tell people not to do that, and to do something RFC compliant like
>>      "Stable [4.8+]" <stable@vger.kernel.org>. This is a little funny
>>      for git because we otherwise do not require things like
>>      rfc-compliant quoting for our name/email pairs. But it Just Works
>>      without anybody having to write extra code, or worry about corner
>>      cases in parsing.
>> 
>>   2. Drop everything after the trailing ">". This gives a valid rfc2822
>>      cc, and people can pick the "# 4.8" from the cc line in the body.
>
> Comments, surrounded by parenthesis are allowed after the ">" according
> to the RFC, just plain dropping everything comming after that would
> break that support.

Our in-house parser does consider (...) comments, and my patch does not
change how they are handled: they are still kept after the address part.

However, another piece of code does strip everything behind ">":

sub sanitize_address {
        ...
	# remove garbage after email address
	$recipient =~ s/(.*>).*$/$1/;

introduced in 831a488b76e0 (git-send-email: remove garbage after email
address, 2012-11-22).

IMHO, it's OK to continue doing this: removing comments from To: and Cc:
is not really a problem (and I think we've seen nobody complain about it
since 2012). But after my patch, these two lines can probably safely be
removed, as there can no longer be "garbage" after the email, only
comments.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
