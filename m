Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5042021E
	for <e@80x24.org>; Sun,  6 Nov 2016 21:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbcKFVkG (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 16:40:06 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:22302 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbcKFVkF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 16:40:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tBprf73jHz5tl9;
        Sun,  6 Nov 2016 22:40:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A2853143;
        Sun,  6 Nov 2016 22:40:02 +0100 (CET)
Subject: Re: [PATCH] t0021: expect more variations in the output of uniq -c
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
 <20161016232038.84951-14-larsxschneider@gmail.com>
 <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
 <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
 <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org>
 <0B7DE8F1-34DF-4271-8936-B9B596EF5F9E@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c842e0a7-b032-e0c4-0995-f11d93c17c0a@kdbg.org>
Date:   Sun, 6 Nov 2016 22:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <0B7DE8F1-34DF-4271-8936-B9B596EF5F9E@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.2016 um 16:31 schrieb Lars Schneider:
> This looks good to me. I wonder if I should post a patch
> to add the "|| return" trick to the following function
> "test_cmp_exclude_clean", too?!

The function does this:

         for FILE in "$expect" "$actual"
         do
                 grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
                 mv "$FILE.tmp" "$FILE"
         done &&

It is an interesting case: If only matching lines are in the file, 
nothing would be printed, and grep returns failure. But we shouldn't 
care, because, strictly speaking, the function only wants to remove 
lines with a certain pattern. Here, it actually hurts to &&-chain grep!

It wouldn't hurt to write 'mv ... || return', but at the same time, && 
after grep should be removed.

-- Hannes

