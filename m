Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B55C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiFTP5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbiFTP5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 11:57:44 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF981DA6D
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 08:57:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 033971600EF;
        Mon, 20 Jun 2022 08:57:43 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5vdvzBTBUYdg; Mon, 20 Jun 2022 08:57:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 3BBC3160142;
        Mon, 20 Jun 2022 08:57:42 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2mbv_EzoRGtY; Mon, 20 Jun 2022 08:57:42 -0700 (PDT)
Received: from [192.168.0.205] (ip72-206-2-24.fv.ks.cox.net [72.206.2.24])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id C685E1600EF;
        Mon, 20 Jun 2022 08:57:41 -0700 (PDT)
Message-ID: <449bede6-82b0-72ef-300d-bc0c49a1858b@cs.ucla.edu>
Date:   Mon, 20 Jun 2022 10:57:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] grep: add --max-count command line option
Content-Language: en-US
To:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     =?UTF-8?B?TWFydGluIMOFZ3JlbiBbIF0=?= <martin.agren@gmail.com>,
        "Carlos L." <00xc@protonmail.com>, git@vger.kernel.org
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
In-Reply-To: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/22 10:49, Carlos L. via GitGitGadget wrote:
> +	unsigned max_count;

Why not make this intmax_t? That way, you don't have to worry about 
casting -1 to unsigned. Also on typical 64-bit machines you no longer 
have to worry about mishandling counts greater than 2**32 (the limit 
becomes 2**63 - 1 which is plenty).

These days it's typically better to avoid unsigned types in C when you 
can, as standard tools like 'gcc -fsanitize=undefined' can catch signed 
int overflow whereas unsigned int overflow always wraps around which is 
typically bad news.

