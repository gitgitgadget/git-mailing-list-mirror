Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4AFC77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjERWSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjERWSF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 18:18:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBA7E5F
        for <git@vger.kernel.org>; Thu, 18 May 2023 15:18:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae454844edso19297375ad.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684448283; x=1687040283;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y01fWxY5AgqQeznbavwa4LFygPU9SJOoWdjpmw6Aafk=;
        b=D/rhXLWcgT2BB1kSkRkLF54JrHcvfMq2tdmqCWyacC1WSPJuzPAuDPGxZxxp50Oxob
         SVFB2t8JxVPilxoOff2NKwUVkTW/5hxXnyfJljVKx6jxjpZr4T5F0Ot7tezk7/3OcFvC
         4zErLUNTx5nQLEQ9OVaNSa9F4d6sYGzQg5kd/tiJpx3xdAsUXTnVvgjqvhNV+8f5Rxhb
         CfYxxVQvjm9f6IU+PtLEWyBGDwozmHh9luz8/6utncSmu5jhXlap6/FWQWAe37cGrqvk
         aysijPNa4zRM2umZtYVvERKAWtKom875gTamTHbE702dfV39zsq1DNPCuzUzLgbxsTnY
         a83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448283; x=1687040283;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y01fWxY5AgqQeznbavwa4LFygPU9SJOoWdjpmw6Aafk=;
        b=Ahg7q2vh0BsptgQ42d9csLCtnLEEgzZTZFCPutmrXDnjX9tEYXKVhrNt5Gornog4FL
         P7NgswfV1k8lhhVVFEnLO90kERk7AS3RmaQ/z9h3Q2xtaWbj8n8LlvAHkvt/JAnG8e6e
         3FnCK24KehivzBnWIDI+DJzWX62jmOxhenrMAVgSlnqsUW93IypW0XOLa5UnjKq+l2yT
         tVUOKD1W+DRQDOorpnOaF/Mpi9d+HdVSPlgC/2NrPs09vTXxEr4krV5JVI3TjPR6w/KY
         3jIqF05BtrAJVhhaDjifsXprzwJmeZOj2SeoRYPLMXzsneFr8SFSXM0S75dEObcbfLXQ
         wIJw==
X-Gm-Message-State: AC+VfDzjXx7Hh3QUibhHQGvNx/Tn3zT9UbSNFHh+blOsxO+MEj0HNpM4
        V6xSCf+ThKxwqFKFu8M8wlPLADj2Q9A=
X-Google-Smtp-Source: ACHHUZ6HYptoUddBvEbxyJZi72jYAmY9/z/KNCvjEK3S4n4fj6up+qNe6D2DHQG8zHPYV6zFpRZixg==
X-Received: by 2002:a17:903:2310:b0:1ad:164:74fc with SMTP id d16-20020a170903231000b001ad016474fcmr834246plh.20.1684448283125;
        Thu, 18 May 2023 15:18:03 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902e98900b001acad024c8asm1969704plb.40.2023.05.18.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:18:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [not even design notes yet] teaching rerere to remember removal?
Date:   Thu, 18 May 2023 15:18:02 -0700
Message-ID: <xmqq353ts2qt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more like just an early scratches on paper that might some
day turn into a design.

A side branch can remove path P, while the mainline, since the side
branch forked from it, can modify P.  When such a side branch is
merged to the mainilne, we would see a 'one side modified, the other
side removed' merge conflict.  The change made on the mainline may
be of small significance (e.g. code restructuring), while the
removal done on the side branch may be of bigger significance
(e.g. the command implemented by the file P is no longer necessary).

For safety, the rerere mechanism does not unconditionally remember
such a removal and replay.  When you resolve such a conflict in
favor of removal of P after looking at it, the decision to remove it
may be reasonable, but if you let the mainline further tweak P
without knowing other party working on the side branch is planning
to remove it, at some point you may want to reconsider the decision
to discard the changes made to P on the mainline.  The discarded
changes may not be important enough to make you want to resurrect
the change and side-port to another path, but at least you would
want to have a chance to double check and decide that the new
work the mainline did to P is still discardable.

So I am wondering what should be used as the record of "if the other
branch made this change, we have seen this conflict already, and we
know it is safe to resolve it to remove the path".  As such a
conflict will leave either stages 1 & 2 (we modified, while they
removed), or 1 & 3 (we removed, while they kept working on it), e.g.

    $ git ls-files -u
    100644 d1d63feaa9e299ace44d228176cd2b4335193569 1	t/helper/test-fast-rebase.c
    100644 cac20a72b3fcb52c5ccb66cbbb1679ecb8f39f97 2	t/helper/test-fast-rebase.c

one idea is to take a textual diff of these two stages:

    $ git diff :{1,2}:t/helper/test-fast-rebase.c
    diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
    index d1d63feaa9..cac20a72b3 100644
    --- a/t/helper/test-fast-rebase.c
    +++ b/t/helper/test-fast-rebase.c
    @@ -12,15 +12,16 @@

     #define USE_THE_INDEX_VARIABLE
     #include "test-tool.h"
    -#include "cache.h"
     #include "cache-tree.h"
     #include "commit.h"
     #include "environment.h"
     #include "gettext.h"
    +#include "hash.h"
     #include "hex.h"
     #include "lockfile.h"
     #include "merge-ort.h"
     #include "object-name.h"
    +#include "read-cache-ll.h"
     #include "refs.h"
     #include "revision.h"
     #include "sequencer.h"

and record that when we that one side made this change to a path
while the other side removed the path, we know it is safe to resolve
such a conflict to remove the path.

The "rerere conflict ID" (the directory name under .git/rerere/ that
each rerere database entry uses) is most likely the SHA-1 hash of the
above patch text, with pathname and line numbers redacted.

