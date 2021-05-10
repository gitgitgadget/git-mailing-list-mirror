Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD27C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 03:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8961431
	for <git@archiver.kernel.org>; Mon, 10 May 2021 03:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhEJDb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhEJDbX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 23:31:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6C2C061763
        for <git@vger.kernel.org>; Sun,  9 May 2021 20:30:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o127so8307786wmo.4
        for <git@vger.kernel.org>; Sun, 09 May 2021 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=+i7K+cWrZ8EHXGT6fjSd01Yt+b8CENfXotEvb7aE3eg=;
        b=Gt2rLsl73misZow+PdBCUA4jnEK2ERZnFmc/QksyD+iMKqp2kozqw+BeHzPGgyARlt
         gAMBUmsXpxPPBZFGAhH6YJnSfTGgPy8dDA7MyvoTE/BTMjVdgZx2uDj9CDfzwf4pxp+G
         hnM5hJwC/MQfweNG1xCI9QJprsLpiOBw+LTyXhXFM5yKbkdDCf+zpUlE4i4Qko5OK1QM
         QsbTNPUVq1C0HBjPktoQQaINjMmM8j+6nOzLzkxhKEb4IOADZLruH4I8BPT73kyfOTI9
         rWUg7yKwhNb/mDYOkaNeogKuYsoreRLt9GLyQGoLdujRP4ljfZuMoVBaU8OLspEEGSmr
         9xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=+i7K+cWrZ8EHXGT6fjSd01Yt+b8CENfXotEvb7aE3eg=;
        b=ZSB1O05NYXI75vfMYfZavNYuHV+tr1DsExi/4Q6QL2lu82cl4e2ZQpw1Q/eTi+Qzfa
         CGEydRk83FsR9gh5yzdNt86RH1J9jz4aElHdc19W/AfBl3FxgxJQvwUtl2es2+7s4hsQ
         UbI6Q2YrQ3WlsmjDRFwVh5FauYxAwijjwwByy8koOt8GEJnWAS/XDjh0YHwt3XT1UUIB
         VOZ/81EUeXxjTbNQXyRMPCzEPSZgkUvRV54o2vNIC2khqhiR/WUT2o2P29pZYFvGvQgM
         r5maPiRmwqvnIC1CHKw37qqs/XuJnHV0Vg6NplU2FkLtLQqfCdHQXU3f6yfdKWG41YJU
         PeOg==
X-Gm-Message-State: AOAM531sK7DTBH3Xmh/E2jZ2Tr1L3+Fxl3HTectOIPw/j+ThNwS/qfnk
        VI5fGFbHCORt1g1AJoBisX8=
X-Google-Smtp-Source: ABdhPJy1+aZbKO0nrY3lj67hOuLuqbQ7j04bXGZAgv+eR+TQUVzlDIKDlhGCEMJO4fUIT4V4ax9nTw==
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr23857000wml.118.1620617416585;
        Sun, 09 May 2021 20:30:16 -0700 (PDT)
Received: from Inspiron (2a01cb04010c420084a8e8ad2e2ee957.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:84a8:e8ad:2e2e:e957])
        by smtp.gmail.com with ESMTPSA id n5sm20817348wrx.31.2021.05.09.20.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 20:30:16 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 2/8] format-patch: confirmation whenever patches exist
In-Reply-To: <xmqqk0obwhi2.fsf@gitster.g>
Date:   Mon, 10 May 2021 05:30:13 +0200
Message-ID: <878s4ngta2.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Firmin Martin <firminmartin24@gmail.com> writes:
>
>> Currently, git-format-patch, along with the option --cover-letter,
>> unconditionaly overwrites a cover letter with the same name (if
>> present). Although this is a desired behaviour for patches which are
>> auto-generated from Git commits log, it might not be the case for a
>> cover letter whose the content is meticulously written manually.
>
> True.  But if we require confirmation before overwriting patches,
> that would be overall worsening the end-user experience, I am
> afraid.  In a 5-patch series with a cover-letter that was formatted,
> proofread, corrected with "rebase -i" and then re-formatted, unless
> you rephrased the titles of the patches, you'd get prompted once for
> the cover letter (which *IS* valuable) and five-times for patches
> (which is annoying).
This is true for this patch, but the semantics changed after the patch
#3. I really should have squashed them together to not create
confusion. Sorry about that.

After patch #3:

- The prompt happens only one time so that the user could decide whether they
want overwrite the existing file and subsequent ones. In your example,
the session would go like this:

    git format-patch --cover-letter -o patch upstream/master

    The file 'patch/0000-cover-letter.patch' already exists.
    Would you overwrite this file and subsequent ones [Y/n]? n
    fatal: failed to create cover-letter file

(replying Y would overwrite the cover letter and the patches as usual)
 
- The default behaviour affects only cover letters, meaning that, in
  your example, if the user employs instead 

    git format-patch -o patch upstream/master

(without --cover-letter) the second time, the patches are overwritten
without any disturbance.

After all, the point of this patch series is to prevent overwriting an
existing cover letter by using a cover letter template
(--cover-letter). 

>
> It also is unfortunate that this change does not address another
> annoyance after retitling a patch---the stale output from the
> previous run is not overwritten with the updated one but is left in
> the same directory as the output files from the latest run.


> So, while I very much do welcome the motivation, I am not onboard
> with this particular design.
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 6102893fcc..bada3db9eb 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -35,6 +35,7 @@
>>  #include "repository.h"
>>  #include "commit-reach.h"
>>  #include "range-diff.h"
>> +#include "prompt.h"
>>  
>>  #define MAIL_DEFAULT_WRAP 72
>>  #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
>> @@ -959,6 +960,10 @@ static int open_next_file(struct commit *commit, const char *subject,
>>  			 struct rev_info *rev, int quiet)
>>  {
>>  	struct strbuf filename = STRBUF_INIT;
>> +	struct strbuf file_exists_prompt = STRBUF_INIT;
>> +	const char *yesno;
>> +	static int not_prompted = 1;
>
> When the API passes a structure that keeps track of state (like
> "struct rev_info *rev", used to hold rev->diffopt.file which is
> clearly a state), add a member to it, instead of inventing a
> function local static that will hurt reuse of the API you are
> touching.  This static variable will make it impossible from a
> single process to format two patch series, but if it is made a part
> of rev_info, you do not have to introduce such a limitation.

OK, I will keep in mind of that. But after the discussion on git_prompt,
I think this variable will be dropped.

Many thanks for your comments,

Firmin
