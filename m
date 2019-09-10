Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FA71F463
	for <e@80x24.org>; Tue, 10 Sep 2019 16:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbfIJQIt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 10 Sep 2019 12:08:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:56317 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfIJQIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:08:48 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x8AG8fIk049251
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Sep 2019 12:08:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Diomidis Spinellis'" <dds@aueb.gr>, <git@vger.kernel.org>
References: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
In-Reply-To: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
Subject: RE: Patching Git to handle dates before the Unix epoch
Date:   Tue, 10 Sep 2019 12:08:34 -0400
Message-ID: <003301d567f2$03550df0$09ff29d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/0c5jf8FvkpzUFkxwKpHPjZcy2qZQPI7w
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 10, 2019 10:15 AM, Diomidis Spinellis wrote:
> As people use Git to create synthetic commits of code written in the past
> [1,2] it becomes important to handle dates before the Unix epoch
> (1/1/1970).  I see that modern C libraries, Unix kernels, and tools can handle
> such dates.  However Git seems to mishandle such dates in several places,
> such as in date.c [3,4].  I'm planning to work on a fix, but before I embark on
> this I have a few questions.
> 
> - Do you see any reasons that may prevent the acceptance of such a patch?
> - Can you think of any non-obvious issues (e.g. backward compatibility,
> switch to the Gregorian calendar) I should be aware of?
> - Should I submit changes as a bug fix on the maint branch or as a new
> feature on master?

My suggestion is a new feature as a patch. See other contributions. While you're at this, especially given how extensive this may be given the time_t references, it might be useful to examine the end of epoch concerns as well. 2036 is not that far off and some of the repositories I am managing will likely last beyond the Unix date rollover. There are no time64_t to get us to 2106, but even that is probably not sufficient (thinking beyond my own expiry date). The concept of unlimited date ranges is intriguing if we are going to store broader range artifacts in git, like signatures of physical core samples and use the carbon dating in git, or some Sci-Fi conceptual commit on old 1701D. So if I had a preference, it would be to store an extensible date range going from the Big Bang to the Big Crunch (or beyond), but that is excessive.

Sadly my platform's own date ranges are 64-bit microsecond that range from year 1 (AD) - 10000 (AD) and I can't map easily to Unix dates.

Just my $0.02,
Randall

