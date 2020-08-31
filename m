Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDBC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B97206E3
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp+2aSQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgHaTl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgHaTl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 15:41:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039AC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 12:41:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so8129221ljn.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CDItFA5PV7lT7RuJlW76tsxycCpYYmuVYL2hpCpQIes=;
        b=Kp+2aSQOApKfWFKbGsdirG7M7hLtpKjOGjwPV8zl5NtNrvCLySsKHsdZd1/A8pcydl
         JiHKx6tHCs7rN+8PQGTJY57DHQ9QhGtCzHkf774YZ/X8QiYCMmxiQ/fwFEZIk1Vz+qOO
         wk+XnEN+7PLKT276Hw4pUxvYcVwTzLdimau7s10bTWxTBL1I9UpmwCvNTsggbsxYmwko
         FqgEwpPU8Zqd+R63Ucpx8Uvi2W4wR5gXSKoT3NnsH6BY4aSB3dGBT1gnx7VmAM4EsSmt
         lbJkSldvHpGYjVGxEKF370APyMqSb0coHbsUJUWeTBJzpNQch/pLnBB5UkY3opwaDZNt
         9PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CDItFA5PV7lT7RuJlW76tsxycCpYYmuVYL2hpCpQIes=;
        b=HWYr+Q9X+LJs+csFYMMjkBAjiEI8f+PL5jHfaMG/0qWyg5XRa9csPrfnFsdEcPwlEd
         hs1FA0PaZZ7JwNsBA0igUqrwxfM70xwb/5KCrvK16HrKI+zPcIqKsA35JEiZbvTMyzkz
         DVEx/hH4u4CJsiFtxd9+i2JmDark8NFXvBFK8o6x+PxqYFqjUi5UGnv1MIjyYWS75bwR
         55SXCeTn4qGErDRleMLKi4AiXmXpF98Ln2TOQVs44d3vKlozIDlg2HbEvBIZkKsa0/bz
         ymllgOwYA/fDpk9a90xHOQg2JSZM1DLXFyGR7IIo6M5u8T7WpdgaNre9wxKFccZjRDTS
         4TYA==
X-Gm-Message-State: AOAM530odT63qm15K9w9EIRm0gcBZrzotrdQdEPvhcmRkevX8X7obJ8v
        x/rpViLxInjSb7MjpFl2xPmZOWrkb3o=
X-Google-Smtp-Source: ABdhPJzhMILniRtAtr/pdwdVD6YDzF3c/dmsoeut0Noscl3cBosdAvWG8NyWjnSpqn2hwCvtcIiLyg==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr1196973ljn.115.1598902913767;
        Mon, 31 Aug 2020 12:41:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g63sm2171093lfd.28.2020.08.31.12.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 12:41:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3] revision: add separate field for "-m" of "diff-index
 -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200831125350.26472-1-sorganov@gmail.com>
        <xmqq4koihgpk.fsf@gitster.c.googlers.com>
Date:   Mon, 31 Aug 2020 22:41:51 +0300
In-Reply-To: <xmqq4koihgpk.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 31 Aug 2020 10:23:51 -0700")
Message-ID: <87wo1eob5s.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Add separate 'diff_index_match_missing' field for diff-index to use
>> and set it
>> when we encounter "-m" option. This field won't then be cleared when another
>> meaning of "-m" is reverted (e.g., by "--no-diff-merges"), nor it will be
>> affected by future option(s) that might drive 'ignore_merges' field.
>>
>> Use this new field from diff-lib:do_oneway_diff() instead of reusing
>> 'ignore_merges' field.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>
> Much easier to reason about.  As I said, I think we would ideally
> want to detect and diagnose --[no-]diff-merges on the command line
> of "diff" or "diff-{files,index,trees}" as an error, but for now
> this is a good first step.
>
>>  	} else if (!strcmp(arg, "-m")) {
>>  		revs->ignore_merges = 0;
>> +		/*
>> +		 * Backward compatibility wart - "diff-index -m" does
>> +		 * not mean "do not ignore merges", but "match_missing",
>> +		 * so set separate flag for it.
>> +		 */
>> +		revs->diff_index_match_missing = 1;
>
> Half the wart has been removed thanks to this patch and the rest of
> the code can look at the right field for their purpose.  The parsing,
> unless we make a bigger change that allows us to detect and diagnose
> "diff-index --no-diff-merges" as an error, still needs to be tricky
> and may deserve a comment.
>
> The comment should apply to and treat both fields equally, perhaps
> like this:
>
> 	} else if (!strcmp(arg, "-m")) {
> 		/*
> 		 * To "diff-index", "-m" means "match missing", and to
> 		 * the "log" family of commands, it means "keep merges".
> 		 * Set both fields appropriately.
> 		 */
> 		revs->ignore_merges = 0;
> 		revs->match_missing = 1;
> 	}
>
> By the way, let's drop diff_index_ prefix from the name of the new
> field.  I do not see a strong reason to object to a possible update
> to "diff-files" to match the behaviour of "diff-index".  
>
> In a sparsely checked out working tree (e.g. start from "clone
> --no-checkout"), you can check out only paths that you want to
> modify, edit them, and then "git diff-files -m" would be able to
> show useful result without having to show deletions to all other
> files you are not interested in.  And that is exactly the same use
> case as "git diff-index -m HEAD" was invented for.

Fine with me, thanks! I'll re-roll soon.

Thanks,
-- Sergey
