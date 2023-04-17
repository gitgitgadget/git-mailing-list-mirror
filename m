Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B826AC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 08:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDQIVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDQIVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 04:21:21 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F904216
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 01:21:19 -0700 (PDT)
Received: from [192.168.42.163] (205-49-142-46.pool.kielnet.net [46.142.49.205])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 3EF313C033A;
        Mon, 17 Apr 2023 10:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1681719675;
        bh=taMu+AbrFaOOLGUOi/cN6oc/n1raXMTWHcR84BaeDGE=;
        h=Date:To:Cc:From:Subject:From;
        b=msgTMY1rgBmQcpZMkbJHBj6zVQhkPB1YMB139LUfhWMvn4hLO9bXfW0gyel8i1DbG
         7+OybJKUiePqeakulSYfLJyEDh9blnKfZuvII+6aELjbmtYo+pIjlBn7pAjClm27xD
         hZu9BBONW0J3WWdCZUd3Eke+0Kz6bTOGq6zBLLYrIAsiJG2lrbYueeyQQFVkvn0QAh
         k9hrJuCgW+bANEvWautXGlil1ogKyHvfz21hn0zY+9Jei+C+PgVvhn24YoMzASGlCG
         CFpEGSQbf47jzkLwhIsoy/VsDcb/B2OmdbWOJUDBjsv1wtf4BR0RDDI+zIgB3izp9z
         qLOYA7Rl8IGuQ==
Message-ID: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Date:   Mon, 17 Apr 2023 10:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Content-Language: de-DE, en-US
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        ", Elijah Newren" <newren@gmail.com>,
        ", Phillip Wood" <phillip.wood123@gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
Subject: Should --update-refs exclude refs pointing to the current HEAD?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --update-refs option of git rebase is so useful that I have it on by
default in my config. For stacked branches I find it hard to think of
scenarios where I wouldn't want it.

However, there are cases for non-stacked branches (i.e. other branches
pointing at the current HEAD) where updating them is undesirable. In
fact, pretty much always, for me. Two examples, both very similar:

1. I have a topic branch which is based off of master; I want to make a
copy of that branch and rebase it onto devel, just to try if that would
work. I don't want the original branch to be moved along in this case.

2. I have a topic branch, and I want to make a copy of it to make some
heavy history rewriting experiments. Again, my interactive rebases would
always rebase both branches in the same way, not what I want. In this
case I could work around it by doing the experiments on the original
branch, creating a tag beforehand that I could reset back to if the
experiments fail. But maybe I do want to keep both branches around for a
while for some reason.

Both of these cases could be fixed by --update-refs not touching any
refs that point to the current HEAD. I'm having a hard time coming up
with cases where you would ever want those to be updated, in fact.

Any opinions?

-Stefan

