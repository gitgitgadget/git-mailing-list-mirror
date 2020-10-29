Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB91C5DF9D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D44B207DE
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7m3Bq4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgJ2Msf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2Mse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 08:48:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57EC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h22so2307954wmb.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IqioK9mKrERhzdYImUSricuzyDfKoxn/rb4pHfYr3Nc=;
        b=M7m3Bq4kHjtchxDHHkmUuT3QHgHTVzsS/T6WflJbVI6gsJcN3hdPUkMRePM3BGre0j
         F5Q5WhYPRNj16dfm8qSTyG7XNwf00PcaULIvzZw9Po0NHIOgojRdr20EBRFwBclciLa2
         Ak5AL8xGzfDxj95Mca5gGJwUmZkdb+g9cJ9qVBwrPXFxNOnS1f5aR7u70TwHpN8iIXxO
         UJhC7wJscEKCYbAEe6YvlWvH1zW8R3cCy8mUZYUn01RctZdmvbEdLlh7NHLKYPqVxz3f
         w2GKff2vq2XHUhdp2tvo15/PXriW1A0SLHAptpDDDWerSqGwwkoYOmENjXepEq0S0Gha
         THBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IqioK9mKrERhzdYImUSricuzyDfKoxn/rb4pHfYr3Nc=;
        b=UihHE0EhIwPzC5zFg8XGgThAdJKW3kduRlMBVCCtskKnEeY2JU48NmCkCRbHByB0eh
         UFNsRsNT5OSr+AgQZMCwBWAO+qWMBFVL6ErNcngA1Pv/HqNL0rxqLBKa6gDgz/hPYDiN
         x0SxH3IVhsG4BzQaLwpeXfM9l382nLcIq2vaF0zSByhZZfkzxSwA8Cuw3bwGQECue7cL
         xmXOVQX+sY4tkmNYSa/WOmFr4XwXdzNi2pP2m/VMTO63SXhT2BBVBffSg8L6OGoyz6lG
         VbHWu6y/CAt69J0Ld9zXpTieQ9e40KF8nlJH89jJfoUEYUn5BCb+aLNWyX/k4FJ2eoZU
         lONw==
X-Gm-Message-State: AOAM532USAEr5et3dDHtvDjkYPD3Q2byoMlDZqDJQboRT/noSogqdRAT
        uNVmvXQCILWQnvI3XCBIw7X+kf2zbUU=
X-Google-Smtp-Source: ABdhPJyUkkTwmSAfz5ZlvPQxbLw0Sl4Ajn1iQShRATYMOqGK6Uq35vO7MW0nCJd97btNy9KEZ/592w==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4276433wmj.149.1603975710610;
        Thu, 29 Oct 2020 05:48:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm4832787wrh.70.2020.10.29.05.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:48:29 -0700 (PDT)
Message-Id: <pull.576.v5.git.1603975709.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
References: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 12:48:27 +0000
Subject: [PATCH v5 0/2] ref-filter: handle CRLF at end-of-line more gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4 :

 * tweaked the wording of both commit messages to not call the behaviour a
   bug
 * added || return 1 in one test - that had already been squashed in by
   Junio


----------------------------------------------------------------------------

The ref-filter code does not correctly handle commit or tag messages that
use CRLF as the line terminator. Such messages can be created with the
--cleanup=verbatim option of git commit and git tag, or by using git
commit-tree directly.

The function find_subpos in ref-filter.c looks for two consecutive '\n' to
find the end of the subject line, a sequence which is absent in messages
using CRLF. This results in the whole message being parsed as the subject
line (%(contents:subject)), and the body of the message (%(contents:body))
being empty.

Moreover, in copy_subject, '\n' is replaced by space, but '\r' is untouched.

This behaviour is a regression for git branch --verbose, which bisects down
to 949af06 (branch: use ref-filter printing APIs, 2017-01-10).

The first patch hardens the code in ref-filter.c to handle these messages
more gracefully and adds a test script to check that the ref-filter and
pretty APIs deal correctly with CRLF messages.

The second patch adds tests that check the behaviour of git log andgit show 
in the presence of CRLF in messages, to prevent futur regressions.

Cc: Michael J Gruber git@grubix.eu [git@grubix.eu], Matthieu Moy 
git@matthieu-moy.fr [git@matthieu-moy.fr], John Keeping john@keeping.me.uk
[john@keeping.me.uk], Karthik Nayak karthik.188@gmail.com
[karthik.188@gmail.com], Jeff King peff@peff.net [peff@peff.net], Alex
Henrie alexhenrie24@gmail.com [alexhenrie24@gmail.com]cc: Eric Sunshine 
sunshine@sunshineco.com [sunshine@sunshineco.com]cc: Junio C Hamano 
gitster@pobox.com [gitster@pobox.com]

Philippe Blain (2):
  ref-filter: handle CRLF at end-of-line more gracefully
  log, show: add tests for messages containing CRLF

 ref-filter.c             |  36 ++++++-----
 t/t3920-crlf-messages.sh | 126 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 14 deletions(-)
 create mode 100755 t/t3920-crlf-messages.sh


base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-576%2Fphil-blain%2Ffix-branch-verbose-crlf-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-576/phil-blain/fix-branch-verbose-crlf-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/576

Range-diff vs v4:

 1:  03b2d7d78a ! 1:  06231c315f ref-filter: handle CRLF at end-of-line more gracefully
     @@ Commit message
          This impacts the output of `git branch`, `git tag` and `git
          for-each-ref`.
      
     -    This bug is a regression for `git branch --verbose`, which
     +    This behaviour is a regression for `git branch --verbose`, which
          bisects down to 949af0684c (branch: use ref-filter printing APIs,
          2017-01-10).
      
     -    Fix this bug in ref-filter by hardening the logic in `copy_subject` and
     -    `find_subpos` to correctly parse messages containing CRLF.
     +    Adjust the ref-filter code to be more lenient by hardening the logic in
     +    `copy_subject` and `find_subpos` to correctly parse messages containing
     +    CRLF.
      
          Add a new test script, 't3920-crlf-messages.sh', to test the behaviour
          of commands using either the ref-filter or the pretty APIs with messages
 2:  75a87887be ! 2:  f536fee695 log, show: add tests for messages containing CRLF
     @@ Metadata
       ## Commit message ##
          log, show: add tests for messages containing CRLF
      
     -    A previous commit fixed a bug in ref-filter.c causing messages
     -    containing CRLF to be incorrectly parsed and displayed.
     +    A previous commit adjusted the code in ref-filter.c so that messages
     +    containing CRLF are now correctly parsed and displayed.
      
          Add tests to also check that `git log` and `git show` correctly handle
          such messages, to prevent futur regressions if these commands are
     @@ t/t3920-crlf-messages.sh: test_crlf_subject_body_and_contents tag --list tag-crl
      +		cut -d" " -f2- <tmp-branch >actual-branch &&
      +		cut -d" " -f2- <tmp-tag >actual-tag &&
      +		test_cmp expect actual-branch &&
     -+		test_cmp expect actual-tag
     ++		test_cmp expect actual-tag || return 1
      +	done
      +'
      +

-- 
gitgitgadget
