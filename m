Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F35C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64AB613D3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhFKRaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:30:39 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46980 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKRai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:30:38 -0400
Received: by mail-qt1-f182.google.com with SMTP id a15so3134784qtx.13
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=63r2xuzJ0+MmW/CSJaGcmBp3PZjZPQl1ssEpCYXi2A4=;
        b=DwpVvSCFela837doLd2Ik/Sw0fN60nZMI0VWXTiytqhktfKxApsdBRyprtz1EhWFjt
         AfuR7lPTl+YQK2UCwJM7XjUzh7h/Fj/5I6HRppXpsU0LA2TmwF9hgNaD658Ik2HPLEgH
         DRDRArpLobYYlA3ySK/jODRVrz5u6C4xw9vrQ1ynaRb7xMie1AeUXxrp2YXOywUIllBP
         UGtTYuLHbOVk5RJgz3o4nKnwCqrD6SbweFVVnglhoLrcho5Oawn9p2WZbVhj1wULGB5i
         Wc9tu/w5b0Z9sP+pzjIP6LsNiTZLPVKWgmVaEV+Qq8dmQQ692Wa5nl4tX22rHlSF9pcD
         eryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=63r2xuzJ0+MmW/CSJaGcmBp3PZjZPQl1ssEpCYXi2A4=;
        b=azQ5XGAmbgBpn4Dhji+cj4n77B6aCcFVXaq6tIuO9N5YB+I1Ji/Wq9Go4g6CUVOS21
         MHPzMJH3/Kfrs8jy0Yd4pIzUX8c+h1F5S+TO0hD/4EKhP/0Z87iB/eucE1+TNA2CLZk+
         60lhRjw3wQxlIrZu1Rg9JLq0RKxBd9wG6wtJHWPpv/uFEHt5T3Gy097AzglzmY7BAM4E
         vlg1Ae7C2mz/n8HiLEWEQP+KMbMqWbhrWUJG5/Mb1mUdXjV6KrW0iH1nnRIH9QKVrrvY
         DsMzRRRnRoULtlWIFhb8+/poDfi3lly7JYVB/0b2s4IY8dO6uCNk4tkCplBFi/yPea8B
         3Tlw==
X-Gm-Message-State: AOAM5329iCy+mYJ36djmcmDUChIxgKA9OkcuKCBtHCUjVf4D81XHbWaf
        A4qMWBZcpL+dmGLZxp//GVE=
X-Google-Smtp-Source: ABdhPJw/EeyneuuGcKJJulBh9S8+6fHqeWkVw5B65ODUP0gGiHiw/rGNFFYXJLnO0QTmZlaPGv74dw==
X-Received: by 2002:a05:622a:ca:: with SMTP id p10mr4991384qtw.83.1623432460386;
        Fri, 11 Jun 2021 10:27:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c70:274a:799:2c37? ([2600:1700:e72:80a0:3c70:274a:799:2c37])
        by smtp.gmail.com with ESMTPSA id t62sm4846947qkc.26.2021.06.11.10.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:27:39 -0700 (PDT)
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
From:   Derrick Stolee <stolee@gmail.com>
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
 <7d6ca59b-2713-5c10-88de-963efc7779fc@gmail.com>
Message-ID: <2784d29b-b22a-2bf6-2450-7b4a0a72df54@gmail.com>
Date:   Fri, 11 Jun 2021 13:27:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7d6ca59b-2713-5c10-88de-963efc7779fc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2021 8:57 AM, Derrick Stolee wrote:
> On 6/10/2021 5:31 PM, Elijah Newren wrote:
>> On Thu, Jun 10, 2021 at 10:45 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> I'll send a new version with this patch tomorrow, as well as the
>>> other recommended edits.
> 
> ...still planning on this today, but...

So optimistic!
 
>>> +       /*
>>> +        * If both are sparse directory entries, then expand the
>>> +        * modifications to the file level.
>>> +        */
>>> +       if (old_entry && new_entry &&
>>> +           S_ISSPARSEDIR(old_entry->ce_mode) &&
>>> +           S_ISSPARSEDIR(new_entry->ce_mode)) {
>>> +               show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
>>> +               return 0;
>>> +       }
>>
>> What if S_ISSPARSEDIR(old_entry->ce_mode) != S_ISSPARSEDIR(new_entry->ce_mode) ?
> 
> You make a good point that something different would happen
> in the case of a directory/file conflict on the sparse checkout
> boundary. This can be as simple as the trivial "only files at
> root" cone-mode sparse-checkout definition, with "folder/" (tree)
> changing to "folder" (blob).
> 
> I'll see what I can do to create a test scenario for
> this and add the correct cases.

Creating a directory/file conflict in this way exposes a bug in
a different codepath in unpack_trees(), although it isn't visible
until 'git checkout' allows the index to stay sparse. It's due to
the code in unpack_callback() that handles blobs and trees
differently, and hence the blob/tree conflict isn't handled
appropriately there. The changes from Patch 8 are to blame for
these first errors.

At least, those are the first errors I have discovered with these
conflicts. There might be other scenarios that care about this
section of diff-lib.c, but I have not gotten to a point where
such behavior would be exposed.

I don't expect to succeed in squashing this bug today, so I'll
try again next week.

Thanks,
-Stolee
