Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB20211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeL0KGV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 05:06:21 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:50580 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbeL0KGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 05:06:20 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43QQTk0pGLz5tlH;
        Thu, 27 Dec 2018 11:06:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5247E2091;
        Thu, 27 Dec 2018 11:06:17 +0100 (CET)
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
Date:   Thu, 27 Dec 2018 11:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227021734.528629-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.12.18 um 03:17 schrieb brian m. carlson:
> We've recently fielded several reports from unhappy Windows users about
> our handling of UTF-16, UTF-16LE, and UTF-16BE, none of which seem to be
> suitable for certain Windows programs.
> 
> In an effort to communicate the reasons for our behavior more
> effectively, explain in the documentation that the UTF-16 variant that
> people have been asking for hasn't been standardized, and therefore
> hasn't been implemented in iconv(3). Mention what each of the variants
> do, so that people can make a decision which one meets their needs the
> best.
> 
> In addition, add a comment in the code about why we must, for
> correctness reasons, reject a UTF-16LE or UTF-16BE sequence that begins
> with U+FEFF, namely that such a codepoint semantically represents a
> ZWNBSP, not a BOM, but that that codepoint at the beginning of a UTF-8
> sequence (as encoded in the object store) would be misinterpreted as a
> BOM instead.
> 
> This comment is in the code because I think it needs to be somewhere,
> but I'm not sure the documentation is the right place for it. If
> desired, I can add it to the documentation, although I feel the lurid
> details are not interesting to most users. If the wording is confusing,
> I'm very open to hearing suggestions for how to improve it.
> 
> I don't use Windows, so I don't know what MSVCRT does. If it requires a
> BOM but doesn't accept big-endian encoding, then perhaps we should
> report that as a bug to Microsoft so it can be fixed in a future
> version. That would probably make a lot more programs work right out of
> the box and dramatically improve the user experience.

It worries me that theoretical correctness is regarded higher than 
existing practice. I do not care a lot what some RFC tells what programs 
should do if the majority of the software does something different and 
that behavior has been proven useful in practice.

My understanding is that there is no such thing as a "byte order 
marker". It just so happens that when the first character in some UTF-16 
text file begins with a ZWNBSP, then it is possible to derive the 
endianness of the file automatically. Other then that, that very first 
code point U+FEFF *is part of the data* and must not be removed when the 
data is reencoded. If Git does something different, it is bogus, IMO.

-- Hannes
