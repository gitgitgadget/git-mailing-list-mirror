Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47E81F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfAXTRl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:17:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45631 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAXTRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:17:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so3960040qka.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=emfKEtyCMTpMK8+AmYhrlz08STOuANxWJF8bRrAXB4Y=;
        b=fdEW5MDekFvX/HYt67kbvE3RSAgdBcBs9Ver824EKJ4EVn4OrzSM9yjkhF1+rXxe1a
         yVRtj145R4SNkwdRxEmEf4T50irscocjsuMgSSAXBd+EYq/poO+z0UzulxE7+HUGTXtj
         tJrUDYChQLNX7hdL0z3iCoQ0EK0aoN23QjSLkpfVduxLUZhyRA5pzDFaeDdSZd2zTca2
         nluuvfVSmPhRtGXPgp5p9FOEW9wBcWyzflkR0rOvi/aMuEA1iietzbY3NXQt26f+GspJ
         M5AuJFh6ee0oVK2gI8pvsFg52FTMHl+tRaEPqXIuYwGnLNYQOJDy55seBIKkvHSr4PdU
         aH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=emfKEtyCMTpMK8+AmYhrlz08STOuANxWJF8bRrAXB4Y=;
        b=sRzEJNtoF+SzdeIjJJMpQGxInUOgrAqFLA2iU4fgmG/5hFWjBGXKZ3Z+1mR96ud4Mi
         PaEBFLaMXCJITQdzY2Et3M1iKJmPUh4BMvRskduqv0szsjcGCQWd3WOP7YEhWq2waWK5
         kA40Atv8J+SSJ1bLUTy7j/LCi4qMlwHC8hbhMnjk2V9MXVb7FKo2KxydsxeARGnnDYd7
         ItSKTNENzehlNaFvJci5qdX7lnkwEfjXzAYIqa6PWpZGgbAaqJNJiLmtETliNBSw9x4N
         CXdzYmR84srCIyzvWIbAx9Hhyqj7UxGuInxCcv4AfRqciAayGPV97nBJGWjdIvYzlhyb
         KZsA==
X-Gm-Message-State: AJcUukfcsK6bJx26Lntt49uNZ01ILvKmYUmcLszIum2J0+5UDzhlqZzc
        lotR5GG85Z+xioUCtFWqK7o=
X-Google-Smtp-Source: ALg8bN7H2QHN2L4Cd663Flc85S5E/m25GhXPor+Y3dK/ytCWgiI1XxAZUOzoED1XGdZtE861rxUhyQ==
X-Received: by 2002:a37:a141:: with SMTP id k62mr6872723qke.280.1548357460165;
        Thu, 24 Jan 2019 11:17:40 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:0:8946:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id o48sm73411149qtb.87.2019.01.24.11.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:17:39 -0800 (PST)
Subject: Re: [PATCH v3 5/9] midx: refactor permutation logic and pack sorting
From:   Derrick Stolee <stolee@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com
References: <a0d4cc6cb3fbca0de732dfd34cbec4d765b55228.1547047269.git.gitgitgadget@gmail.com>
 <20190123210054.118647-1-jonathantanmy@google.com>
 <14fe05d0-75e5-0975-d490-550539dbb34a@gmail.com>
Message-ID: <295eb5fb-5497-0517-a5ed-af96aafb3133@gmail.com>
Date:   Thu, 24 Jan 2019 14:17:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <14fe05d0-75e5-0975-d490-550539dbb34a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 12:34 PM, Derrick Stolee wrote:
> On 1/23/2019 4:00 PM, Jonathan Tan wrote:
>> Indeed, the sorting of pack_info is moved to after get_sorted_entries().
>> Also, pack_perm[old number] = new number, as expected.
>
> Thanks for chiming in with all the detail on the use of 'perm'. This 
> is the most confusing part of this code path.
>
>> I think a comment explaining why the perm is needed would be helpful -
>> something explaining that the entries were generated using the old pack
>> numbers, so we need this mapping to be able to write them using the new
>> numbers.
>
> I can put this comment in the struct definition. Is that the right 
> place for it?

I mistakenly thought the pack_perm array was placed into the pack_list 
struct. I'll put the comment right before we populate the contents of 
the array.

Thanks,
-Stolee
