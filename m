Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDF41F461
	for <e@80x24.org>; Thu, 22 Aug 2019 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391831AbfHVTP4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 15:15:56 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:60628 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfHVTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 15:15:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46DvQ25jJJz5tlG;
        Thu, 22 Aug 2019 21:15:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 41B291D1B;
        Thu, 22 Aug 2019 21:15:54 +0200 (CEST)
Subject: Re: First Git status takes 40+ minutes, when mounting
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
To:     "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b409d16f-c392-7f1f-79a0-e14e70148cad@kdbg.org>
Date:   Thu, 22 Aug 2019 21:15:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.19 um 20:02 schrieb Saravanan Shanmugham (sarvi):
> We have a diskimage/fileysystem that has a 50G Git repository + 900G
> of binary/build articles and untracked files. When we mount such a
> diskimage, The verify first “git status” command can take as long
> 40-50minutes. Subsequent “git status” finish in under 5-10 seconds.>
> If I had a diskimage of just the 50G source repository, and I mount
> and do a “git status” takes around 15 seconds.
Are you saying that you commonly mount and unmount the filesystem?

Git tracks a device number in the index. Could it happen that it is
different every time you mount the filesystem? Because when it is, Git
reads the data and checks whether it has changed. At this time, the
device number is also fixed up in the index. Thereafter, "git status" is
fast because it sees from the cached file properties that no change was
made and does not have to read the data.

You may set "git config core.checkStat minimal" to avoid the problem.
But it may come with its own problems (certain kinds of modifications
would not be noticed, although these would be hard to trigger in practice).

-- Hannes
