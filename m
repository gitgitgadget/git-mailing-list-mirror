Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA269C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 11:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22DD20716
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 11:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgC3LWA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Mar 2020 07:22:00 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21154 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgC3LWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 07:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585567311; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Gmv/c+fBs5pqGvRd+f40NJr6fPqgvHaJlX0MxVpNPRkj8CR+2WnS7mGf6KkidoeBO9zyM8IetNMMIcFF+cJimgYyUl9i6+iP+uspvU73jZDMko5LDgPgcZgyAf/1rYKiBwdvckv4QvSNcIF1OCx6guJ8jjN2K0AibfVX6hRmGVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585567311; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BJIZt/0qA505D4cFoaLgB/K6W8ITGmGwtj5upXO00zM=; 
        b=btK3zrYEgcv0nIjNdRSjXWdFmhiJbAtcgmrIDJ3Rzdmzpf/vGYyUC6a4CHD8aSanSmvh/W+nL+Cd6oe/iyTDOGnvWk6Ie9MMk2B6D8Sd0nxJ3g+FQvCAS45mAr2oj/rtxwK3eWqH73PoauSEXwn0CA393uJFrdhcXqOlsgmY5xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=jon@smalls.rocks;
        dmarc=pass header.from=<jon@smalls.rocks> header.from=<jon@smalls.rocks>
Received: from Genusers-MBP.fios-router.home (pool-108-49-187-119.bstnma.fios.verizon.net [108.49.187.119]) by mx.zohomail.com
        with SMTPS id 1585567309631465.42408415644945; Mon, 30 Mar 2020 04:21:49 -0700 (PDT)
Subject: Re: git > 2.10.1 fails to update index on macOS 10.14.5
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
References: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
 <20200323231351.GD6499@camp.crustytoothpaste.net>
 <414a10db-18d4-0c19-eafe-fbb85811fffe@smalls.rocks>
 <20200324235934.GI6499@camp.crustytoothpaste.net>
From:   Jonathan Smalls <jon@smalls.rocks>
Message-ID: <909fa74a-2310-c744-6b85-fac3a5bd5081@smalls.rocks>
Date:   Mon, 30 Mar 2020 07:20:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324235934.GI6499@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also need to specify, it looks like I was on git version 2.21.0, not 
2.22.0.

On 3/24/20 19:59, brian m. carlson wrote:
> Does running "ls -l" on the file before and after show different
> timestamps and file sizes? 

Changing the index file updated the file modification time appropriately.

--

Mar30 0715.19 [jsmalls:~/Documents … c310/lorenzCurve] master+
     >> vim index.py

     Mar30 0715.31 [jsmalls:~/Documents … c310/lorenzCurve] master+ 8s
     >> ls -l
total 56
-rw-r--r--  1 jsmalls  staff   1650 Mar 30 07:15 index.py
-rw-r--r--@ 1 jsmalls  staff  16878 Mar 29 20:10 lorenzCurve.png
-rw-r--r--@ 1 jsmalls  staff   1800 Mar 26 09:05 pop2010.npy

Does "git config -l | grep -iE 'checkstat|ctime'"
> show anything? Can you use the stat(1) command to tell us whether the
> change results in a device or inode number change (if that's possible
> using the macOS version)?

The git config command returns an empty result. I am not sure what I 
should see in the stat command, but I have included the result here.

--

Mar30 0715.40 [jsmalls:~/Documents … c310/lorenzCurve] master+
     >> git config -l | grep -iE 'checkstat|ctime'

     Mar30 0716.19 [jsmalls:~/Documents … c310/lorenzCurve] master+ 1
     >> stat
1054203952 723 crw--w---- 1 jsmalls tty 268435456 0 "Mar 30 07:16:43 
2020" "Mar 30 07:16:43 2020" "Mar 30 07:16:43 2020" "Dec 31 19:00:00 
1969" 131072 0 0 (stdin)

