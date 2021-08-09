Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0396C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4ABE61055
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhHIHhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhHIHhN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 03:37:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D7C0613CF
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 00:36:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so948451pjb.0
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=vuonV9gI6u+DcvSJVWyvbm6jQFOZgrW9hzZq4HtnMeA=;
        b=Bg/mJyQh3HFIhKZCZEqBXo/+w7UzD1IUXFWvBhYffOjcKapPCIGF1+VrUAL3/QrUu2
         mHOCTidTdALDt7+30RDz1Sr5NMs+Kq7pQLe3523U+2A+YAxkWX4lbcOHZlDHAjEC3EsK
         91QRfuFcyY3+mzCAoGcjGh2J6VoiJ5uXHLVs9zQm7CTXNlcPzy7elqP1XcLON0aLYtjq
         kASRj/bG/52/JvUKg1XYjWiA79SsiS2okOK4QhfldgDGZ/w8lYgKkOpytDMIIezqnaJx
         aELZes5094JnmUcj03lvij3bQozWrGV/EDYHxkD/VspQRcYJZjps0/gJqKl/x7KcUysl
         /dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=vuonV9gI6u+DcvSJVWyvbm6jQFOZgrW9hzZq4HtnMeA=;
        b=f/vJDX1Ct/fKQkLap0RE3JVPQOrPMBHQrMKKs+rCaNkeEDLxZlgfR6Ygk4ML0Pd6J2
         ZP1JVO5k8+Ltji8wOeyM/vKhIdeH8BKbohjzcldducrkstRUO/TcYFiEudaGmhcAP3lN
         yCu3Su1MMYqI4KBEPeczQPLTEXvKgxKMmR+nAYUsqU7BwgTcP0o5piTuJ2dlqUpga9Zl
         HeoQyMus7U1zzpeD8JWOeI3OwYjzdcCKA/JYmMNzZ3vxGrxULrRuI8tqz0Ibi0Q6nBbY
         WPafKSrotHWVC4HKCLhvrw05CPdgpSW6lJGoRmBwYp2WkiM0XIYsqg2Exug/6gX00veC
         4SGg==
X-Gm-Message-State: AOAM531N4pR9U3HwspayKE1kH/jAgdunCLgnibe1wmJGb4U/biQ+WXWm
        646uQ0pqtjjk0ghxvBsdd18=
X-Google-Smtp-Source: ABdhPJwxbshy50g4D9XMh0qMgMNp+wv6yOyYhVCB4KyMlA25e2ldfhdXIelTMRyysdgr/Xsy1ja+oQ==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr33374876pjh.135.1628494613358;
        Mon, 09 Aug 2021 00:36:53 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id r18sm24016515pgk.54.2021.08.09.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:36:53 -0700 (PDT)
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-4-raykar.ath@gmail.com>
 <d37adee0-8636-548b-c581-16eaa417a05c@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 3/8] submodule--helper: remove repeated code
 in sync_submodule()
In-reply-to: <d37adee0-8636-548b-c581-16eaa417a05c@gmail.com>
Message-ID: <m24kbzax2o.fsf@gmail.com>
Date:   Mon, 09 Aug 2021 13:06:47 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>> This part of `sync_submodule()` is doing the same thing that
>> `compute_submodule_clone_url()` is doing. Let's reuse that helper here.
>>
>
> Nice to see more code redundancy being removed. Now that we're using
> 'compute_submodule_clone_url' in multiple places, I'm starting to
> wonder if the name still suits the helper. Yeah, I just started yet
> another naming discussion ;-) I guess this one wouldn't be tough though.
> It feels to me like 'resolve_relative_url' is a good enough name that
> doesn't mislead readers by having 'clone_url' in its name. In case anyone
> else has better name suggestions, they are indeed very welcome to suggest
> those :-)
>
> Once there's agreement on a particular name, I think the helper function
> could be renamed. Possibly in a new patch next to this one.

I don't mind the rename back to resolve_relative_url(), although it
definitely has to come in a separate patch. I didn't want to create a
situation where readers will be confused about what actually happened
with that function. I felt a thing might happen if I repurpose it from
subcommand to internal helper in the same patch.

>> Note that this change adds a small overhead where we allocate and free
>> the 'remote' twice, but that is a small price to pay for the higher
>> level of abstraction we get.
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <periperidip@gmail.com>
>> ---
>>   builtin/submodule--helper.c | 16 +++-------------
>>   1 file changed, 3 insertions(+), 13 deletions(-)
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f4b496bac6..9b676c12f8 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
>>   	if (sub && sub->url) {
>>   		if (starts_with_dot_dot_slash(sub->url) ||
>>   		    starts_with_dot_slash(sub->url)) {
>> -			char *remote_url, *up_path;
>> -			char *remote = get_default_remote();
>> -			strbuf_addf(&sb, "remote.%s.url", remote);
>> -
>> -			if (git_config_get_string(sb.buf, &remote_url))
>> -				remote_url = xgetcwd();
>> -
>> -			up_path = get_up_path(path);
>> -			sub_origin_url = relative_url(remote_url, sub->url, up_path);
>> -			super_config_url = relative_url(remote_url, sub->url, NULL);
>> -
>> -			free(remote);
>> +			char *up_path = get_up_path(path);
>> +			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
>> +			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
>>   			free(up_path);
>> -			free(remote_url);
>>   		} else {
>>   			sub_origin_url = xstrdup(sub->url);
>>   			super_config_url = xstrdup(sub->url);
>>
