Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3244BC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 16:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiEUQu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiEUQuy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 12:50:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD6AE43
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:50:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh17so7716297ejc.6
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IDm7o5qShhiarlTi1RJ1f7Empdp4iZoHD3qNrssmpRE=;
        b=OlLD8tma4WtoGnHl5rpzUKUdKEyhI8cddouiML9RKvYSxID2vOtXtElM0zYmetmUZ3
         SU3y5OrITsvlL9o3MO3bs7FIhK3rcoVZWU1U4BTLSFMnpl/7EdndA2pfZJuj2/ogMZnK
         dau4i6B9U8DkjWhypSLHMZUfapZ7f/xeeYesxVXdj3HiLAfVcfuHYyZbfNfPFDSiPyH6
         Qv5fhLOC0MeiEbAdJPXIKvBO5JhSSISu/+DtpSIXXcGDCocPrSwvGMWVfgVXrr6T5ls5
         8NNmOzDrqOD4f5ABF9EJ1SxPpxCou9cXrEcZhvHTZ2yuKrbYhdDPeNWDMi60uEK8zfsw
         N/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IDm7o5qShhiarlTi1RJ1f7Empdp4iZoHD3qNrssmpRE=;
        b=jQjm1zN/xqBEeLNlV9g8Ciqm9qAsZWGq7P1p3AKankdphWS53kknqQpDaOhjaUZ1tT
         yEtDtpy33+M77Y6vtlxY8b9gYmMBu1Cocd47E74ltgLCvGCwKyP3Si0QlDD2V0ZH1Xdj
         VLNfSCTWWJprBRotL4tBTEQ6rq1gi+vl409RFymxGMH013LPfDT2CkRNSdINrh5DwECu
         TNzFwZWlSkSB1WVqPIePPmKViHscyaadkBrUPTXMgKg5Ke98WhWmBGddB/dksHf2WfIB
         q8mSeu/1L390rScT0qzryIUexumkORUqiNvSzQ4Ot4oz/8jnNe21CVIPHrkx7RniLU0U
         h6yw==
X-Gm-Message-State: AOAM531EiMd5MUWku2C7bw9XDDOsNKtRk/wpQOl9XAAGsfC3Mf9l4oli
        9KE7YFdQHpubM1v4cz9ZNQMJBFm2mHc=
X-Google-Smtp-Source: ABdhPJw8tMrBqhbo1XVOw1xObIbE3CtzQYF0rHnB4HX3emmxvHcPx/nbNCvwgOqRyiATy+5Iz5dqfw==
X-Received: by 2002:a17:907:971e:b0:6fe:b652:7d51 with SMTP id jg30-20020a170907971e00b006feb6527d51mr5899589ejc.356.1653151850798;
        Sat, 21 May 2022 09:50:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jy1-20020a170907762100b006f3ef214dfbsm4446453ejc.97.2022.05.21.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:50:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsSJV-002fe3-82;
        Sat, 21 May 2022 18:50:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 10/15] bisect--helper: return only correct exit codes
 in `cmd_*()`
Date:   Sat, 21 May 2022 18:45:04 +0200
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
 <1236a7319033a67befe34ed892db0eb5200490fd.1653144546.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1236a7319033a67befe34ed892db0eb5200490fd.1653144546.git.gitgitgadget@gmail.com>
Message-ID: <220521.864k1i25jq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 21 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Exit codes cannot be negative, but `error()` returns -1.
>
> Let's just go with the common pattern and call `die()` in
> `cmd_bisect__helper()` when incorrect arguments were detected.

This is good in that before we'd return e.g. code 255 here:

    $ ./git bisect--helper  --bisect-terms foo bar; echo $?
    error: --bisect-terms requires 0 or 1 argument
    255

But now say:
    
    $ ./git bisect--helper  --bisect-terms foo bar; echo $?
    fatal: --bisect-terms requires 0 or 1 argument
    128

But after this patch we emit e.g. this:

    $ ./git bisect--helper  --bisect-terms ; echo $?
    error: no terms defined
    1

We should instead treat all these usage errors the same. A better fix
would be to either use usage_msg_opt[f]() consistently instead of die().

Or just this, which would narrowly fix the inconsistency and the exit
code:

    diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
    index 21a3b913ed3..e44d894e2ec 100644
    --- a/builtin/bisect--helper.c
    +++ b/builtin/bisect--helper.c
    @@ -1325,7 +1325,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
                    break;
            case BISECT_TERMS:
                    if (argc > 1)
    -                       return error(_("--bisect-terms requires 0 or 1 argument"));
    +                       return -error(_("--bisect-terms requires 0 or 1 argument"));
                    res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
                    break;
            case BISECT_SKIP:

But returning 129 instead of 1 or 128 is better here, as that's the exit
code we specifically use for bad usage messages.

I'll read on, but changing "error" to "fatal" and the exit code from 255
and 1 to 128 and 1 instead of either always 129 or always 1 in these
cases seems odd, especially as the last part of the function has this
code:

        return -res;

I.e. it's expecting "res" to be e.g. -1 or 0, and to convert that to 1
or 0.
