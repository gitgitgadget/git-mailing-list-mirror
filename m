Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288AC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 18:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiCHSdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349723AbiCHSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 13:33:15 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB153BA63
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 10:32:18 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KCkSv6rNdz5tlH;
        Tue,  8 Mar 2022 19:32:15 +0100 (CET)
Message-ID: <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
Date:   Tue, 8 Mar 2022 19:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     jaydeepjd.8914@gmail.com
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
 <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
 <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.03.22 um 17:54 schrieb jaydeepjd.8914@gmail.com:
> So, the final regexes are these, right?:

Not quite.

> 
>      "[a-zA-Z_][a-zA-Z0-9_]*"
>      /* hexadecimal and binary numbers */
>      "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
>      /* integers and floats */
>      "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlLuU]*"

This would not match 12.5 because you allow only a single digit before
the decimal point. Perhaps

	"|[0-9][.0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]*"

>      /* floating point numbers beginning with decimal point */
>      "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlL]?"
>      /* unary and binary operators */
>     
> "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<=|>>=|&&|[||]|->|\\.\\*|!!|::|[?:.][.:]"),

[||] does not work as you intend. A new suggestion: do not start with an
initial optional character in order to reduce the number of
backtrackings that the regular expression evaluation has to do. I would
write this line as

	"|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|::|[?:.][.:]"),

BTW which operators are handled by "[?:.][.:]"? I'm asking because you
list :: separatly that would also be matched by this sub-expression.

-- Hannes
