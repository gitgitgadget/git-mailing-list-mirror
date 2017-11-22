Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58345202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 08:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbdKVIWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 03:22:12 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28892 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751516AbdKVIWL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2017 03:22:11 -0500
X-IronPort-AV: E=Sophos;i="5.44,436,1505772000"; 
   d="scan'208";a="301955686"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 22 Nov 2017 09:22:10 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org>
        <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
        <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop>
        <b131cc195280498ea3a77a37eff8444e@BPMBX2013-01.univ-lyon1.fr>
Date:   Wed, 22 Nov 2017 09:22:05 +0100
In-Reply-To: <b131cc195280498ea3a77a37eff8444e@BPMBX2013-01.univ-lyon1.fr>
        (Junio C. Hamano's message of "Wed, 22 Nov 2017 01:34:27 +0000")
Message-ID: <q7h97euiradu.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Was there any reason why Mail::Address was _inadequate_?

I think the main reason was that Mail::Address is not a standard perl
module, and not relying on it avoided one external dependency. AFAIK, we
don't really have a good way to deal with Perl dependencies, so having a
strong requirement on Mail::Address will probably end up in a runtime
error for users who compile Git from source (people using a packaged
version have their package manager to deal with this).

> I know we had trouble with random garbage that are *not* addresses
> people put on the in-body CC: trailer in the past, but I do not recall
> if they are something Mail::Address would give worse result and we
> need our workaround (hence our own substitute), or Mail::Address would
> handle them just fine.

For a long time, we used Mail::Address if it was available and I don't
think we had issues with it.

My point in cc907506 ("send-email: don't use Mail::Address, even if
available", 2017-08-23) was not that Mail::Address was bad, but that
changing our behavior depending on whether it was there or not was
really bad. For example, the issue dealt with in this thread probably
always existed, but it was present only for *some* users.

-- 
Matthieu Moy
https://matthieu-moy.fr/
