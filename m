Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C85C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE163206B7
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHYpODgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfLPOC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:02:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPOCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so7390572wru.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NZB4S2mSwe2xBw+sVtXH6+5aj8jDr35k4sU89BXUnG4=;
        b=uHYpODgEDiJdgwlwE+TMlj/itOdkuLNz1KbQUF9UokwcurcDyRbqgIKBycv2zvmmHm
         bx3gUwOlL3Dkz1bzvlf0TRNk3zR+YVxGxS5oNqBQ6U3UQzHRzYLzXuv/Co7LZP4YpGob
         1vAyWw6NaOM0iPlHy3Tx6R+kv7bwoGF9QgwHYm6hoitX58AQy0Ibz5+vlqoyjLgWj10s
         nSzGGC6QtEqkF2Ig093QBI1Fa3x182YR3eImoAiXD9RRreSuQ/EH8srpSPMm7+68rS5l
         kmSDosiLpA1qhNoflFhRkRSN28UiyHIWtQ8eB4jZQZVTSzgL6QD03yyZAAxn8pqByY0c
         sSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NZB4S2mSwe2xBw+sVtXH6+5aj8jDr35k4sU89BXUnG4=;
        b=PdsuCCDpZpc73VazweHsJCV10oKJNczwDMlGvWqwtuKCAEWbX3aPqhyuo1jF8hU/1C
         uh/1/qhjBs2AR+59YBCplokLrkvfOscTnFXzuF31UEle3Vk4XkxtYrLwrUOxxvByIZt0
         Dta1bITENhiOnAXgq8QUp12B7AZrJPByCv4CH63i/cmXcD3YMzJp1NpSThKp7jgzHwvF
         VQhwP1jKzqPMEPt9P0xhWvbaVDJkuhQZaOg00Pyh7KJbUc1HLNgag9apZc77SJvqs/tx
         eBm0pgCZkDuYY4eBZPrF5yKcSBm3G4dAlGFzSqQQw8/f0LHC2gllx9OeQcF6PwfAWpaQ
         P15A==
X-Gm-Message-State: APjAAAU4+Kxn/LbVpmcmI9G0d4zUyko5hDOPA4yEnbiqhyBFBWp4SAKh
        3vFuvxZCKtyvTaymyvoYipU/4Wn2
X-Google-Smtp-Source: APXvYqwjCeumYW/H+p0D1ckc3pYKKWFmrSkTIGZyW2i/gBtcw3zPMG12pyIKQWrnHjLa6t2XUqsSug==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr32786563wrr.27.1576504943410;
        Mon, 16 Dec 2019 06:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm20570842wmh.25.2019.12.16.06.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:02:22 -0800 (PST)
Message-Id: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 14:02:18 +0000
Subject: [PATCH v5 0/4] git-p4: Usability enhancements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some user interaction with git-p4 is not as user-friendly as the rest of the
Git ecosystem. 

Here are three areas that can be improved on:

1) When a patch fails and the user is prompted, there is no sanitization of
the user input so for a "yes/no" question, if the user enters "YES" instead
of a lowercase "y", they will be re-prompted to enter their answer. 

Commit 1 addresses this by sanitizing the user text by trimming and
lowercasing their input before testing. Now "YES" will succeed!

2) If the command line arguments are incorrect for git-p4, the program
reports that there was a syntax error, but doesn't show what the correct
syntax is.

Commit 2 displays the context help for the failed command.

3) If Git generates an error while attempting to clean up the RCS Keyword
expansions, it currently leaves P4 in an invalid state. Files that were
checked out by P4 are not revereted.

Commit 3 adds and exception handler that catches this condition and issues a
P4 Revert for the files that were previously edited.

4) Git can handle scraping the RCS Keyword expansions out of source files
when it is preparing to submit them to P4. However, if the config value
"git-p4.attemptRCSCleanup" isn't set, it will just report that it fails.

Commit 4 adds a helpful suggestion, that the user might want to set
git-p4.attemptRCSCleanup.

Revisions
=========

v3 - Implemented the various suggestions from Luke and Denton.

I did not add additional exception handling for the EOFError in the prompt
method. I do believe that it is a good idea, but that would change the logic
handling of the existing code to handle this new "no answer" condition and I
didn't want to introduce that at this time.

v4 - Whitespace clean up and commit clarifications.

Submit 3 suggested some clarifications to the commit test and revealed some
whitespace errors.

v5 - Fixed typo in a commit message. (Invalid attribute to Thanks-to: Denton
Liu liu.denton@gmail.com [liu.denton@gmail.com])

Ben Keene (4):
  git-p4: yes/no prompts should sanitize user text
  git-p4: show detailed help when parsing options fail
  git-p4: wrap patchRCSKeywords test to revert changes on failure
  git-p4: failure because of RCS keywords should show help

 git-p4.py | 93 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 34 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-675%2Fseraphire%2Fseraphire%2Fp4-usability-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-675/seraphire/seraphire/p4-usability-v5
Pull-Request: https://github.com/git/git/pull/675

Range-diff vs v4:

 1:  6c23cd5684 ! 1:  7e0145fa32 git-p4: yes/no prompts should sanitize user text
     @@ -26,7 +26,7 @@
          choices, remove the loop from the calling code that handles response
          verification.
      
     -    Thanks-to: Denton Liu <Denton Liu>
     +    Thanks-to: Denton Liu <liu.denton@gmail.com>
          Signed-off-by: Ben Keene <seraphire@gmail.com>
      
       diff --git a/git-p4.py b/git-p4.py
 2:  bfdd3dc517 = 2:  4960d1fa22 git-p4: show detailed help when parsing options fail
 3:  20f6398693 = 3:  81a09a1228 git-p4: wrap patchRCSKeywords test to revert changes on failure
 4:  c78e2e4db1 = 4:  4c4b783fd5 git-p4: failure because of RCS keywords should show help

-- 
gitgitgadget
