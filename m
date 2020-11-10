Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF52C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4A6206A1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="VdAQsv5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgKJOVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgKJOVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 09:21:20 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095EAC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 06:21:20 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so8944683pfd.7
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QHJK9QsLCOwjVxT+UXjaJZjb653B+pBciji8IatZ2ho=;
        b=VdAQsv5zuDBYE72DQPREg/mVDYoomVd3FW7xeKbzVIy8hM7bGymyIMeS3l6eyPrYcv
         Q6Z51+Q/lsn/nd7aFX5iSEYRhmoGJ391d7uMrCmlgXZo2OaQaPUKR6l8VP73wx1Cw5SO
         SDyCLnB7AjXFdB21Rc8gmYqkSIQ8EeqabRGowsDVkNSjHbYO8OKvmGcFA177aNQOJeQH
         IbHO+WmgE3axTvBrvLZQbhdOZ6IWsEeFIrltgBoGlkKIkN98DgJBi9lCEyn81xaS3jbN
         GQ9c9gycQJE7IBGPmELSlXV8FZVrx8HKFsrAHfauV2RRFIS0hrjtB2O9yTE6pLPW3bJf
         eG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QHJK9QsLCOwjVxT+UXjaJZjb653B+pBciji8IatZ2ho=;
        b=PTkK4GHZrp7M24W30Hi2XGT0aQcF7oBPzTBhCYY4YmUSIMGS05+XkasluCcRc6fPdj
         eIvVWcTvU48ugpsema67AA/cU8uUZ3ONxojvl0v/MI4BU9VBnL8oc9Kxl0Eu+Pa1qrGH
         4nFdPLy1PeEdYQ7/OAaFLpy0yyPiKgmcs7pB3lusMpOMvBTWJzc5l9JgPiZhBsBQBNPC
         auzH2J+K95eiiHYJMHnJDAqB004wcSx1LSJ0eMvemgugsC3Rt5zw2fcj1AXeAKUG+Unk
         +QuN0LbrJEu5RGs8i5CMimvWzexyIoxOCF6SL+SAQgYGfcnsvm9Ud+Oqn91sHQHIpYoM
         ZUOw==
X-Gm-Message-State: AOAM533/01eobtJYC+0UAut6dt4CgjRGY79I53BvJOuSHlvyxz1ZZJz/
        aYoJ4d1WLrUJv+1mQr250LJ+r6j3FT9LLg==
X-Google-Smtp-Source: ABdhPJzbBdEorpaLWxqllzUmji+C0dAABlw6AErQL2nwwpCAr0hYCFReNAVue9Oa/nPnXHp9DokU+g==
X-Received: by 2002:a63:79c2:: with SMTP id u185mr17211266pgc.280.1605018079241;
        Tue, 10 Nov 2020 06:21:19 -0800 (PST)
Received: from [127.0.0.1] ([222.99.114.187])
        by smtp.gmail.com with ESMTPSA id d18sm4783452pgm.68.2020.11.10.06.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:21:18 -0800 (PST)
Subject: Re: [PATCH v3] diff: make diff_free_filespec_data accept NULL
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
 <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
 <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
 <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
From:   Jinoh Kang <luke1337@theori.io>
Message-ID: <406549bb-1ab6-eb8a-7383-4715666071f9@theori.io>
Date:   Tue, 10 Nov 2020 14:21:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011101257540.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/20 1:16 PM, Jinoh Kang wrote:
> On 11/10/20 12:08 PM, Johannes Schindelin wrote:
>> I am unaware of any other commit having a `Fixes:` trailer in the commit
>> message. In any case, I would have expected `Fixes:` to mention a ticket
>> or a bug report, not the commit that fixed _a separate_ issue (but
>> unfortunately introduced this regression).
> 
> Sorry for this one; somehow I didn't notice that git and linux use
> different conventions.
> 

After leaving it out, I realized there are actually five commits using
"Fixes: <commit>":

    $ git log --oneline --grep='Fixes: [0-9a-f]\{8,\} (".*")' master
    e2bfa50ac3 pack-write/docs: update regarding pack naming
    7328482253 repack: disable bitmaps-by-default if .keep files exist
    ba3a08ca0e fsck: fix leak when traversing trees
    5cae73d5d2 http: release strbuf on disabled alternates
    c22f620205 xread: retry after poll on EAGAIN/EWOULDBLOCK

Since it's not that common, I guess it's fine to leave it as is?

-- 
Jinoh Kang
Theori
