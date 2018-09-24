Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460881F453
	for <e@80x24.org>; Mon, 24 Sep 2018 17:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeIXX20 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 19:28:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45608 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeIXX20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 19:28:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id q20-v6so7521451qkc.12
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nhcJxIlk++ReBND0ga8cSeQGJEOOTatvsf6NcRkCR98=;
        b=Wv3VhpRycnXId1PBOpfiOqZMLD1VBzf7A/kXWsYvtVMmzgqSuW2iOTkprSA8e0qyWt
         BDcx2ZoRrSBmd107fqmJ7pFO4004QeHvfWtwL8Lz47SBpXapFEpbG85K9Y4bcyj5kzCs
         zxCts32rkMM+V1XJG1c7zDHe86LTVUbusPNpdavSTFWUB6HbCkP1+0DMKqIQtrQ1i4Qq
         cvPFv1rdn3oLA6KPGUVI6NxxaE5q6sEtJlRJPlAfkC3bBktD3uLaZ3QBMhS51riIp+em
         ZAZt7RMv9L7lQHF+r408jQV1FxLal4JJ1UNLYdIY+S4HjXmnGvxV6009vJ7Jp1nEYNRA
         rKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nhcJxIlk++ReBND0ga8cSeQGJEOOTatvsf6NcRkCR98=;
        b=pNs0aYqcQnYReXHKRgiYhhHUiuIJoS/air/a8KTiduTOo83MwY2AcUPdvdzsB7A+fS
         hDPdxbNaMWrRxQB+vEv2JRwnATtGmDondOd7LAfXsukDanDZXKK4nTryoXTgzpqTe877
         OOnzmT5dUsRRXAB6L6FmHa6JGWaCumGKIc3J/vYSNcdw+HPlnkwp0t76IPNJ3h0bRRCg
         6G06Ec6jX/EziawA6PeRxlKjAcczuS1OtjjyeoOcxhoqPAVQPNDJOZ/nIjL/B21gEXPa
         kQ00HVBfr6QOKhdrebvS4ly33Es//z0Lf6xPIeRRpLVyAHleEv9u1SO1s5f7wbhZOnLK
         g2tg==
X-Gm-Message-State: ABuFfoj2wBmsu/ARmK+0TYzWGYt+ki2Nw9rDM9eH8B2iMvYrNtpWY1M1
        7b6xyd9t+W4UnI0tENZ1d2Q=
X-Google-Smtp-Source: ACcGV606DRq44R9TEw4NUsTdxt3ws0mp2+DiKwyVDtCHOepvMPRciOV6taY5b4PxsReP++k1w0VfGw==
X-Received: by 2002:a37:d743:: with SMTP id m64-v6mr5577499qki.322.1537809913777;
        Mon, 24 Sep 2018 10:25:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c0ea:9fdb:fe08:b63a? ([2001:4898:8010:0:aa20:9fdb:fe08:b63a])
        by smtp.gmail.com with ESMTPSA id f53-v6sm25779844qtk.40.2018.09.24.10.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:25:12 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] commit-reach: fix memory and flag leaks
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
 <pull.39.v3.git.gitgitgadget@gmail.com>
 <b2e0ee49788bfbf2182df7a93694333568552962.1537542323.git.gitgitgadget@gmail.com>
 <20180921235803.GB3437@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c8320650-230a-9a17-df79-9555d5214bd2@gmail.com>
Date:   Mon, 24 Sep 2018 13:25:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921235803.GB3437@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 7:58 PM, Jeff King wrote:
> On Fri, Sep 21, 2018 at 08:05:27AM -0700, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The can_all_from_reach_with_flag() method uses 'assign_flag' as a
>> value we can use to mark objects temporarily during our commit walk.
>> The intent is that these flags are removed from all objects before
>> returning. However, this is not the case.
>>
>> The 'from' array could also contain objects that are not commits, and
>> we mark those objects with 'assign_flag'. Add a loop to the 'cleanup'
>> section that removes these markers.
>>
>> Also, we forgot to free() the memory for 'list', so add that to the
>> 'cleanup' section.
> Urgh, ignore most of my response to patch 1, then. I saw there was a
> patch 2, but thought it was just handling the free().
>
> The flag-clearing here makes perfect sense.

In my local branch, I ended up squashing this commit into the previous, 
because I discovered clear_commit_marks_many() making the cleanup 
section have this diff:

@@ -600,10 +622,12 @@ int can_all_from_reach_with_flag(struct 
object_array *from,
         }

  cleanup:
-       for (i = 0; i < from->nr; i++) {
-               clear_commit_marks(list[i], RESULT);
-               clear_commit_marks(list[i], assign_flag);
-       }
+       clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
+       free(list);
+
+       for (i = 0; i < from->nr; i++)
+               from->objects[i].item->flags &= ~assign_flag;
+
         return result;
  }

With the bigger change in the larger set, there is less reason to do 
separate commits. (Plus, it confused you during review.)

Thanks,

-Stolee


