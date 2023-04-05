Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7746EC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 08:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjDEIbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEIbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 04:31:36 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D01BDD
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 01:31:35 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 1DFA61BF20C;
        Wed,  5 Apr 2023 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680683493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YVL9l3QCnYH5iTKwsPNkbz6I458S18rFwk4cPq1lf4=;
        b=VQANCJAcLQ3Kn/9xf+m86dzeeOZzRzQILP9YXg5Bqvv+Siu8xOI00SUUMf5IS9Wl+w7xIG
        Sdcyhw6OLO8ldjI5MFiVeN/oF7FG9aewRfrt974Tj10zJuGa5Xhy+oD5RbQ1yAF9LmXQsp
        OzNvwHlDBediLlisNriwoaLDXjeCYUTCH/9IHiWbAUQKsar7/fTYdx6UdLlsMXZy25IT+g
        5agkKeNp99x9y8RjGq5Cg78GFKzB0Xv3cm+m78ju6g71yioK54+KwTlit1k9/RhqGGaEJN
        Z3A6iHpQRfAg9r3BipxLEfvLfL3yWo/i6o8og921kBqAa69YI7HEk7gt54OFsQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 05 Apr 2023 10:31:28 +0200
Message-Id: <CROOKNR29PDV.1WIGA6219L1C6@ringo>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
From:   "Robin Jarry" <robin@jarry.cc>
X-Mailer: aerc/0.14.0-147-gac3061ba16e0
References: <20230402185635.302653-1-robin@jarry.cc>
 <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
 <CRNH5FOB91JE.14CZEA494X002@ringo> <xmqq7cus4m0b.fsf@gitster.g>
 <CRNHSC3H2B6C.UCSDE4Y6ET4A@ringo> <xmqqbkk3z9p9.fsf@gitster.g>
In-Reply-To: <xmqqbkk3z9p9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Apr 04, 2023 at 22:14:
> Feeding the filenames as the command line arguments would have been
> much simpler X-<,

Just a thought. Instead of adding another hook, wouldn't it be better to
add an option --validate-series (git config sendemail.validateSeries)
that would change the behaviour of the sendemail-validate hook? Calling
it with all patch files as command line arguments only once instead of
once per file.

I know I was concerned with the max size of the command line args but is
there really a chance that we hit that maximum? On my system, it is
2097152 bytes. Even with a 1000 patches series with 1000 bytes
filenames, we wouldn't hit the limit.

This way, we support any crap filename that the user may send and we
don't add a new hook which basically does the same thing than the
existing one.

Thoughts?
