Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DAD1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966842AbeFSPpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:45:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36554 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeFSPpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:45:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so162511wrm.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=of203WSCpD/YEfuwZwWzpQsoBc4wG4gE4zjw6mOMQXg=;
        b=NMSruvWE+Afbe9OtrgtIishfDd987zZP8bVKTHfUkdldVaHjL7veI3aH9pn7SumLTq
         4rND0OzhAKGq1QepvbKOezXz23laxuK5b+43bpCYLX32qHISERkQFvZ1t1XgWSUmgyIQ
         eZtovnSCstyANnfrIuBRjyTe7R/CmQH7CA+Xj6129rDVN9lUsGHQgeiknR/q9mdT1X8A
         Ms+G2DELeSDSr3MWUBnVoDt78lZHIH7BpHs3V5YC6AKz0+W51mMe1DnRcLI0tPoIZBdW
         qnejOxJeLFqI/CWcowhzCnOnEvi+ISinoJepI5JiRwjbPil9RxYXzbad6coXW+adwvXa
         o7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=of203WSCpD/YEfuwZwWzpQsoBc4wG4gE4zjw6mOMQXg=;
        b=L4WyFghcG/crk3oTFLYafWU/QryDB1TjjPSRiilMFN/WWhIBTTmZys1csUltw6pYHP
         6HXHyv7w1NfAqendW24NhG280O0eK4mO8dRvk6J8sVG/ctJUTwykNq5jodXiqA+z4QnX
         wmCx6OEsBtPZH44zvhKzGsQXx5lyKjP9Q+aGRemJC0gWx8Bd8qHFtYbugaMNnEbcj1lG
         CsHh86G4NqPO0KTyMy4oEC7j2OtUA7NqTAkfIotFmf9qS7089Pgsvg4DMndXucPm0eV3
         dGERP2BxxFUyc7iRYq0gnuPuee9nh4cW+T49gjCIc4XCynstZ1Vb56LvMf+xbKihZY+k
         lwug==
X-Gm-Message-State: APt69E1eqFTDifhucTLH1iNKHvf6RcfGh9REDU7E6QMhAzOMa8WAvQ79
        /yoCjDVzjYUgkOw15kVtVn0O7CfU
X-Google-Smtp-Source: ADUXVKLAHbylSJ3XQdZ4liGZSz8MudCHBijiXSf59YtKez1rAFx7QMBxpNcBsdPPbq2BYBAoogDpTA==
X-Received: by 2002:adf:be09:: with SMTP id n9-v6mr15392465wrh.267.1529423098683;
        Tue, 19 Jun 2018 08:44:58 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id q77-v6sm596176wmg.25.2018.06.19.08.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:44:57 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 0/3] rebase -i: rewrite reflog operations in C
Date:   Tue, 19 Jun 2018 17:44:18 +0200
Message-Id: <20180619154421.14999-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618131844.13408-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites the reflog operations from shell to C.  This
is part of the effort to rewrite interactive rebase in C.

The first commit is dedicated to creating a function to silence a
command, as the sequencer will do in several places with these patches.

This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
with pu (as of 2018-06-19).

Changes since v1:

 - Replacing run_command_silent_if_successful() by
   run_command_silent_on_success() in the first commit’s message (thanks
   Christian!)

 - Adding a “verbose” parameter to run_command_silent_on_success()
   (thanks Phillip!)

 - Using OPT__VERBOSE to parse the “--verbose” flag (thanks Stefan!)

 - Fixing some typos and errors in the commit messages

 - Renaming “setup-reflog” to “checkout-base”

 - Renaming checkout_base_commit() to run_git_checkout()

 - Replacing calls to die() by error()

Alban Gruin (3):
  sequencer: add a new function to silence a command, except if it
    fails.
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C

 builtin/rebase--helper.c   |  14 ++++++-
 git-rebase--interactive.sh |  39 +++--------------
 sequencer.c                | 102 +++++++++++++++++++++++++++++++++------------
 sequencer.h                |   6 +++
 4 files changed, 99 insertions(+), 62 deletions(-)

-- 
2.16.4

