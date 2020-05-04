Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C532075B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZeJ+zgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgEDNb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDNb3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C340C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r26so9085976wmh.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pphhDSNHKiU1lYgef0jlldw66oTlT30MB7oja7bojDw=;
        b=RZeJ+zgZSIbP2Q8pUCP/y4BYa8010d9o27anu1laIkj6ARGGG3zTlheTowiwaw5Wga
         oXFOpxaejCqjz2ASAsikwbXnO5uUfPv3u6HecFVbgHWSHALkYEGQ6dDwwNm5Y61K2yz3
         sWvsX+Jom4vImO7qLTgOM9WTi8c8e4o8y6Yim4OqroMionG+PcBrbQuec6UzZoZRBsTr
         N0PtQNIBbHy6KEdj46j5bTj1sNoFwNkyjp8akszk3Mozq4pgP0h51nTB5k2oFD03pqa4
         yE0BoXqGQihiPZQssSTd/b7ZnPT+PPHjB/huaz88FW6Dz5dHmfWdYIS4F1DOMZ/2kibC
         fxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pphhDSNHKiU1lYgef0jlldw66oTlT30MB7oja7bojDw=;
        b=oEvRftZNC6eZ9vIrspBV3F+f8S7o5KsbAaqsF0irglpG4cLb2yelftO0JgDYm+Sm+7
         XcU3QFFBDD0TFza4cVFfIVnn2zq+dQ+/GFVhB9C6KlVXqsVnsrgDwF4mnjNhPPojwjWl
         nLiwigYk/7G+cV5eVHoSfwm6ptvVVobrM3dfjDELWUTbvivq0Wt76j5a9NNW3UDWgbzt
         kfsaEufRLgpsZon8kujhZBPhV+0dSG2K68S6sfbiq2NNPI9WHrFhIeD4IO6no6Pn1yNH
         2GjNllVFDEY2fMt2cvMKgAor6QZhNt4CyomfppgRELJT/QhLIHm5uhkwuK9eWZC97wPB
         Cvgg==
X-Gm-Message-State: AGi0PuYV3WSBcBJR71amDQQKthjLAuLnaCNE0MVdR8j1NXpYyUOvceR9
        dwEGWXtLOoa7FhpEH/W9mCxzXVZK
X-Google-Smtp-Source: APiQypLeREWQcgGhM3iQ8mbvaePcjE9X6N/ULM2efBL+7uqFTxf/nYS8cMhnSYtoWviBavY3IwW3vg==
X-Received: by 2002:a1c:a9d3:: with SMTP id s202mr14678536wme.160.1588599087393;
        Mon, 04 May 2020 06:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm21169626wro.18.2020.05.04.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:26 -0700 (PDT)
Message-Id: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:20 +0000
Subject: [PATCH 0/6] Minimal patch series to fix the CI runs of hn/reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are not intended to be complete, not by any stretch of
imagination. They are just enough to get the CI run to pass, even in the
Windows-specific parts.

As I mentioned elsewhere, I would much prefer for hn/reftable to not 
re-invent get_be*(), struct strbuf, struct string_list, struct lock_file 
etc.

However, in the context of the test failures, I do not think that this would
have made a big difference. Apart from the unportable constructs, and from
the "delete/rename while there is still a handle on the file" issues, it
would appear that one big reason why it was so hard to debug and fix the
test is the recursive complexity of the data structures.

To elaborate on that: struct reftable_stack has an attribute called merged 
that has an array of struct reftable_reader * (confusingly called "stack").
Each of these readers has an attribute of type struct reftable_block_source 
that uses a vtable and an opaque pointer to abstract three types of block
sources: file, slice (which is apparently unused, i.e. it is apparently just
dead weight for now) and malloc.

I am not sure that this abstraction fest serves us well here.

Quite honestly, I would have expected the packed_git data structure to be
imitated more closely, as it strikes me as similar in purpose, and it has
seen a ton of testing over the past decade and a half. I could not recognize
that design in the reftable, though.

It is quite obvious, of course, that the code tries to imitate the
object-oriented nature of the Go code, but it seems quite obvious from my
difficulties to address the problem where stack_compact_range() would try to
delete stale reftable files (without even so much as a warning when the
files could not be deleted!) without releasing all file handles to all
reftable files, even the ones that do not need to be deleted. To be smarter
about this, the code has to know more about the nature of the block source
than the abstraction layer suggests. It has to know that a block source
refers to a file, and that that file is marked for deletion. My heavy-handed
work-around, even if it works, is not really a good solution, but it is a
testament that there is a lot of opportunity to simplify the code
drastically while at the same time simplifying the design, too.

I know you have been putting a lot of effort into this library, so I feel a
bit bad about saying the following: The hn/reftable patches will need
substantial work before we can merge it with confidence. Part of the reason
why it is so hard to review the reftable patches is that they intentionally 
refuse to integrate well within Git's source code, such as (re-)implementing
its own fundamental data structures, intentionally using a totally different
coding style, and it concerns me that the stated requirement for bug fixes
is to treat Git's source code as a downstream of the actual project. I am
not too bad a C developer and would consider myself competent in debugging
issues, even hard ones, in Git, and yet... it was really hard to wade
through the layers of abstraction to figure out where the file handles
should be closed that were opened and prevented deleting/renaming files.

At this point, I don't feel that it makes sense to keep insisting on having
this in a separate library. The only other user of that library will be
libgit2, and I really think that given libgit2's heritage, it won't be a
problem to adapt the code after it stabilized in git.git (and since libgit2
treats git.git as upstream for the libxdiff code, it won't be a problem to
do the same for the reftable code, too). I believe that the best course of
action is to reuse the data structures libgit.a provides, and to delete the
re-implementations in reftable/. Only then can we start working effectively
on refactoring the code to simplify the data structures in order to clarify
resource usage (which was the root cause for the bugs I fixed, although I am
sure that there are way more lurking in there, hidden by the fact that the
code is not covered thoroughly by our tests).

Johannes Schindelin (6):
  fixup! Add reftable library
  fixup! Add reftable library
  fixup! Add reftable library
  fixup! Add reftable library
  fixup! Add reftable library
  vcxproj: adjust for the reftable changes

 config.mak.uname                           |  2 +-
 contrib/buildsystems/Generators/Vcxproj.pm | 11 ++++++++++-
 reftable/record.c                          |  2 +-
 reftable/stack.c                           | 17 +++++++++++++++--
 4 files changed, 27 insertions(+), 5 deletions(-)


base-commit: 1b749f9d62f2c8b5a8e91f382d2be14902459cba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-623%2Fdscho%2Freftable-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-623/dscho/reftable-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/623
-- 
gitgitgadget
