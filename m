Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3885BC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1583460FD8
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhEQRWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhEQRWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:22:15 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB97C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:20:58 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so3337292oig.12
        for <git@vger.kernel.org>; Mon, 17 May 2021 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wZdIxhGTVbviTE2Ct1Gep0iuCMumIFNL7nccHpGxc5k=;
        b=qYrYF0bRw+NooHyT6j5No46Xi5QWXbkrfZIiy6PbyawFQ2qrGr2nHcWjfSNVB5km5e
         b2bsn/PyJ6ZfuwAzqoYZKGBWCH6k3MGk4nZnazPloFeYTURgpbTc4+tkoJdmhI7rm8OM
         kxRneL75cm+WcJtpWv6zB+CixQVdc3/Hilw98Cjm2xLwnGOfmw9jCOhwyT9Si5IrqNhB
         eKxrvfnxp9lihQnIylGbe4TwvTr7SruGaja4M060D3OOBvpwVacx1GwpoTHX2hPC1NWB
         HgXOMq2rm7ywMqqXZjT+LdGMjXixSjBQsauhvp8xLo3+CtbxFvAwrkob2ucjm5obvK/s
         3wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZdIxhGTVbviTE2Ct1Gep0iuCMumIFNL7nccHpGxc5k=;
        b=KOfWTMI7gcix6dlmWQ5FD21XNjqd74t/Kv+WBtyVXlwxfqLIZs21V/8dgH36gaoHv3
         UNKSc6O+3qbIQ9CHR2aP2jtGPH3Bpw7CqpDcop55Xiw7ZGtqu3T6rxg2e/DyYFa17Kp7
         +t1e88lOZTblq+xvRgPkeSsxG9P6Lrc1rPxkdZ6RWb7o4itxRiJEMSBrNwMDka93Ghv9
         GSc6FH6j97LdQgZN23mpZhr3xeqWBWXRDVbvsIqfcZOdukmquHDz9aPEHePUsxOglypx
         svHtjUFuxXsVywAvAXm1Ns8sR1e4Mu9nKF2uBlSfFh9cuu+8mRwdDvywlqK9rvWo2FDe
         nNDA==
X-Gm-Message-State: AOAM533cPtcxEKoaqEMy+Ovi8uzQCAio3+FjKfmtcI3tFWlGduBqnVfU
        nJlW12huKIhOg9sKVK+692s=
X-Google-Smtp-Source: ABdhPJzF+/YlNk0mkM8+CpvVjh/GVoY/tKJlg1ydIj5Keiv0Qdw9ggNP7vkLUDRKS5b3bMlZQ2XjCA==
X-Received: by 2002:a05:6808:1154:: with SMTP id u20mr616243oiu.35.1621272057991;
        Mon, 17 May 2021 10:20:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id p11sm3204045oti.53.2021.05.17.10.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 10:20:57 -0700 (PDT)
Subject: Re: [PATCH v5 8/9] dir: update stale description of treat_directory()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
 <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bac325b9-8370-601b-a348-a7270df8b824@gmail.com>
Date:   Mon, 17 May 2021 13:20:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <179f992edc9254803252ae10e5d692f3755a40f3.1620840502.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2021 1:28 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The documentation comment for treat_directory() was originally written
> in 095952 (Teach directory traversal about subprojects, 2007-04-11)
> which was before the 'struct dir_struct' split its bitfield of named
> options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
> dir_struct into a single variable, 2009-02-16). When those flags
> changed, the comment became stale, since members like
> 'show_other_directories' transitioned into flags like
> DIR_SHOW_OTHER_DIRECTORIES.
> 
> Update the comments for treat_directory() to use these flag names rather
> than the old member names.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Elijah Newren <newren@gmail.com>

I think you want the "Reviewed-by" before the "Signed-off-by",
followed by your own sign-off.

Thanks,
-Stolee
