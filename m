Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75AC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 10:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38675207C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 10:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5Q82lgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgFIKgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgFIKgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 06:36:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED6C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 03:36:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k26so2574417wmi.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JTLKPa5kScxiOln2Kh/r74XyK9uyU7L2K+A6l1mAhC8=;
        b=o5Q82lgIBKywphkD/8Rwmpw17aX6uDRtcHBf0Wi3QevBers+pUtepXFQloaqBA3Xs3
         chfvm4pU+cOD1FMdaP3d2VZYPkzmBRhojCEH/ewd6J0e/ZElWGkpWBaHbt9DOTwrepug
         pnKxIWM4LoebhDG5DKCWeGUQh4mijFMZ7Hno2ds7vk1YoTsaKw28XbFob37LPPjFBmu0
         5AC1B94R1A5C6Y1RCxu/fodk1yVBOpiL7/GgqVXYaL6X2Kr+gB0ejb+i2phKmI8OO4b/
         SLD1rKyehw1YuKU79gUOIVwY0/UsKE5EPqoFZx3h5Tkg406ILOmoUZRtzVhRSmr6AyoY
         +cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTLKPa5kScxiOln2Kh/r74XyK9uyU7L2K+A6l1mAhC8=;
        b=jPcFyGINQjD+hM2ydNoGNtVYx0/fZ6sZRIvt1H/bwUeLZS4eurEK7BnyJgRe0MYFGB
         TyclFn6i3sIamGOPNxOH3nbVmezLt7bDQ2va6bIdA3rwK0/MFAJXzjQYzYySewFgdWsU
         qQ7fnMQWX+uCWX9VXcOiG9Fo1B0FS/G0Rk0fABgz7pEmEyYf7m4Yi5Db9bAPIQ309VmW
         CAQri5mY6Z9Xbe5SvuhXno5sMRL+USTlXCR2Q5XS9cTcunu/kZsV12g6z5dTQaPsYJrO
         qjFPiDrnOG30fcgzq8cgePw9Vaa/NTreICChuSBRW4t0IwiGB/TfeMzZIeZAnW0E/NH4
         VddQ==
X-Gm-Message-State: AOAM530KcpCpRrl+Fgdn9l8pi8/ygeEsUWEsL6bawlleNKINJIJ4oPgt
        gcr50/oe4wulXnjRA4wOG7pCgby5
X-Google-Smtp-Source: ABdhPJwRi/J6/vfw0CStw8BDP6zyMHr3k4sGG8FJnWZu5oQbNYkAHLxrUbfZbbKzKRVcBBh4wPU1Nw==
X-Received: by 2002:a1c:28c5:: with SMTP id o188mr3211029wmo.62.1591698977362;
        Tue, 09 Jun 2020 03:36:17 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id c6sm2899026wro.92.2020.06.09.03.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:36:16 -0700 (PDT)
Subject: Re: [PATCH v16 02/14] Make refs_ref_exists public
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com>
Date:   Tue, 9 Jun 2020 11:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06/2020 19:03, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 2 +-
>  refs.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index 12908066b13..812fee47108 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
>  	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
>  }
>  
> -static int refs_ref_exists(struct ref_store *refs, const char *refname)
> +int refs_ref_exists(struct ref_store *refs, const char *refname)
>  {
>  	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
>  }

It is a shame that ref_exists() does not take a struct repository. The
code in the following patches would be pleasanter if we could write
    ref_exists(r, ref)
rather than
    refs_ref_exists(get_main_ref_store(r), ref)
all the time

Maybe we should think about updating the existing callers to
ref_exists() to pass a struct repository.

The existing code is inconsistent about its repository handling - we
create the refs with update_ref() which operates on the main repository
but when checking their existence and deleting them we use a path which
depends on the repository. I've realized now the answer to my question
about using delete_ref() in my reply to the previous patch - it does not
take a repository - maybe it should along with update_ref() but that
might be more work than you want to do though.

Best Wishes

Phillip

> diff --git a/refs.h b/refs.h
> index 4dad8f24914..7aaa1226551 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
>  				  const struct string_list *skip,
>  				  struct strbuf *err);
>  
> +int refs_ref_exists(struct ref_store *refs, const char *refname);
> +
>  int ref_exists(const char *refname);
>  
>  int should_autocreate_reflog(const char *refname);
> 

