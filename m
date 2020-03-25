Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C44C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B47820772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSpJX9WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCYJyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:54:01 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35626 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYJyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 05:54:00 -0400
Received: by mail-wr1-f51.google.com with SMTP id d5so2128785wrn.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xaPDJ4yDLHUdxQB0nGyjpu2GZH7vQRGlNXGJnqc6FIg=;
        b=XSpJX9WUismOEw6zNdyQWYN0ZrfnnGDlmAuHsTBTrIEskNsVs2d6jg9beJtVvG60XZ
         ec3Ta9JJ0XKMUOEaz+CkJq6chQuwnzy6Umo3g/nwfwW04VCztMO0iMzZg9qOAkDQKnB5
         EyJ4FGJBHgfLtlct0auZxEjJpjV9hZmIypHtFNtOOsdFuBVfiMIM4ndykyGd3EN15y2w
         qcU9BA2l8QL1do6zEtBAfygag1kyqO21CDNpso/HYG1+wllgrzRK0hRC3bz7NbGgbO/T
         oVoAoFnBIsfFam4eoKMaiov5AFNSrYmmtm8hvjKf+C6pJWbA4971bdHjA6lqeCbo05CK
         NBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xaPDJ4yDLHUdxQB0nGyjpu2GZH7vQRGlNXGJnqc6FIg=;
        b=tF67iOXr2RMvHRJCatQhuXmorRZ+eTHFpNc1agL0qZ8EWCBFmw9hmoOt6DckUQiuyU
         mIsWdhKHtFERxsKIqf7dvsiiKLQn1++qOuFEwcEOHVRref2yS4m3hD1kXXKDEJp1st2Y
         6mTcwrcPLj9GqhQRtLotemAhoK2N4uGUFbPunDnzWe/jmRVg6PDjq17ZUMJZWp4T+Z0g
         oSjqT2sDP/Ye9PnEJLsZ+0CCJ8yjTgYfmMIKfbR/7dXqQRSeGh3PHt3CGMQNaYKY6xp+
         xstRl/fJE8sltDv5zUnKOIrfj1yrNou3w5+tFjc8ux4bN0mmwaNtz3uaKmL0Ut/9jZG3
         FdhA==
X-Gm-Message-State: ANhLgQ0c5N1L2Rj91AvqOpU6fq2vwZpopata0drjs3sVX/5gyG5lnCO3
        //1YhHJeSSD8+XCHITZ3WfanIwha
X-Google-Smtp-Source: ADFU+vtd72EbaB2Hp/xuXW+bLnVc4qdpfHQy2j2bNLH9k8E+BXK0G7EaT58twCEqaXhPJXFiv8yGxw==
X-Received: by 2002:adf:ab5d:: with SMTP id r29mr2743445wrc.158.1585130038683;
        Wed, 25 Mar 2020 02:53:58 -0700 (PDT)
Received: from ?IPv6:2a02:a451:bb78:1:1507:b7b7:10cb:873f? ([2a02:a451:bb78:1:1507:b7b7:10cb:873f])
        by smtp.gmail.com with ESMTPSA id w11sm33190044wrv.86.2020.03.25.02.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 02:53:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Wrong Version On The Website ?
From:   Anton Mladenov <anton.g.mladenov@gmail.com>
In-Reply-To: <20200325053455.GB651138@coredump.intra.peff.net>
Date:   Wed, 25 Mar 2020 10:53:57 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <701EAC93-99E2-4D7E-A991-857A7CB82E6C@gmail.com>
References: <D6C222C5-3949-43F3-A63C-24D58EAB6675@gmail.com>
 <20200325001258.GJ6499@camp.crustytoothpaste.net>
 <20200325053455.GB651138@coredump.intra.peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

@Brian - thanks for your quick email. I will use Homebrew this time.

@Jeff - thanks for your attention.

Stay home, stay safe! 
Cheers!

> On 25 Mar 2020, at 06:34, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Mar 25, 2020 at 12:12:58AM +0000, brian m. carlson wrote:
> 
>> The Mac and Windows builds linked to from the website are provided by
>> third parties.  The Git project itself only provides source releases.
>> While the Windows builds are usually released around the same time as
>> the main source releases, the Mac builds sometimes take longer, since
>> they're done by a volunteer.
>> 
>> If you're interested in the latest release, I recommend trying Homebrew,
>> as they tend to be a little more up to date.
> 
> I think the web page could do a much better job of making this clear:
> 
> - mentioning homebrew and possibly other sources on the /download/mac
>   page
> 
> - make it clear that the binary builds are provided by a 3rd party;
>   they may lag official releases (and are not themselves official; I've
>   never heard any complaints about them differing in behavior from what
>   Git devs would expect, but I don't think anybody from this list is
>   really actively paying attention to them either).
> 
> Patches welcome (we take PRs at https://github.com/git/git-scm.com).
> 
> -Peff

