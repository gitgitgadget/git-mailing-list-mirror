Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC141F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfIYUVI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:21:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIYUVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:21:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so8385209wrw.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4frS2VFIjyyQqgkr4HKDJHBhSW3ymupXzFbpuOfWGr4=;
        b=Su5PMsCxCCe0OpM7b8ORbzHDiT8XXikj2E94r9tVFZlfhnhXHu0pQ4E78WXH2P537p
         M/hhocp18JP90vCHX9ymlDz5DvY7WO8jCMrjKmaFwUXg+KKU3pB8XmDxsVoIadWynRNg
         2qke5v9nRijx36pKwlp5ugz0Kt8UIxYtoKLSqFV0qK7MqBb6bhVWb2JI2MLIuhP2kVV2
         rsKMNMmvd4H3GGyTUbV80N49Yokivcm6FJg/eC2VrfW0OYJySDdpbthLwd2hwu754rh1
         vHUpMwwFfdPl5CsgGJyW5p0Z5ymOGd5PgKJMEInQ9+gkWC/4kaY/zDrR0aiBsDmpZpwm
         vZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4frS2VFIjyyQqgkr4HKDJHBhSW3ymupXzFbpuOfWGr4=;
        b=cuSCyFBTgOJRLydaj9B9F39fUpHB2Vghfx3UD14yCzFcNFg4n53kzket+qFylKvqFP
         qQdJouzquy+Rk2iv5xkkuVwrXvxtunNijO6ChY8fIcqp2HHon64w4GwvJWwe97nflaG7
         PuyqzBCiocmUzkbB5OwL8EChZ6KJT3PyW7BH+yJWmf+BXqN4f+xtoPP1gy3RR8vpA91a
         IQJgVSZAwKO8OUxhoF+iL63DuPbsn+VCGd20hHcjzNsGGS6h0AacR38SKFunXbIkKEDP
         WgjT0GYiLhVkJgCL/cRZ7Fbi0iV1XjrY2nDfIJ13HGBHVI2WkweuzgWz7mEGcuLtamrv
         +QVA==
X-Gm-Message-State: APjAAAVgo7pFc3pSy07XPz50cMyObQqwSH6BB3s+izF4rTBtJjFuVlTk
        4Z293VScMqgSxmJqNWvid5j8f0+L
X-Google-Smtp-Source: APXvYqzl6qR8F/hySeqOsehOc094IHvcLLDrY5+sC1iZ3rM7uwytv7BrLXmPsA1SjVZxPfOwXxcjbw==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr130278wrx.226.1569442864176;
        Wed, 25 Sep 2019 13:21:04 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id f10sm178875wml.4.2019.09.25.13.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:21:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 0/5] Use complete_action's todo list to do the rebase
Date:   Wed, 25 Sep 2019 22:20:54 +0200
Message-Id: <20190925202054.20416-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Sorry, I made a mistake and this message was not transmitted :/]

This can be seen as a continuation of ag/reduce-rewriting-todo.

Currently, complete_action() releases its todo list before calling
sequencer_continue(), which reloads the todo list from the disk.  This
series removes this useless round trip.

Patches 1, 2, and 3 originally come from a series meaning to improve
rebase.missingCommitsCheck[0].  In the original series, I wanted to
check for missing commits in read_populate_todo(), so a warning could be
issued after a `rebase --continue' or an `exec' commands.  But, in the
case of the initial edit, it is already checked in complete_action(),
and would be checked a second time in sequencer_continue() (a caller of
read_populate_todo()).  So I hacked up sequencer_continue() to accept a
pointer to a todo list, and if not null, would skip the call to
read_populate_todo().  (This was really ugly, to be honest.)  Some
issues arose with git-prompt.sh[1], hence 1, 2 and 3.

Patch 5 is a new approach to what I did first.  Instead of bolting a new
parameter to sequencer_continue(), this makes complete_action() calling
directly pick_commits().

This is based on master (4c86140027, "Third batch").

The tip of this series is tagged as "reduce-todo-list-cont-v1" at
https://github.com/agrn/git.

[0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.com/
[1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/

Alban Gruin (5):
  sequencer: update `total_nr' when adding an item to a todo list
  sequencer: update `done_nr' when skipping commands in a todo list
  sequencer: move the code writing total_nr on the disk to a new
    function
  rebase: fill `squash_onto' in get_replay_opts()
  sequencer: directly call pick_commits() from complete_action()

 builtin/rebase.c |  5 +++++
 sequencer.c      | 26 ++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.23.0

