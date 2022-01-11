Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFEC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbiAKRvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344787AbiAKRvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:51:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC7C061757
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:51:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v48-20020a25abb3000000b006113ce63ed8so11070581ybi.22
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WevlBVXxoPbYOhN33XHPJOAZXxWbCuvWBDm55uoKQX4=;
        b=q3tTM4rWk3xcN6r/zdmWacsHdPP+o+I+ETMN/rChN7dKnqSx08VxykM61vPy8h4p45
         a8nA2lFDBVPceWZwyh0+QvXSF3AWN/OPE+xJBJQUsZsBUOZ3JgXaTCnEvNb5yfv/GltI
         9k41n+7m7IL242V+OVMsA67DuVjeEjIM9tBdstNWk+O5hziUc5vu6yQBtXZ8RTW5sL2f
         r1NFgcut1QeX9XZz8xlcsIPJdHO+Akatx9HdQqt3Uma0eDQvnPXxVKPAUxQZmnjOW3Qt
         z2CqYeeq3SfZZe+geU+3hpcuBSEcBCb+2LQ8MzwbaHNGxLS9yiVnpThhl4crEuFkBpQZ
         Ca+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WevlBVXxoPbYOhN33XHPJOAZXxWbCuvWBDm55uoKQX4=;
        b=KAFcRYVrZYOAHaCFWXLPWsAb5Bi2mMBbsuyJAeKEET+IaCMITx8eh6GY76oMhBJ281
         EJ/nd5kTIMO/p71mtqEfQnV+GwpveCzcjegHMxUwTFT1rZp3Kb0m9mcVtGpeOgO4Ltth
         B5GlQOOt1b4Y6a47GyACIjhMBDEzNC29YcyIuihF4JHlilfLGNX9c7/IVujElOZThQiK
         VmEMGqBRBiH/TR8GOe9vdlCnMGrnYjrv2bCKV7FwzYXCVZh93l3exjGAbgniyikDqMtc
         7BNP2Z1yaSHNhAoQv1UZFcu67y0CtAg5kCJazy38qN4j2EPKSahiNd7YNajbDDyFiJ0S
         Oc2Q==
X-Gm-Message-State: AOAM533H4rTTU8SzOI4St5CLEm9/CpLtRY0s7EFPEUiiz4lC0vDBgtnA
        3YL9+7V+Ke2eHYVFdWGd231xNsHdk+slXg==
X-Google-Smtp-Source: ABdhPJzA6plNX2Ht7SsL7rAcy9To52a3cLUde8LLhK1CIJL502JVp/FVTs9bGKaK4V63FPFJvlmo4O+RD29k0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:25ca:: with SMTP id
 l193mr7459812ybl.299.1641923467946; Tue, 11 Jan 2022 09:51:07 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:51:05 -0800
In-Reply-To: <20220111021912.1228794-1-jonathantanmy@google.com>
Message-Id: <kl6l7db6kvp2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211220233459.45739-3-chooglen@google.com> <20220111021912.1228794-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 2/5] branch: make create_branch() always create a branch
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> create_branch() was formerly used to set tracking without creating a
>> branch. Since the previous commit replaces this use case with
>> dwim_and_setup_tracking(), we can simplify create_branch() so that it
>> always creates a branch.
>> 
>> Do this simplification, in particular:
>> 
>> * remove the special handling of BRANCH_TRACK_OVERRIDE because it is no
>>   longer used
>> * assert that clobber_head_ok can only be provided with force
>> * check that we're handling clobber_head_ok and force correctly by
>>   introducing tests for `git branch --force`
>
> This might have been more simply explained as:
>
>   With the previous commit, these are true of create_branch():
>    * BRANCH_TRACK_OVERRIDE is no longer passed
>    * if clobber_head_ok is true, force is also true
>
>   Assert these situations, delete dead code, and ensure that we're
>   handling clobber_head_ok and force correctly by introducing tests for
>   `git branch --force`. This also means that create_branch() now always
>   creates a branch.

This is a great suggestion, I'll incorporate some of this.

As an aside, it has always been the case that clobber_head_ok is only true
when force is true, so it might be misleading to include it under the
umbrella of 'With the previous commit'. I'll move things around
accordingly.

>> @@ -426,15 +426,17 @@ void create_branch(struct repository *r, const char *name,
>>  	char *real_ref;
>>  	struct strbuf ref = STRBUF_INIT;
>>  	int forcing = 0;
>> -	int dont_change_ref = 0;
>> -
>> -	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
>> -	    ? validate_branchname(name, &ref)
>> -	    : validate_new_branchname(name, &ref, force)) {
>> -		if (!force)
>> -			dont_change_ref = 1;
>> -		else
>> -			forcing = 1;
>> +	struct ref_transaction *transaction;
>> +	struct strbuf err = STRBUF_INIT;
>> +	char *msg;
>> +
>> +	if (clobber_head_ok && !force)
>> +		BUG("'clobber_head_ok' can only be used with 'force'");
>> +
>> +	if (clobber_head_ok ?
>> +			  validate_branchname(name, &ref) :
>> +			  validate_new_branchname(name, &ref, force)) {
>> +		forcing = 1;
>>  	}
>
> Also assert that track is not BRANCH_TRACK_OVERRIDE.

Makes sense, I'll do that.
