Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2481BC001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 15:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGYPmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGYPmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 11:42:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8921FDE
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:42:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fd2f298712so25105365e9.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690299731; x=1690904531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBRP6UWGt01tc2oGSCf+9l/QCWJmr/IDSktqyM4hSOc=;
        b=GG6D9wFV0ihzKYE84DgG0Z9VwFDoQIn/k3Ge/PePRSPrJdf6JS0Qe3oT1dHGlA0VTJ
         r3GbHF2dd8nZmiVhDQNBcD7Cao2FB/32dT/z2RpXMs9jB6nwVN6bmDxNH24fWe3T8MzO
         YKq6ftQdYzKqbRdNIMbX6/Qt5gMktlhw74TnPncFV8uk/oaxSzrYC6UOatFkJ2AVccRM
         SNH4BR1Ee9uoDc9H4Zw6H0O5YlolJqQqQS2TxLcuLqZpHsoqSeTeDulJjrskXUMOa5ZG
         UWY8dUCzVOjvQTP7oOz18mxKCXOM8hfA6S0gRDcx7TrgEq7iZCAakoS6pZss33yAfW/U
         X7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299731; x=1690904531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBRP6UWGt01tc2oGSCf+9l/QCWJmr/IDSktqyM4hSOc=;
        b=jA9PO9xywgYN0/GcA/Vprv+nlF2H8/1JlMTKelFhZoRYeuzPF67I4n/ELuFtsVE0lE
         fgcA+5uYa7v4CzwjPuodk8exC29e3idu06wgqNsLmLhBqVh/TvQM0t/7mWhce5AGteJJ
         I2aYa3jyAHIu/sSthXo26JW7QPP0UiKl0V8CTAITAp0tnPG5+9i2JL0J9Pm1j4pkoQwM
         Kzd8uibigIvqiCjYXdL1thVfVZ365ieMWtlhws+ypYjTz5Yffx5TrFVwg2sTewi/6hMB
         D4Sx5Mk+daI2zmuCI9NKGC2nI3i/UXLvjUnV1s9cawpibCmpEOgYUIWlfiSwffGWAn2M
         HXIg==
X-Gm-Message-State: ABy/qLYipsvTg3dqi7UYwjGPtGWFVpZ5MOcMb+5C8dqvEuso4/Y1KpNf
        uXX3krAiI5DcAm9zGz6/zzA=
X-Google-Smtp-Source: APBJJlHLVmtLWdRYx+00sTBSBMDCLoIS5ZrDuMvvXPEBrbGoDx78kTl3SzRDceavfmWlGA1M4Ngt5A==
X-Received: by 2002:a05:600c:2981:b0:3fb:b890:128b with SMTP id r1-20020a05600c298100b003fbb890128bmr9857464wmd.27.1690299730636;
        Tue, 25 Jul 2023 08:42:10 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c22cd00b003fbcf032c55sm16015748wmg.7.2023.07.25.08.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:42:10 -0700 (PDT)
Message-ID: <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com>
Date:   Tue, 25 Jul 2023 16:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
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
 <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
 <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

On 21/06/2023 21:49, Glen Choo wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When rebasing commands are moved from the todo list in "git-rebase-todo"
>> to the "done" file just before they are executed. This means that if a
>> command fails because it would overwrite an untracked file it has to be
>> added back into the todo list before the rebase stops for the user to
>> fix the problem. Unfortunately the way this is done results in the
>> failed pick being recorded as rewritten.
> 
> I could not make the connection from the described problem to the
> proposed solution. In particular, I couldn't tell what about "the way
> this is done" that causes the incorrect behavior (e.g. are we failing to
> clean up something? are we writing the wrong set of metadata?).

Yes, on reflection that first paragraph is not very helpful. I've 
updated it to

git rebase keeps a list that maps the OID of each commit before
it was rebased to the OID of the equivalent commit after the rebase.
This list is used to drive the "post-rewrite" hook that is called at the
end of a successful rebase. When a rebase stops for the user to resolve
merge conflicts the OID of the commit being picked is written to
".git/rebase-merge/stopped-sha1" and when the rebase is continued that
OID is added to the list of rewritten commits. Unfortunately when a
commit cannot be picked because it would overwrite an untracked file we
still write the "stopped-sha1" file and so when the rebase is continued
the commit is added into the list of rewritten commits even though it
has not been picked yet.

Hopefully that is more helpful

>> Fix this by not calling error_with_patch() for failed commands.
> 
> So unfortunately , I wasn't sure how this solution would fix the
> problem, and I didn't dive too deeply into this patch.
> 
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index c1fe55dc2c1..a657167befd 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1289,6 +1289,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>>   	test_cmp_rev HEAD F &&
>>   	rm file6 &&
>>   	test_path_is_missing .git/rebase-merge/author-script &&
>> +	test_path_is_missing .git/rebase-merge/patch &&
>> +	test_path_is_missing .git/MERGE_MSG &&
>> +	test_path_is_missing .git/rebase-merge/message &&
>> +	test_path_is_missing .git/rebase-merge/stopped-sha &&
> 
> This also seems to be testing implementation details, and if so, it
> would be worth removing them.

With the exception of the "patch" file which exists solely for the 
benefit of the user this is testing an invariant of the implementation 
which isn't ideal. I'm worried that removing these checks will mask some 
subtle regression in the future. I think it is unlikely that the names 
of these files will change in the future as we try to avoid changes that 
would cause a rebase to fail if git is upgraded while it has stopped for 
the user to resolve conflicts. I did think about whether we could add 
some BUG() statements to sequencer.c instead. Unfortunately I don't 
think it is that easy for the sequencer to know when these files should 
be missing without relying on the logic that we are tying to test.

Best Wishes

Phillip
