Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCF31F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfG2ONX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:13:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44086 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfG2ONW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:13:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so28756992qtg.11
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sNqM+4kktTw34TmFubsslTD7x4QVujXfOdFRGt2a4JY=;
        b=kC950X1rftetaPG7+B9aAeAGTAqQ5ZDJ0uwSyqGuGnV3HfUa18SUprmXaZfgabVfR1
         tN4jagvoFtrt6B8C9IF9uBlOx9qd62zskG6M/TQZ84huC1Bc5OmMaa0CI8mfIziz8H5o
         ymf/0VGEtBJ3p1YesSV0drJUiwo1JDvNWbCEN+co833cHuAH0Jf7rv9ORMiXubLXWdOL
         QcOoszOimJ3rD089fY09EuWTSH2gKuv/PDm1vDfp6KcvADs1UYSqE3eRJ6vNhobFtqf7
         SReTUyVN8QmpIJvoOVnk4YtqfkeX8R8nRQASI7gp9rh+DzlS7SwioZtX+ZXEKKsqNlcP
         /FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sNqM+4kktTw34TmFubsslTD7x4QVujXfOdFRGt2a4JY=;
        b=jPrhRUAV3Psh8DPjPDd1NIg6vlUGc5Wll6EFWRXxDVeF9KpySl2Vs+TMWuMT73jz06
         5uL0/N7qAgwPGgpsBQeYJSRkzuNBkhWaP+vo/qTCzbuyDOmR53fIhJyMhl5TAyt7EBNu
         D/hSnV8jd6Gj+XiJBsZWz/ZVlD9mkv/+snPgog7Vh7kCWwFiz0nApB/q5IiWwb5x9taX
         tumjzVcLONMkeeKHXtdRTiv4uKsLBAe8IZsVLCDAMSP80XWWh+nd3xSSZrML64tOEXgM
         a8W51VY0BJC9FbMKWh63fTWL4MWUYqDMcf6WvxMMEWJe73IGAGekQ9iERbbmc/m7xB0u
         b2fg==
X-Gm-Message-State: APjAAAX950ORJEaZrS/k0OLCvelnhqmCBoRIv62O6ewOcWYH+Lhg698X
        jF90TbjrgVwpp8mnhnyQVDWVa8CO
X-Google-Smtp-Source: APXvYqxQ4t306Un4UGMCvhwlMgin8nNn3tZH2svIx0iapaHnyx5+rrP7BLibkx5PN5bTddBdXkzVBQ==
X-Received: by 2002:ac8:7941:: with SMTP id r1mr72661414qtt.82.1564409601719;
        Mon, 29 Jul 2019 07:13:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1190:2f14:782d:822c? ([2001:4898:a800:1012:c2c3:2f14:782d:822c])
        by smtp.gmail.com with ESMTPSA id r40sm37836144qtk.2.2019.07.29.07.13.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 07:13:21 -0700 (PDT)
Subject: Re: [PATCH v2 01/20] merge-recursive: fix minor memory leak in error
 condition
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-2-newren@gmail.com>
 <xmqqo91godev.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <698e7154-b625-dfe5-ccf7-87e34c77e480@gmail.com>
Date:   Mon, 29 Jul 2019 10:13:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqo91godev.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2019 2:31 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> Returning before freeing the allocated buffer is suboptimal; as with
>> elsewhere in the same function, make sure buf gets free'd.
> 
> I do not have a real objection to the patch text, but the above
> justification does not make much sense to me.  The original code
> returned an error when buf is NULL, so there is no leak returning
> directly, without jumping to free_buf: label (whose only effect is
> to free(buf) and return the value in ret).
> 
> The real value of this change is it may future-proof the codepath by
> making sure that everybody after an error goes to the same place to
> free all resources---which happens to be only buf in the current
> code, but this change allows it to change in the future, where some
> additional resources may have been allocated before the call to
> read_object_file() and freed after free_buf: label.

It should be noted that any future change to make the "free_buf:" label
mean "free everything" then it should be renamed to "cleanup:" or similar.

Not that we should do that now, as that would muddy the blame.

Thanks,
-Stolee
