Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DEC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjDTP1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjDTP1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 11:27:20 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEC3AB7
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 08:27:17 -0700 (PDT)
Received: from [192.168.42.163] (214-49-142-46.pool.kielnet.net [46.142.49.214])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 177673C084E;
        Thu, 20 Apr 2023 17:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1682004435;
        bh=8IUTHQ1ymqchAPMkkNEL31aVGiIeFBSvUewtUyIVzOU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xVS3Ww1VvqA4NlC4MgE2u0oTshvaXWZSHnH8zgfqiQpAk7lKAuymebcvxIV6BOmb1
         kR3ptXoXKdlxgqWGgMf0D//nqlGzwnYr3uW/pkmtdUmIRt7mpWzZvoZDMR+FRUeRhC
         oakyqIk957WlmXsEcbcCOnwwr9aHsmNZwxhSR4BzHaioaYfrbiKHa11nQzaLhx/nBk
         aqXl5+2xl2hz06mpoSyWP0QSUxiIIPAyJMReE+cOdpqB/CoMPTWzsMpG7KWg/MKPV0
         C6oPieGZm6mGJHGD1YfzM/LE2u9fkBwBVgZ5mZ69LjeU33i488j+kFQeej/Zl4Vp7g
         3PY33djJBW4pQ==
Message-ID: <2db5c4a5-533a-f004-cf26-7ef938d1f94d@haller-berlin.de>
Date:   Thu, 20 Apr 2023 17:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <98548a5b-7d30-543b-b943-fd48d8926a33@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <98548a5b-7d30-543b-b943-fd48d8926a33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.04.23 14:14, Phillip Wood wrote:
> On 17/04/2023 09:21, Stefan Haller wrote:
>> Both of these cases could be fixed by --update-refs not touching any
>> refs that point to the current HEAD.
> 
>> I'm having a hard time coming up
>> with cases where you would ever want those to be updated, in fact.
> 
> If a user using stacked branches creates a new branch and then realizes
> they need to fix something on the parent before creating any commits on
> the new branch they would want both to be updated. e.g.   
>     $ git symbolic-ref HEAD
>     refs/heads/topic
>     $ git checkout -b another-topic
>     # fix a bug in topic - want topic and another-topic to be
>     # updated
>     $ git rebase -i --update-refs HEAD~2

OK, this is indeed one situation where my proposed change would do the
wrong thing.

It is of course impossible for git to tell whether you were meaning to
create a stack of branches here, or whether this is one of the cases
where I'm creating a copy of a branch and want to "detach" it from its
source branch, as in the examples I posted earlier in this thread.

In my personal experience the latter is much more common than the
former, and it's also easier to correct the mistake manually in your
example by hard-resetting one branch to the other again, so I still
think it would be a useful change.

Any other opinions about this?

-Stefan
