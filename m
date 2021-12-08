Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47527C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhLHSVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhLHSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 13:21:16 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56BC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 10:17:44 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b67so2758250qkg.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tXKfMeb4mA0/vO8zFkR4+bQl/PdJPIWAlOG3GcbeZug=;
        b=D6qOcfsoAnXD3iVYNciVxCFONArniOKVX5O1ipGuAxqsYcIcfD9fX/3sxyJGXN9oM7
         xYXJ6CVoDs0+XBPb493rez/5+5otP63Id5jTHX6ZgOF/Qm+tyOr0AGyRDiHnGhIVSFcB
         rOj2feFg6GrwT1jpTFvi5NtM7R1XQzO8P6h0KrT1H8LSn6mlMcm8Hx4FCQvTD2pxNVq7
         ahH8+z0071U6rcYjD/41FEnlexSe8NR1ccxhm5MnRpBxMaNSYaVM44N+v1jvgP+XxVHE
         lDzOuPwym0kCq99x6o1oha+HAaGqGE9ACuwb9rvlOs/CZDOdWE4zhvIT+VEFY8zzLt8z
         +ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tXKfMeb4mA0/vO8zFkR4+bQl/PdJPIWAlOG3GcbeZug=;
        b=i/IpTvNVuMUd3hPFtZ/07padA8u5avTq3H4i+vZ0pk3M/NRKZxu5OxbB8X2LFL1cMf
         tA3xsev8SZWFfXLCEJddz0lAVeO2cqhE8Sbvc7OmSX6zPOi9USYSqgGT6apohvfwhmOL
         O1ZgKy+958hkt0284l+sRBwYkALOgIuGMBWTF35ltEayOKt+np5Wu3pd9x2W+L4kJuaT
         G1bETHV32Pc2EO3/BDweTSq/AekQAGAHLbmnSZyBm5/xGzO7SF+CKdJFj32GUPrIjSGU
         H5nQqNMHNtIrsJcbL0yR+BU8Xnr94SxGpaVAHr9QJRYXABg/RfNCB4vcuWSpl+Nu926d
         3lvw==
X-Gm-Message-State: AOAM530Hy+fSoH3ba8MxPissDebakeXvbvdTOcEq/GGBxilkXOlAaFs6
        AiI16kz6HiMWiqoNnrtExic=
X-Google-Smtp-Source: ABdhPJxzs41F+/ugx11p+LYiTu587uTPVS0KmLCvWP/C1ghN4yxxX6vWsWfBrccN3qYluydj+B7YpQ==
X-Received: by 2002:a05:620a:199f:: with SMTP id bm31mr7812229qkb.450.1638987463482;
        Wed, 08 Dec 2021 10:17:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id j22sm1881677qko.68.2021.12.08.10.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:17:43 -0800 (PST)
Message-ID: <569fded7-48d7-6f48-47fb-b78c403214fc@gmail.com>
Date:   Wed, 8 Dec 2021 13:17:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
Content-Language: en-US
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com>
 <CAFQ2z_PmwLKC2Y39yj2Cqk=FMGC4gJTgZUEFOmgC=wE2KmdTfQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAFQ2z_PmwLKC2Y39yj2Cqk=FMGC4gJTgZUEFOmgC=wE2KmdTfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 9:48 AM, Han-Wen Nienhuys wrote:
> On Wed, Dec 8, 2021 at 3:35 PM Derrick Stolee <stolee@gmail.com> wrote:
>> This is a HUGE diff, especially compared to the previous changes
>> in this series. I recommend splitting this out into its own series
>> and finding a way to break it down into smaller changes.
> 
> Would you have a suggestion how? The reftable_record type is used
> across the reftable library, so if we change its definition, that
> impacts most callsites.
 
Looking at the diff, I'm seeing a lot of things that don't seem
necessary to changing the struct, like renaming "reftable_new_record"
to "reftable_record_for". Yes, the implementation changes, but that
implementation is related to the struct changing and can be done in
a more isolated way.

Some things can be split out easier, such as the addition of
"uint8_t type" into the struct and replacing all reftable_record_type()
calls with <var>.type.

The big one is definitely the addition of a union, but it could be
done in a way that only changes the implementation of methods with
names such as reftable_record_from_obj() then we can replace those with
"<var>.obj" later.

Some of these changes are definitely going to have a lot of lines,
but when it's the same kind of change it is easy to verify. I'm
getting lost in this diff because it's doing too many things at once.

Thanks,
-Stolee
