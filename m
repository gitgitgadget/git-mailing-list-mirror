Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB2C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D73217D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 12:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsPEX9Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635885AbgDPMjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635720AbgDPMjk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 08:39:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36838C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:39:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m67so20978548qke.12
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EXfjHWo23nSMXEp5rj8pYLt8xOa2+8Ihu78bzB8L5jU=;
        b=WsPEX9HplDLPp76aSHhTJ2N+FsruK+D9TYHuvaUuVGwYrhsm0Zw3kB7mkKDCP2Mz3R
         +2ah+yrT1sBkut5rNNUjZbaWbdcWbnU2Z0rfN1vn5Q8R8GF1eueNamVzGMspAMOP8QrH
         65jLcB8C7Eiu7jITbQ47ErcPDSPAf9go+5ziXYcwljwRZ/XZmrKKj9uBLwAY7A0JOMgE
         7nUL5XflIBmUZiLoBNxXzNa5QQ9IDBpxvNM/KZLfrmY+cEsApy8Zi0l8kTnVhu5epSTS
         wdw9irQIrEi6WEym2KMzMZ/dB4dqESfg7T8PszoeVjgea9i4Ujf1TO2eLnMAYYd/ONJm
         7LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EXfjHWo23nSMXEp5rj8pYLt8xOa2+8Ihu78bzB8L5jU=;
        b=GRQJWEZkoW7eo4ugGWHTuyqVwUGTfq9hMEK/zkYnLYYF1Jn49hVPTGt3fSv7g59d7J
         ZottbU2ZvpWH79+3DswfSRQzTr9qjnTkS0FkCFIKiLhSyr59WckydB/uzEsLLKQa1GkX
         Qakfubb3yR67lUF/PZlDBELjWBEi9DczTKO5/4Y1a8IpsZ+cWpBrwFlWbFeQvaAKZPcN
         rHQN50/uBgdhT3vWtH9ylJbd3JBwJp7AbFhGhACzFycV2bHMDqXbU0J9Us/04vLMcMjP
         OUsafh9fd/o9bhV1G1YX2CD4DmdVZcH4VpPBfK2B9ruvtGqko7Bdb55EAtrmWEdOwaQC
         8bTg==
X-Gm-Message-State: AGi0PuY/DC7VQacPokOU+2a34EatDMJsatrw7bkpcFT3twtpsfEZg3Ct
        PoCNcab3+TqNicG1kZj3c3M=
X-Google-Smtp-Source: APiQypKUWtBtlGuLCoxrHRG5ONpGOX2u4/6yWGVGnhAjW49wRKVs3+bN4lbv6aSP7eRyaidtsXEqgw==
X-Received: by 2002:a37:7002:: with SMTP id l2mr31787296qkc.372.1587040779309;
        Thu, 16 Apr 2020 05:39:39 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u65sm14718342qkh.100.2020.04.16.05.39.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 16 Apr 2020 05:39:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] pull doc: refer to a specific section in 'fetch' doc
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200406201945.GA1245278@coredump.intra.peff.net>
Date:   Thu, 16 Apr 2020 08:39:36 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
        Clemens Buchacher <drizzd@gmx.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0099CBAF-983E-46F2-B7E9-D5E661189587@gmail.com>
References: <pull.751.git.git.1586101819.gitgitgadget@gmail.com> <9c94c2770f0eb1cbb9383cffde7c275d7d3f52c9.1586101819.git.gitgitgadget@gmail.com> <20200406201945.GA1245278@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

> Le 6 avr. 2020 =C3=A0 16:19, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> One thought:
>=20
>> diff --git a/Documentation/pull-fetch-param.txt =
b/Documentation/pull-fetch-param.txt
>> index 7d3a60f5b93..95ea8499029 100644
>> --- a/Documentation/pull-fetch-param.txt
>> +++ b/Documentation/pull-fetch-param.txt
>> @@ -19,7 +19,8 @@ ifndef::git-pull[]
>> 	(see <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> below).
>> endif::git-pull[]
>> ifdef::git-pull[]
>> -	(see linkgit:git-fetch[1]).
>> +	(see the section "CONFIGURED REMOTE-TRACKING BRANCHES"
>> +	in linkgit:git-fetch[1]).
>> endif::git-pull[]
>=20
> We can hyperlink directly to this section with the CRTB tag (as you =
can
> see in the context above). But I guess we don't have a portable macro =
to
> do so across different manpages. Assuming we'd need something like
> linkgit to accomplish, it's best not to hold up this change waiting =
for
> that.

I didn't know it was possible. I agree that cross-linking directly to a =
specific section would be
great, especially if it would work for the manpages, the HTML =
documentation as well as the website!

Philippe.

