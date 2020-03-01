Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9EC3F2CD
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FBA246BE
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="KirRZcW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCAUdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:33:16 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:49198 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAUdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 15:33:15 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 15:33:15 EST
Received: from [192.168.1.8] (hvdijk.plus.com [81.174.157.28])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 0E56AEBB;
        Sun,  1 Mar 2020 21:27:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 0E56AEBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1583094427;
        bh=Nks3wped0lmGCX7vKzGPfh8+byGuasofnb9VG7Y7R+8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KirRZcW/QYl23j9wzEV/6aGC0UHp4NbfuGneFZ5YhUsr5Sj/dZumXCTdDsJTrJieV
         ZdOcRp//2Mrbv6sWefZcwi79Xi8nT1P16eKsx0vvW1/4Yr6o/25FRyt0E/SYr+0opk
         MzloctqOKh17MBocMJdgPZovYrn8aOPQMLNKSz0o=
Subject: Re: [PATCH] show_one_mergetag: print non-parent in hex form.
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com
Cc:     git@vger.kernel.org
References: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
 <20200301155937.7168-1-martin.agren@gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
Message-ID: <7330146a-5a4f-17cc-cb26-f90d4060c0ee@gigawatt.nl>
Date:   Sun, 1 Mar 2020 20:25:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200301155937.7168-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On 01/03/2020 15:59, Martin Ågren wrote:
> But I also wonder if we even need the "bar" commit. Similarly,
> "--detach"-ing when checking out master seems unnecessary, unless we're
> afraid of "messing up" master, by modifying the expectations of later
> tests? Was that something you were concerned about?

The "bar" commit was present in the test I based mine on, where it was 
equally unnecessary except possibly for making the test easier to 
understand. I have no feelings whether it is better to have it in or 
leave it out, other than that it should be consistent across tests.

Not messing up the master branch is what multiple tests in this file, 
specifically the test I based mine on, do. If the test I had based mine 
on and my test had both done

   echo aaa >bar &&
   git add bar &&
   git commit -m bar_commit

on the master branch, whichever test appeared second would fail, because 
git commit would not detect any modifications. This seems needlessly 
fragile to me, so I agree with the pattern used by the existing tests.

> I realize the test you add is similar to the ones surrounding it. But it
> does look tempting to squash in the diff below. The test still fails
> before and passes after. What do you think about this? Does this
> correctly capture your scenario?

Yeah, the test set up is literally a copy of the test immediately above, 
except modified not to use conflicting ref names.

It could be simplified, but in that case, the other tests should be 
simplified the same way, and I did not think it was appropriate to make 
such changes here.

Cheers,
Harald van Dijk
