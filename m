Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F74E20365
	for <e@80x24.org>; Wed,  4 Oct 2017 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdJDNGg (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 09:06:36 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:47050 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdJDNGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 09:06:34 -0400
Received: by mail-qt0-f181.google.com with SMTP id 6so9890012qtw.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KLouU9mlDl8NiirzK7s19N67eGRrj5qA+TM7jfJg0lU=;
        b=UYUWZrBmPA5VBVeGmu6RG0Xhh0JJB9YigLo03AHK5btqpHHDAGn3qth+9O1N4xpsGR
         XdnhC4muTxGffHdPt5cCaDiQJL77dEFoZeJyeg4AI8TivGsDdvWPznw3UEKSYjpMZitT
         oWG+xCuWyWjLV8no+kToZ3hqIJ/GqSDznHqwLkf4VvpOmtYWcZPBZAzC6PaFZgIzmZPt
         iNCseNPl5g6ldsLbdbgNkGqD3nkgxcmdy/qGiSJwP1107vgI8wSGX8xJyYdZj+cBSMSm
         93YMCSxILd9mzZVYUn4lBTmQJ7RRbIsfrOt2mDQGIr4LFFMEysViBVbWLWOqeu0aIdzh
         VOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KLouU9mlDl8NiirzK7s19N67eGRrj5qA+TM7jfJg0lU=;
        b=it0vGRbPf1v1uUV8ENdc9UkFbpCRgCtDbfu6BrfBT+5BLRYWEIEe6isvdywxPSfC2U
         8ZgtnlwUwi1hs90vmgjRez+6rtIFWAfwv/khCIaBa44jSsvS3QHVnIrwcbmdmssaoQGc
         fTLDb4jCptspE2pDegXWXoVwQe1IX//MV6GM4dutdI/LUySJL/aN3maHV4N7oQlIqE34
         +WrqCCfqJsM89CitUhYmMavz4msV6yb2v5oQw1n0T3DZDB0h7Sa7UY2jJkos8QHqSWy4
         Ail5GO7G0evr6yWo4PE4Ra7VuRGXjo8BipT9LTe8rFigdp6oa0vaCB4Wuv9aCkR0+qrm
         p74g==
X-Gm-Message-State: AMCzsaWVQUpX7QdnQTSS7iv0ycUOCu4BKv3J55IpM6+HyKXDf4Rt5pr5
        f2DSb1UaK+4zMf5CzPELyww/jQ6z
X-Google-Smtp-Source: AOwi7QB1Y35f4WIyOIhHzj6ZNJjw4EDMuKc64DBqQlSkmIpGfrxzVSSHVV2liajU1tmahOF9xR8tfA==
X-Received: by 10.200.36.19 with SMTP id c19mr27409869qtc.231.1507122393852;
        Wed, 04 Oct 2017 06:06:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id q206sm4405904qke.54.2017.10.04.06.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 06:06:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com, sbeller@google.com
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-4-dstolee@microsoft.com>
 <xmqqinfwh5g0.fsf@gitster.mtv.corp.google.com>
 <6a3804a4-9728-d122-7fac-f297fc7977d1@gmail.com>
 <xmqqpoa3cujz.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ff54de0c-cd7c-bc3d-dd18-5fc248f3f573@gmail.com>
Date:   Wed, 4 Oct 2017 09:06:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoa3cujz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2017 2:10 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> ...
>> I understand that this patch on its own does not have good numbers. I
>> split the
>> patches 3 and 4 specifically to highlight two distinct changes:
>>
>> Patch 3: Unroll the len loop that may inspect all files multiple times.
>> Patch 4: Parse less while disambiguating.
>>
>> Patch 4 more than makes up for the performance hits in this patch.
> Now you confused me even more.  When we read the similar table that
> appears in [Patch 4/5], what does the "Base Time" column mean?
> Vanilla Git with [Patch 3/5] applied?  Vanillay Git with [Patch 4/5]
> alone applied?  Something else?
In PATCH 3, 4, and 5, I used the commit-by-commit diff for the perf 
numbers, so the "Base Time" for PATCH 4 is the time calculated when 
PATCH 3 is applied. The table in the [PATCH 0/5] message includes the 
relative change for all commits.

I recalculated the relative change for each patch related to the 
baseline (PATCH 2). Looking again, it appears I misspoke and PATCH 4 
does include a +8% change for a fully-repacked Linux repo relative to 
PATCH 2. Since PATCH 5 includes an optimization targeted directly at 
large packfiles, the final performance gain is significant in the 
fully-packed cases.

It is also worth looking at the absolute times for these cases, since 
the fully-packed case is significantly faster than the multiple-packfile 
case, so the relative change impacts users less.

One final note: the improvement was clearer in test p0008.1 when the 
test included "sort -R" to shuffle the known OIDs. Providing OIDs in 
lexicographic order has had a significant effect on the performance, 
which does not reflect real-world usage. I removed the "sort -R" because 
it is a GNU-ism, but if there is a good cross-platform alternative I 
would be happy to replace it.

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

| Repo  | Baseline | Patch 3 | Rel % | Patch 4 | Rel % | Patch 5 | Rel % |
|-------|----------|---------|-------|---------|-------|---------|-------|
| Git   | 0.09     | 0.06    | -33%  | 0.05    | -44%  | 0.05    | -44%  |
| Git   | 0.11     | 0.08    | -27%  | 0.08    | -27%  | 0.08    | -27%  |
| Git   | 0.09     | 0.07    | -22%  | 0.06    | -33%  | 0.06    | -33%  |
| Linux | 0.13     | 0.32    | 146%  | 0.14    | + 8%  | 0.05    | -62%  |
| Linux | 1.13     | 1.12    | - 1%  | 0.94    | -17%  | 0.88    | -22%  |
| Linux | 1.08     | 1.05    | - 3%  | 0.86    | -20%  | 0.80    | -26%  |
| VSTS  | 0.12     | 0.23    | +92%  | 0.11    | - 8%  | 0.05    | -58%  |
| VSTS  | 1.02     | 1.08    | + 6%  | 0.95    | - 7%  | 0.95    | - 7%  |
| VSTS  | 2.25     | 2.08    | - 8%  | 1.82    | -19%  | 1.93    | -14%  |

(Each repo has three versions, in order: 1 packfile, multiple packfiles, 
and multiple packfiles and loose objects.)

Thanks,
-Stolee

