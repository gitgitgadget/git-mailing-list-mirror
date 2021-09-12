Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56FAC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83B7610A3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhILARV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhILARU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6EC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s24so3872861wmh.4
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk22lbSYFNPqy77Rn3DhIJirWfBroEabSZATpdNZ7yc=;
        b=CaVKsv5Whwddlx0C8pQRsjDrRF81Fl1HI0ADWHr9N8h6RULjWniNfJy/LOfRq7yOvO
         AAwaEwsBAI17eNnE90iPsDKhmJbi09Ln4wiKfaQgxl4z70k413iYbJO46R8Ag5+QLbnF
         1yPPzfBG8/xGYJ4Lrun+sP+MpUkF2vgwjiAqBvctYGnqw2sTuUOFZi6zlTw/PTewInBG
         RAQzWIISpz9CaSdZLjvCQENxtViAzebVaAq02iYlcPyJ9j1REIc68wdIa+NCezpgJwPa
         FhpEmikxkpMsLayDyTgmFXdvSxWpqNA6Z++zd4PkNfn+8cKyimUzJ+ktS7CxMkZRo3UK
         Ho2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk22lbSYFNPqy77Rn3DhIJirWfBroEabSZATpdNZ7yc=;
        b=sjgz1MTZ9wLDVlupFutVDFajUFhmzRJfXTAfs7KqwW1j4b8lqSq3XPcG5Oc95oumGT
         cZgQtEl/XIMLKlJhQ4/pBCMU8J8UWAv/kN8pAzCLKvP4DgZkyiLwSWBp9jHQjlFWYuOO
         d24yNCPqLWfNMwf9alT1VwbOaW9IMAtSuqsqeVR/EJMrIAB0TQ8wf6ZS4azIr7gHD9e6
         wt4en6b2pRCp3/bbYwVu70L4VAqhYGqrFX3UCSHa+HLF/8YjzPzUYmZc6Jevoav2fsrR
         tHnimaD41ecVoUv9chFVqzmsTRth1EX6cRuyayshMvbF9Ier2t/98ybN9vHm86Yo8m/G
         K9vA==
X-Gm-Message-State: AOAM530Dfk1c2KBpJuFI3+lZxqOt7Ou6Hqozi6v0XI+ws6KuldvbjgTp
        jJ0CUz8VFCTN+0ZsUlG7Q+jSpgjU67HBLg==
X-Google-Smtp-Source: ABdhPJwP9HwnGXgc44BYi3Q7g7e2O+LDKRlDN5x21OK6Vu7QelKQFdfmkI/NcRFSAK2HHrHRv8U5Zw==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr4538810wma.57.1631405765164;
        Sat, 11 Sep 2021 17:16:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] strvec: use size_t to store nr and alloc
Date:   Sun, 12 Sep 2021 02:15:48 +0200
Message-Id: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a proposed v2 of Jeff King's one-patch change to change
strvec's nr/alloc from "int" to "size_t". As noted below I think it's
worthwhile to not only change that in the struct, but also in code
that directly references the "nr" member.

On Sat, Sep 11 2021, Philip Oakley wrote:

> On 11/09/2021 17:13, Ævar Arnfjörð Bjarmason wrote:
>> On Sat, Sep 11 2021, Jeff King wrote:
>>
>>> We converted argv_array (which later became strvec) to use size_t in
>>> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
>>> order to avoid the possibility of integer overflow. But later, commit
>>> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
>>> converted these back to ints!
>>>
>>> Those two commits were part of the same patch series. I'm pretty sure
>>> what happened is that they were originally written in the opposite order
>>> and then cleaned up and re-ordered during an interactive rebase. And
>>> when resolving the inevitable conflict, I mistakenly took the "rename"
>>> patch completely, accidentally dropping the type change.
>>>
>>> We can correct it now; better late than never.
>>>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>> This was posted previously in the midst of another thread, but I don't
>>> think was picked up. There was some positive reaction, but one "do we
>>> really need this?" to which I responded in detail:
>>>
>>>   https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
>>>
>>> I don't really think any of that needs to go into the commit message,
>>> but if that's a hold-up, I can try to summarize it (though I think
>>> referring to the commit which _already_ did this and was accidentally
>>> reverted would be sufficient).
>> Thanks, I have a WIP version of this outstanding starting with this
>> patch that I was planning to submit sometime, but I'm happy to have you
>> pursue it, especially with the ~100 outstanding patches I have in
>> master..seen.
>>
>> It does feel somewhere between iffy and a landmine waiting to be stepped
>> on to only convert the member itself, and not any of the corresponding
>> "int" variables that track it to "size_t".
>>
>> If you do the change I suggested in
>> https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/ you'll
>> find that there's at least one first-order reference to this that now
>> uses "int" that if converted to "size_t" will result in a wrap-around
>> error, we're lucky that one has a test failure.
>>
>> I can tell you what that bug is, but maybe it's better if you find it
>> yourself :) I.e. I found *that* one, but I'm not sure I found them
>> all. I just s/int nr/size_t *nr/ and eyeballed the wall off compiler
>> errors & the code context (note: pointer, obviously broken, but makes
>> the compiler yell).
>>
>> That particular bug will be caught by the compiler as it involves a >= 0
>> comparison against unsigned, but we may not not have that everywhere...
>
> I'm particularly interested in the int -> size_t change problem as part
> of the wider 4GB limitations for the LLP64 systems [0] such as the
> RaspPi, git-lfs (on windows [1]), and Git-for-Windows[2]. It is a big
> problem.

Okey, fine, no fun excercise for the reader then ;)

This is what I'd been sitting on locally since that recent thread, I
polished it up a bit since Jeff King posted his version.

The potential overflow bug I mentioned is in rebase.c. See
5/7. "Potential" because it's not a bug now, but that code
intentionally considers a strvec, and then iterates it from nr-1 to 0,
and if it reaches 0 intentionally counts down one more to -1 to
indicate that it's visited all elements.

We then check that with i >= 0, except of course if it becomes
unsigned that doesn't become -1, but rather it wraps around.

The rest of this is all changes to have that s/int/size_t/ radiate
outwards, i.e. when we assign that value to a variable somewhere its
now a "size_t" instead of an "int" etc.

> [0]
> http://nickdesaulniers.github.io/blog/2016/05/30/data-models-and-word-size/
> [1] https://github.com/git-lfs/git-lfs/issues/2434  Git on Windows
> client corrupts files > 4Gb
> [2] https://github.com/git-for-windows/git/pull/2179  [DRAFT] for
> testing : Fix 4Gb limit for large files on Git for Windows

Jeff King (1):
  strvec: use size_t to store nr and alloc

Ævar Arnfjörð Bjarmason (6):
  remote-curl: pass "struct strvec *" instead of int/char ** pair
  pack-objects: pass "struct strvec *" instead of int/char ** pair
  sequencer.[ch]: pass "struct strvec *" instead of int/char ** pair
  upload-pack.c: pass "struct strvec *" instead of int/char ** pair
  rebase: don't have loop over "struct strvec" depend on signed "nr"
  strvec API users: change some "int" tracking "nr" to "size_t"

 builtin/pack-objects.c |  6 +++---
 builtin/rebase.c       | 26 ++++++++++++--------------
 connect.c              |  8 ++++----
 fetch-pack.c           |  4 ++--
 ls-refs.c              |  2 +-
 remote-curl.c          | 23 +++++++++++------------
 sequencer.c            |  8 ++++----
 sequencer.h            |  4 ++--
 serve.c                |  2 +-
 shallow.c              |  5 +++--
 shallow.h              |  6 ++++--
 strvec.h               |  4 ++--
 submodule.c            |  2 +-
 upload-pack.c          |  7 +++----
 14 files changed, 53 insertions(+), 54 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  2ef48d734e8 remote-curl: pass "struct strvec *" instead of int/char ** pair
-:  ----------- > 2:  7f59a58ed97 pack-objects: pass "struct strvec *" instead of int/char ** pair
-:  ----------- > 3:  c35cfb9c9c5 sequencer.[ch]: pass "struct strvec *" instead of int/char ** pair
-:  ----------- > 4:  2e0b82d4316 upload-pack.c: pass "struct strvec *" instead of int/char ** pair
-:  ----------- > 5:  be85a0565ef rebase: don't have loop over "struct strvec" depend on signed "nr"
1:  498f5ed80dc ! 6:  ba17290852c strvec: use size_t to store nr and alloc
    @@ Commit message
         We can correct it now; better late than never.
     
         Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## strvec.h ##
     @@ strvec.h: extern const char *empty_strvec[];
-:  ----------- > 7:  2edd9708888 strvec API users: change some "int" tracking "nr" to "size_t"
-- 
2.33.0.998.ga4d44345d43

