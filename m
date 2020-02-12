Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18946C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 04:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FC2073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 04:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shin9GNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBLEew (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:34:52 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42750 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgBLEev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 23:34:51 -0500
Received: by mail-lj1-f179.google.com with SMTP id d10so678855ljl.9
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 20:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=/aA1o9eOZp3Ajsn/cdDvGgsPX9LZFSgwM2ra5bOHyys=;
        b=Shin9GNM51yEkRcAFioldEW/8QL7Locw/hoRorUZy3H2tXBXZVL90/pHDsHc2p8RBo
         GPsL4KOh5WwNMqQkfQsTGsRtjUPQbdRE2LaU/lXmKHGxFfCU+AcSwhfYn0gcqHT12Hbx
         cKjPIP9aPNr3Y9yXuFSxcIToHCHV/AWTFNIySvgmy+4yipYyiT5m6h4uNZdPLgSrgMCQ
         LfBmS5Kwdnm6AyEIPBlW9jnkXKeZ5wMV9/UTo5VzFQ5QbJErBQYMiXx/xYFbMPiZ5fJ5
         vH8CQlGchCO8/v0dPTBIlEdNt0A9zKthvcymTOHu88b/37Cvlnt8vqwMNYGFSFzuZgzp
         Efcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=/aA1o9eOZp3Ajsn/cdDvGgsPX9LZFSgwM2ra5bOHyys=;
        b=TM1qj7SO0o0tvX9QBB2H7gQBSDSXbS18yE2qi0BWGwoOlwl715wAYA68JYsrQ8SsYa
         NZkSu1snKrLs+d3Un3BY72uq2lT/59lk7+CumQ75plJize586A1x9VDsI4WK46QSF/Ms
         vepYDXKar6sROLqpt1LFY9u5RFJP5EuMRiCdMJDPj098WqM7wI3CLANCbJXT9iCgooi8
         HAa4reCkcjOfhKfEBAMrufaYaexDtcJZ8Xnsqbl0CBRZFe+Xcd977+muJ6OfQRurdesW
         k/e2vz4dTGZLaYvzH5pB9RSyLYMzMv8ddIWeRv++TB5ZAoNNuKE18kxbxFenX1o06qLL
         RxxA==
X-Gm-Message-State: APjAAAXw7StHJGAB4cyLaDDUzeltiCSw9M2PoRM12ECnahUrTYuTJ/eN
        hQp9NQEw63qlSKR8drot55IRcNz7
X-Google-Smtp-Source: APXvYqxgWJfy5qKs4mWvqqgcKiyI48oVCsNV2s4X4K6ymSui36gy4XUzzuwMEAhAkKzEAqW73wi0bA==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr6353009ljn.40.1581482089134;
        Tue, 11 Feb 2020 20:34:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q14sm2745948lfc.60.2020.02.11.20.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 20:34:48 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Aleksey Midenkov <midenok@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
In-Reply-To: <20200211195627.GF2127797@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 11 Feb 2020 14:56:27 -0500")
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
        <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
        <20200211195549.GE2127797@coredump.intra.peff.net>
        <20200211195627.GF2127797@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 12 Feb 2020 07:34:46 +0300
Message-ID: <87k14se849.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 11, 2020 at 02:55:49PM -0500, Jeff King wrote:
>
>> On Tue, Feb 11, 2020 at 05:19:53PM +0300, Aleksey Midenkov wrote:
>> 
>> > Nice info, thanks. Does that disable maintenance messages like:
>> > 
>> > Updated 1 path from the index
>> 
>> I don't think it does. Usually how this works is that we add new
>> messages which we think might be helpful, enable them by default (since
>> users aren't likely to find out about them if they never see them!), and
>> then if they turn out to be annoying or verbose, add an advice.* config
>> option to allow people to avoid them.
>> 
>> The message quoted above is a relatively new one, and I don't think it's
>> hit that third step yet. Patches welcome. :)
>
> Oh, and if you want to see the complete list, look for "advice.*" in
> "git help config".

It says:

   All advice.* variables default to true, and you can tell Git that you
   do not need help by setting these to false:

If there were an option to set that default to 'false' (advice.default
maybe?), it'd have answered the demands of the experts, I think.

-- Sergey
