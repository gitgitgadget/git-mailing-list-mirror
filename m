Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E2C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjDYN5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjDYN5w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:57:52 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA218D
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:57:50 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 376DBCA124E;
        Tue, 25 Apr 2023 09:57:50 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:69d8:c39b:c604:54bf] (unknown [IPv6:2600:1700:840:e768:69d8:c39b:c604:54bf])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0F6E2CC839D;
        Tue, 25 Apr 2023 09:57:50 -0400 (EDT)
Message-ID: <e7dba6a6-b0dd-061d-ee94-06c66f955c0f@jeffhostetler.com>
Date:   Tue, 25 Apr 2023 09:57:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] t/helper/test-json-writer.c: avoid using
 `strtok()`
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <201fcac6c41a80df78e58edd0d4dfda5f3944b8a.1682374789.git.me@ttaylorr.com>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <201fcac6c41a80df78e58edd0d4dfda5f3944b8a.1682374789.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/23 6:20 PM, Taylor Blau wrote:
> Apply similar treatment as in the previous commit to remove usage of
> `strtok()` from the "oidmap" test helper.
> 
> Each of the different commands that the "json-writer" helper accepts
> pops the next space-delimited token from the current line and interprets
> it as a string, integer, or double (with the exception of the very first
> token, which is the command itself).
> 
> To accommodate this, split the line in place by the space character, and
> pass the corresponding string_list to each of the specialized `get_s()`,
> `get_i()`, and `get_d()` functions.
> 
> `get_i()` and `get_d()` are thin wrappers around `get_s()` that convert
> their result into the appropriate type by either calling `strtol()` or
> `strtod()`, respectively. In `get_s()`, we mark the token as "consumed"
> by incrementing the `consumed_nr` counter, indicating how many tokens we
> have read up to that point.
> 
> Because each of these functions needs the string-list parts, the number
> of tokens consumed, and the line number, these three are wrapped up in
> to a struct representing the line state.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

LGTM

Thanks,
Jeff
