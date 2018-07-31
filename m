Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0C81F597
	for <e@80x24.org>; Tue, 31 Jul 2018 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeGaJNE (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 05:13:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53943 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaJNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 05:13:04 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so2971926itw.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNhKBCLQ7o84Kgz4WJ6q6UGL+Eg7Wab2SzZhkLmYP2k=;
        b=J1NmcscMl3eNET7HuDnn/8yco7f8+gVfmtLTPJ5+HjDonmrpSm2jnlmZ/cwLlS7fTZ
         /PCkBRWLV8e9B2BkzRfN3WmnSDcaOx5ExfmjcHBYfF1RRok+xLYjTAOOGWoaxoHnvktO
         +K5iXuA0vj9UCKyJm1l8kZABAZxWXyXrmQ0478/mxvH1R56foiZCD/QQ+e2Xk53y/82A
         YHMp4y0dg4Ua0oOPDhvBF9tIske5gmlHTOFsUyJ4SpFwM/JIBGeQj1SmGSJ4ohA1xp0j
         D9W0c2cI43xWGlQbCn/AeBg3W+hlrydT2Nl6q/nB25F4+3W39dFcGmcQMrzIShM3LkRD
         4F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jNhKBCLQ7o84Kgz4WJ6q6UGL+Eg7Wab2SzZhkLmYP2k=;
        b=B7Yxaxzs31/LQLwGvXAJ5M2WxaZ9bryThuNT/FWZT1ANXltixdSd7gJhE0ECmal4bX
         TmGtbcvwAjZS3Bv99tIRet5tVa8X+eCXKR3LnoOHuu44L1mSOUR10gkDVODBdLfRL0AV
         ob0z/jxscXVN+2fGy9pTjYAfhAz1YRo00939oA9eM41TwGTNb33KDCZLGReEB/6AORhK
         VaYuEB6vxbjDo2IcL7xfTJ/KLccCP0C6EkC3nXnkDW4boXM1EY5AR3Pans4Q2BOZLlLt
         j10PgGyOIiqYIfdPdMDQwcVthq6DqKSw7kFIPInCadzdsfEXB8C2L29y/iJY+iiB9+DD
         6QLQ==
X-Gm-Message-State: AOUpUlFigCzcTMW/TCyTqeJEcH40ZMa1EraGt4Qzl3AGTWa+FlS86jWp
        gJNl/uSxHTNrFUbUjsTUJ5HCJYOw
X-Google-Smtp-Source: AAOMgpcC+GbEjuQt2qrtAroHv4WTSpKx9gH+TBwACiTAYmk0aHegdoilzeU9bJqc+pV1vSfYt3J8Mw==
X-Received: by 2002:a24:57cc:: with SMTP id u195-v6mr2009755ita.142.1533022444876;
        Tue, 31 Jul 2018 00:34:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m1-v6sm2371058iok.81.2018.07.31.00.34.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 00:34:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
Date:   Tue, 31 Jul 2018 03:33:27 -0400
Message-Id: <20180731073331.40007-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which fixes sequencer bugs resulting in commit
object corruption when "rebase -i --root" swaps in a new commit as root.
Unfortunately, those bugs made it into v2.18.0 and have already
corrupted at least one repository (a local project of mine). Patches 3/4
and 4/4 are new.

v1 fixed these bugs:

* trailing garbage on the commit's "author" header

* extra trailing digit on "author" header's timezone (caused by two
  separate bugs)

v2 fixes those same bugs, plus:

* eliminates a bogus "@" prepended to the "author" header timestamp
  which renders the header corrupt

* takes care to validate information coming from
  "rebase-merge/author-script" before incorporating it into the "author"
  header since that file may be hand-edited, and bogus hand-edited
  values could corrupt the commit object.

Patch 2/4 of this series conflicts with Akinori MUSHA's
'am/sequencer-author-script-fix' which takes a stab at fixing one of the
four (or so) bugs fixed by this series (namely, adding a missing closing
quote to GIT_AUTHOR_DATE in "rebase-merge/author-script"). That patch
probably ought to be dropped (without prejudice) in favor of this series
for the following reasons:

* It has the undesirable property of adding an unwanted extra blank line
  to "rebase-merge/author-script"; this series doesn't make that
  mistake.

* The fix in this series (patch 2/4) is more complete, also ensuring
  that the return value of sq_dequote() is checked.

* And, most importantly, this series sells the change as a fix for a
  genuine serious bug (commit object corruption), whereas that patch
  talks only about adjusting the file content to make it parseable by
  the shell. It's important for future readers of this change to
  understand that the bug (missing closing quote) had much more dire
  consequences than merely being syntactically invalid as a shell
  script.

The test added by Akinori MUSHA's patch may still have value, and it may
make sense to re-submit it, however, doing so need not hold up this
(higher priority) series.

Phillip's proposed[2] unification of parsers and other fixes and
cleanups can easily be built atop this series and, likewise, need not
prevent these (higher priority) patches from graduating independently.

[1]: https://public-inbox.org/git/20180730092929.71114-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/1f172fc1-4b51-cdf7-e841-5ca41e209be4@talktalk.net/

Eric Sunshine (4):
  sequencer: fix "rebase -i --root" corrupting author header
  sequencer: fix "rebase -i --root" corrupting author header timezone
  sequencer: fix "rebase -i --root" corrupting author header timestamp
  sequencer: don't die() on bogus user-edited timestamp

 sequencer.c                   | 39 +++++++++++++++++++++--------------
 t/t3404-rebase-interactive.sh | 10 ++++++++-
 2 files changed, 33 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  ba10ae4e5d ! 1:  8c47555bcf sequencer: fix "rebase -i --root" corrupting author header
    @@ -11,8 +11,8 @@
         This is a result of read_author_ident() neglecting to NUL-terminate the
         buffer into which it composes the "author" header.
     
    -    (Note that the extra "0" in the timezone is a separate bug which will be
    -    fixed subsequently.)
    +    (Note that the "@" preceding the timestamp and the extra "0" in the
    +    timezone are separate bugs which will be fixed subsequently.)
     
         Security considerations: Construction of the "author" header by
         read_author_ident() happens in-place and in parallel with parsing the
    @@ -26,6 +26,7 @@
         inserted as part of the parsing process.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     
     diff --git a/sequencer.c b/sequencer.c
     --- a/sequencer.c
    @@ -61,7 +62,7 @@
     +	set_fake_editor &&
     +	FAKE_LINES="2 1" git rebase -i --root &&
     +	git cat-file commit HEAD^ >out &&
    -+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
    ++	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
     +'
     +
      test_done
2:  c0400cda85 ! 2:  1d4064147e sequencer: fix "rebase -i --root" corrupting author header timezone
    @@ -22,6 +22,9 @@
         a NUL-terminator at the end of the shifted content, which explains the
         duplicated last digit in the timezone.
     
    +    (Note that the "@" preceding the timestamp is a separate bug which
    +    will be fixed subsequently.)
    +
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
     diff --git a/sequencer.c b/sequencer.c
    @@ -56,8 +59,8 @@
      	set_fake_editor &&
      	FAKE_LINES="2 1" git rebase -i --root &&
      	git cat-file commit HEAD^ >out &&
    --	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
    -+	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
    +-	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9]*$" out
    ++	grep "^author ..*> @[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
      '
      
      test_done
-:  ---------- > 3:  cb65c7dd98 sequencer: fix "rebase -i --root" corrupting author header timestamp
-:  ---------- > 4:  3a624da9f4 sequencer: don't die() on bogus user-edited timestamp
-- 
2.18.0.267.gbc8be36ecb

