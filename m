Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB75C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0366120753
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kREDDVqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCTAeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:34:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 20:34:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id 111so4383608oth.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+dURAKiDJcQylvsoY838nbe/48fXB/TIiEsANXfv/oM=;
        b=kREDDVqUdJqTwEm6FCt2qyru2NEhdCWyaASVGbyM9fWXPcqwcS6AcM9/TZKt4jRrVS
         Hxb7P4OJw780rC4vpHpBfPDJKcmEaDrDp5NQxHUQr36AZFZ16xg1IV9Yj3UiSy1c6BB+
         rpMNHcLASq+aiW6qmZFHAxtq1pkgz2PhaK3Tx1ACkjjIlP5dTq4VCCcnbn0G32GCj5Gk
         5Aga28iAzV+Ef1JOfZ88EZEtCUDnbplazsJX/7T7F6ESMqqoivmwv6LIdq+aRUhAQph6
         W1V50rLdTqAR6f8gqEVZ2yDzoV7eGzTh81b/Ax1ThgeQIuy/AABmWoUQJzS/b+6hWiVD
         cYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dURAKiDJcQylvsoY838nbe/48fXB/TIiEsANXfv/oM=;
        b=B9TS4p8RpPd3mXcAxEcbt0M3+9EfHFaFcfgvv/GwlJ2j3JMPqoIBAZ2KGBxHD+zqXN
         ruJnlvpIMaEeyA2RXdFq59AyfMfk+BZBnSeFX0BChF41fs77oMVNTZhprH/Qubl650XB
         hVTZYN5+QAvXua3JurBM23RLKlM8a3BloJgFyLKdrjG7F6LK0bcJrzBf2VWSJwAAUDG2
         OLC+LoCPKQbMC/UfpYbo/8taLVvs5pC+xmAvtd/Ii1VCu7SDPUEvfmoBIMEabjubhPMy
         0piMiTBnJCjDU+ilJXw+M1RKokduTraq7aH9Xjnk/JHCApYTjOfgPCHQ1lcjpUCswJNW
         egxQ==
X-Gm-Message-State: ANhLgQ1u8z0zqoaaAWK8QL6cpbn0hoe+1QZrLwtM+xpLcYuk2K1PN4+8
        oy3sINNVzdz0mjyJowbfwD0TkERZByk=
X-Google-Smtp-Source: ADFU+vtYVLC0eQo5cPRthbtRV35UrVHtxRMfDYg/ELf3B55wrTiYrW1+tXBN49lPcaRfnEEpsvTsyA==
X-Received: by 2002:a05:6830:118d:: with SMTP id u13mr4392943otq.41.1584664443818;
        Thu, 19 Mar 2020 17:34:03 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t206sm1410103oib.7.2020.03.19.17.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 17:34:03 -0700 (PDT)
Subject: Re: [PATCH] config: set pack.useSparse=true by default
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
 <20200319231332.GB129493@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7986b9d0-34cb-5a60-484d-ba268dad146a@gmail.com>
Date:   Thu, 19 Mar 2020 20:34:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200319231332.GB129493@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2020 7:13 PM, Jonathan Nieder wrote:
> Hi,
> 
> Derrick Stolee wrote:
> 
>> The pack.useSparse config option was introduced by 3d036eb0
>> (pack-objects: create pack.useSparse setting, 2019-01-19) and was
>> first available in v2.21.0. When enabled, the pack-objects process
>> during 'git push' will use a sparse tree walk when deciding which
>> trees and blobs to send to the remote. The algorithm was introduced
>> by d5d2e93 (revision: implement sparse algorithm, 2019-01-16) and
>> has been in production use by VFS for Git since around that time.
>> The features.experimental config option also enabled pack.useSparse,
>> so hopefully that has also increased exposure.
>>
>> It is worth noting that pack.useSparse has a possibility of
>> sending more objects across a push, but requires a special
>> arrangement of exact _copies_ across directories. There is a test
>> in t5322-pack-objects-sparse.sh that demonstrates this possibility.
>>
>> Since the downside is unlikely but the upside is significant, set
>> the default value of pack.useSparse to true. Remove it from the
>> set of options implied by features.experimental.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/config/feature.txt | 3 ---
>>  Documentation/config/pack.txt    | 4 ++--
>>  repo-settings.c                  | 3 ++-
>>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> Makes sense.  Thanks for writing it.
> 
> Should this have a test?

I suppose the test that demonstrates the difference in algorithm
in t5322-pack-objects-sparse.sh could be adjusted to drop the
explicit config setting, which would demonstrate that the config
option is being set correctly.

While looking at that test, I see that we use --[no-]sparse
explicitly everywhere to avoid conflicts with the GIT_TEST_*
variable that enables the algorithm. This leads to two things
I will do in v2 that I did not do here:

1. Update the docs for "git pack-objects" because it doesn't
   reference that --no-sparse is an option. Point out that the
   new default is --sparse.

2. Remove GIT_TEST_PACK_SPARSE which was used to test this sparse
   algorithm throughout the test suite.

Thanks,
-Stolee
