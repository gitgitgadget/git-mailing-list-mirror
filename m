Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE4C433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 09:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9FD610E6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 09:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhINJ7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhINJ7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 05:59:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51509C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 02:58:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so19219954wrn.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pVgkxaCUSb56urtqgSUwbD0XZzDaRXFc9sU8UKmme1s=;
        b=LG0ju+E/iyesW36q2H2vwtXOWLMrlkzTCi3+aEoB0iqB+JWKgn25NU2r38dFIDA/B3
         hCUr2bzqkbmt9xxIrOoja/9b82pUGoyAi9NYsTfq8cKKdVCzRpgVzOrEaVH0U0NLiV9f
         NiMUOYgIJYzYz/8YCEqtQeDbr5xncxRCfolh7T/ppRCKmeAg7GmSC86i4skUIDtxDpRF
         w9GASA+hat0i2F5JoOdMPi9McJJlqOZX1mZZMTIX9MOCg+IVuqdjXBZ+v/f8y81lw0BK
         BAEP5c40W22OEMRCVwKZViILV9cW4qfQ3jvtz4u+CV/EprrQrnqRUE7ekFMXC4lThi9z
         9fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pVgkxaCUSb56urtqgSUwbD0XZzDaRXFc9sU8UKmme1s=;
        b=XVnrlYuZA1n+muUuS5ToAk/mvYipaJsGss/x9AYPK6TpVUSK/8O7X7QN5H5CuPyyaB
         wmJnOnTIhNCJ/nUfXPJgqDX/CmWK04zNfZh1F0U68ujuqqBilwHmSYZAR5m/VMQ7++yD
         qoGo4XDadFWrd8kfkmVr4otvj854bx4NncX59dSjvFvj+i8kfmnuTMzkREJq44W4HKe+
         GRi+w+DOqiVBzOLNw/dLH7xJXDXhxOkQVZSxUSN6l/3mooeOBMv8N7tffXmz32p189XA
         H+5da40VhEO//Ok+/k4HDt4NPwzpDKiPaxDhKYtGQkWHYZhad+0WxCw4SX9f7BSO3SBY
         rOPA==
X-Gm-Message-State: AOAM533QMTSj+AvmgIVJk7GmmbrCqyJ5ydPIfgqxf1kdsYsqOtn9N+Zc
        JKL5s0MDk8RMDLpeYZe/Z3Y=
X-Google-Smtp-Source: ABdhPJzo0jt0qoklO07n1Lx6fYh12i0tqrQMIq72BpWM8IcF4UTyh/2RorMOGimZkuv2HUxwVSfcMg==
X-Received: by 2002:adf:e643:: with SMTP id b3mr18137466wrn.67.1631613482916;
        Tue, 14 Sep 2021 02:58:02 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id x21sm628888wmi.15.2021.09.14.02.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:58:02 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
To:     Sergey Organov <sorganov@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
 <87r1dr5vyd.fsf@osv.gnss.ru>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c0e95f69-b4e9-4510-8880-3110e9af36ab@gmail.com>
Date:   Tue, 14 Sep 2021 10:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r1dr5vyd.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey

On 14/09/2021 10:48, Sergey Organov wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
>> should checkout the commit pointed to by <tag-object>. Instead it gives
>>
>>      error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
>>      trying to write non-commit object
>>      710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>>
>> This is because when we parse the command line arguments although we
>> check that the tag points to a commit we remember the oid of the tag
>> and try and checkout that object rather than the commit it points
>> to. Fix this by using lookup_commit_reference_by_name() when parsing
>> the command line.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> [...]
> 
>> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
>> index 162112ba5ea..ebbaed147a6 100755
>> --- a/t/t3407-rebase-abort.sh
>> +++ b/t/t3407-rebase-abort.sh
>> @@ -11,18 +11,18 @@ test_expect_success setup '
>>   	test_commit a a a &&
>>   	git branch to-rebase &&
>>   
>> -	test_commit b a b &&
>> -	test_commit c a c &&
>> +	test_commit --annotate b a b &&
>> +	test_commit --annotate c a c &&
>>   
>>   	git checkout to-rebase &&
>>   	test_commit "merge should fail on this" a d d &&
>> -	test_commit "merge should fail on this, too" a e pre-rebase
>> +	test_commit --annotate "merge should fail on this, too" a e pre-rebase
>>   '
> 
> These two do not seem to belong to this particular commit?

They do, the annotated tag is used in the new test added in this commit 
which tests that we peel tags.

Best Wishes

Phillip
>>   # Check that HEAD is equal to "pre-rebase" and the current branch is
>>   # "to-rebase"
>>   check_head() {
>> -	test_cmp_rev HEAD pre-rebase &&
>> +	test_cmp_rev HEAD pre-rebase^{commit} &&
>>   	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
>>   }
> 
> 
> -- Sergey Organov
> 
