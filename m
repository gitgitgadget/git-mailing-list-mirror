Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68857C4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 13:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbiK3NCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiK3NB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 08:01:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A0286A0F
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:01:16 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so26821047lfu.11
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 05:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KQjg0sHff2WZWnQf18hPZ1u1GrkB3WrGZKTuZfgv4z0=;
        b=KnYfyWTDIPfdhByWUbumorBKrNRlkewUHRPI/QzJQsVzTUtemvC/i+9FgWPE3nYjRc
         3ffljhAzMhdvw8+9kAoVKgWL0n4Oy7PYCtyEqUPf7+VQ+vD6uZXwj3G7VBozz/FI3mIq
         p6AVwKw/ECHmz4qh3f44hqpvJjxduOCvrjF6AU5AbPRtpc88ayCYbLO7/Hlp+ZMofJbW
         GmRr7nTRktXmvlfU5OAsfWN4jlWfW8w8airBL/tTsaQFIuxHrmOwCXqbO733kExa9rTI
         0mJVa30Y05Lx2ANKAxt0aioT2Jk0LFUC5VFTJw1+IHpqF9qdZa4pMRwC2GnyP/yTXxCj
         V9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQjg0sHff2WZWnQf18hPZ1u1GrkB3WrGZKTuZfgv4z0=;
        b=mZPcD+r1SsY3umWltwZCxeNJFhfWjmYCEq6SepyQru8ceGrRlIvdEz6RYWcZhTglEP
         AA7b3WzXWg21OEkz0cTAscf9JhL+q4C+G1aEqV0oXV7VedB31Yu2yvKnTMBoV+q7uzm2
         wj/ysSE88DIvucQaoPhO5p5HeRdTXes+tKVmvgIx1HXalG55DPYtUc0+iodlyTXDraDj
         73iiHNV/cKXRo6tpSdQAlU0tpWvQJEADIuWfj70cfV+XuyR5PDo8UsCG6eD5QiL/Io8T
         zrdUGLmK2IBW2BdBibwIJd3XOzbjV9OrpyHzhkb8/F9HKX0505331a8wyvNOQ5t/rCzH
         uJqA==
X-Gm-Message-State: ANoB5pl4CVAE4U8ZyQeG/akpMXI6WbMTvbtHoNTqNOf/i22H10h72vxf
        lMpnzR1bDnWVglnzbIUA/M30qrp1w6w=
X-Google-Smtp-Source: AA0mqf5yD3zBKQATsd6ivYN/wq1yaiz3EvUC/D7iXlRUTvKCMDWtTBFrftZDwCVb5SCOPq7YE0fwzQ==
X-Received: by 2002:ac2:4855:0:b0:4a2:25b5:a2aa with SMTP id 21-20020ac24855000000b004a225b5a2aamr23129662lfy.531.1669813274475;
        Wed, 30 Nov 2022 05:01:14 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s10-20020a2eb8ca000000b00277534851a6sm124250ljp.63.2022.11.30.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:01:13 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <xmqqedtn957j.fsf@gitster.g> <8735a3gmuq.fsf@osv.gnss.ru>
        <xmqqbkop3hjb.fsf@gitster.g>
        <221129.86tu2hiqre.gmgdl@evledraar.gmail.com>
Date:   Wed, 30 Nov 2022 16:01:12 +0300
In-Reply-To: <221129.86tu2hiqre.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 29 Nov 2022 18:59:37 +0100")
Message-ID: <87v8mwtx47.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 30 2022, Junio C Hamano wrote:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Sergey Organov <sorganov@gmail.com> writes:
>>>>
>>>>> +	if (set_func != NULL) {
>>>>
>>>> Please write it like so:
>>>>
>>>> 	if (set_func) {
>>>
>>> OK, will do.
>>>
>>>>
>>>> I am not reviewing any new feature topic during -rc period (yet),
>>>> but this triggered CI failure at the tip of 'seen', so.
>>>
>>> Thanks! Do we now have tool for auto-check for these issues? I still use
>>> one from Linux kernel, and it didn't object to this form.
>>
>> I noticed it when I pushed to GitHub, which ran the CI ;-)
>>
>> If you have your own fork at GitHub of https://github.com/git/git/, I
>> think preparing a pull request against it triggers the CI.
>
> ...in this case though there's no reason to wait for the glacially slow
> GitHub CI. You just need spatch installed and:
>
> 	make coccicheck
>
> Sergey: If you've hacked on the (I'm assuming linux) kernel you likely
> have that installed already, they use it too (being the canonical and I
> believe original use-case for it).

Thanks a lot! I'll definitely give it a try even though I didn't use it
while hacking on the Linux kernel.

-- Sergey Organov
