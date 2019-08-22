Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4E91F461
	for <e@80x24.org>; Thu, 22 Aug 2019 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfHVV3O (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 17:29:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:59145 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfHVV3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 17:29:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46DyMr2DJmz5tl9;
        Thu, 22 Aug 2019 23:29:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AD2CA146;
        Thu, 22 Aug 2019 23:29:11 +0200 (CEST)
Subject: Re: First Git status takes 40+ minutes, when mounting
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
 <b409d16f-c392-7f1f-79a0-e14e70148cad@kdbg.org>
 <xmqq4l29ov2k.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dde804a6-5169-be17-40c3-2a89f93ace0d@kdbg.org>
Date:   Thu, 22 Aug 2019 23:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq4l29ov2k.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.08.19 um 21:32 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 22.08.19 um 20:02 schrieb Saravanan Shanmugham (sarvi):
>>> We have a diskimage/fileysystem that has a 50G Git repository + 900G
>>> of binary/build articles and untracked files. When we mount such a
>>> diskimage, The verify first “git status” command can take as long
>>> 40-50minutes. Subsequent “git status” finish in under 5-10 seconds.>
>>> If I had a diskimage of just the 50G source repository, and I mount
>>> and do a “git status” takes around 15 seconds.
>> Are you saying that you commonly mount and unmount the filesystem?
>>
>> Git tracks a device number in the index. Could it happen that it is
>> different every time you mount the filesystem?
> 
> I read the above to mean that a diskimage file is treated as a
> virtual block device on which a filesystem image exists, and it is
> mounted via the lookback device mechanism.  In such a case, I do not
> think stability of i-num would not be an issue (the filesystem image
> would record them all).

Inode number would be stable, but st_dev may not be. But it looks like a
default build does not use it anyway (I see that we do not define
USE_STDEV), so my guess was most likely wrong.

-- Hannes
