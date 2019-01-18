Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678E61F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfARNjy (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:39:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:54925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfARNjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:39:54 -0500
Received: from [194.114.62.122] ([194.114.62.122]) by web-mail.gmx.net
 (3c-app-gmx-bs22.server.lan [172.19.170.74]) (via HTTP); Fri, 18 Jan 2019
 14:39:52 +0100
MIME-Version: 1.0
Message-ID: <trinity-02f2f7de-850d-4ad6-b709-86b7914cd81f-1547818792471@3c-app-gmx-bs22>
From:   "Steve Keller" <keller.steve@gmx.de>
To:     git@vger.kernel.org
Subject: How do I get rid of unneeded objects?
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Jan 2019 14:39:52 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:advfJdKp2kQMzlTa+MldZAhsYABOaq+VdBVY444wrCb0a2qs1VstjK8H+XdEaPWR0CEpV
 RogrxdK/ep0quOJOlASUsT7QJmNPh3fwQwfX3X7ED/AeE2gzYW8d4gni3AX8pHfTAi3sSBj0CDvY
 nIOk9GGzET3rIepTljuDxfdR1HNW7wsursSRF3v7S/OBidLptzBb62xxl/ydvo+PoPZ45xiTJKdY
 HXMjkb1iGwzs48zk9TynYzChShdHs0UdRkDcFnAYoT3HnisZle4FOyazOkyuIq7qWQXZwgrFeGgs
 vU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:sE4cQmyuHXc=:Ch4IjkDig8MPvBhxZ2p7Bl
 hQvVw/vOGTbtShZOoSCBZ4kHMTha2VYxgS8RxK0ghkRTtt7BMmaJ80AxJsdEVZxWZqblhPlB/
 b8fuwXuVTTV8/eQsKs5WPE7k5CQBtiW2kpbSGJ5SFpVbxJteeFNnD4olOg29zf0ouWuKOUT4O
 a3f+CEu+wFXxlZG7c7c+Uluot8MPmolWL2aTDeeidboUrJIxrhO3BI9lfv1JCzJmW4IeATMtY
 y8Kv2qoZt7MgwK76sYqkgTHm/M7n0ElI4q3//UoUdX8wsBdAIemoATLSfKhxlmMMruPQ9Ib9r
 6KZD1HrDaE5RZ2YvElwCOg6v/0GdSESTKUjtSglkM4TvLcAr2BGM8HBzlI1CFh0ZTnuopGTwx
 KUgpWJQRxpeXQ5luQQpn+CO08Iqw0T08wjAR/62jDiKYUk9p7fkqUAQfDcUPKNlimWALUcfWJ
 P0zkWDvj0vjll0jBFJXRxIDTTV5Wx9FZg7M12iIYpkXKLW481H/is3WHdcehI8xG4lp0tZHXV
 53wZrF2ztTDzK9aBZFEhpyqY7GBerHvjnkKzFqkt18hz36SO2M/OTkQOF9EJjowOILa9Vl+my
 bbYLESEZ3ONbw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After deleting a branch or amending a commit I still have orphaned
objects in the repository:

    $ mkdir repo; cd repo
    $ git init
    $ date > foo; git add foo; git commit -mmsg1                                        
    $ date > foo; git add foo; git commit -mmsg2                                        
    $ git checkout -b branch-1 HEAD^
    Switched to a new branch 'branch-1'
    $ git commit --allow-empty -mbranch-1
    [branch-1 84cfad2] branch-1
    $ git log --oneline
    84cfad2 branch-1
    09fdcb1 msg1
    $ find .git/objects/ -type f | sort | nl
    1  .git/objects/09/fdcb1cb7d5642874bd642ce5685ac0bebd116c
    2  .git/objects/41/d9ceb271c5e72f8a94a38dc4852ab501566bd1
    3  .git/objects/4f/c6596065dd08ebc62ce0728e2407d58dbde7e1
    4  .git/objects/5f/c4d7af12460d774be720f8761da0be2595404d
    5  .git/objects/84/cfad2cea2ae3f7a67530d5c596853f656e68d9
    6  .git/objects/a1/5faea60776cd537c4ef527f08caff48ff6c86b
    7  .git/objects/c8/c0278da7cf96d86c5881f3884b5015deee7113

These objects are 2 files, 2 trees, and 3 commits.  If now delete the
branch again, I'd like to have the unneeded commit deleted, but:

    $ git checkout master
    Switched to branch 'master'
    $ git branch -D branch-1
    Deleted branch branch-1 (was 84cfad2).
    $ git reflog expire --all
    $ git prune
    $ find .git/objects/ -type f | sort | nl
    1  .git/objects/09/fdcb1cb7d5642874bd642ce5685ac0bebd116c
    2  .git/objects/41/d9ceb271c5e72f8a94a38dc4852ab501566bd1
    3  .git/objects/4f/c6596065dd08ebc62ce0728e2407d58dbde7e1
    4  .git/objects/5f/c4d7af12460d774be720f8761da0be2595404d
    5  .git/objects/84/cfad2cea2ae3f7a67530d5c596853f656e68d9   <-- [1]
    6  .git/objects/a1/5faea60776cd537c4ef527f08caff48ff6c86b
    7  .git/objects/c8/c0278da7cf96d86c5881f3884b5015deee7113

Why is [1] not deleted?  It seems reflog still knows about the deleted
branch, and probably this is the reason git keeps the referenced
commit:

    $ git reflog
    c8c0278 HEAD@{0}: checkout: moving from branch-1 to master
    84cfad2 HEAD@{1}: commit: branch-1
    09fdcb1 HEAD@{2}: checkout: moving from master to branch-1
    c8c0278 HEAD@{3}: commit: msg2
    09fdcb1 HEAD@{4}: commit (initial): msg1

Also, git gc, mentioned in the man page for git-reflog does not help.
And I see similar things when amending a commit, where the old commit
object is kept.  How can one get rid of this?

Steve
