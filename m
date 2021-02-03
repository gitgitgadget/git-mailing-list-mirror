Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AB8C433E9
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4DB64F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBCDJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhBCDJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:09:00 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E3C06178B
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:09:02 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so25207175oic.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SqltQk6znpK4212tNHMzyh84kQbuOyNNMW9+tZgFSgI=;
        b=NbeVTUm8PIpUN/awdceQYpFKvICXgVBLo10+ZwEFS461L2FQXYfxnkpYjNzFxpsMVH
         Sd1fE9f0iVsbHrFXL516ig0doNhgURUn2I2GcWOmKzJYJ3508s1WF5yCiotgcdLIxvz/
         BEKqEFNjMoSO+qpNCamHY/tP6kUhd+ZCZLbfA1YBLKCbc4UKg7mW6bzxExpMzuB2CMBv
         zVyhTFGQuEgmkWifi+GKhJ54b8tvU7fWn48keW/hpukC4u4tAqsFK13khJg/exxazsrE
         5qi+7522TAdgrdZAgNSs+nnBi/Jn69iZKfaQS/DUoSNbMhDzFyt1o2boKaLNm7SO2TWB
         ic8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SqltQk6znpK4212tNHMzyh84kQbuOyNNMW9+tZgFSgI=;
        b=KZ0xYG2i/Bq8K1tlBwGkIHYuSYP2J7apIgvsMVrNfcZfnRjh+WVKItomnwtB4ebFhP
         oPP6QdRdhYUsuFR5qRw0KIGxa5TMhkQajiRTmeC5y20osJBdyrVnIJY72fFRn637BkHk
         Us0JNhSxxWfKEwSsqzlhXveP0MdVKAAKu+t4Diywt7FFetmZxcOPIQ0QR9koQdw6NRFf
         Y5Y34qYei+Q6xQ7JwZ3GJpiya1roftj6EHFjj6ez9V6YpP83gModgbDkoBjPUtK1hmKC
         8fn6CB0x4ddiP6RagkUNo8AdKoLTB3i+iWdF0DBxtq9auHHE20FAoKiAuuqSZmpK29QP
         Dn1g==
X-Gm-Message-State: AOAM533mHs3rCX1ndTI+DyxwY3bmZ+sMBnOzf2fbTFkkZAaVpOgYsUCJ
        UTzRpcV8vkDberdcr/CMPqoTMn9tiDB+x/sV
X-Google-Smtp-Source: ABdhPJwsaa5N6dBmJcLHM+jeY8snjHu2qLqE2D/2vqtav1T9HfXztCB1SqsnKoq4hBesGv0k12EseQ==
X-Received: by 2002:aca:b286:: with SMTP id b128mr696395oif.126.1612321741876;
        Tue, 02 Feb 2021 19:09:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:79cd:7444:bf97:c4d4? ([2600:1700:e72:80a0:79cd:7444:bf97:c4d4])
        by smtp.gmail.com with UTF8SMTPSA id v67sm189405otb.43.2021.02.02.19.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 19:09:01 -0800 (PST)
Message-ID: <247b0056-8358-f71f-22ee-0bacfbc4239d@gmail.com>
Date:   Tue, 2 Feb 2021 22:09:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/2/2021 9:06 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> - what is the recommended way to recover from this state?  "git fsck"
>>>   shows the repositories to have no problems.  "git help commit-graph"
>>>   doesn't show a command for users to use; is
>>>   `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
>>>   command?
> 
> "rm -f .git/objects/info/commit-graph" as well, no?

In this case, that won't be necessary since they are using a
split commit-graph. However, the following is what I do to
be extra sure:

	rm -rf .git/objects/info/commit-graph*

Deletes the singleton file and the directory.

>> That, followed by `git commit-graph write --reachable [--changed-paths]`
>> depending on what they want.
> 
> Just out of curiosity, how important is "--reachable"?  It only
> traverses from the tips of refs and unlike fsck and repack, not from
> reflog entries (or the index for that matter, but that shouldn't
> make much difference as there is no _commit_ in the index).

I just like to focus on the reachable commits starting at refs
instead of scanning all packed objects to see which are commits
or not.

Thanks,
-stolee

