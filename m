Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E1020248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIPjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:39:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42733 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDIPji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:39:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so15951208otd.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=u3LeWUWoGy32sZp53aB1vJLMoZMbdIX19PT7H2KwTg4=;
        b=W2cjjoWMaJtcL8u4R6maUV6uTXn1lla0vK75/SUBCPvG5Zm/K5OucvVXHWwKm7c1NM
         7KZIhWQ9w6C4i64fTYFmDvlb27MjzRiqhGLw2Z7wZmiE8KujQ1Rginwj28qATvorX9Ya
         NrZRm8a0XZjfsPcR5L5r8iufZqDyoPJtHONwvhp1jcvznxOEYdrjTd4WftRkI0Vk+6v5
         sG64itrLSeijFgiqedpNPLBvIRwIMNJ+ywnioJYaj/LdB2+1f5GyMNLgBkn7PugZ3QBE
         DEWBoeAOVI4V48mrLtEgyZMZ6Sb945JJC0JEYzA79US4sRjUpjvlqgo0ajC9NFsVyecM
         9fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u3LeWUWoGy32sZp53aB1vJLMoZMbdIX19PT7H2KwTg4=;
        b=kxJu7BN3wdH82FCeQG9kT6qtF+uuBH/sZa9IcZ2j/E2zeLGJQnD/cNW5sAbJHfHmK3
         Ea6zyfYeYyTkVz35ClwX116Y/3Id47or41gl8r0kUaHq0pjjlna/mHoKALC4RvTbezQl
         IWIyHn6NPza9BxAZqpc4PB1NZByD3UhVeLfbc+Dp19fTTI/Q6cXRCTsHjCr8XSJsB/B2
         sNfy7UGbn4QVIbfC2AGFlmPthRD6lUg5o3UwSI0KoFw0RMdDMkEEOvZWtpavhPXJANjG
         HWYqDBHOgpxUdGIWwTSLBL5aLz3zVY9ty6VWp/J54wX2Fgv6QhaCt4xfh7c2Beg2bma5
         NEhQ==
X-Gm-Message-State: APjAAAWRWtWrfszp2P6ej1BzBNd5zOi0z49RibAgWdcMZwkVULVHG13M
        Zk7ok7VDU9flWQzgdz8qAX74KpNSAPNGDo16jMVmudYx
X-Google-Smtp-Source: APXvYqy0FEnKqdjl2K7tCjnUo2d8Hxpy8hQzZZmALPdxY2SDLqe2+Cb1WpmyLXEFsgGIb0SabRN+O0PTQ3mVTqdqu6U=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr22788584oto.317.1554824377548;
 Tue, 09 Apr 2019 08:39:37 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Tue, 9 Apr 2019 21:09:25 +0530
Message-ID: <CAMknYEMh=CN6GGRPD_fkafHy84e49JY5dK2dAgX6Z7542dJ-Uw@mail.gmail.com>
Subject: [GSoC] [RFC] Proposal: Teach git stash to handle unmerged index entries.
To:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plan to implement the project.

Objective:
Teach git stash to handle unmerged index entries.

Description:
When the index is unmerged, git stash refuses to do anything. That is
unnecessary, though, as it could easily craft e.g. an octopus merge of
the various stages. A subsequent git stash apply can detect that
octopus and re-generate the unmerged index.


Implementation Idea:
Performing an octopus merge of all `stage n` (n>0) unmerged index
entries, could solve the problem, but

What if there are conflicts in merging ?
In this case, we would store(commit) the conflicted state, so they can
be regenerated when git stash is applied.

How to store the conflicted files ?
create a tree from the merge using `git-write-tree`
and then commit that tree using `git-commit-tree`.


Relevant Discussions:
https://colabti.org/irclogger/irclogger_log/git-devel?date=2019-04-05#l92
https://colabti.org/irclogger/irclogger_log/git-devel?date=2019-04-09#l47


Idea Execution Plan: Divided into 2 parts.

Part 1: Store the unmerged index entries this part will work with `git
stash push`

stash.sh: file would be changed to accommodate the below implementation.

Step 1:
Extract all the unmerged entries from index file and store them in a
temporary index file.

read-cache.c: this file is responsible for reading index file,
probably this implementation will end up in this file.

Step 2:
cache-tree.c: study and implement a slightly modified version of the
function `write_index_as_tree()`

int write_index_as_tree(struct object_id *oid, struct index_state
*index_state, const char *index_path, int flags, const char *prefix);

this function is responsible for writing tree from index file.
Currently in this function, the index must be in a fully merged state,
and we are dealing with its exact opposite. So a version to write tree
for unmerged index entries will be implemented.

Step 3:
write-tree.c: some possible changes will go here, so as to use the
modified version of write_index_as_tree() function.

Step 4:
use git-commit-tree to commit the written tree and store the hash in
some file say `stash_conflicting_merge`

Step 5:
Write tests for all implementation till this point.

Part 2: Retrieve the tree hash and regenerate the state of repository
as it was earlier.

Step 6:
Modify implementation of `git stash apply` for regenerating the committed tree.

Step 7:
Write tests.
