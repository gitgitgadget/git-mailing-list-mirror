Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9A81F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbdKJPia convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 10 Nov 2017 10:38:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57959 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753260AbdKJPhv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 10:37:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBDC8AB5D
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:37:49 +0000 (UTC)
Subject: Re: [RFC] cover-at-tip
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
To:     git@vger.kernel.org
References: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
Openpgp: preference=signencrypt
Message-ID: <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
Date:   Fri, 10 Nov 2017 16:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 10/11/2017 à 11:24, Nicolas Morey-Chaisemartin a écrit :
> Hi,
>
> I'm starting to look into the cover-at-tip topic that I found in the leftover bits (http://www.spinics.net/lists/git/msg259573.html)
>
> Here's a first draft of a patch that adds support for format-patch --cover-at-tip. It compiles and works in my nice and user firnedly test case.
> Just wanted to make sure I was going roughly in the right direction here.
>
>
> I was wondering where is the right place to put a commit_is_cover_at_tip() as the test will be needed in other place as the feature is extended to git am/merge/pull.
>
> Feel free to comment. I know the help is not clear at this point and there's still some work to do on option handling (add a config option, probably have --cover-at-tip imply --cover-letter, etc) and
> some testing :)
>
>
> ---

Leaving some more updates and questions before the week end:

I started on git am --cover-at-tip.

The proposed patch for format-patch does not output any "---" to signal the end of the commit log and the begining of the patch in the cover letter.
This means that the log summary, the diffstat and the git footer ( --\n<git version>) is seen as part of the commit log. Which is just wrong.

Removing them would solve the issue but I feel they bring some useful info (or they would not be here).
Adding a "---" between the commit log and those added infos poses another problem: git am does not see an empty patch anymore.
I would need to add "some" level of parsing to am.c to make sure the patch content is just garbage and that there are no actual hunks for that.

I did not find any public API that would allow me to do that, although apply_path/parse_chunk would fit the bill.
Is that the right way to approach this ?

My branch is here if anyone want to give a look: https://github.com/nmorey/git/tree/dev/cover-at-tip

Nicolas




