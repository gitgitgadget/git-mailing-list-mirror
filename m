Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6690C2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjwSnKu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIMn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:43:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLIMn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 07:43:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so15326029wmj.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PkqGkXjmUiEwbvSwKm2Ng6s4a2dP67UBvFwzG+4mH18=;
        b=qjwSnKu7rWWEVqlS1aeO2Q+DhN6YIQg/Wu9z17/4YBw3kuZEa23Erfsbunv8vgqaWd
         u6jpfHXmGMM/TTwUPKRSiMwq+f4J7nWe0hng3iZTADS6MYbtCsgNl8en4gqsPKQ2ZM1E
         IOwqUzt3q23MlnK4Pdd5r6tH+DkMvdU42XQwaDSpQ8X6VH9JZ8bB7XARqCJ/0vQy7DBN
         gfJk8kJSxwvEIsCuDHe91VBiTl8TnUQT13ZuQANtKDddy7HcB5iptLuhibpOucGhjq5d
         d3tFmLC9KOvSuhbMbFZ3MVMWvg8bP6b/OJdTR2BCwz9I7Fmb4kHFc8KIlMRsy6WMO3hB
         na9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PkqGkXjmUiEwbvSwKm2Ng6s4a2dP67UBvFwzG+4mH18=;
        b=dNN9AFFropLqHjabZg6L7O2omaEfPIHkjSgHWSCHJrUxE1xJf5dX4CKYCsrnBlKId2
         VDtll2pp1YFpfCkNyXPonygSkKxQ306Ia2rGc728K3untgW/xEvv8nldWXHs6M8aDkcC
         PZLShPJjIc4vlTm6Bn7LTisGd6fg29XzjQZDjUeQsOxA3S+gVNOldjKbD8YFBscZsi/t
         dLUkcflSnc9IBe0DbmAW3Te4/VCc4rWukRABrAzYYn8wGKKZJzh6G/MhnsCD67doI8Ek
         vsBIl3acr5BnAgQn5kY+PA0D8D/V5WegwRQh5Q4SI+BBrm24EVEW2hU/YcHKf4vGrz1+
         md9Q==
X-Gm-Message-State: APjAAAVBIZhANN7LEPvKU8DCD69wVmVJ0TEgsk1zHwDd57qMnRlTVDwZ
        hr7QwHccwfPCESGIIoNBwG0=
X-Google-Smtp-Source: APXvYqx3vC36QFqJKJJtNaer5uVf1vEH7cdz4ZBZg4eamid6jYePCR8ImJpEQ7yaZBh1W9sRiU08kA==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr25350454wmc.9.1575895434961;
        Mon, 09 Dec 2019 04:43:54 -0800 (PST)
Received: from szeder.dev (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id s82sm13502521wms.28.2019.12.09.04.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 04:43:54 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:43:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] name-rev: rewrite create_or_update_name()
Message-ID: <20191209124351.GD2746@szeder.dev>
References: <20190919214712.7348-8-szeder.dev@gmail.com>
 <20190922081846.14452-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190922081846.14452-1-martin.agren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 22, 2019 at 10:18:46AM +0200, Martin Ågren wrote:
> This code was moved straight out of name_rev(). As such, we inherited
> the "goto" to jump from an if into an else-if. We also inherited the
> fact that "nothing to do -- return NULL" is handled last.

>  For the record, --color-moved confirms that your patch is a move and
>  the conversion around it looks good to me. I was a bit puzzled by what
>  the moved code actually wanted to *do* and came up with this rewrite.

Yeah, I had a bit of a "Huh?!" moment myself looking at that goto
jumping over the condition, too...  Initially I left it as-is to keep
this patch a pure code movement, and that others might have a bit of
fun as well when they stumble upon it in the future ;)

>  It seems there was some discussion around leaks and leak-plugs. That
>  would conflict/interact with this. 

And I didn't pick it up in later versions, because René's plans to
clean up memory ownership would deal with it (and with much more) as
well.

