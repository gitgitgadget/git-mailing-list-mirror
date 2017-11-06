Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3FD320A10
	for <e@80x24.org>; Mon,  6 Nov 2017 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbdKFRvz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 12:51:55 -0500
Received: from siwi.pair.com ([209.68.5.199]:52505 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753493AbdKFRvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 12:51:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D017A844F4;
        Mon,  6 Nov 2017 12:51:53 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6D097844F3;
        Mon,  6 Nov 2017 12:51:53 -0500 (EST)
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102175013.3371-5-git@jeffhostetler.com>
Message-ID: <68f3c18f-8bee-dbb7-26f3-c1070d9177ac@jeffhostetler.com>
Date:   Mon, 6 Nov 2017 12:51:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102175013.3371-5-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/2/2017 1:50 PM, Jeff Hostetler wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create traverse_commit_list_filtered() and add filtering
> interface to allow certain objects to be omitted from the
> traversal.
> ...
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> new file mode 100644
> index 0000000..7f28425
> --- /dev/null
> +++ b/list-objects-filter.c
> ...
> +/*
> + * A filter for list-objects to omit large blobs,
> + * but always include ".git*" special files.
> + * And to OPTIONALLY collect a list of the omitted OIDs.
> + */

Jonathan and I were talking off-list about the performance
effects of inspecting the pathnames to identify the ".git*"
special files. I added it in my first draft back in the spring,
thinking that even if you set the blob-limit to a small
number (or zero), you'd probably still always want the
.gitattribute and .gitignore files.  But now with the addition
of the sparse filter and functional dynamic object fetching,
I'm not sure I see the need for this.

Also, if the primary use of the blob-limit is to filter out
giant binary assets, it is unlikely anyone is going to have
a 1MB+ .git* file, so it is unlikely that the is_special_file
would include anything that wouldn't already be included by
the size criteria.

So, if there's no objections, I think I'll remove this and
simplify the blob-limit filter function.  (That would let me
get rid of the provisional omit code here.)

Jeff
