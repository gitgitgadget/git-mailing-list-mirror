Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1066C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876C9610D1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbhIMUoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbhIMUoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 16:44:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34268C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 13:42:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t18so16680623wrb.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cskSIzGqsVqu8Xj24yeJQSpdcoWnqPhd34zOIZJm8so=;
        b=FCzW0kAl34/f7x03A4bdKfpHIS6LonBqSoBwhZP2A7CaSGRqdND72yLB+NpWUE5vFv
         Oyz3ma5RawnDXmz0kjhZ9XdoKsjIB5IHUqsVycUmdRF5PRkx3x/Zod6KuPfmJ8uPvg+k
         e/Q19lX8GOC9R0RMLa6hQZSoaRCX38NhEp/Z/3K9wBWsDK4fl7EJtmR5dflw6dT+2VZF
         fGS/O9aFvsrRzC3Uc9Yl6rmK/bChnUfCnL8+bbKysBx80ppaRpFVCA7tx6uONo0RyOGz
         ZrdKhm7H5fcOzVjxxw0CS3VZfmHuwNXIoR1FqGNQqni9jcI5XpQZbHnmg0C5++0Fm7pK
         KysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cskSIzGqsVqu8Xj24yeJQSpdcoWnqPhd34zOIZJm8so=;
        b=YFoYqt+HSVARhJVlFN2Ky8iRTnFBdRn0QvTmQf/HWCAqXMVCxfeuMOEZfGyMSwq2BS
         zndtwo3sjiS+caQ3K1ErbPJYRu/Ki2+tQg2M76jyGpdJxokcPg77LnC8C4Hp81ybq4kC
         BS8uYbswvaG4j1F9WhaeQgjFXdtrEaAxYOAOM2PGaXpIyqDYTzxrg3z10ogC+ncChBdu
         FxwA1Q6N9iuDIr8j6gtRw6Ij5XdLifaFOpGXaGFcKW5wZkhWDlUm9mAQTODsABPUrYTR
         efB9zBJeMTmC3iWGGyx/641ob6gvyDq1JuHdWcvh0YyCf7EKf8/hAW3RNzZkvVu9CPe5
         w3HQ==
X-Gm-Message-State: AOAM532ZZ+WPxoJuQMgrW+/kZG/L0fEBwWDvOXkD82vol3il87mJiu+s
        +98OODeb8uq3jrPpJNwo/S6M1P6uBtc=
X-Google-Smtp-Source: ABdhPJw0xoZ2TPdd8CTWl1jD9OwcTV5dX5biDj9zFDhJr8JrDUeXbWyGsaGthh/aS9SpKwpDy2/Zuw==
X-Received: by 2002:adf:e649:: with SMTP id b9mr14983583wrn.309.1631565763024;
        Mon, 13 Sep 2021 13:42:43 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-48-114.w92-156.abo.wanadoo.fr. [92.156.201.114])
        by smtp.gmail.com with ESMTPSA id n186sm7108412wme.31.2021.09.13.13.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:42:42 -0700 (PDT)
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20210913185941.6247-1-alban.gruin@gmail.com>
 <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
Date:   Mon, 13 Sep 2021 22:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Le 13/09/2021 à 21:26, Eric Sunshine a écrit :
> On Mon, Sep 13, 2021 at 3:14 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>> This adds the --recursive option, an alias of --recurse-submodule, to
>> git-clone's manual page.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>> I found this out when a friend told me he could not remember how to
>> fetch submodules with git-clone, and when another one suggested
>> `--recurse-submodule'.  I checked the man page, and I was surprised to
>> find out that `--recursive' is not mentionned at all.
>>
>> I did not modify the synopsis.  So, this alias, although shorter than
>> the "real" option, would still be somewhat hidden in the man page.
> 
> Considering that the `--recursive` option was intentionally removed
> from `git-clone.txt` by bb62e0a99f (clone: teach --recurse-submodules
> to optionally take a pathspec, 2017-03-17), it's not clear that this
> change helps the situation.
> 

The patch you mention also hides --recursive from the option array, but
that was reverted with 5c387428f1 (parse-options: don't emit "ambiguous
option" for aliases, 2019-04-29).  The option should be re-hidden, or
even removed.

Alban

