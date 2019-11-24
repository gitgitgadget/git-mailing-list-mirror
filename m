Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA80C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 10:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B7B20706
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 10:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGj4teNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKXKwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 05:52:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36724 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfKXKwH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 05:52:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so10610649wme.1
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TKHiNgqhGT3cmLqgLGurJpW6T0pSILxhNp/lmzexXVo=;
        b=bGj4teNr/99D3sKnrOeI8WhLTO3Qod7tyc1OZ7x2SNNnanpiRV4dsZV1jaDfWZ+g0q
         ZO5Su1O6TQ/gd0S23P4d2/2x1oEJpEMghYGOPFyaaDlD5b1uklX/Qd5NWzeCj7gSOSbZ
         YuySIsKwYhCCDk1Y7QhRV0OsIEq+Uwm36pVyovp6c5oHXgAQ+Q0IPM8VsJcoPvnIuzrW
         camV7Espju2wgUt3YaPaT+E9zWzX0InMbGiVV7loC7L3fquhmAYg53qhLWEeRwlwReds
         6Ckiax9MokIWBZdjq8ochpeLeL/DvPetGvBvBZKCWVQYHQyWADMJUdJw2i3Ra3I+UGzC
         kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TKHiNgqhGT3cmLqgLGurJpW6T0pSILxhNp/lmzexXVo=;
        b=tpx/n8X1Qk1zd+GltbXgC3XGeyGwh1HEbC5HuEVr694r6w5RC5M/4cLpSBMT0ILLSg
         wDYgG8nDvZqq2xEwG1t7p1pRLVRYTTmLHMddnXSTIJ2tDjjRbHY/wOCL6j9f2rIcuAT8
         2xPXUSdkeU8yEb7fgR8Zg1izxyJmxMMUv3s/ACcKP4AUmyluOL6+BSTfw6PXlzX8QEM+
         QVtcEaww/T9zMrI96aucZYv38w48VJDrI3xgAOblk5CpwCvgU0lGXvHnmcZbnhRbU2nM
         ujPvw8oOvFO9Ued8uUe17dC4Ocz/Qmhm0yH6OgPwsMadm5C22DDlXCbEVV39e+Kvmbxk
         cEyw==
X-Gm-Message-State: APjAAAXQQcxsLmrHCR6G1ISD7l5AfTpSeqgJ5adpDiRwKFEsnj3sgimL
        7bK57mFD36OPSYWUyg3XCihQWaZ6
X-Google-Smtp-Source: APXvYqyek5yw4Hx6Z4GW5t7k26pHKDye+PgJH4fVXipjcCHoKoCOOTKViVYY15x7PMx/g/h94dwn2w==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr23666916wmc.64.1574592724631;
        Sun, 24 Nov 2019 02:52:04 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id f24sm4726274wmb.37.2019.11.24.02.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 02:52:04 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
 <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
 <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
 <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
Message-ID: <94573071-556b-caae-b159-40c168a08f44@gmail.com>
Date:   Sun, 24 Nov 2019 10:52:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 23/11/2019 09:54, Phillip Wood wrote:
> Hi Junio
> 
> On 23/11/2019 02:03, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +    if (!(flags & ALLOW_EMPTY)) {
>>> +        struct commit *first_parent = current_head;
>>> +
>>> +        if (flags & AMEND_MSG) {
>>> +            if (current_head->parents) {
>>
>> It is not apparent to me that somebody guarantees that this access
>> is safe; would we need to do things differently when !current_head?

We do actually check that there is a valid HEAD before we try to fixup a 
commit. Though perhaps we should still change this patch as HEAD may be 
changed by another process between that check and re-reading it here. If 
you try to fixup a commit without a valid HEAD you get

error: need a HEAD to fixup
hint: Could not execute the todo command
hint:
hint:     fixup faef1a5a7637ff91b3611aabd1b96541da5f5536 P
hint:
hint: It has been rescheduled; To edit the command before continuing, please
hint: edit the todo list first:
hint:
hint:     git rebase --edit-todo
hint:     git rebase --continue
error: could not copy '.git/rebase-merge/message-squash' to 
'.git/rebase-merge/message'

The last error message is unfortunate but we do exit in an orderly 
manner rather than segfaulting. It's a bit tricky to trigger this (there 
isn't a test at the moment) but something like this does it

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2f1d5bd23..4f55f0cd1c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -67,6 +67,21 @@ test_expect_success 'setup' '
  SHELL=
  export SHELL

+test_expect_success 'fixup on orphan branch errors out' '
+
+       test_when_finished "git switch master" &&
+       write_script switch-branch.sh <<-\EOF &&
+       git symbolic-ref HEAD refs/heads/does-not-exist &&
+       git rm -rf .
+       EOF
+       (
+               set_fake_editor &&
+               FAKE_LINES="exec_./switch-branch.sh \
+                           fixup 1" git rebase -i HEAD^
+       ) &&
+       test_pause
+'
+

I think it would be useful to add something like this to the test suite 
(changed to check the error message, with a better name for the script 
and modified to expect failure) What do you think?

Best Wishes

Phillip

> That's a good point, I'll fix it, thanks for catching this
> 
> Best Wishes
> 
> Phillip
> 
>>
>>> +                first_parent = current_head->parents->item;
>>> +                if (repo_parse_commit(r, first_parent)) {
>>> +                    res = error(_("could not parse HEAD commit"));
>>> +                    goto out;
>>> +                }
>>> +            } else {
>>> +                first_parent = NULL;
>>> +            }
>>> +        }
