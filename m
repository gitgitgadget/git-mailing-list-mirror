Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25564C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 08:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjDQIac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDQIa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 04:30:27 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB310F7
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 01:30:25 -0700 (PDT)
Received: from [192.168.42.163] (205-49-142-46.pool.kielnet.net [46.142.49.205])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 1693A3C0BAC;
        Mon, 17 Apr 2023 10:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1681720224;
        bh=cL/NjBo66sSsGJkJi9kjI479+SK9zmiZehQPni5k3d8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=B/xswVYX3Y0F/3z13LMyM9to4Id0NXudsCUGEfPdskLL98Tb1jzisvTcc9bAaSnUk
         WfL8gV8T+YpqzdAKOTCE4oqa15WpF5jXeLizBTCMBhEZJQNNYWs2t7O6SVnYHcIAcb
         x8n1QgqrEvBw+7BNlyIbpJsbpqHbbx1TxfmP8OXgjSDJ5ZmzmqwtXO4Pcn15oRsv0P
         lc0nUNpqNQ5VeD0QXM9LoVPIGPRwf4t+UDi1BM9mPmnqsJooCmzFOI9FgRFJv7cCnz
         S8QDFf1z5n2HBB7AKNEIwIGgtdWn5ABdQyklBfXt31kYDne4DneUj7fczS5GeTBMBC
         EaIUK2hC4dsDA==
Message-ID: <3e278b6d-70f8-7ee4-3ff4-0212f6838ef5@haller-berlin.de>
Date:   Mon, 17 Apr 2023 10:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
From:   Stefan Haller <lists@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
In-Reply-To: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.04.23 10:21, Stefan Haller wrote:
> The --update-refs option of git rebase is so useful that I have it on by
> default in my config. For stacked branches I find it hard to think of
> scenarios where I wouldn't want it.
> 
> However, there are cases for non-stacked branches (i.e. other branches
> pointing at the current HEAD) where updating them is undesirable. In
> fact, pretty much always, for me. Two examples, both very similar:
> 
> 1. I have a topic branch which is based off of master; I want to make a
> copy of that branch and rebase it onto devel, just to try if that would
> work. I don't want the original branch to be moved along in this case.
> 
> 2. I have a topic branch, and I want to make a copy of it to make some
> heavy history rewriting experiments. Again, my interactive rebases would
> always rebase both branches in the same way, not what I want. In this
> case I could work around it by doing the experiments on the original
> branch, creating a tag beforehand that I could reset back to if the
> experiments fail. But maybe I do want to keep both branches around for a
> while for some reason.
> 
> Both of these cases could be fixed by --update-refs not touching any
> refs that point to the current HEAD. I'm having a hard time coming up
> with cases where you would ever want those to be updated, in fact.

One question then is whether the behavior makes sense for the case where
you have a stack of branches, and you make a copy of the topmost one and
then do either of the two above scenarios with that copy. With my
proposal it would leave the old top of the stack alone, but it *would*
update all the inner branches of the stack. Whether that's desired or
not is very unclear to me, and I would leave it up to user to add
--no-update-refs in this case if they don't want it.

-Stefan
