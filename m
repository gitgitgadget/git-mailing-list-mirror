Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478472018B
	for <e@80x24.org>; Tue, 28 Jun 2016 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcF1Uvl (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:51:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56213 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbcF1Uvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 16:51:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5SKpCRI016326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 22:51:13 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SKpFre028522;
	Tue, 28 Jun 2016 22:51:15 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v2 0/2] Config conditional include
References: <20160626070617.30211-1-pclouds@gmail.com>
	<20160628172641.26381-1-pclouds@gmail.com>
	<20160628202809.GA21002@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 22:51:15 +0200
In-Reply-To: <20160628202809.GA21002@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jun 2016 16:28:09 -0400")
Message-ID: <vpqk2h9qbp8.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 22:51:13 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SKpCRI016326
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467751874.33041@wzywR5C2/erYsZJMrtuhEw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jun 28, 2016 at 07:26:39PM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> There's a surprise about core.ignorecase. We are matching paths, so we
>> should match case-insensitively if core.ignorecase tells us so. And it
>> gets a bit tricky if core.ignorecase is defined in the same config
>> file. I don't think we have ever told the user that keys are processed
>> from top down. We do now.
>
> Hrm. I'm not excited about introducing ordering issues into the config
> parsing.

There's already at least one case of ordering-sensitive variables, that
we encountered when writting the config cache during Tanay Abhra's GSoC:
diff.<driver>.funcname Vs diff.<driver>.xfuncname. Git applies the "last
one wins" policy, which is the normal rule for a single-valued variable,
but in this case, a "funcname" definition can override an "xfuncname"
def. To preserve this behavior we had to introduce ordering in the
cache, but to me this was a design mistake to rely on order.

In short: we already have one, but I'm not excited either about
introducing new ones.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
