Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1328E1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDOWQo (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 18:16:44 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35903 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOWQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 18:16:43 -0400
Received: by mail-wr0-f174.google.com with SMTP id q13so17448942wre.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l3IQKLa0uk4zOAXoL682GdPPdTZheqT06XPuwkTXUSI=;
        b=NrQ979KaOQUd19i8T+wxNPyEMmbvrLzo8fvmTgoCpIpGZsFGST+t7knFTo0fiH5vTQ
         X7vBXARdKzPocS7p6d4y2immgjDQE39mKsL8G84k/IkodItKJZFNLGQrNZ9eMd+J0WS5
         t2jdiLrQJvZFyopA0uYWuBKhox6xTGuACfrxeZ72v3fvIdboebv6S1EL5WQrGAq9NylL
         okA39ImGVHCXakQzQHPHKToVN5Qn8ahPPwats4BlCcD2VhtM0eHq73ZetyMCLGVD2tti
         2UXDgPWxilUjSX2X5gHDLbzPrZ1sfSeWiBVnTZM7icg081T5o4saYPlWaFVbQQteuJiB
         VTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l3IQKLa0uk4zOAXoL682GdPPdTZheqT06XPuwkTXUSI=;
        b=oqgGKLeEWxWlNCxSoRQLSUqLTfaHwtkEuIu4sHn4mqyll3zCfBqgmUOI2ull5PpsaW
         j/GzLKiI1KbJAlvzfXkz87ih0r6ciQK2fKDFusfoeHcXT+dvrXFObLOv3Kkk9uRosr3C
         Oy9GaZWY4WoZ/AS54deWJuh1I1Fa0FaT/ZNwTqouqXUNjEceVrrcLy9uT+ORNbJ7ZaVR
         rVnHzK5kVa6feY632TdtzLo/HVSKGK5FUIj8WQpsMGiMUXO4nyMCSY8sBUgXyKb1R0cF
         ZGa+Kj4YWqsVYY9nqHAltB0VxHoTAvwyV2cN8h8CZ3FlBDZhq7ZEPpemFY8VTlYe8GTi
         YHfA==
X-Gm-Message-State: ALQs6tC2Ou4oGkzQW7UuOAboj00ZyMcZNSKx73R9bv5gb6jKMFQ2iIMo
        a29HOQOn8Wk0q+4pekX/EeI=
X-Google-Smtp-Source: AIpwx4/JFeoIai+4itNahxlhkIwCCR/eq3q95B7e61R42GHlCdeMEZ0CV/3mtCQxtpEJ/Hsi2qHgRA==
X-Received: by 10.28.180.195 with SMTP id d186mr5784730wmf.32.1523830601858;
        Sun, 15 Apr 2018 15:16:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r196sm6283588wmf.9.2018.04.15.15.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 15:16:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
References: <20180412210757.7792-1-kgybels@infogroep.be>
        <20180412210757.7792-2-kgybels@infogroep.be>
        <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 16 Apr 2018 07:16:41 +0900
In-Reply-To: <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 16 Apr 2018 06:54:08 +0900")
Message-ID: <xmqqvacsyv1y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think you identified the problem and diagnosed it correctly, but I
> find that the change proposed here introduces a severe layering
> violation.  The code is still calling what is called poll(), which
> should not have such a broken semantics.

I only mentioned a piece of fact (i.e. "the code calls poll() after
the patch"), but I guess I should have made it clear what makes that
a bad thing.  Future readers of the code in daemon.c are required to
be aware of the limitation of some poll() emulation; they cannot
"optimize" out and made the code unware of the (non-)existence of
remaining children, for example.  When the callsite uses poll(),
those who know how poll() ought to work won't be.  The reason why
the xpoll() I mentioned as a possible alternative would be better is
because they will learn why we do not use normal poll() there and
why we maintain and pass live_children (and those who cut and paste
without understanding the existing code _will_ copy the calling site
of xpoll(), which will automatically copy the need to maintain the
number of remaining children ;-).


