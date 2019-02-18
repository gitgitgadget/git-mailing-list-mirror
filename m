Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A5C1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbfBROJ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 09:09:57 -0500
Received: from placid1.grammatech.com ([98.159.213.246]:57428 "EHLO
        placid.grammatech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391341AbfBROJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:57 -0500
Received: from placid.grammatech.com (placid1 [192.168.219.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by placid.grammatech.com (Postfix) with ESMTPS id 028B51446AE;
        Mon, 18 Feb 2019 09:09:56 -0500 (EST)
Received: from jranieri-l1.local (barracuda.grammatech.com [192.168.219.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by placid.grammatech.com (Postfix) with ESMTPSA id D83A61446AD;
        Mon, 18 Feb 2019 09:09:55 -0500 (EST)
Subject: Re: [BUG] ls-files showing deleted files (unchecked lstat return
 value)
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
 <000001d4c6d9$bceb5810$36c20830$@nexbridge.com>
From:   Joe Ranieri <jranieri@grammatech.com>
Message-ID: <6588ca4f-7ecb-748a-ded5-f9bd014700c4@grammatech.com>
Date:   Mon, 18 Feb 2019 09:09:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <000001d4c6d9$bceb5810$36c20830$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/17/19 10:59, Randall S. Becker wrote:
> On February 17, 2019 8:50, Joe Ranieri wrote:
>> "git ls-files -m" can show deleted files, despite -d not having been specified.
>> This is due to ls-files.c's show_files function calling lstat but not checking the
>> return value before calling ie_modified with the uninitialized stat structure.
> 
> What version of git are you looking scanning? Commit 8989e1950a (2.21.0-rc1) has the following:

The analysis was performed on an old version of git, but I examined the 
code manually (commit 7589e63) to verify the code hadn't meaningfully 
changed.

> err = lstat(fullname.buf, &st);
> if (show_deleted && err)
> ...
> 
> You may be correct that the following check:
>   if (show_modified && ie_modified(repo->index, ce, &st, 0
> 
> may need to include !err. Is that your conclusion? Is there a test case you have to demonstrate this that I can include in the test suite?

Yes, this is the line I was referring to and the change I would have 
suggested. I don't have an automated test case, though I was able to 
replicate it by deleting a file on disk and running "git ls-files -m".

-- 
Thanks and Regards,
Joe Ranieri
Software Engineer
GrammaTech, Inc.
