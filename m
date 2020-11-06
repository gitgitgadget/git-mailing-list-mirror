Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A92C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4CD217A0
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theori-io.20150623.gappssmtp.com header.i=@theori-io.20150623.gappssmtp.com header.b="JC3TWxrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKFRC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKFRC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:02:26 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB8C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 09:02:26 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so1859245pfm.13
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori-io.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lINSCS9ApJn/H0VR/yYf5aoUofEAUNXt/BknQHtPVWw=;
        b=JC3TWxrEkYgz0PnKCcbfgrJc4u0pDg6OebenroM7tMbYx+2WweX8csuK6nGMqGOv+j
         FES0DfuNBM501UNczxyji0fqNT1bFJbOfIG188M0IRXitx+55mLOApthYa6ku3YBgL80
         tXTYwBHCf8GTYd+7/OTVnKpFiS/auSlWPyfg8GLsHw44SIalJX0TEcpdwRvxKrzDv/hJ
         MReuqawBPOu38kFvFa/ayqfpbZ+3wT5Y89VJY9NhoANZPMrN6cfKZxwzCGF5DGdngo3i
         F971H/YrnXaKL8e7xDICseFjdDPF8z521Xuz7tJTri74K37ulUe4mQP6P2NXT9CPUhG0
         rnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lINSCS9ApJn/H0VR/yYf5aoUofEAUNXt/BknQHtPVWw=;
        b=LIG/rpsoHME8sQZHMeeEp4xyRfjlhuG8OHCZCLg2QtpiG1V8uGTF0u0K6mXDx4ritE
         q9KIDLtcWXVYT7rRQkP193SJHXgCT9HYtVB65pUzrap48ng7lxtBBFb0ofNpIRKOmfG+
         6HoAgwufBGOLHA6RV/Ej32hKYHlhAaRxq6FELxnF7srxYwjYHeIjaHDi8OK139uu3RRt
         v7BiX/2jZzOzTAAZn5SzjZ7qSw5j6dhgHvtPy4NJgh2EYxygsPDAfQSlIEIsmVgj0fsW
         X2ddCkNdaroQlh/P0+EUppOwTZ1UXEkISu203hYhrBriEP3eUGbXt9X5eACH8ZQvk0M2
         vvng==
X-Gm-Message-State: AOAM5336+CDkLk/4HyyJS4foluCdYV/yXAL4cImOBi0xVp9WUhrSVhd3
        Ax76S+pq5Kpggj0sfykm2L0sKg==
X-Google-Smtp-Source: ABdhPJyZFQi1GEjZh8m3We6NC3qHIakmxmkAJB7t+YVIAHwmgCay2mjusOFQhT+0hy6yF7GmqKEjZw==
X-Received: by 2002:a62:6487:0:b029:18b:70d7:bbb5 with SMTP id y129-20020a6264870000b029018b70d7bbb5mr2851636pfb.6.1604682145923;
        Fri, 06 Nov 2020 09:02:25 -0800 (PST)
Received: from [127.0.0.1] ([118.34.160.70])
        by smtp.gmail.com with ESMTPSA id e17sm1739844pfl.216.2020.11.06.09.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:02:25 -0800 (PST)
From:   Jinoh Kang <luke1337@theori.io>
Subject: [PATCH v2] diff: handle NULL filespecs in run_external_diff
To:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
 <xmqq4km4lppy.fsf@gitster.c.googlers.com>
Message-ID: <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
Date:   Fri, 6 Nov 2020 17:02:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
In-Reply-To: <xmqq4km4lppy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[forwarding from git-security@googlegroups.com to git@vger.kernel.org]

On 11/4/20 10:30 PM, Junio C Hamano wrote:
> Jinoh Kang <luke1337@theori.io> writes:
> 
>> `one` and `two` can be NULL when comparing an unmerged pair.
>> There is a conditional above that already tests for this.
>>
>> Fixes: 3aef54e8b8 ("diff: munmap() file contents before running external diff")
>> Signed-off-by: Jinoh Kang <luke1337@theori.io>
>> ---
>>  diff.c              |  6 ++++--
>>  t/t7800-difftool.sh | 23 +++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index d24f47df99..ae1ec2d6c8 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4267,8 +4267,10 @@ static void run_external_diff(const char *pgm,
>>  	strvec_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
>>  	strvec_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
>>  
>> -	diff_free_filespec_data(one);
>> -	diff_free_filespec_data(two);
>> +	if (one)
>> +		diff_free_filespec_data(one);
>> +	if (two)
>> +		diff_free_filespec_data(two);
>>  	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
>>  		die(_("external diff died, stopping at %s"), name);
> 
> Have you considered allowing diff_free_filespec_data() to take NULL
> and return safely without doing anything?

Yes, I have. In fact, this kind of behavior is exactly what I would
expect from a function that "frees" something.  However, I was not
entirely sure if this applies here, for several reasons that follow:

> That models after free() and other "we are done with the resource
> and it is time to clean it up" functions,

This corresponds to `free_filespec`. In this particular case,
I strongly agree that it makes perfect sense to do nothing when
passed a NULL pointer.

However, I humbly opine that the free() semantics do not apply to
`diff_free_filespec_data`; rather, I prefer to see it as a function
that simply transitions a diff_filespec from one state to another.

For this reason, I'd consider the act of passing NULL to
diff_free_filespec_data as a bug in the first place.  Further,
if it does not entail a security issue, why not just crash *right
now* rather than (possibly) causing more obscure bugs later?

I would put the blame on its name, since "data" feels too generic
and makes the function sound like freeing the filespec _itself_.
diff_filespec carries a lot of other things besides just `data`
and `cnt_data`.

Please feel free to correct me if I'm wrong; after all, I am not
exactly one of the long-time maintainers.

> fixes this particular bug, and possibly simplifies existing
> callers that check the NULL-ness before calling it.

I was unable to find any callsites that explicitly check for
NULL-ness _immediately_ before calling diff_free_filespec_data.
Excluding 3aef54e8b8, `GCC -fanalyze` suggests to me that
all the callers have already dereferenced the pointer by the time
the call is made; therefore, a NULL pointer dereference would have
already happened before the flow could even get to
the diff_free_filespec_data function.

The NULL checks are usually placed in the beginning of caller
functions rather than close to the exit path (which then calls
diff_free_filespec_data).

> 
>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index 524f30f7dc..8cc1c9117c 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -728,6 +728,29 @@ test_expect_success 'add -N and difftool -d' '
>>  	git difftool --dir-diff --extcmd ls
>>  '
>>  
>> +test_expect_success 'difftool --cached with unmerged files' '
>> +	test_when_finished git reset --hard &&
>> +	echo base > file &&
> 
> Style.  "echo base >file &&" (no SP between redirect operator and
> its target).

My bad. Thanks!

> 
> I do not think this is "security" matter.  I do appreciate you
> erring on the side of being cautious and sending the patch first
> here, but please take it to the regular mailing list.

Yes, no sensible web-based git browser would prepare a working tree,
start a conflicting merge *AND* run an external diff on it...

> 
> Thanks.
> 

-- 
Jinoh Kang
Theori
