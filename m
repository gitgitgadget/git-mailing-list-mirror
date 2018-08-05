Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C35B1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHET0E (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43686 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeHET0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so10111860wrv.10
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ztCix584BWtncLZSC7Brde6FHvnvhUYGlSv/ye7bmU=;
        b=XZRI07jDJ4w+EBLZS+xHt3Ao1XC2gHo6g69opwlD0zCpSpNWkgLHlDwZo9ib5oVBHK
         nasjbQDANPjeymwCBLNOMOEuAnv7AkrOjhcJnfNP+iEPUsHGObMJf9rjm+ItMxpsR4OF
         dp5u/0CuA054FmsilFPtNAvXwtWZK6ht+kX2/fWx3k2g7nEa44wniRFwh+dfQr/DDEFw
         peoe3gegx020TPdLmjLujFTmGQZ3ljE+dA2+mS+wQHwHYRQvaVm363HWPSZJMn+KKdLt
         EN9IrV/fG6A1fPpK6QW3SnsUDhGhzq9Emu7xnTD1XWQ418Rz/rhzywu9LBxRCSVeiKzQ
         SWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ztCix584BWtncLZSC7Brde6FHvnvhUYGlSv/ye7bmU=;
        b=MtQjj6TjdYSIP2h+m6c9D2WJuYVQcWyblGxF4nG7tDLCXmdWBL0SkhJEscDz0nUiRf
         TtySGGFUFKCX/qAUYFDL/f7NKTqInqkr5o1LTQH6pI5x5LZYrC2JTHtZ3uOxyaRMzPuz
         zj2b4MwFNtshR24/RxRkQSpTAURt9vUHxpf0SLqlDy+JtZEgdVCHyIlCvd9cpouof0ul
         /ERexFwg4wLUyNonokp6D9I6lTPaqzBM4bMLmBceFZk4SQTZ1tAK0T6lFKPeM6aZZCSI
         HJdPr+2siRSyaVfl4ErAjCWvN9/LdaRYZTXqqH8aNGmAnCkrA0ZKV2zM0FWIsej8Zeii
         x6VQ==
X-Gm-Message-State: AOUpUlGckZOTRbglnNRAesNxUKXG6Y6NitWh1FayCx/8Q/9utvy5Je26
        yl7tyHLetXV+U54+KjQAgCJbkpI2
X-Google-Smtp-Source: AAOMgpeE2qeulHuJBkLeeCPEInbuIzUkVPU7bKcH9y6PYRceQJ7qlxVzDG1I/mtkxmFBcj2R1U1EpQ==
X-Received: by 2002:a5d:458b:: with SMTP id p11-v6mr7550061wrq.122.1533489644958;
        Sun, 05 Aug 2018 10:20:44 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id c12-v6sm8552777wrr.6.2018.08.05.10.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:43 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 00/11] rerere: handle nested conflicts
Date:   Sun,  5 Aug 2018 18:20:26 +0100
Message-Id: <20180805172037.12530-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds were at
<20180520211210.1248-1-t.gummerer@gmail.com>,
<20180605215219.28783-1-t.gummerer@gmail.com> and
<20180714214443.7184-1-t.gummerer@gmail.com>.

Thanks Junio for the review and Simon for pointing out an error in my
commit message.

The changes in this round are mainly improving the commit messages,
and polishing the documentation.

It also simplifies one test case in patch 6/11.

Patches 10 and 11 are still included, however I'm not going to be too
sad if we decide to not include them, as they really only help in an
obscure case, which could be considered using git "wrong".

I also realized that while I wrote "no functional changes intended" in
7/11, and functional changes were in fact not intended, there still is
a slight functional change.  As I think that's a good change, I
documented it in the commit message.

Thomas Gummerer (11):
  rerere: unify error messages when read_cache fails
  rerere: lowercase error messages
  rerere: wrap paths in output in sq
  rerere: mark strings for translation
  rerere: add documentation for conflict normalization
  rerere: fix crash with files rerere can't handle
  rerere: only return whether a path has conflicts or not
  rerere: factor out handle_conflict function
  rerere: return strbuf from handle path
  rerere: teach rerere to handle nested conflicts
  rerere: recalculate conflict ID when unresolved conflict is committed

 Documentation/technical/rerere.txt | 182 +++++++++++++++++++++
 builtin/rerere.c                   |   4 +-
 rerere.c                           | 243 ++++++++++++++---------------
 t/t4200-rerere.sh                  |  65 ++++++++
 4 files changed, 365 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

Range diff below:

 1:  ce876f1b6b =  1:  018bd68a8a rerere: unify error messages when read_cache fails
 2:  0326503c4a =  2:  281fcbf24f rerere: lowercase error messages
 3:  a33211e3d3 =  3:  b6d5e2e26d rerere: wrap paths in output in sq
 4:  3da84604f0 !  4:  6ed390c8f5 rerere: mark strings for translation
    @@ -2,7 +2,7 @@
     
         rerere: mark strings for translation
     
    -    'git rerere' is considered a plumbing command and as such its output
    +    'git rerere' is considered a porcelain command and as such its output
         should be translated.  Its functionality is also only enabled through
         a config setting, so scripts really shouldn't rely on the output
         either way.
 5:  749d49a625 !  5:  3cef1d57bc rerere: add documentation for conflict normalization
    @@ -28,8 +28,8 @@
     +conflicts before writing them to the rerere database.
     +
     +Different conflict styles and branch names are normalized by stripping
    -+the labels from the conflict markers, and removing extraneous
    -+information from the `diff3` conflict style. Branches that are merged
    ++the labels from the conflict markers, and removing the common ancestor
    ++version from the `diff3` conflict style. Branches that are merged
     +in different order are normalized by sorting the conflict hunks.  More
     +on each of those steps in the following sections.
     +
    @@ -37,8 +37,8 @@
     +calculated based on the normalized conflict, which is later used by
     +rerere to look up the conflict in the rerere database.
     +
    -+Stripping extraneous information
    -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ++Removing the common ancestor version
    ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     +
     +Say we have three branches AB, AC and AC2.  The common ancestor of
     +these branches has a file with a line containing the string "A" (for
    @@ -79,7 +79,7 @@
     +
     +By extension, this means that rerere should recognize that the above
     +conflicts are the same.  To do this, the labels on the conflict
    -+markers are stripped, and the diff3 output is removed.  The above
    ++markers are stripped, and the common ancestor version is removed.  The above
     +examples would both result in the following normalized conflict:
     +
     +    <<<<<<<
 6:  d465bd087e !  6:  a02d90157d rerere: fix crash when conflict goes unresolved
    @@ -1,37 +1,42 @@
     Author: Thomas Gummerer <t.gummerer@gmail.com>
     
    -    rerere: fix crash when conflict goes unresolved
    +    rerere: fix crash with files rerere can't handle
     
    -    Currently when a user doesn't resolve a conflict in a file, but
    -    commits the file with the conflict markers, and later the file ends up
    -    in a state in which rerere can't handle it, subsequent rerere
    -    operations that are interested in that path, such as 'rerere clear' or
    -    'rerere forget <path>' will fail, or even worse in the case of 'rerere
    -    clear' segfault.
    +    Currently when a user does a conflict resolution and ends it (in any
    +    way that calls 'git rerere' again) with a file 'rerere' can't handle,
    +    subsequent rerere operations that are interested in that path, such as
    +    'rerere clear' or 'rerere forget <path>' will fail, or even worse in
    +    the case of 'rerere clear' segfault.
     
    -    Such states include nested conflicts, or an extra conflict marker that
    +    Such states include nested conflicts, or a conflict marker that
         doesn't have any match.
     
    -    This is because the first 'git rerere' when there was only one
    -    conflict in the file leaves an entry in the MERGE_RR file behind.  The
    -    next 'git rerere' will then pick the rerere ID for that file up, and
    -    not assign a new ID as it can't successfully calculate one.  It will
    -    however still try to do the rerere operation, because of the existing
    -    ID.  As the handle_file function fails, it will remove the 'preimage'
    -    for the ID in the process, while leaving the ID in the MERGE_RR file.
    +    This is because 'git rerere' calculates a conflict file and writes it
    +    to the MERGE_RR file.  When the user then changes the file in any way
    +    rerere can't handle, and then calls 'git rerere' on it again to record
    +    the conflict resolution, the handle_file function fails, and removes
    +    the 'preimage' file in the rr-cache in the process, while leaving the
    +    ID in the MERGE_RR file.
     
    -    Now when 'rerere clear' for example is run, it will segfault in
    -    'has_rerere_resolution', because status is NULL.
    +    Now when 'rerere clear' is run, it reads the ID from the MERGE_RR
    +    file, however the 'fit_variant' function for the ID is never called as
    +    the 'preimage' file does not exist anymore.  This means
    +    'collection->status' in 'has_rerere_resolution' is NULL, and the
    +    command will crash.
     
         To fix this, remove the rerere ID from the MERGE_RR file in the case
    -    when we can't handle it, and remove the corresponding variant from
    -    .git/rr-cache/.  Removing it unconditionally is fine here, because if
    -    the user would have resolved the conflict and ran rerere, the entry
    -    would no longer be in the MERGE_RR file, so we wouldn't have this
    -    problem in the first place, while if the conflict was not resolved,
    -    the only thing that's left in the folder is the 'preimage', which by
    -    itself will be regenerated by git if necessary, so the user won't
    -    loose any work.
    +    when we can't handle it, just after the 'preimage' file was removed
    +    and remove the corresponding variant from .git/rr-cache/.  Removing it
    +    unconditionally is fine here, because if the user would have resolved
    +    the conflict and ran rerere, the entry would no longer be in the
    +    MERGE_RR file, so we wouldn't have this problem in the first place,
    +    while if the conflict was not resolved.
    +
    +    Currently there is nothing left in this folder, as the 'preimage'
    +    was already deleted by the 'handle_file' function, so 'remove_variant'
    +    is a no-op.  Still call the function, to make sure we clean everything
    +    up, in case we add some other files corresponding to a variant in the
    +    future.
     
         Note that other variants that have the same conflict ID will not be
         touched.
    @@ -90,8 +95,7 @@
     +	git commit -q -a -m one &&
     +
     +	test_must_fail git merge branch-1 &&
    -+	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
    -+	mv test.tmp test &&
    ++	echo "<<<<<<< a" >test &&
     +	git rerere &&
     +
     +	git rerere clear
 7:  fac2b79245 =  7:  49815bee02 rerere: only return whether a path has conflicts or not
 8:  b5892c1861 !  8:  0c51696d10 rerere: factor out handle_conflict function
    @@ -4,7 +4,13 @@
     
         Factor out the handle_conflict function, which handles a single
         conflict in a path.  This is in preparation for a subsequent commit,
    -    where this function will be re-used.  No functional changes intended.
    +    where this function will be re-used.
    +
    +    Note that this does change the behaviour of 'git rerere' slightly.
    +    Where previously we'd consider all files where an unmatched conflict
    +    marker is found as invalid, we now only consider files invalid when
    +    the "ours" conflict marker ("<<<<<<< <text>") is unmatched, not when
    +    other conflict markers (e.g. "=======") is unmatched.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
 9:  e8e0ca4db9 =  9:  f604efe05d rerere: return strbuf from handle path
10:  1fc106ffaa ! 10:  a2393d3424 rerere: teach rerere to handle nested conflicts
    @@ -6,6 +6,10 @@
         it encounters such conflicts.  Do that by recursively calling the
         'handle_conflict' function to normalize the conflict.
     
    +    Note that a conflict like this would only be produced if a user
    +    commits a file with conflict markers, and gets a conflict including
    +    that in a susbsequent operation.
    +
         The conflict ID calculation here deserves some explanation:
     
         As we are using the same handle_conflict function, the nested conflict
    @@ -66,8 +70,8 @@
     +
     +Nested conflicts are handled very similarly to "simple" conflicts.
     +Similar to simple conflicts, the conflict is first normalized by
    -+stripping the labels from conflict markers, stripping the diff3
    -+output, and the sorting the conflict hunks, both for the outer and the
    ++stripping the labels from conflict markers, stripping the common ancestor
    ++version, and the sorting the conflict hunks, both for the outer and the
     +inner conflict.  This is done recursively, so any number of nested
     +conflicts can be handled.
     +
11:  4463aed2f8 = 11:  371af30766 rerere: recalculate conflict ID when unresolved conflict is committed

-- 
2.18.0.720.gf7a957e2e7
