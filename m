Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4B9C7EE43
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 22:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjFFWtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbjFFWtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 18:49:05 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 15:49:03 PDT
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3129E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 15:49:03 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id 6fR9qHWDrfWm36fRAqdrBP; Tue, 06 Jun 2023 23:46:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1686091560; bh=PLa7hEkMGi7s6BqyyK5c5am+jdu//WyZTdX451EAZUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FGEBjACAojOI7tXaYkaAM3ZNu+HDtBNmeMJ4I9CXFRUXMhhcNtZi3P7/+RzrmBWjs
         9abZzxwW7KuZ00qNAizdEl5renTQkySENBVR+Kdk12AusP3w+AVCLo7ukFRNAKjmDx
         Vp6Ec1E31sDKw0wFEodJZLWULptj0UbKbiTmtogxYDjuPSBbc5lwsv6TDgmabLPySO
         VIOPmNlccDBYHjbHuKxu4QlUWnobNSCx83op3ONhc4qEhBKGETpNuV0NuxDaCmwYDU
         S4qQg6vIqrcFem56tR1b/hjQcc3zBsqQnpHk78IH4EBWvFw3c2FrMM+ieL7jZmRtSJ
         JMcffQapcUAWw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GJAbr8BK c=1 sm=1 tr=0 ts=647fb728
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=G0YMkZFut-bV4kl7-L4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
Date:   Tue, 6 Jun 2023 23:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and
 functions
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, jonathantanmy@google.com
References: <20230606170711.912972-1-calvinwan@google.com>
 <20230606171002.914075-5-calvinwan@google.com>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20230606171002.914075-5-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOwY4iKV/WN1Jyh29efakgFnXDf/ICiOm5U86x4+172HO4CCE5Mf3mi08GVAIzhpDoozpFruuX2ucVSabWWvb9KTjSZSR2IeLcGCtndsDq+HWiy0Y+KO
 e2aQDcD1XsdTKvP99srX7k2dcW8Bk+LqurLwse5APedtLdIfScWHH3//ny+u0mI1jQJ1w3aB11yTqdEHVhT6PUyykFlz+gVbmTw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/06/2023 18:09, Calvin Wan wrote:
> git-compat-util.h has grown to a large and difficult to read file partly
> because its set of functionality is overloaded. Besides being a
> compatibility file that ensures Git's operation across different
> operating systems, it has also become a dumping ground for commonly used
> macros and static inline functions.
> 
> This commit separates out macros and static inline functions that are
> compatible across operating systems into common.h. common.h is
> reincluded back into git-compat-util.h so that other files do not also
> have to include it. The eventual goal is for common.h to be separated
> out into more reasonable boundaries, but for now this should be a good
> first step towards that goal.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  common.h          | 410 ++++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h | 402 +--------------------------------------------
>  2 files changed, 412 insertions(+), 400 deletions(-)
>  create mode 100644 common.h
> 
> diff --git a/common.h b/common.h
> new file mode 100644
> index 0000000000..0f164c1071
> --- /dev/null
> +++ b/common.h
> @@ -0,0 +1,410 @@
> +#ifndef COMMON_H
> +#define COMMON_H
> +
> +#include "git-compat-util.h"

Hmm, ... So, "common.h" includes "git-compat-util.h", which
in turn includes "common.h" ?

Something is not right here! ;)

(Sorry, I have not been following this series, it just floated
past on the ML and looked odd ...)

ATB,
Ramsay Jones

