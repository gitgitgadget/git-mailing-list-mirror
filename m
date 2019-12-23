Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2ABC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB1206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWPPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:15:53 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:34395 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWPPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 10:15:52 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ijPR0-0001jO-91; Mon, 23 Dec 2019 15:15:51 +0000
Subject: Re: NewHash alternatives and SHA benchmarks
To:     Michael Clark <michaeljclark@mac.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
References: <20191223011306.GF163225@camp.crustytoothpaste.net>
 <9279D11D-2BC2-4800-8282-C2219F152269@mac.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5aff676a-c4b2-6448-f99c-ec6f54f25a1a@iee.email>
Date:   Mon, 23 Dec 2019 15:15:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9279D11D-2BC2-4800-8282-C2219F152269@mac.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/12/2019 01:59, Michael Clark wrote:
> git doesn’t really support large files that well either so I’ll have to keep that in mind...
I presume you are thinking of the Git-for-Windows (GfW) implementation
here, where 'sizeof(long)'=32 bits, so currently the GfW is limited to
2/4GB file sizes.

The limitation is partly due to the zlib library API which uses 'long'
for stream sizes, though does have 'pointer*' file sizing, and hence
follows the Microsoft 32->64 bit transition approach. However zlib is
able to handle larger files when the deflation/inflation is done in
chunks of less than 'size(long)'.

On the 'Linux' version the limit is a 64 bit address and file size, so
probably not a real issue on those platforms ;-)

There has been a body of work on the change to using size_t for Git file
sizes, but such a change is extensive and may not be acceptable because
of the size of the code churn. I (and others!) had been looking at it
https://github.com/git-for-windows/git/pull/2179.

Hope that helps clarify the large file support limitation on Windows.

Philip
