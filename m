Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF3320986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbcJSW0l (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:26:41 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34420 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbcJSW0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:26:40 -0400
Received: by mail-yw0-f180.google.com with SMTP id w3so31591681ywg.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=7j/4V0FH5BX4KCIorUW04q2KEEL3SFIxbN64bfkYUTA=;
        b=rHHKQZ48p+8BGqD1jYvIjUBI6kAhdqNnKbRu3xOnr4//vRJTM6dU89ZYPXKxPfTyD5
         9O1hpz90JK25Kt85dZ9O4bWAivkNs9lYctItDUD1jnVFfSHuKE4SEDl6V7jLF+XpM95C
         OyzuyWr7BuEuOfKcvscr8n7TShfQGH2ILnU6UAHVgu+06aiW4sO9tCw7p+8SIf3XndB1
         tPJ8pAASLhjsGOwSYyHNNMhopCjUSqf4m38lygDAb9binrBjKoJ7uelK7FHwoG7D9VnA
         TzIOvcL8QalSmCZporD1INWJzkb+wAb3e2Xgubf3ffndlBueV+xk6laNUrT6WniZhuNJ
         AEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7j/4V0FH5BX4KCIorUW04q2KEEL3SFIxbN64bfkYUTA=;
        b=M4ItvFkWZzJmygVH2JvFI1SmRX7BjvPp0pSe3fJXiY1MTCT8oGzMzIJUerqNjYP+vy
         MlvoET7D5XvCw++ZWO76nK92p2YKO2pmqEz9MpdfZ0syNjuh0aIPZ5MCu79fTNAVUOyr
         EMCIA7cvkSZKL1JAYQ83jGUeWxhZOA85kAtnix9ulXDzjQ45kivxF8O54Rv9fesg2Jk0
         T152xl3oDcAoKKJNzDAMurdWG4A0Jhtz/Njr8EFFe4TY8GkF4avclnNInlzyQCPi5GMD
         WXUx/TDH9IOSS0k60jHbGwx1X56JbsVImcj1n0XNL/PsN8OSkSZw5wlJpksLp2QynDkz
         obZA==
X-Gm-Message-State: AA6/9RldRulsn5r6hK0mu7VDtFKCh3Ar4p+Tb1AeArv9w6YnuZG9s3DvQXc5barv/5LUJW7ybMPefpeILwoV3Q==
X-Received: by 10.13.244.69 with SMTP id d66mr9704311ywf.318.1476915999148;
 Wed, 19 Oct 2016 15:26:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 19 Oct 2016 15:26:18 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 15:26:18 -0700
Message-ID: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
Subject: tools for easily "uncommitting" parts of a patch I just commited?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently (and in the past) had an issue where I was using git add
--interactive and accidentally did something like the following:

# hack lots of randmo changes, then begin trying to commit then separately
git add -i
# set only the changes I want
# accidentally add <file> to the commit
$git commit -s <file>
# type up a long commit message
# notice that I committed everything

At this point I'd like to be able to do something like:
$git unstage -i
# select each hunk to unstage

and end up with a commit that only has what I originally wanted,
without having to re-write the commit message, nor having to do a lot
of weird things, or anything.

I can ofcourse use reset HEAD^ and lose my commit message, but then
I'd have to retype that out or copy paste it from somewhere else.

I ended up doing something like:

# save the current tree
$git rev-parse HEAD >savetree
# checkout the old files and re-write
$git checkout HEAD^ <file>
# update commit removing all changes from this file
$git commit --allow-empty --amend <file>
# now checkout the tree again to the contents of the saved tree
$git checkout $(cat savetree) <file>
# now add only the parts I wanted before
$git add -i
# finally amend the commit
$git commit --amend

That's a lot of steps and forces me to save my own file.

I thought of a few alternatives:

1. Create an advice setting which basically allows me to say "git,
please prevent me from staging files + an index if the files I marked
also conflict with paths already added to the index, maybe unless I
passed a force option"

or

2. somehow streamline the process of what I did above so I could just
do something like:

git commit --amend --set-tree=HEAD^

which would force the commit tree up one and avoid the double checkout
stuff, without actually changing my checked out copy at all

Then I'd be able to quickly re-add what I wanted.


3. somehow allow an unstage option.

So for the TL;DR; .. does anyone know of any tools which would help
automate the process so I could simply do

"git uncommit -i" and run a tool just like git add interactive or git add -p?

Thanks,
Jake
