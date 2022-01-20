Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B2C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 23:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbiATXPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbiATXPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 18:15:40 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65927C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 15:15:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id i8-20020a17090a718800b001b35ee7ac29so5010420pjk.3
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 15:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BzNxGeTADBLClXFhbR9lY/PsXyNmLf2v1CRHH/jg0Tw=;
        b=TAtBaHEgBY7hrFnNzetUidjvAo/ojklWDtC2CJZNgAyQKICDa18pqL4mNJu7G/wrKz
         uIAmgTfSj1aYySTuQPMtNbGRPUDpsGxt4WoWbcvLBrecoCaxlXmiVyYeiYRruzaTZYx7
         GhOxRbi1AA7ZNx52CTMGplsFJxE4KOm2R6aReO3eqdCEnGV+1UgcQwKhePG4uA6FmG1T
         vTDp0C58UWM/9TcJyawICTfRbipVjCRhge4ARxQ8Yn6n3hQvcOGhBipSRgHw4mIK8MuP
         vzQanoxvaeAF2ZnwPFIeRcAhi/mFwSkZQF8jeT75BmfOY4HZh/VSs55RozIDF1qf/Huv
         lIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BzNxGeTADBLClXFhbR9lY/PsXyNmLf2v1CRHH/jg0Tw=;
        b=hpu4EAupkOv5iSCbfrPkTtUuOvupwvwhef45yXJhjx59zk+x4pqFy6Z4ZaAy5Wr+cV
         GWYQnPIJMODO225zmVQtHlHysDGlcvaCRPB+ZyoOVUStzDLXKmDZQyaGGqUSaRxe68ux
         S5qIR55TObkPalLh5XGmFYo1DbZezhhRmcf/Alu07fQuR9pW8tL8xqZ1QGV8WYs7D/iX
         cKBMDHJdPO9MuH2jZhFYKgMorPYM2wPWfgjha42YJhtB06j8ucqfjJelZQ7OvKz7dYJE
         kSaHz6JJW+Q/oIazvtVyhs85MCQduuLzl1JCgdOnT5vdhN+U5LyUCGCX/oitCr5u9hHA
         Q3yw==
X-Gm-Message-State: AOAM5308cqzzx/k/k+vxuzqYiv2sXtkvYBGKmLB60eB15xYQULrl7IIt
        Leb3znj7QzMN43OWeONdfdO1iJ5I9Jq5fw==
X-Google-Smtp-Source: ABdhPJy7UevDxv6Z+3GF4EDLpDOmMB9eez/qnAdkvqjyJANdx/SNfCJXAjoobD7NLDgoV67SULERfiUckKed5g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:2e17:: with SMTP id
 q23mr13716870pjd.115.1642720539704; Thu, 20 Jan 2022 15:15:39 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:15:30 -0800
In-Reply-To: <xmqqk0eugjcc.fsf_-_@gitster.g>
Message-Id: <kl6lee52xalp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com> <20220120174942.94231-1-chooglen@google.com>
 <xmqqk0eugjcc.fsf_-_@gitster.g>
Subject: Re: Re* [PATCH v7 0/3] fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Changes since v6:
>> * use standard message format introduced in 246cac8505 (i18n: turn even
>>   more messages into "cannot be used together" ones, 2022-01-05) (thanks
>>   Jiang Xin!)
>
> As v6 is already in 'next' since yesterday, let's make it an
> incremental update.  It would give us a place to spell out why we
> consider this change is desirable.

Ah, yes. I will take note of this for the future.

>
> This is a tangent, but I recall there was a talk about "reviewer
> checklist".  Things like:
>
>  - check if we can reuse existing and identical message to reduce
>    load on translators
>
>  - when we are creating a file in a subdirectory of $GIT_DIR, be
>    prepared to see any directories other than $GIT_DIR itself
>    missing and create them as necessary
>
>  - use safe_create_leading_directories() and adjust_shared_perm() on
>    things under $GIT_DIR but not in the working tree
>
>
> may belong there.
>
> I am not sure if it is feasible to create and maintain such a list,
> though.

This sounds like a combination of low-hanging fruit things to check when
submitting/reviewing. I think that even a minimal list is preferable to
the toil of spotting and fixing the same mistakes over and over.

A ReviewingPatches doc has been discussed internally for a while, but I
don't recall if this checklist was part of it.

> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] fetch: help translators by reusing the same message template
>
> Follow the example set by 12909b6b (i18n: turn "options are
> incompatible" into "cannot be used together", 2022-01-05) and use
> the same message string to reduce the need for translation.
>
> Reported-by: Jiang Xin <worldhello.net@gmail.com>
> Helped-by: Glen Choo <chooglen@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/fetch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/builtin/fetch.c w/builtin/fetch.c
> index dc6e637428..5c329f9835 100644
> --- c/builtin/fetch.c
> +++ w/builtin/fetch.c
> @@ -2014,7 +2014,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			break;
>  
>  		default:
> -			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--negotiate-only", "--recurse-submodules");
>  		}
>  	}
>  

The diff looks good. Thanks!
