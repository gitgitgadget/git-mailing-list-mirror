Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3E5C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EB260F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhIGJmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbhIGJmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 05:42:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9018C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 02:41:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so1104912wms.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZwknQFIPvjDDWegMOy4N8r+SaF+ZSsmBhGUe06hGghM=;
        b=IfJZB8E2wHssLwkIcbh98uELDX7o5fGNsE6MvLuVATGpBcSM3BJ2TTvWTh1q8zU51t
         F8dNBHn785CFEAJUmuJQCu2SizhOTbpuG/Gm72FkQLDQgpWDmjuqjI5Dwum5RjWlCOvU
         lq4wCHYtKJU8ij5fSbQP6QApj6DefPqjv34x66t/mbvk6iBzheN8sMxnJ3+I1qmh0M7X
         9C8clQcW0UJrGmJjScXR21kMySzh7qYxLlAlgeO20AW9VfNsYhFxPX9X0qe4n1d0zEbe
         9AxxjdhMpvhzJ7xyB9+rqMI957n7sHi73x56OvlNigvZTxZzdcqoUh/0p6IBm3sRcDjD
         41hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZwknQFIPvjDDWegMOy4N8r+SaF+ZSsmBhGUe06hGghM=;
        b=C2tzFC6VwbS8AjaSOdbZ7HLzehd0qhkcnT+YW8X6yNS/GuL37+lvqcGUFXT54tgem+
         Y8WlRvNhp+VSftYBzD+farqGKiYauHZRZemxsQ+jA0GVRMfjRCMgvBUmgcKpfFnZaXTS
         nc6vrU9sIh0E9bHhHtTfgNiLVaMwe85YwXfFqUOmjPHhZNDBRPkebgE7InT4mqTI2BST
         mOlTFp3A09w+LN7Edcub4TdG5asHbgGqD9O6VDVu1q43Gb/zkv/p2fCaNe1jW6sM02oP
         1DYzn/Gdbd6ooOw8DpXR2RgbMF7TKjbyaucGfcdXXNJmhhARVw+RTMvA4uMW2cbdk1Jk
         fMMg==
X-Gm-Message-State: AOAM530pTQqNx1lrOujQmNVdCckAJdDLGqbIjcdzy7XMtAPlhXToFKfJ
        whkboFB699Myx5Z/JvaazXM=
X-Google-Smtp-Source: ABdhPJyFOg5QH1jmhZwTzjmgLJ61zb2IrsR06WhLx+fij7nhW7h+c3ZssSwNX0rBJQJ0R5Nrj3ssPQ==
X-Received: by 2002:a05:600c:5102:: with SMTP id o2mr3042041wms.4.1631007695796;
        Tue, 07 Sep 2021 02:41:35 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.254])
        by smtp.gmail.com with ESMTPSA id f17sm1889689wmf.4.2021.09.07.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 02:41:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
 <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
 <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
 <87czplnxn3.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8912317f-7eb0-edae-29e3-2e05099bc696@gmail.com>
Date:   Tue, 7 Sep 2021 10:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87czplnxn3.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09/2021 23:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 06 2021, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 06/09/2021 08:05, Ævar Arnfjörð Bjarmason wrote:
>>> Remove the git_pager() function last referenced by non-test code in
>>> 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
>>> We can also remove the test for this added in 995bc22d7f8 (pager:
>>> move
>>> pager-specific setup into the build, 2016-08-04), the test that
>>> actually matters is the one added in e54c1f2d253 (pager: set LV=-c
>>> alongside LESS=FRSX, 2014-01-06) just above the removed test.
>>> I.e. we don't care if the "LESS" and "LV" variables are set by
>>> git-sh-setup anymore, no built-in uses them, we do care that pager.c
>>> sets them, which we still test for.
>>
>> git_pager() might not be documented but I think it is useful for
>> script authors and I wouldn't be surprised if someone out there is
>> using it. The same goes for peel_committish(). It does not seem like a
>> huge maintenance burden to keep and maybe document these two
>> functions.
> 
> The git_pager() and peel_committish() seem to thoroughly be in the same
> camp as the now-removed git-parse-remote.sh (see a89a2fbfccd
> (parse-remote: remove this now-unused library, 2020-11-14)) and say its
> get_remote_merge_branch(). I.e. we carried it for a while, but the
> function was never publicly documented.
> 
> I think rather than document these it makes sense to just kick that
> maintenance burden over to whoever decided they'd rely on undocumented
> shellscript functions git was shipping.
> 
> In these cases they can rather easily use the documented GIT_PAGER
> environment variable directly, 

No, they need to know to call 'git var GIT_PAGER' rather than using the 
environment variable directly to pick up core.pager and they should be 
checking whether stdout is a tty. That is why this function existed and 
we didn't just check the value of GIT_PAGER in our scripts

> and their own invocation of "git rev-parse" for peel_committish().

The reason the function exists is that you cannot just call 'git 
rev-parse $OID^{commit}' if $OID starts with :/

I'm not sure what the maintenance burden of keeping these functions is 
that makes it worth removing them

Best Wishes

Phillip

