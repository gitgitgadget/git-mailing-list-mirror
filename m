Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9DC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 03:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CD8611CA
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 03:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhFADlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 23:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhFADlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 23:41:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C4C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 20:39:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g18so10361461pfr.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z98AErgMbUAtbaQSCNZlxyj+Xo0c0LKW5DKB1iOsaIk=;
        b=YLZ32FpoprdPSgspF6+e0K7RRE6UNrVyPjMlaYIQs39iydD7n0MjEUVY2MrusdNzgP
         HnR88ckSi50tsh0DpPEgKhKuPpgJjcErn752NXOqirEHSapxERPSonvFH2l0GGrsByMw
         HC5NtZ4WSYy0z/WWaqZ0wc5JhykO9WbLQMMpLqcajVilDXwVfQxmKyBkN4sOqWsp5c//
         gtNc1mTaxXt9D3mRAyuc1oLNJTqnd2FmRNxGd7iOhYUb75h0ccmTxDofYKBTXjfvcTUw
         fbG0XUD1dlxh491YZPl0Ja34DuJieEnoo+qNlAXYkjDtkWgSW0mR+BBpa4P/Tnd6kcz/
         e1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z98AErgMbUAtbaQSCNZlxyj+Xo0c0LKW5DKB1iOsaIk=;
        b=pU8C7QT9hf+cmQA82qTPtdf42X+PzCE/Uryz+zonjce8mNasbskGazID5yUdgp80H+
         tmtQ8YwrRyWC2AZKknnvbm/iRpNzprHkhvJEWWUsWPDNC9ZzYyl5kzNDA2Afor3oBNRo
         rA/VkhNlQrM6OEoj7QcVF3LZ2F5VlrNMSo0QGPERcG4hJjw2aX6OA2/u36rQyWlIspoE
         aVyUupCEWyAbY3vjKA/6v6FDQSN+HI0YDhWXmptgPQsEbN+Jt4+D1BtrEGy+0Qh6Y6OH
         CXFomo7hVHZyMuGKIUq6r126m/jrzP5qlH9mX8e+Hc/4umhx0VJYrlL8f42DHE9oiI8b
         rGrw==
X-Gm-Message-State: AOAM5310iPZVfuZgP5ZS+Vq9nCfRwcypx1uIL6O1heZjQOYDCkPM2bYh
        cB9ei/Vybx7K7ecyccA+ZnzYwYP/Q3D9TA==
X-Google-Smtp-Source: ABdhPJyjwMX2U9jhLlF95w2OdrV272TJQ7r7imy8RxkDTslo/BKWpY1LgpOXV3Y2WjZBL7eBQiwY6w==
X-Received: by 2002:a65:60cc:: with SMTP id r12mr26285327pgv.164.1622518766989;
        Mon, 31 May 2021 20:39:26 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id r28sm12729712pgm.53.2021.05.31.20.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 20:39:26 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_Slow_fetch_on_repo_with_tags_per_each_commit_=28?=
 =?UTF-8?Q?=c3=a0_la_Vim=29?=
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <f9c1115a-2e17-9d3e-02f5-138eab8048d9@gmail.com>
 <60b50829553df_24d2820813@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <11b3e4e2-4b2c-e7d8-01d7-d7249b7a0424@gmail.com>
Date:   Tue, 1 Jun 2021 10:39:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60b50829553df_24d2820813@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On 31/05/21 23.00, Felipe Contreras wrote:
> Bagas Sanjaya wrote:
>> I have full clone of Vim repository [1] on my computer. This repo has
>> tags for each commit, meaning that when there is a new commit landed on
>> default (master) branch, it will be tagged (something close to release
>> tags but not same).
> 
> I sometimes work on that repo and I just have to say how much of a
> pleasure it is to work on a properly maintained repo such as git.git.
> 
> My last bisection on vim.git landed on this beauty of a commit:
> 
>      Update runtime files
> 

What were you doing there? I'm discussing about performance issue instead.

-- 
An old man doll... just what I always wanted! - Clara
