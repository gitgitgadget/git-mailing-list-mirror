Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B940720365
	for <e@80x24.org>; Tue,  3 Oct 2017 11:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdJCL0H (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 07:26:07 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55149 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdJCL0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 07:26:06 -0400
Received: by mail-qt0-f181.google.com with SMTP id i13so12294994qtc.11
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SzzevRoYWZM/g8HOfeSHOABAVmh1tVHaE1uYm5XVwD8=;
        b=l0rbcEZbUJF6Mlv9CMDEULf5d4HtQQvm0XWt9AVdSiB4i2snUkRCvbGEJJw2Acftnd
         DiRudBfFezepPxhnE7mTchaNkKlr8bfPUVcicNdWuzvJWxpYSgKmSTYDrsfZGvLh8IWl
         GihDmM6vdrUvg2IwLLZQrOfWaT/z0G7ez06XC/wf1b+6PBjqg3kCqPv/jq7vzOHr8KPI
         ijdWuylgPKYssHc9qmB2ckTXy86IjBsd0uhx9VR/vghSwX+qgLtA6OvDkMHQFsAwBs3S
         kHCLBI1qLG2J1kAHYWnn1Y4/tb2bn3TPybgpw79XZgARH2XlmvRVkrLZBSZdFOB7wk7G
         JzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SzzevRoYWZM/g8HOfeSHOABAVmh1tVHaE1uYm5XVwD8=;
        b=INlW8FauUr8alB2qLLpNkyyffXAvBHumLgH8EGARHtdJ+RRswygyc8cwm1PTexJIzK
         CPlTMrEyEroark3q9FEGPhhWRsQ7UK0tJWjRFJusLbNfD5t+oFMQQQjB6nX9it7/cxlD
         XUtOuCljoxI1ly9ElafkvjyWgknb0JhI7nYvjwYHp3zlPLwf1IBOIXm8PldMdU0GHLbD
         uxG6Y/V0sVWsvhR+p/UpLGHzzFrg/5FTsb1vom4cJPCq1qcXnFAkFGYF0QYUJfTzKhb9
         i18W8d0wE95sf6RsbzfPkqoWxCRBwCYPOzZ1M9JOnxeMsVRVwZaOkv8p+YhDSqtp6aB6
         yCUQ==
X-Gm-Message-State: AMCzsaUaIGMLfCR8Jwa6hvMq3qaIGrszXkeGacsOdoekzwp04NIOvWC5
        wojJCNtQlUXLZA6rnsfLFME=
X-Google-Smtp-Source: AOwi7QC+FTVSrt516ke0rh84/XGKejbRY2IYjfZMkAfvs0uaLdLmwKhXg/ziytDuHALlweCP523qXw==
X-Received: by 10.200.4.158 with SMTP id s30mr23374857qtg.311.1507029964486;
        Tue, 03 Oct 2017 04:26:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id k11sm1610013qtg.62.2017.10.03.04.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 04:26:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, sbeller@google.com
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-4-dstolee@microsoft.com>
 <xmqqinfwh5g0.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6a3804a4-9728-d122-7fac-f297fc7977d1@gmail.com>
Date:   Tue, 3 Oct 2017 07:26:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqinfwh5g0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2017 6:49 AM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> p0008.1: find_unique_abbrev() for existing objects
>> --------------------------------------------------
>>
>> For 10 repeated tests, each checking 100,000 known objects, we find the
>> following results when running in a Linux VM:
>>
>> |       | Pack  | Packed  | Loose  | Base   | New    |         |
>> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%    |
>> |-------|-------|---------|--------|--------|--------|---------|
>> | Git   |     1 |  230078 |      0 | 0.09 s | 0.06 s | - 33.3% |
>> | Git   |     5 |  230162 |      0 | 0.11 s | 0.08 s | - 27.3% |
>> | Git   |     4 |  154310 |  75852 | 0.09 s | 0.07 s | - 22.2% |
>> | Linux |     1 | 5606645 |      0 | 0.12 s | 0.32 s | +146.2% |
>> | Linux |    24 | 5606645 |      0 | 1.12 s | 1.12 s | -  0.9% |
>> | Linux |    23 | 5283204 | 323441 | 1.08 s | 1.05 s | -  2.8% |
>> | VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.23 s | + 91.7% |
>> | VSTS  |    32 | 4355923 |      0 | 1.02 s | 1.08 s | +  5.9% |
>> | VSTS  |    31 | 4276829 |  79094 | 2.25 s | 2.08 s | -  7.6% |
> The above does not look so good, especially in cases where a
> repository is well maintained by packing into smaller number of
> packs, we get much worse result?
I understand that this patch on its own does not have good numbers. I 
split the
patches 3 and 4 specifically to highlight two distinct changes:

Patch 3: Unroll the len loop that may inspect all files multiple times.
Patch 4: Parse less while disambiguating.

Patch 4 more than makes up for the performance hits in this patch.
>
>> p0008.2: find_unique_abbrev() for missing objects
>> -------------------------------------------------
>>
>> For 10 repeated tests, each checking 100,000 missing objects, we find
>> the following results when running in a Linux VM:
>>
>> |       | Pack  | Packed  | Loose  | Base   | New    |        |
>> | Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
>> |-------|-------|---------|--------|--------|--------|--------|
>> | Git   |     1 |  230078 |      0 | 0.66 s | 0.08 s | -87.9% |
>> | Git   |     5 |  230162 |      0 | 0.90 s | 0.13 s | -85.6% |
>> | Git   |     4 |  154310 |  75852 | 0.79 s | 0.10 s | -87.3% |
>> | Linux |     1 | 5606645 |      0 | 0.48 s | 0.32 s | -33.3% |
>> | Linux |    24 | 5606645 |      0 | 4.41 s | 1.09 s | -75.3% |
>> | Linux |    23 | 5283204 | 323441 | 4.11 s | 0.99 s | -75.9% |
>> | VSTS  |     1 | 4355923 |      0 | 0.46 s | 0.25 s | -45.7% |
>> | VSTS  |    32 | 4355923 |      0 | 5.40 s | 1.15 s | -78.7% |
>> | VSTS  |    31 | 4276829 |  79094 | 5.88 s | 1.18 s | -79.9% |
> The question is if this is even measuring a relevant workload.  How
> often would we have a full 40-hex object name for which we actually
> do not have the object, and ask its name to be abbreviated?
>
> Compared to it, the result from p0008.1 feels a lot more important.
> We know we make tons of "abbreviate the object name for this object
> we have" and we see them every day in our "git log -p" output.
>
> Seeing a lot more impressive result from p0008.2 than p0008.1 makes
> me unsure if this patch is optimizing for the right case.
>
> I'll have to see the code a bit deeper before I can comment on it.
>
> Thanks.
I agree that p0008.1 is more important. p0008.2 covers an important case 
of the
previous implementation. The line

     exists = has_sha1_file(sha1);

will inspect all packfiles and scan the full loose-object directory that 
would contain
the object. The only reason for this call is to determine how to inspect 
the result of
get_short_oid(), but is a significant portion of the time that is gained 
here.

Thanks,
-Stolee
