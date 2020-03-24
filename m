Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF644C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A654E20714
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCXBhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:37:36 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21117 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCXBhg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 21:37:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585013846; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SmZD2+ih+115X2Xpmi4m69fz1/T0uup9RcMbSBLBvCmd8bWtVk/qeZ8B7sB2J/PQVRGVnpSFZDCS6BKiJwzJdecwiuKiMpZdKbC1sry9snewwS7awIOubdqaZ5vIJUvDvjA+grik5mF4fzTs5O4yA0MOOSn8tsPmWs7JeS757QE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585013846; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tcB0Fi8pdkTlFe+ylOVh9R1MJUiq/wueg7V7Z2rFSO0=; 
        b=jcxuPjQrQ5EK6SL3dacodWC0kHZpFTWnr91/ZcYLdQBtAD8d81Zl78eD3C9Aj7R1xM2GZqsKl7flpTqYiED9psIeVjEOvmx2i1uFxcdRo5JL81Kj7hEmSw2T7Thd3te39RN8uoopwJtvzjcOVi4FLczzUmL869aDbQRgXZ7DSZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=jon@smalls.rocks;
        dmarc=pass header.from=<jon@smalls.rocks> header.from=<jon@smalls.rocks>
Received: from Genusers-MBP.fios-router.home (pool-108-49-187-119.bstnma.fios.verizon.net [108.49.187.119]) by mx.zohomail.com
        with SMTPS id 1585013843625508.93594848753673; Mon, 23 Mar 2020 18:37:23 -0700 (PDT)
Subject: Re: git > 2.10.1 fails to update index on macOS 10.14.5
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
References: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
 <20200323231351.GD6499@camp.crustytoothpaste.net>
From:   Jonathan Smalls <jon@smalls.rocks>
Message-ID: <414a10db-18d4-0c19-eafe-fbb85811fffe@smalls.rocks>
Date:   Mon, 23 Mar 2020 21:36:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323231351.GD6499@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/20 19:13, brian m. carlson wrote:
> What exactly do you mean by "doesn't recognize any file changes"?  Can
> you tell us what commands you ran and what you expected to see, and what
> you actually saw?  That information would be helpful for us to track
> down what might be happening.

In git-2.22:

I would write a change to a file. Running `git status` would return that 
the working directory was clean, and `git commit .` would show that 
there were no changes to commit.
	However I could target a specific file like `git commit test.txt`, and 
git would successfully recognize the change, and write the commit. I 
could also run `git reset --hard`, and that would update the index to 
reflect the change that I had just written rather than resetting the 
working directory to match the latest commit. If I ran `git reset 
--hard` a second time, that command would reset the working directory.

In normal operation, I would expect to `git status` to recognize a 
change in a file once it had already been added to the index. I would 
expect `git commit .` to commit all files in the current directory, and 
subdirectories without having to specify their file names. I would 
expect `git reset --hard` to revert the working directory to match the 
latest commit the first time.

In git-2.25

I would write a change to a file. `git status` would continue to show 
that the working directory was clean, but I was not longer able to 
target a particular file to force a commit. `git reset --hard` had no 
effect, and still showed that the working directory was clean without 
resetting the working directory.
	To successfully commit a file I would have to run `git rm --cached 
test.txt` to target a file, and then `git add test.txt` for git to 
update its index, and recognize the change.

I would expect the same normal operation in git-2.25.

> 
> Also, are you using any specific workflow or tool that might be related?
> Are you using an editor integration or GUI, and if so, does this happen
> without that editor integration or GUI as well?

I use git on the command line, so there should be no external 
interference with its normal function.
