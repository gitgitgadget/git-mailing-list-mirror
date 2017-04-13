Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A347620960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbdDMSdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:33:06 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36190 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbdDMSdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:33:01 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so32059916pfb.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q1T8lbcz88krmzzOJnvOIMY92MsCKt7DLs4FYXSI+zI=;
        b=tpl4b647x+1sL9FQzBCIgrvLe3uWApo9wOZ8uqzeahhIagt1bHQTj6x6+hhWDqXoLJ
         irJnPosjXRJbTOF+NMTIejCEoaXrgVj/aIsyTgigNBcb+NllPHPPRxIssI1pKr2UwGof
         pGgp89tc7yDAsp475i2g9RrXUdR5QbF27jVfKiFGU8+kmHdHs87jPsn/tLVPOgfyr/h1
         QefEh6LTtTQsDxjiF8WiDyc9IjWyQDEMxpNV3cmAPl4zuPCpdJUW6Icd9Lzj+pQAoitq
         uQ28sdeyZEtD+aWwKui9U+B1RiCu0zhAjbPhKkxNMfISk3eSidtprDoAtQF+ETUcXg9S
         ybJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q1T8lbcz88krmzzOJnvOIMY92MsCKt7DLs4FYXSI+zI=;
        b=JRIYFcYOqV3s/SmgD0loWoU8UBTGYaHeovjUWdIhw5VfFisQGQG05Sjt9E4yTnooNZ
         Al+ZJrXG2rkotIFyI362KyaqDC21iSMfP9d0VLAa4NCQoYtzuBIBzK2pd66JzFNFnxHX
         TygXKxMpfPmOQ2q9pw6GwL5y72D+jrkRq/+Y9/y3z3/9R1xM33Xts8pbPaMF9uJY+He6
         zxgESRdIjWlKYET0DPvqKUC7BY8TUwCJ+myHRRNhCZSQpwvc7NoRjJMXKAG3ZIuUlBN5
         f53Hx0nFonca3+IxWo3XE91b3dlzpq5PD3tFEp95sXS3jzG9fGXvjiSvL/HurxBvp+9n
         XUHA==
X-Gm-Message-State: AN3rC/7W0zuQun1fhB3n1edULc3cfo0vKyULMedU7IsuGPkD59D0gTLM
        yNUCjSwOc4Oo8B1H
X-Received: by 10.98.43.3 with SMTP id r3mr4144268pfr.32.1492108380748;
        Thu, 13 Apr 2017 11:33:00 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 201sm43764654pfc.126.2017.04.13.11.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:32:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v2 0/6] forking and threading
Date:   Thu, 13 Apr 2017 11:32:46 -0700
Message-Id: <20170413183252.4713-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 does a bit of restructuring based on comments from reviewers.  I took the
patch by Eric and broke it up and tweaked it a bit to flow better with v2.  I
left out the part of Eric's patch which did signal manipulation as I wasn't
experienced enough to know what it was doing or why it was necessary.  Though I
believe the code is structured in such a way that Eric could make another patch
on top of this series with just the signal changes.

I switched to using 'execve' instead of 'execvpe' because 'execvpe' isn't a
portable call and doesn't work on systems like macOS.  This means that the path
resolution needs to be done by hand before forking (which there already existed
a function to do just that).

From what I can see, there are now no calls in the child process (after fork
and before exec/_exit) which are not Async-Signal-Safe.  This means that
fork/exec in a threaded context should work without deadlock and we could
potentially move to using vfork instead of fork, though I'll let others more
experienced make that decision.

Brandon Williams (6):
  t5550: use write_script to generate post-update hook
  run-command: prepare command before forking
  run-command: prepare child environment before forking
  run-command: don't die in child when duping /dev/null
  run-command: eliminate calls to error handling functions in child
  run-command: add note about forking and threading

 run-command.c              | 291 ++++++++++++++++++++++++++++++++++-----------
 t/t5550-http-fetch-dumb.sh |   5 +-
 2 files changed, 223 insertions(+), 73 deletions(-)

-- 
2.12.2.762.g0e3151a226-goog

