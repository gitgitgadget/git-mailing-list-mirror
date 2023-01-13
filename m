Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6205CC3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjAMRte (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAMRsy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:48:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660608B51B
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:40:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so27699403pjj.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtsiyRycO6jtQnDyqkThi2xVLjSQij+a6CsQwLRlUhI=;
        b=RK00SPfBWPz5Dx9vv4/QdC0AhPL5EAS6vEsNKpjnKtHngKOcLWRNkaCOjaQHlcPywa
         9eZ3c4IMrR1KEbZ2hIT1ultg0LfG4kdhYceZx8yIj7ATFt8oAJy2lfuJGiuOrimcvJy5
         s8AzWrWmPBG6lH3vDTvHOF/7CoAZBbOQKjdk7MhDciTigeZTUSEeAZKx9SM7YVysRAhH
         te11PsYbarsI8SBEoUKi6LoMP9/uzCHQgOVXQYBV4z9IXkTzwozLG7sUp10LI5WtwGXe
         ofscbgS5yTt28GSyW3e1Ya9sajqkq352qFDEhzCdbj/MFvpeVHqG/eM1l3d6Wc4ziHB6
         jnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtsiyRycO6jtQnDyqkThi2xVLjSQij+a6CsQwLRlUhI=;
        b=1XVtu1t8yOdoYAOBPweegjg54ma++q7v4hVg63zZV4qQ0aarQOJPGWFodI4wCaPYJD
         1YFvSlS4VzoQNXNG5lpMcUtkwPGNX40JOfZZq3ogiRW8ymIg1bfKyDQ9iuY3bDJIQJt9
         dIQOZHDulucHgyyiriZV2VgHCPQCLktaEYMYWGUFRURICZOtay1QYGB+/ZGnHsAx+VSV
         fqpQlpRAp7jB7C/bz/IvqTe/wPsGlykqB8k4Et5pruhNS4eNBKeATBXn7CuUUcC5iQQj
         SXyo+AhUEg+XFl0K0jZ7lv3pJsafHV7QuefhtgLlyKbcOc0AXUZkiIdvN+JxRXfLopCa
         tlXg==
X-Gm-Message-State: AFqh2kqCNfO2VVqBTTIO0bn9slzLiaUMUQ1HYbDIq2JDTjrTuP43kD3n
        iIUUJxOy+IFBINo2jlpTZVo=
X-Google-Smtp-Source: AMrXdXvZxjKgPjeH5haDLdJeMIxS38bCjYHT6r+0CJoc8Pto98+uin0MAULHHFTEEt4d9Qz/kw3Y3Q==
X-Received: by 2002:a05:6a20:aa9f:b0:a3:7d0b:5dcb with SMTP id ck31-20020a056a20aa9f00b000a37d0b5dcbmr12153220pzb.15.1673631616744;
        Fri, 13 Jan 2023 09:40:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c10-20020a63d14a000000b004468cb97c01sm11916987pgj.56.2023.01.13.09.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:40:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] object-file: fix indent-with-space
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
        <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
        <230112.86k01s2jzm.gmgdl@evledraar.gmail.com>
        <Y8AwGdtrsjnBdXN7@coredump.intra.peff.net>
        <230112.864jsv20r2.gmgdl@evledraar.gmail.com>
Date:   Fri, 13 Jan 2023 09:40:16 -0800
In-Reply-To: <230112.864jsv20r2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 12 Jan 2023 17:08:35 +0100")
Message-ID: <xmqqsfge49kv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> diff --git a/object-file.c b/object-file.c
>> index 80b08fc389..ce9efae994 100644
>> --- a/object-file.c
>> +++ b/object-file.c
>> @@ -1708,7 +1708,7 @@ void *repo_read_object_file(struct repository *r,
>>  	oi.sizep = size;
>>  	oi.contentp = &data;
>>  	if (oid_object_info_extended(r, oid, &oi, flags))
>> -	    return NULL;
>> +		return NULL;
>>  
>>  	return data;
>>  }

Thanks, both, for being extra careful.

> Thanks, I didn't notice (assuming it was too soon, it being less than a
> week) that it was in "next" already. This change LGTM, thanks!

It would be surprising if an ordinary topic goes to 'master' without
spending a week in 'next', but it is something I aim to merge a
reasonably well-done topic down to 'next' from 'seen' with minimum
amount of time.  Here minimum usually means 1 wallclock day, just to
catch silly typos, if the patches are reviewed adequately on list by
folks (or possibly by me).

Thanks.
