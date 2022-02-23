Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2FC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbiBWXN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiBWXN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:13:26 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABBC4926F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:12:53 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id bu6so798551qvb.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ECMjH6x2Lax1Pghs7CUdVgUnPm751uEaVxfVKIYu4g=;
        b=XKWn9oXrnk3C7C8enPybr2hHFFIfxoVYAcfn0Oa6nIig35ySO/q9FQ/APyz3wIrQRr
         jxD96LKhgULoVjKExP0f9bsWB4gTf/nxHbUUEJjE7XVP1UzdjKL5YUVy8/A42tRkBbDw
         oj+AvTNd6+CDYd6+mz9vG85H05DOihw3SrNXL0GbFPlHppZxgu2Mtczms4lL6Igc9c72
         6bqmbFWmBZvf0+ZNbRXomvfQB/Qc0VyIyZaSOQUEgo3e7abXbmpge4qicgDUcBgi7un3
         p/xKPNsb6CeOg+zLilcLkGqtMcl6nZHrxiJNe7db1cMQYDuGHrnzb3cup55KurA2yf0E
         eRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ECMjH6x2Lax1Pghs7CUdVgUnPm751uEaVxfVKIYu4g=;
        b=G06vghvQC5dQU69sLTa+KboZFqsWw0UzW+FAt4Fkqydhhm1zZf02hq1CgpTM+EtQME
         CHny/Zf623m3sB9itj18w0QVBRY3JlDrEeEiXNpwOA8R+2avBO9pYC6CJqax2+uWVczq
         YPMBmxUmaB1keRYWnjYOZBXNU/ZkbNiqEsW0EyngbOEeexABucQX1k2mlloA8sR2+zp1
         RRu3rFRVPJpR5aPdzJyNTMoFRGNXm0ixdhufcD+2nkTDG51AQLTM/6T+X3Yz4nwWRhPv
         PxCOhEHYi3ndhZm6Xeurk2FGGTcfrPxHvAg2YGUgWOizmc/ETXR51myKYo9CqRIkX4AN
         fZUA==
X-Gm-Message-State: AOAM532DGA5B+rYaFdlPZWtAkV9kwSFM9tVqTrYxnIfYyP49LucCVm1o
        BXaVNdQTRWm0n3+CNsle40SuDNkaI9s=
X-Google-Smtp-Source: ABdhPJwbh4xkWa3gvnVEhWBpqd8SqTyYCSkXvq+1jHOTH+Rf43IklZxHJHK5kczglKcpPu+j0ZXRQg==
X-Received: by 2002:a05:622a:1713:b0:2de:889:f00d with SMTP id h19-20020a05622a171300b002de0889f00dmr67566qtk.169.1645657972262;
        Wed, 23 Feb 2022 15:12:52 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id k15sm482440qkj.5.2022.02.23.15.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 15:12:51 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref behavior
Date:   Wed, 23 Feb 2022 18:12:51 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <272D2409-1CAE-4203-96F7-9B104F7E5D4D@gmail.com>
In-Reply-To: <xmqqbkyxqjrq.fsf@gitster.g>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqqbkyxqjrq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 23 Feb 2022, at 17:51, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +test_expect_success 'drop stash reflog updates refs/stash' '
>>> +	git reset --hard &&
>>> +	git rev-parse refs/stash >expect &&
>>> +	echo 9 >file &&
>>> +	git stash &&
>>> +	git stash drop stash@{0} &&
>>> +	git rev-parse refs/stash >actual &&
>>> +	test_cmp expect actual
>>> +'
>>
>> This one will be portable to the reftable backend.
>>
>>> +test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
>>
>> But as I noted in <220222.86fsob88h7.gmgdl@evledraar.gmail.com> (but it
>> was easy to miss) this test will need to depend on REFFILES. So just
>> changing this line to:
>>
>>     test_expect_success REFFILES 'drop stash[...]'
>>
>>> +	git reset --hard &&
>>> +	echo 9 >file &&
>>> +	git stash &&
>>> +	oid="$(git rev-parse stash@{0})" &&
>>> +	git stash drop stash@{1} &&
>>> +	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
>>> +	cat >expect <<-EOF &&
>>> +	$(test_oid zero) $oid
>>> +	EOF
>>> +	test_cmp expect actual
>>> +'
>
> Why should this be tested with "cut" in the first place, though?
>
> If we start from
>
>     stash@{0} = A
>     stash@{1} = B
>     stash@{2} = C
>
> and after saying "drop stash@{1}", what we need to check is that
>
>     stash@{0} = A
>     stash@{1} = C

Yes, this is true but that doesn't seem to test the --rewrite functionality.
I could be missing something, but it seems that the reflog --rewrite option
will write the LHS old oid value in the .git/logs/refs/stash file. When
--rewrite isn't used, the reflog delete still does the right thing to the
RHS entry.

I couldn't find any way to check this LFS value other than reaching into the
actual file. If there is a way that would be preferable.
>
> now holds, which can be done with "git rev-parse", and the fact that
> the ref-files backend happens to record both before-and-after object
> IDs is an irrelevant implementation detail, no?
>
> I am still puzzled.
