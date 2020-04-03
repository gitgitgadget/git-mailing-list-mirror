Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFACC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927532073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxLOboZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390315AbgDCK2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:34 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54991 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCK2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:34 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so2808048pjb.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kX1/J7feQJCQERbOT/3IVE2i2KpE/4FhNznhaJYgNzo=;
        b=fxLOboZGns0I+xByvBTPTCvIcwp1vVEpSZTgPVfovAcXeZNiJKMNqnwfA3nze2hmrh
         keo4Xtk9cDQK9cIJh2pMURdrCr7pKuu29djYCT1xd4PvTT9DeZd3sz26Aa6K5s027S9p
         FjMr2jK6cEvm07WDcMf2XFPgSH3P8VGNfGs6atQ62PR3Ph2QgqujBKdnCDn38NHQzlOn
         uHB+5ZnNjiAM7Xmr3EVm/Ks87gtiOq0P83P1JXj0xtsHW3fjSt/CTF+PDApXqm5kkFnI
         7qhTsK+XSYVv0jVnzBdYm+HnbbXtNRnONzvQMnSXuSnCSsYaueC3EsOd991lHHuk6qmY
         6PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX1/J7feQJCQERbOT/3IVE2i2KpE/4FhNznhaJYgNzo=;
        b=PsmlBrvcYVvV9G+izI3YPm7RMnbLaO4ekrw14i/rJs+5RjpQT+cr8jS7wDNO6O8OEM
         cQSd70hJZixh1xM1ZMKo50j6yF+qplzwEsp3WlfLa+QjwcnWM9wmlkDbgtyw6/AxmS/h
         hU0wnD4PkYwX3ufZ3ztAyyJ4IIQab/w+AwWfKXVlxHO3LV93EHmmgCI7pv5fah93aoiy
         cl71SBQ9ZqGEcosG8gXh9KFytdNJOgSgCkNqEW7nIUCb4PJ8QdGmueFn9m2hJf3LoFXS
         bAR0atYrcmGz885d7+XS4awTXin3h+YS2jM2L5cy25+rumkK1+078RLj/sutwF89drI2
         ZD4A==
X-Gm-Message-State: AGi0PuY5nYdwn3DlUJ57uergAOqlE/ZvZfCBDu33YYmjL0rUkKu8A9nl
        /S3VDwmDPIT/pSXe0TzCWQUmjT19
X-Google-Smtp-Source: APiQypIZV5vpKGByI7UAndfPW+c86SGG29bLs+8LEk4U9xEXW1HItfpgdqprkFLeT+ZVWb1b5SsjKg==
X-Received: by 2002:a17:90a:1a03:: with SMTP id 3mr9065973pjk.136.1585909712561;
        Fri, 03 Apr 2020 03:28:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:32 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Dominic Chen <d.c.ddcc@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 0/6] Honour and Document --no-gpg-sign
Date:   Fri,  3 Apr 2020 17:28:01 +0700
Message-Id: <cover.1585909453.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <20200331064456.GA15850@danh.dev>
References: <20200331064456.GA15850@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand `git commit` supports a `--no-gpg-sign` argument, which is
useful incases where e.g. a GPG key is specified in `.gitconfig`,
but is located on a hardware key that may not currently be attached to
the system.

Multiple commands that understand --gpg-sign but haven't understand
--no-gpg-sign, yet.

Also, document more commands that honours --no-gpg-sign

Change in v3 since v2:
- Use `backticks` instead of "dquote" for options
- Add missing "--no-gpg-sign::"
- Merge git-commit-tree --[no-]gpg-sign"

Change in v2 since v1:
- FREE_AND_NULL as soon as possible
- update test code for rebase --no-gpg-sign
- revert (--edit which is default in tty) now honours --no-gpg-sign
- cherry-pick --edit now honours --no-gpg-sign
- add more documentation

Đoàn Trần Công Danh (6):
  rebase.c: honour --no-gpg-sign
  cherry-pick/revert: honour --no-gpg-sign in all case
  Documentation: document am --no-gpg-sign
  Documentation: reword commit --no-gpg-sign
  Documentation: merge commit-tree --[no-]gpg-sign
  Documentation: document merge option --no-gpg-sign

 Documentation/git-am.txt          |  5 +-
 Documentation/git-cherry-pick.txt |  5 +-
 Documentation/git-commit-tree.txt |  8 ++-
 Documentation/git-commit.txt      |  9 ++--
 Documentation/git-rebase.txt      |  5 +-
 Documentation/git-revert.txt      |  5 +-
 Documentation/merge-options.txt   |  5 +-
 builtin/rebase.c                  |  7 +--
 sequencer.c                       |  2 +
 t/t3435-rebase-gpg-sign.sh        | 71 +++++++++++++++++++++++++
 t/t3514-cherry-pick-revert-gpg.sh | 86 +++++++++++++++++++++++++++++++
 11 files changed, 190 insertions(+), 18 deletions(-)
 create mode 100755 t/t3435-rebase-gpg-sign.sh
 create mode 100755 t/t3514-cherry-pick-revert-gpg.sh

Range-diff against v2:
1:  b886c69e92 ! 1:  b601c99f7b rebase.c: honour --no-gpg-sign
    @@ Metadata
      ## Commit message ##
         rebase.c: honour --no-gpg-sign
     
    -    Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
    -
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      	GPG-sign commits. The `keyid` argument is optional and
      	defaults to the committer identity; if specified, it must be
     -	stuck to the option without a space.
    -+	stuck to the option without a space. "--no-gpg-sign" is useful to
    ++	stuck to the option without a space. `--no-gpg-sign` is useful to
     +	countermand both `commit.gpgSign` configuration variable, and
    -+	earlier "--gpg-sign".
    ++	earlier `--gpg-sign`.
      
      -q::
      --quiet::
2:  e1b6d7866d ! 2:  28ebbfe72a cherry-pick/revert: honour --no-gpg-sign in all case
    @@ Documentation/git-cherry-pick.txt: effect to your index in a row.
      	GPG-sign commits. The `keyid` argument is optional and
      	defaults to the committer identity; if specified, it must be
     -	stuck to the option without a space.
    -+	stuck to the option without a space. "--no-gpg-sign" is useful to
    ++	stuck to the option without a space. `--no-gpg-sign` is useful to
     +	countermand both `commit.gpgSign` configuration variable, and
    -+	earlier "--gpg-sign".
    ++	earlier `--gpg-sign`.
      
      --ff::
      	If the current HEAD is the same as the parent of the
    @@ Documentation/git-revert.txt: effect to your index in a row.
      	GPG-sign commits. The `keyid` argument is optional and
      	defaults to the committer identity; if specified, it must be
     -	stuck to the option without a space.
    -+	stuck to the option without a space. "--no-gpg-sign" is useful to
    ++	stuck to the option without a space. `--no-gpg-sign` is useful to
     +	countermand both `commit.gpgSign` configuration variable, and
    -+	earlier "--gpg-sign".
    ++	earlier `--gpg-sign`.
      
      -s::
      --signoff::
3:  9cc14b52e4 < -:  ---------- Documentation: document am --no-gpg-sign
4:  801750016e < -:  ---------- Documentation: reword commit --no-gpg-sign
-:  ---------- > 3:  340374fb68 Documentation: document am --no-gpg-sign
-:  ---------- > 4:  1b952f7348 Documentation: reword commit --no-gpg-sign
-:  ---------- > 5:  685832b069 Documentation: merge commit-tree --[no-]gpg-sign
5:  857178defd ! 6:  b1a3d42355 Documentation: document merge option --no-gpg-sign
    @@ Documentation/merge-options.txt: When not possible, refuse to merge and exit wit
      	GPG-sign the resulting merge commit. The `keyid` argument is
      	optional and defaults to the committer identity; if specified,
     -	it must be stuck to the option without a space.
    -+	it must be stuck to the option without a space. "--no-gpg-sign"
    ++	it must be stuck to the option without a space. `--no-gpg-sign`
     +	is useful to countermand both `commit.gpgSign` configuration variable,
    -+	and earlier "--gpg-sign".
    ++	and earlier `--gpg-sign`.
      
      --log[=<n>]::
      --no-log::
-- 
2.26.0.334.g6536db25bb

