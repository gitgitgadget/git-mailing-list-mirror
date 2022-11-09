Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC717C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKIWWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKIWWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:22:46 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B31743E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:22:45 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 7so156859ilg.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKSKKU46o4bpMplrJboUFFWZ3bGXhwW7YLdunkJ4A0M=;
        b=Uscu5KlzKTe1B0/czcHRXQI6IxKZ5wCvgd2e5scReVsnaaNlOyGn9THirV3IyIFflo
         03TjpAdxDjpP1nykHCDJUdITxosS1TL0s21fugTGuJOoV51ltExUI2x9LwtQlzqRlH9s
         5YHNZgHuMA0bmThKB2L5KusiD3r3TRmomCrj6HdQJnXFrPOUsOMx5if6us/d+fRkQKed
         SDiyjvFScV+6WUIkhfGSX8aeAk92tqWzr9Aa+Luui/kZEUB4K//02kPY2i21BSlv0nzQ
         q7xP6+lCIMa4skiI4YJCkSmRopmCM+foUG7Qvdw8poqwGNnO3CimMvSMua8+p/HLbSJ3
         3YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKSKKU46o4bpMplrJboUFFWZ3bGXhwW7YLdunkJ4A0M=;
        b=8HAqGrF9X2Vnt5Ge9W0ZobX3HHkh13nvKUtI1xUgYA/wMAy3S/+dbBonii5a/tCDJA
         D4YK8XbeYzBtI+Hewcwrcjwlf7rCkH4/LOmFn7vIURKMCqDwHudOmyVfTawMG+Czumsx
         C7+V8QwLVEHaLmcJwbK+O4ZQSKDK15ieRm+v+cvfy+v0wVVNplnd2ipaXranf5vGa+st
         t4kJncjZcGh00N4yfTDzhr48wLv9V6N90M5iooclF7NgZ+KHZVKBhNkde/r1ST0Qv5+O
         AlKdjM4RyMhHULQ76YBc+W+JZ98LhROv0cCwwyMsiYLDfxrKGqM0C2LsAkM10n7nb1Oh
         7VYw==
X-Gm-Message-State: ACrzQf0xqlzJqAjp14xc6SNJUGMddXGjLwpFPqffkI7/pauOml1E1HjL
        rb3/X7DZ1xAl3zT7xiZb7JTZcw==
X-Google-Smtp-Source: AMsMyM6VUbkxpYxgAct9n3nBVG2ErkilkLfdMgakZf3mND9OkOcMt7mSO+5aiCxR3j3VeGyWco6+Wg==
X-Received: by 2002:a05:6e02:1207:b0:300:afb8:b51e with SMTP id a7-20020a056e02120700b00300afb8b51emr29778444ilq.35.1668032565121;
        Wed, 09 Nov 2022 14:22:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e59-20020a028641000000b0037494035324sm5274969jai.48.2022.11.09.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:22:44 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:22:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] chainlint: emit line numbers alongside test
 definitions
Message-ID: <Y2woMwY2CmteZwgS@nand.local>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 04:58:31PM +0000, Eric Sunshine via GitGitGadget wrote:
> This patch series further assists the test author by displaying line numbers
> alongside the annotated test definition, thus allowing the author to jump
> directly to each problematic line.

This is really nifty. I applied it on top of your earlier series,
intentionally broke a test and got some very pleasing chainlint output
after trying to run it.

As previously, I am no expert in the chainlint code, but everything here
looks pretty reasonable to me. And certainly it works, so I'm inclined
to start merging this and the other topic down.

It would be nice to have some more familiar eyes take a look at it,
though.

> (Note to self: Fortify against Ævar's nerd-snipe blacklist evasion.)

;-).

Thanks,
Taylor
