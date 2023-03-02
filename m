Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C389EC6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCBU1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCBU1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 15:27:39 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43853B0EF
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 12:27:24 -0800 (PST)
Received: from [192.168.42.163] (127-98-142-46.pool.kielnet.net [46.142.98.127])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id C1B6B3C1165;
        Thu,  2 Mar 2023 21:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1677788842;
        bh=zxatUfc2wzbWqjcjfl+RXtNlX26SA33JjKyJIf8BqtI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dJIYFxfEzICW24MKWPihXBw3mAHzTLpXALYaDA6PxVv5VfrXI1o9uZkAbJLov/p2l
         hM/PFxJywNAivn3xAhiVPO6svDVFNpeQLiukGIXVHDzdENTT4QCd2ZXbdj5APgEK9j
         gfZ2XznzXtUfAg04oZoSQwzX6foltOFBPW1z2KlZLZkiSncfNeJSUaSL5MBkdz28kp
         vonjVRy84GPDWlv+5xPtbM9ux5pzqlfisZGO3DEzGWRlEE70HXZ4yhrncw1dULR1yN
         z1M2aqmu0Qq9et8qOxEK2LbEG/kKAZJB4XA/HdKhDCUn0ciLp9n60BVase95u3chQD
         pyJtULcW87RSQ==
Message-ID: <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
Date:   Thu, 2 Mar 2023 21:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.03.23 11:19, Phillip Wood wrote:
> On 28/02/2023 12:55, Stefan Haller wrote:
>> As far as I can tell, REBASE_HEAD always points to the last commit that
>> was attempted to be applied in a rebase, not matter whether that attempt
>> was successful or not. In other words, when you break in a rebase with
>> "edit" or "break", REBASE_HEAD is the same as HEAD 
> 
> As you said at the beginning REBASE_HEAD points to the commit that we're
> trying to pick, so it will only be the same as HEAD if the pick was
> successful and it was not rebased onto a new parent.

Right, I was a bit sloppy in describing the current behavior.

> I think it is
> useful to have REBASE_HEAD set when editing a commit as I find it is
> sometimes useful to look at the original commit.

OK.

>> The reason why I am asking this is: I'm using lazygit, which, during
>> interactive rebases, shows a combined view of the real commits that were
>> already applied, and the remaining commits that are yet to be applied
>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>> this, when I set the 2nd commit to "edit":
>>
>>    pick   4th commit
>>    pick   3rd commit
>>           2nd commit  <-- YOU ARE HERE
>>           1st commit
>>
>> This is great, but assuming that the 2nd commit conflicted, currently
>> the display looks like this:
>>
>>    pick   4th commit
>>    pick   3rd commit
>>           1st commit  <-- YOU ARE HERE
>>
>> I would like to extend this to also show a "fake entry" for the commit
>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>> except that I need a way to distinguish whether it was applied already
>> or not.
> 
> Can you check the index for conflicts when the rebase stops?

I could do that, but then the fake entry would go away as soon as I have
staged all conflict resolutions. I would find it useful for it to stay
visible in that case, until I continue the rebase.

-Stefan
