Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F30207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbcJKHkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 03:40:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34364 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbcJKHkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 03:40:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u9B7dvHx021418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 11 Oct 2016 09:39:57 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9B7dv6w012049;
        Tue, 11 Oct 2016 09:39:57 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Jeff King <peff@peff.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
        <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
Date:   Tue, 11 Oct 2016 09:39:58 +0200
In-Reply-To: <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Oct 2016 17:57:11 -0400")
Message-ID: <vpqfuo3l4fl.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 11 Oct 2016 09:39:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9B7dvHx021418
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476776399.04305@yOp1pqszi5V+QX51IAxQMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [+cc authors of b1c8a11, which regressed this case; I'll quote liberally
>      to give context]
>
> On Mon, Oct 10, 2016 at 05:48:56PM -0400, Jeff King wrote:
>
>> I can't reproduce the problem with this simple setup:
>> 
>> 	git init
>> 	echo content >file && git add file
>> 	git commit -F- <<-\EOF
>> 	the subject
>> 
>> 	the body
>> 
>> 	Cc: Stable <stable@vger.kernel.org> [4.8+]

Is this RFC2822 compliant (https://tools.ietf.org/html/rfc2822)? Not an
expert of the norm, but my understanding is that you're allowed to use
either "Name <addr@domain.com>" (name-addr) or addr@domain.com
(addr-spec), and that comments are allowed within parenthesis like
"Stable <stable@vger.kernel.org> (4.8+)".

What is this [4.8+] supposed to mean?

The guilty function is parse_mailboxes in perl/Git.pm. It should be
rather easy to modify it but I need to understand the spec before I can
try to implement anything.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
