Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EDE1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIEAMJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:12:09 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39184 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:12:08 -0400
Received: by mail-wm0-f42.google.com with SMTP id q8-v6so5449945wmq.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TP5Pny1D9A8ev8LhVbJy190jM1Eh65pz8hWahUIPgSQ=;
        b=NQ8l/g8PFpdWkBTaLtvmFZfdzTdlN89j8/wQfugWWCBW8nRJUtQk3JAa/kvkW2vcXB
         QsvsCJ7Zw2jhNYdT3tnWI8v3/fhdh7IGb88EGxao/9Kxl9jsG75baCYFIEJJLXmNMUcC
         4tO36VSjzOSQkpd7f5NB66BFZ0gm3YzAfSMNPMTqGQ/7fbfbQt6Eeq9NOXHF4xX8ojja
         sg0SSiwJuScJrq+lg/AbZCaebjBN2eRbPI4iJsLXpj2wczFfE6TrZWDF2xEDRvvDMfvJ
         UZ1yofyCsa6IN2F+gZRO+o5AOLEO8SPUqwgZc2HWA2K7nezQuMvFJlF2EYyZ50AfBiFu
         uWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TP5Pny1D9A8ev8LhVbJy190jM1Eh65pz8hWahUIPgSQ=;
        b=deb/G8wUU+gP9JIDEwL4cd7OFdyW1sn6jLZdArl425Kvle1CCNOkBHJSNVOPL7tiJf
         TmOIdWgOTBoKVvX95Km6mlSjwU0qLwrfibMtrsEpWyr5FZSwDzywSoah/DXAEh/P8sEC
         V5Pg3EkUmBuzumfhsOrDpW+ZR/1Go1BuNIrXnwx2nTgikUlfsVI6gxJi/+hQTql/1j7N
         9LaPdBTX40kea33yVYgOq3T9ag0xqm6w1HmXo5/ka1HBXE6fhh2jYmw+r/jKUk++bupg
         oetTsYCY6B6QPXNuI0UEqoJoPTW06WuyJyk8dIlvUuAer8X/qsMqqovhegQLo/FVZ6PL
         lHmQ==
X-Gm-Message-State: APzg51B7t6t297awwuNpCJNdF+kKTDw7Bu3LFCjebSEAMiNgqxkvT6n3
        wvZ9iHsVpZrwuL/cHgFmDAc=
X-Google-Smtp-Source: ANB0VdaSoak5UKYk24/G7DD/Rf9WWcFUONfjAM2Ybcxca9Uc4e07d+Bz76udFkYNK5pLa4sppp7X+w==
X-Received: by 2002:a1c:adcc:: with SMTP id w195-v6mr9264251wme.41.1536090331921;
        Tue, 04 Sep 2018 12:45:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w18-v6sm46282220wrc.38.2018.09.04.12.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:45:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
References: <20180901074145.GA24023@sigill.intra.peff.net>
        <20180901074813.GB25461@sigill.intra.peff.net>
        <20180901080316.GA25852@sigill.intra.peff.net>
        <CAGZ79ka8e2-f4fYgy+=HUDdvugefvQ5TnDG0v8YmUn7kGhTdaQ@mail.gmail.com>
Date:   Tue, 04 Sep 2018 12:45:30 -0700
In-Reply-To: <CAGZ79ka8e2-f4fYgy+=HUDdvugefvQ5TnDG0v8YmUn7kGhTdaQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Sep 2018 12:05:58 -0700")
Message-ID: <xmqqin3l82sl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From some offline discussion, maybe we want to adapt a philosophy of
>
>   Each patch needs to add a test, that fails when the patch
>   is not applied, but succeeds when it is applied. This shows
>   that _some_ code in the patch is exercised at least.
>
> (and automatically/strongly enforce this going forwards; however
> enforcing such a strict thing is hard, not sure how we'd do it.)

Some patches lack test, but when one comes with a test, I do revert
the code change and try to run the tests before I create a topic
branch for it, when I have time.

An enforcement mechanism may be good (e.g. submitGit could learn to
do that "does it come with a test" check followed by "let's see if
the new test fail without the change to the code part" before
allowing the patch to escape to the list), but 
