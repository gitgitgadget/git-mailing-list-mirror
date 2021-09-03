Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD34C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169BE610A2
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbhICMby (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349328AbhICMbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 08:31:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C1C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 05:30:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso6371368otv.3
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5B0PUr5tPMedJzVcyiFkGCTEzvMOm1B4h2uVT1e43Rk=;
        b=D6NO87HIz+U2K1hr3H30l1oLKG9bqUse3TDS2YYVYJOeuRDLhUnlyqogv07MJdsUZc
         L+rH487F0IJF8lM7YNV40BAmg3q/ivvuuOpQw3+wv/cvlf3DY8Xo2TGyx6xR0O/K7VmF
         Y0sZQc632xq4YDwe88mD0UCOgOJHGogm/CKfOY/nRsJI3bhr7F4MrSkjzt9tD2TfQLiE
         AeNNTDyFM5Nvl4DY56dDd5Hd1Uv+k77gfbbfdPr9r21qEdCuOY8NNxVtaFr/mboegUMr
         eDypeEGKpuMSovhV4VSbfdfbWpD2drxlKUy7I/2vriBYSB9z1TS5BFQRYng/R4YiIE7d
         XiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5B0PUr5tPMedJzVcyiFkGCTEzvMOm1B4h2uVT1e43Rk=;
        b=Ivqas2FlVpb9n5qwCyRMmM52DaLPpSun4iPvOQq1ahSF06SWC4v/cFeN4ls9D2qfyy
         9hZnZSwWd8dPA+ArNxtH25R0+i+MgtUCwjNsUGIwTEUd5xHdFeHnIKEId+Tl2FhwXMZG
         z4F6ZN8piLd8qYkH3I/0D8sREl9oGmKV9DvoJaRR3G0epZReqURw2gWETQC4mUJB5AXc
         lIFjxd57/JzCgzDl+7fX7P6nekegBZOQYBSFAv4XRMqUKYHufTmrxZb5gkwrs62Vf7Qb
         mwYfJ5oCRzPX8TDouYEewE+dUfWhItFJPr3Wm0X2/PQgYSRhYFAJGwxOdvKjqp+c0fNg
         zHbw==
X-Gm-Message-State: AOAM533iDifS0AQWYOfhKNDgZRe4ZEEzXSst3Nhi4yOav7w7B2m1xDOM
        mNYeAgDVXLUWA+pcOGHi6lM=
X-Google-Smtp-Source: ABdhPJyoVDDq1rjkQCcXjSbDX4IY+jf3PmUiBEiqKk3F30bGh6D2cLk+033Pj44bdmPi9DtNFdlGGQ==
X-Received: by 2002:a9d:5a9e:: with SMTP id w30mr598578oth.378.1630672252523;
        Fri, 03 Sep 2021 05:30:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:59b9:ef25:8bd8:d675? ([2600:1700:e72:80a0:59b9:ef25:8bd8:d675])
        by smtp.gmail.com with ESMTPSA id b3sm979219oie.1.2021.09.03.05.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:30:51 -0700 (PDT)
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
 <xmqqsfyoqm6e.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7c9870a-9af3-bac8-1964-358ecdebe344@gmail.com>
Date:   Fri, 3 Sep 2021 08:30:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfyoqm6e.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2021 12:45 PM, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
...
>> +	dir = xstrfmt("%s/src", enlistment);
>> +
>> +	strbuf_reset(&buf);
>> +	if (branch)
>> +		strbuf_addf(&buf, "init.defaultBranch=%s", branch);
>> +	else {
>> +		char *b = repo_default_branch_name(the_repository, 1);
>> +		strbuf_addf(&buf, "init.defaultBranch=%s", b);
>> +		free(b);
> 
> Doesn't "git clone" already use their HEAD without having to make an
> extra "git ls-remote" roundtrip?
> 
> Ahh, you do not do "git clone"; you do "git init", set things up,
> and then "git fetch" and checkout, all manually.
> 
> Which is kind of shame.
> 
> I wonder if it is a cleaner implementation to give a new option to
> "git clone" that gives a command sequence (not necessarily have to
> be implemented as a shell script) that specifies necessary
> pre-configuration steps to be done before the command starts the
> transfer step.

I agree that 'git clone' plus maybe some more improvements like
'--sparse=cone' to set up cone-mode sparse-checkout would be good.
And also the implementation being contributed here is cleaner if
we can use 'git clone'.

We are trying to balance a clean upstream implementation with some
custom things that we still need in our microsoft/git fork to
handle the integration with the GVFS Protocol (i.e. partial clone
on Azure Repos). That customization is cleaner to keep here in the
scalar code instead of adding an option to 'git clone'. It is
difficult to justify code patterns here due to choices we have made
in our fork, so I _could_ see a way to replace those custom bits
with new, custom flags to 'git clone'. It just requires additional
investment during our integration when we incorporate these upstream
changes. Naturally, I'm motivated to avoid that extra work.

If your opinion to switch to 'git clone' is a strong one, then I
could see us doing that change. I just want you to be aware of the
hidden reasons for choices like these.

Thanks,
-Stolee
