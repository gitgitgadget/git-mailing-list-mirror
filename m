Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8DC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1944E61029
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 12:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFKNBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:01:02 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40493 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKNBB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 09:01:01 -0400
Received: by mail-oi1-f173.google.com with SMTP id d19so1657530oic.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIp4/GHmJsTNRxbyhNIk9PEEm1koULwwbK2+k2oyqbs=;
        b=ip2kcap/3n9SLhzamHjbZykiUxCJxr8MSZrcskFC1pdG12+nCIXGoxyhrf/gOJDxAM
         xdSJ9XIxf9zpyn6eBjOJkkTkQXXUESixU/MdTtkegetWAg3gZv5UnBPP6BMH2oPFmCod
         T1yYDSxSGwqfkk4580OfiaEFfAwaQFID0vMVG2qfec+9U42aKLt+z5WwJD6pAloUln4w
         qvycbjmVWrlbGrXiv3FGU0abEtDGnvSn6lhH8Wc7bWnpCJVI/Mf4rAfwsoBmM/Ur8S00
         bP7sTRzkNPaeQajSwuVTavOrcD74lz4GiMNLOIYsnNUfRC/ImG86a1jHS5Lx5omFyn4I
         KFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIp4/GHmJsTNRxbyhNIk9PEEm1koULwwbK2+k2oyqbs=;
        b=WPNNQZtPyk/6Q/AboxNJxKuncrFxPvpaeSdamMhmapTNqhKh6qEug/wUKA12+RiYnZ
         CRCLjD5z1wKh7/lW1NYW2anEMwXwpFQmZdHDgq7v8Y9HKvv90IYnY5QMqHhwL9yq9brQ
         ctyQAV923e8Z4ZTE35HYWwMjJy4hV+lGRMF4SbCqcqkx+q2WKThL4wiSTjrSnaeHIMyM
         mEbyXb0yKvjRuoUUE4VGMHZe93NFhGCVIhVDoQJFXc1ktVE08HRBhRmALgcZrt3um37V
         YU4lWRHJr9/a5ykLWumth4EaO22PLJw1bbjPFosDrwUXI9woEvQntg26MVJc5wDg22rS
         6mYw==
X-Gm-Message-State: AOAM533CgXqwm2RnGvZdckLtBa7SYO2gbwT96p3zp/Hjj6FRDZ+fbNhA
        VbA3r+mibZRFfmJ6232QNaRjsXK4w4o0hg==
X-Google-Smtp-Source: ABdhPJwPRrb+48rZ6fBBE60NCSw/HPLeFIUCgSBUlqTk69ho1HRyUP2K7BPZ8OokywbFskyDE97v3g==
X-Received: by 2002:aca:fc0d:: with SMTP id a13mr2379079oii.14.1623416274383;
        Fri, 11 Jun 2021 05:57:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c70:274a:799:2c37? ([2600:1700:e72:80a0:3c70:274a:799:2c37])
        by smtp.gmail.com with ESMTPSA id h23sm1166056oih.30.2021.06.11.05.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 05:57:53 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
 <xmqqfsxrk0oc.fsf@gitster.g>
 <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
 <60844f4b-33d4-b6d7-3611-a93cf012d3ff@gmail.com>
 <38d0900b-c677-a32d-cc63-e615828e9a5d@gmail.com>
 <CABPp-BHFdG9=JfR7fnwSjNgJ2o=ttHn--ogD3_LQLYKe4dV9SQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7d6ca59b-2713-5c10-88de-963efc7779fc@gmail.com>
Date:   Fri, 11 Jun 2021 08:57:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHFdG9=JfR7fnwSjNgJ2o=ttHn--ogD3_LQLYKe4dV9SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 5:31 PM, Elijah Newren wrote:
> On Thu, Jun 10, 2021 at 10:45 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/9/2021 4:33 PM, Derrick Stolee wrote:
>>> On 6/9/2021 4:11 AM, Elijah Newren wrote:
>>>> On Tue, Jun 8, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>>
>>>>> Elijah Newren <newren@gmail.com> writes:
>>>>>
>>>>> The tree-diff machinery takes two trees, walks them in parallel and
>>>>> repeatedly calls either diff_addremove() or diff_change(), which
>>>>> appends diff_filepair() to the diff_queue[] structure.  If you see
>>>>> an unexpanded tree on the index side, you should be able to pass
>>>>> that tree with the subtree you are comparing against to the tree-diff
>>>>> machinery to come up with a series of filepairs, and then tweak the
>>>>> pathnames of these filepairs (as such a two-tree comparison would be
>>>>> comparing two trees representing a single subdirectory of two different
>>>>> vintages) before adding them to the diff_queue[] you are collecting
>>>>> the index-vs-tree diff, for example.
>>>>
>>>> Good to know it seems my idea might be reasonable.
>>>
>>> I agree that this is reasonable. I just didn't look hard enough
>>> to find existing code for this, since I found traverse_trees and
>>> thought that _was_ the library for this.
>>
>> This was surprisingly simple, since most of the complicated stuff
>> is built into diff_tree_oid() and its use of revs->diffopt. The
>> new patch works as shown below the cut-line.
>>
>> I was incredibly suspicious of how quickly this came together,
>> but it passes all the tests I have for it (including Scalar
>> functional tests with the commit, checkout, and add integrations).
> 
> Nice!
> 
>> I'll send a new version with this patch tomorrow, as well as the
>> other recommended edits.

...still planning on this today, but...

>> +       /*
>> +        * If both are sparse directory entries, then expand the
>> +        * modifications to the file level.
>> +        */
>> +       if (old_entry && new_entry &&
>> +           S_ISSPARSEDIR(old_entry->ce_mode) &&
>> +           S_ISSPARSEDIR(new_entry->ce_mode)) {
>> +               show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
>> +               return 0;
>> +       }
> 
> What if S_ISSPARSEDIR(old_entry->ce_mode) != S_ISSPARSEDIR(new_entry->ce_mode) ?

You make a good point that something different would happen
in the case of a directory/file conflict on the sparse checkout
boundary. This can be as simple as the trivial "only files at
root" cone-mode sparse-checkout definition, with "folder/" (tree)
changing to "folder" (blob).

I'll see what I can do to create a test scenario for
this and add the correct cases.

Thanks,
-Stolee
