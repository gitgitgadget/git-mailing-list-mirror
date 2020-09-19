Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410DCC43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EF62098B
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHavHfGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgISRDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC79C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so5404671pgl.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVfjwPR7Ykvj/+IbV1P0IZWoxlcgcrAl4+77RM+tMQQ=;
        b=FHavHfGs+Mt/hK2v+8SL1mun2qwh85W/+vhhGrXl7Zc5NHN3zk5nJuWt9XXoKUBTVa
         ifBN3qEz820IYtrj0qlXE9cRybLSF1XePhoHfeg/w5+x5AUnW/aShozcTJXj+QEdV/70
         YfqZtxVUDgaN2tf1BySm88DNTMsO7gqUsR52jAYKuR+obNfSWeEd88ZYVAsMP6g8wKd8
         9+zxdP6zgORwtvu7SZIanPNhj2I0WcsstraC1KCqwCz5htka/O2Wr2F6R5Qg5PmQ/0Q+
         e1oy98JVtdd4xj80nH0ZUOYvhgCDt3zGYa5vWtxqiIjPxOsUoM+VQIrjFGYqevhPHYyH
         /CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVfjwPR7Ykvj/+IbV1P0IZWoxlcgcrAl4+77RM+tMQQ=;
        b=groauveRi7l9NvDCNmo6tQbB0NYUlExwk4XwmXEbW8SJpwzW/cY5EgNra89J+3bTmh
         Nzk5csOF6xN6P+1VeXozE4iCCEskoQi0DqmV+cR1emsGVc1tNJ52QosLpY9L0yeTyQtG
         64tDzEiHzoUB2uxVDGiIATpDj+inVCbwHOFPOPY2FaEA+y/HBKPOu+au3uFNgJi0Stop
         +3sswEDUMESkPgCwI0rlQRN7UkEOBPFsUWefJ21+wloAGZQ2iLfmBLr6UXHS4qo/ddut
         YFPEyh6XDXQ3NiUHsMYiY4/q7Xa3s4QloDJLm+m2dzBExuieEIF+ay78PPTbizKTJfBM
         6u1g==
X-Gm-Message-State: AOAM532UfYxqfKxtoZIfYn4bYEtWooJJuooMO5oTtPsdGhC2jdF+5J/m
        BnucRL1kMkTuUdlkeZojbyMtloawn98L7xtjeBM=
X-Google-Smtp-Source: ABdhPJziv5ZJF8u0JocPN15kyHs+ht4nL1JYGGjVPie0/zdhNPLy6LiHif/SxXtsPUwqBr/CyYbGQw==
X-Received: by 2002:a62:1410:0:b029:13e:d13d:a129 with SMTP id 16-20020a6214100000b029013ed13da129mr37055640pfu.17.1600535018869;
        Sat, 19 Sep 2020 10:03:38 -0700 (PDT)
Received: from localhost.localdomain ([104.200.132.172])
        by smtp.gmail.com with ESMTPSA id 25sm1510140pgo.34.2020.09.19.10.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:03:38 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 0/3] push: add "--[no-]force-if-includes"
Date:   Sat, 19 Sep 2020 22:33:13 +0530
Message-Id: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between the
checkout and forced push to be lost.

Changes since v3:
  - Switch to the two-step approach: check the "reflog" the first
    time to see if the remote ref exists; if not, go through it one
    more time to see if it is reachable (using "in_merge_bases()")
    from any of the entries. This is a necessary step as explained
    here [1].

  - Added back the configuration setting "push.useForceIfIncludes", now
    that it does not affect the functionality of "--force-with-lease"
    when the expected ref is specified.

  - Update "remote-curl" and "send-pack" to recognize the new option;
    this was missing in the previous patches.

  - Broke up the patch-set into medium sized commits.

  - Clean-up unnecessary function calls.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |  9 ++-
 Documentation/config/push.txt   |  5 ++
 Documentation/git-push.txt      | 20 +++++++
 advice.c                        |  3 +
 advice.h                        |  2 +
 builtin/push.c                  | 27 +++++++++
 builtin/send-pack.c             | 11 ++++
 remote-curl.c                   | 14 ++++-
 remote.c                        | 97 ++++++++++++++++++++++++++++++++-
 remote.h                        | 12 +++-
 send-pack.c                     |  1 +
 t/t5533-push-cas.sh             | 53 ++++++++++++++++++
 transport-helper.c              | 11 ++++
 transport.c                     |  8 +++
 transport.h                     | 15 +++--
 15 files changed, 276 insertions(+), 12 deletions(-)

base-commit: 385c171a018f2747b329bcfa6be8eda1709e5abd

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.2009161214030.56@tvgsbejvaqbjf.bet/

--
2.28.0
