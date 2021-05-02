Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B05BC433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AA461353
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhEBFQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhEBFQX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:16:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F3C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:15:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j12so1561809ils.4
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QT3Lvt52+n0mR0qsA+RhrCOzKvdvNFvwD+al5aC/uE=;
        b=KAJ+X6FK68s1TsQNLeCDpgGvX7kxTsyzVPMXiqPDPyugvH8Lg2LsD7piCpuy9tQ0aI
         HFo4CaXTLEySQ4lqP+G1gWrAQgAXibnjY8/Orb+cJ3f4Dxf66IQnaYRJBT04hheSbcJL
         2irKAraTxoDMD/cS/iUsOXIWt7AzSMpVW1oCiUcMYyn2C9wG7tUHymKGgDmQy14HzHI0
         +f4H00ncsAjn68/I83Yx+iuLEzdRXQ6MMCxxIzN3Wx0UXtG/RMV8Qn1fbzXxY8SvlZzp
         JN3u5PPl3pTbAN+FbFASjc2RjxexrQL8IG6ZByo3Sqm4xHylMQvtz0PBwV4wdk30sUDu
         Fuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3QT3Lvt52+n0mR0qsA+RhrCOzKvdvNFvwD+al5aC/uE=;
        b=CM28pCLl/5cA3IUH7FUZWwuizmwtS5kmJw6+xBhaMLwAThlVAg4wmdPt5nWpX1sUb0
         LEuZ2eP00rPlBD0lYk3w0Kdc3P78NND2wmAkDGM2PFTurtkuHLQJ8duYYn6W8FKW0JOv
         +RtxnqOL/ZJIurI2KnCbu0TqfkHS4nYoLqYSPNjgvCuQG/TfbpdifiIL/uIf7bIJkLX4
         TQAikxSzFSGGSxUNxp6q879I2jDOwdh3m99HoIZCmAgE4Y/YT1sr+qoo0gRFooAsGl5u
         OrbK8lvh2PAgtUZ2w42jrDqy8bYNXWkju/EPlkFUQMSXmyK3Mp+qYyUOFgSEgV6mgGWf
         iYKQ==
X-Gm-Message-State: AOAM532oU/yMuvOUEvEc+883XOBLLEFJIwu82+XBSRSNG7BK+DVpdePq
        ovV3cHmcJMxYn9WmJsG8gGmjMd+ZkFwRtA==
X-Google-Smtp-Source: ABdhPJzv6Vymxo3rNk67tAwkRVIYHuAQ1Qj9+0PLQSPd1VndPKbfHQw8bdBjEIgQ/ETfoBx9v0JSfA==
X-Received: by 2002:a92:1a0f:: with SMTP id a15mr11347110ila.266.1619932531343;
        Sat, 01 May 2021 22:15:31 -0700 (PDT)
Received: from localhost.localdomain (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id e12sm2134049ilu.75.2021.05.01.22.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 22:15:30 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/2] normalize & fix merge "up to date" messages
Date:   Sun,  2 May 2021 01:14:21 -0400
Message-Id: <20210502051423.48123-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459
In-Reply-To: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of Josh Soref's v3[1] which fixes swapped components
of an "Already up to date" message emitted by builtin/merge. This
re-roll additionally normalizes punctuation of "Already up to date"
messages throughout the project.

I kept Josh as author of patch [2/2] but completely rewrote the commit
message to refocus it is a simple fix for a nearly 13 year old bug.

[1]: https://lore.kernel.org/git/pull.934.v3.git.1619052906768.gitgitgadget@gmail.com/

Eric Sunshine (1):
  merge(s): apply consistent punctuation to "up to date" messages

Josh Soref (1):
  merge: fix swapped "up to date" message components

 builtin/merge.c      | 14 +++++++++-----
 merge-ort-wrappers.c |  2 +-
 merge-recursive.c    |  2 +-
 notes-merge.c        |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  3f96947e3a merge(s): apply consistent punctuation to "up to date" messages
1:  8cd2b8c335 ! 2:  5885b18b7f git-merge: rewrite already up to date message
    @@ Metadata
     Author: Josh Soref <jsoref@gmail.com>
     
      ## Commit message ##
    -    git-merge: rewrite already up to date message
    +    merge: fix swapped "up to date" message components
     
    -    Usually, it is easier to read a message if it makes its primary
    -    point first, before giving a parenthetical note.
    +    The rewrite of git-merge from shell to C in 1c7b76be7d (Build in merge,
    +    2008-07-07) accidentally transformed the message:
     
    -    Possible messages before include:
    -    ` (nothing to squash)Already up to date.
    -    `
    -    and
    -    `Already up to date. Yeeah!
    -    `
    +        Already up-to-date. (nothing to squash)
     
    -    After:
    -    `Already up to date (nothing to squash).
    -    `
    -    and
    -    `Already up to date.
    -    `
    +    to:
     
    -    Localizations now have two easy to understand translatable strings.
    -    (All localizations of the previous strings are broken.)
    +        (nothing to squash)Already up-to-date.
    +
    +    due to reversed printf() arguments. This problem has gone unnoticed
    +    despite being touched over the years by 7f87aff22c (Teach/Fix pull/fetch
    +    -q/-v options, 2008-11-15) and bacec47845 (i18n: git-merge basic
    +    messages, 2011-02-22), and tangentially by bef4830e88 (i18n: merge: mark
    +    messages for translation, 2016-06-17) and 7560f547e6 (treewide: correct
    +    several "up-to-date" to "up to date", 2017-08-23).
    +
    +    Fix it by restoring the message to its intended order. While at it, help
    +    translators out by avoiding "sentence Lego".
    +
    +    [es: rewrote commit message]
     
         Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Josh Soref <jsoref@gmail.com>
    +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static void restore_state(const struct object_id *head,
    @@ builtin/merge.c: static void restore_state(const struct object_id *head,
     -		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
     +	if (verbosity >= 0) {
     +		if (squash)
    -+			puts(_("Already up to date (nothing to squash)."));
    ++			puts(_("Already up to date. (nothing to squash)"));
     +		else
     +			puts(_("Already up to date."));
     +	}
    @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      			}
      		}
      		if (up_to_date) {
    --			finish_up_to_date(_("Already up to date. Yeeah!"));
    +-			finish_up_to_date(_("Already up to date."));
     +			finish_up_to_date();
      			goto done;
      		}
-- 
2.31.1.607.g51e8a6a459

