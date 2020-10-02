Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890AC35257
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6532720719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 22:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTtQNeyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgJBWcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 18:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 18:32:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DC9C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 15:32:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h31so2160755qtd.14
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SJaYKi5sc4J3dW3tT0ZrSCWPl2Fw2Zce29p+V87l0aA=;
        b=vTtQNeyMssw8vsAog2wX1TOUjECN70Us2JTgHNmcDXHFaY3Jjak+IB/HFbLlMT0Uzn
         iW72cTeBkfqPTINa9STz6jGMiZrOMwb3mp82TUQZ2EJ9QhsaZak2S0k/HbLHt2CZP9r+
         HsCn2eaRqVbfVlbnHcMpo2HEQTR/IEScNakNU3dZH9ADjMB8+2o7DdlQhEL7Y9qaxUu9
         6+r0UlXOysSMrzEatytGv79OSXv6rrjFIo8E2QNiL9nhogp3vbzN9vFj9d7cVNad6PNE
         j++4TLcK2JMfMKlCYEi+FCaznIip1XtuHEVkJjwhGC/xwvu38W4iST9/QuGzZEW9U9V9
         37Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SJaYKi5sc4J3dW3tT0ZrSCWPl2Fw2Zce29p+V87l0aA=;
        b=J3KzabLbeNeLjacsZHUfdYK98G+0bT0rlEj8JwCOJknFC9e868S2VEZr+L2HKOWx/A
         TkKp0DJiNlT3xujBysn4O1wSNZu0kGXKu0CevzeWDl7zIfwEWfKdp+UNmD3kqLoYHF0p
         3IPSKeFAPBHPZ18wkUqVbvjwod0qpwTiibRVRtDTqDblZF2rdibVnwVOQOCuBdlnlnvH
         kWvPQkSkm258uliqjOG8fH4BOtTf6D6KIMDhrMRLBhfPqi35xrwzhfK2Ak9zF0FnWKEq
         lG2D1gAqy486Q9kuNKO7OArrmqE2CWVUctixJCXpyQd9nZDrQmnIB/p5DdOwNm/Y9Nft
         Cohg==
X-Gm-Message-State: AOAM531zoIKO2y6orZ2y4oB0MJy4ztBiGE85pE8wMVSkoEEaNJfL+ePD
        NIKj419S//2HIsPwAuqKLG4toIx7G0oR
X-Google-Smtp-Source: ABdhPJzje90unQpztybwN1XzZlBjqniyMeQFWmr11+yD6ndlTW2QNFOaaxoz8QOBVbfNxlJujAMefx4vWO+3
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a0c:e348:: with SMTP id
 a8mr692136qvm.49.1601677933281; Fri, 02 Oct 2020 15:32:13 -0700 (PDT)
Date:   Fri,  2 Oct 2020 22:32:12 +0000
In-Reply-To: <20201002061550.GF3252492@google.com>
Message-Id: <20201002223212.93266-1-shengfa@google.com>
Mime-Version: 1.0
References: <20201002061550.GF3252492@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> [...]
>>
>> What does HT stands for? I will change the indentation to 8 spaces.
>
> HT means "horizontal tab", like might be shown with "man ascii".
> 
> Git uses tabs for indentation.  This file is documentation instead of
> source so clang-format doesn't know about it, but I might as well
> mention anyway: if you run "make style", then clang-format will give
> some suggestions around formatting.  The configuration for that is not
> yet perfect so you can take its suggestions with a grain of salt, but
> they should get you in the right direction.
>

Got it, thanks!

>[...]
>>>> --- a/builtin/commit.c
>>>> +++ b/builtin/commit.c
>>>> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>>>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>>>>  	s.colopts = 0;
>>>>  
>>>> +  git_config(git_default_config, NULL);
>>>
>>> Declaration after statement is not tolerated in this codebase.
>>
>> If I use the DEVELOPER=1 flag in config.mak and call make again, would the compiler
>> catches this as an error?
>
> Yes, DEVELOPER_CFLAGS includes -Wdeclaration-after-statement.
>

Got the error from int hide_timezone = 0; but not
git_config(git_default_config, NULL);.

>>>> +  int hide_timezone = 0;
>>>
>>> Unnecessary initialization.
>>>
>>>> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
>>
>> Is it unnecessary because I am checking the return value from git_config_get_bool so
>> that the uninitialized value won't be used?
>
> By leaving it uninitialized, you can help avoid the reader wondering
> whether there is some code path where the default value is used.
>

I see.

>[...]
>>>             Instead, make sure it is set to some timestamp in some
>>> timezone that is not UTC, and the timezone of the resulting commit
>>> author date is in that timezone.  But that must have already been
>>> done in basic tests on "git commit" that we honor the environment
>>> variable, no?  Which means there is no need to add yet another extra
>>> baseline test here.
>>
>> I am not sure if this test has already been done in commit basic tests.
>> Will remove this test.
>
> Let's see: *checks with "git grep -e TZ -- t"*.
> 
> Looks like t0006 tests various aspects of TZ handling pretty well and
> t1100 includes of test using TZ with commit-tree (good).
> 
> Thanks and hope that helps,
> Jonathan

Thanks! That helps a lot.


