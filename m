Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE10EB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjGNKIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjGNKIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 06:08:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C51989
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:08:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so16763085e9.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689329308; x=1691921308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SOotzPUjsZHsomMSE2T0OqRo6SJKpKAB84Z3w2Oxhc=;
        b=P3h/CrvT+fthCk68EdHWYMTJbk12wbF315YaKHj/s1Vx1y8+RAXgpC5zwsOe+vCJad
         KNth+f+65EjMtJWrcet25KcKzAkE30ueS+et0g40FbtH07aSgzVWoEFp5fVudz/ZOnFi
         7VuyGoUV9ZO712U37C5qwS0QAoD9I55xs+CkVbtS2aBcQlwICBvT0PeShzymKzDbisJF
         jMAhjdZQQtpT3hxB1fX6klGWiaNK9G/2LQ9KXwNUpPrCoVwmcuvppiWx6zqqd5vSuWVw
         dLZkOIvKHz+AdaroNV2s3Mu65/q4l43HysLeQVDP7MDPHoV/51B+yG6uyCo+zAqwRitk
         F6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329308; x=1691921308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SOotzPUjsZHsomMSE2T0OqRo6SJKpKAB84Z3w2Oxhc=;
        b=OvZF4Tld6W95fm1l1OgtUUjHl5KIE2mbBwhHjOysUFbKOgzQF07mrRxhdc0l634GAj
         1GzHMoyVjv8BS0i6+Tk3l8u0NuDdR3joBDBQMFLypob2Ge2STN+ZWtAwJ9o2/Y9Tq/ao
         +uFbG6D78ga0z5RaDZ3RuvAIx7YTd/MrWkz4Eo6sXiLtDdmX3bSvRM0EQqVGXG7KPhUd
         Znfh4fKFwLPUYyRKgjv1HCqYyZ/6oEJO5HIQJpDcJwyCbtSDwsuuLXCW/Hru9F7nDW4t
         Rq+XBBtocURBMkW7IrH8KgYv1M3mx/Y2+nNE2fEztNZGobs7uL5C98edN9q3He74qHXU
         J/Cw==
X-Gm-Message-State: ABy/qLZ+/KmsDY2bFcGiD7IHk8mKUFtnvJyhm9k0st0VulX6SgUJ0wh3
        OszwCCDBfSLejM7YPhesFmQ=
X-Google-Smtp-Source: APBJJlG10wX3CGhLjv0iHnpJkUP/aMdFNdG4d586SOgeQrFksDoXQth6nVPbqA9AUY6Qb1K11TmSUg==
X-Received: by 2002:a1c:4b0b:0:b0:3fa:8519:d323 with SMTP id y11-20020a1c4b0b000000b003fa8519d323mr4376749wma.5.1689329307726;
        Fri, 14 Jul 2023 03:08:27 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id q8-20020a1ce908000000b003fc02a410d0sm1038255wmc.48.2023.07.14.03.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:08:27 -0700 (PDT)
Message-ID: <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com>
Date:   Fri, 14 Jul 2023 11:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict
 resolution
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
 <kl6lsfakr2sr.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lsfakr2sr.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/2023 21:14, Glen Choo wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -3490,7 +3495,6 @@ static int make_patch(struct repository *r,
>>   		return -1;
>>   	res |= write_rebase_head(&commit->object.oid);
>>   
>> -	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>>   	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
>>   	repo_init_revisions(r, &log_tree_opt, NULL);
>>   	log_tree_opt.abbrev = 0;
> 
> I was checking to see if we could remove buf or whether we are reusing
> it for unrelated reasons (which is a common Git-ism). We can't remove it
> because we reuse it, however...

I had a look at that and we're using it to construct a path that we 
should obtain by calling rebase_path_message() - I'll add a fix when I 
re-roll.

>> @@ -3498,7 +3502,7 @@ static int make_patch(struct repository *r,
>>   	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
>>   	log_tree_opt.disable_stdin = 1;
>>   	log_tree_opt.no_commit_id = 1;
>> -	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
>> +	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
>>   	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
>>   	if (!log_tree_opt.diffopt.file)
>>   		res |= error_errno(_("could not open '%s'"), buf.buf);
> 
> this buf.buf was supposed to be the value we populated earlier - this
> should be rebase_path_patch() instead.

Oh, well spotted, thanks for pointing that out.

> As an aside, I have a mild distaste the Git-ism of reusing "struct
> strbuf buf" - using a variable for just a single purpose and naming it
> as such makes these sorts of errors much easier to spot. That isn't
> something we need to fix here, I'm just venting a little :)

I agree it can get confusing. We occasionally forget to call 
strbuf_reset() before reusing the buffer (my first contribution to git 
fixed such a case in 4ab867b8fc8 (rebase -i: fix reflog message, 
2017-05-18)), or forget to remove a call to reset the buffer that is 
no-longer necessary when refactoring. However it does save quite a few 
calls to malloc()/free() in the rebase/sequencer code.

Best Wishes

Phillip
