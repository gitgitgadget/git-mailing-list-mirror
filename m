Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27096C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA14206F8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 11:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UimYAMne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgDFLoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:44:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35017 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDFLoM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 07:44:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id k134so5164275qke.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pQ2dWBMPfelRjS9ZTYeynmn4FDb5owZhy8fjmX9jVM8=;
        b=UimYAMneibFTF2kcQcozUozPKQlLoIim+syFREwK/GjwrT2vzhfcs1hN8EOnxH8kHU
         56CP3DI2Vozh04BAC3elB5+9yDmfNOaP9iT9qlbIclSDbT7tDd5TbMdsELdDbaLGNTbi
         Oinr0jNiWIpauqoGwqmUQUFd9/EJZi78ut+kSHXR/mWVRaKtKEIKQc/sJsmtFTF4SD0r
         yI1nRAqawEoQMt/3Be4lTEQzvKmTAmQK151Qf01+UHgAAFoDu+F20m7ccZfWpfOcIIkY
         IDB7aCUomgPjcvjOAUavKAtyelh6jdO4sNvAsvhDSg0siFTf6s1GyNfi7dN8t/UuTu3E
         NeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQ2dWBMPfelRjS9ZTYeynmn4FDb5owZhy8fjmX9jVM8=;
        b=qPhDSUfvUVQdCJYVK3rnXHc7Mj9ZcOce7nNeIWysDJDFMSmHyoF+ZZH4Bj+xwtyzOq
         jSlxvenq/rv8GtNOdr7o1ylwRFw6P9cFoxcsNeL15dt5n7JXPnWFSH4yvZNu2PSQlf5f
         S5F6FgBzFuPaoyyLiUsm4ko4+EOVM8mGxmtpqCV5jB5jI3JJeErraWRODNoULInFG4wl
         hKMs1Lg2e6ImtXgd3WKXNMTVfmJGbWtNJkPzKSXUNrmlhJyrLAQbb8nawZv2UbIkTqvI
         UbLuibgjON3on8M4uhGkD724Stdyt9urpqDztyLxuxY5Dq/V0RdgoCcWeZBGkVSSkOJE
         KJqw==
X-Gm-Message-State: AGi0PuZc4JYbeNib+m92ODLVRcrvfRCZlceeTP74nY6coxlDXV9GnCl+
        oErYOdQY8EFSuKG+oKwglm8=
X-Google-Smtp-Source: APiQypJnf7KFQSRhBpg64ys4IvOTscaDSQOrQN5puRTXkflMNNhC86io7mIpoknyrVU5yrOhmVJ3Lw==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr21034230qks.188.1586173449662;
        Mon, 06 Apr 2020 04:44:09 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 69sm14307535qki.131.2020.04.06.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 04:44:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Restrict when prefetcing occurs
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>
References: <20200331020418.55640-1-jonathantanmy@google.com>
 <cover.1585854639.git.jonathantanmy@google.com>
 <xmqq369l3a4a.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7de2f54b-8704-a0e1-12aa-0ca9d3d70f6f@gmail.com>
Date:   Mon, 6 Apr 2020 07:44:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqq369l3a4a.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2020 4:28 PM, Junio C Hamano wrote:
> I notice that a439b4ef (diff: skip batch object download when
> possible, 2020-03-30) by Garima seems to aim for something similar.
> 
> I'll for now keep both topics with conflict resolution, but it may
> make sense for you two to compare notes.

I pointed this out in [1]. I think the right thing to do is for
Garima's/my patch to rely on Jonathan's change. The commit needs
to be modified, not simply ejected, but it could be separated from
the rest of Garima's series. It is only a performance fix for
normal clones, but is critical for partial clones.

Garima: do you think it would be easy to remove that patch if/when
you do a v4 and I can make a new series based on yours and Jonathan's
with the rename setting?

[1] https://lore.kernel.org/git/b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com/
Thanks,
-Stolee
