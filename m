Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68D920248
	for <e@80x24.org>; Mon, 18 Mar 2019 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCRO36 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 10:29:58 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36998 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfCRO36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 10:29:58 -0400
Received: by mail-ed1-f42.google.com with SMTP id m12so13707292edv.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=swSXMRARQVV9vDTuxYFfDbJZX/AWWJ2/1xlfJTz5ilA=;
        b=pmeDkIrGHABVsVG9Jx9yQYfb4xYI0yY8/jRzxBLCD57mfBNbYZxszhU74cXzbeidpc
         nZ4bL0VhSnWXtG74IyTlZEoZo2UhJjuEadfPyHAbcL6eFOhIDmJwwF7+N8EnknwLnLWX
         MvEfdv2kaY9mE4K1NOq+/i3Y3zQCMGCXCC8TYFGsNswjF9BX6HdLqaXUNe3WofpWa1mN
         Wsm3XodAIUZDf1ANSwUJKqmvsqzqgjQduH/AkZHMxqtE9OfwdFY0QRmiKZ7IOxbODHl1
         9zOzenKgJeHmds/pqLfD4XBL5q1FhNoF5DZGUKTG+X7iCPZS/D607UuAw0PtklCM5ZPv
         pCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=swSXMRARQVV9vDTuxYFfDbJZX/AWWJ2/1xlfJTz5ilA=;
        b=t9fLfqi5I1CGA+CMU1KWQZQM3RpBUksZJWBWLXvDMUsJBx1hKXDxgRsPBMqN2KEUSg
         K2HKET15gONP9gCsizvlOkISSBCmzxhu+NofGwDWPJ0ZEbiWgUyCI/G/Dgw9YSviTB9A
         aRBl8gK/IXeP7WholvgJ/1wViY8ZfaoSWYr6xTnfGdZdURqXKgU2STRNshI6qjBIJj0L
         9es/ZgXx4hXLB4xOJrIepfSKjdyHb2mUVnAtPdRR1ujIl9whCRda1nB88MN+W37Fup36
         jJiyhB97WllA+OulJ5TZWCXVmn4Wk4STQPRe17dMrdMQf+HEtuSDU9+WGYURD7H5eFRM
         sePg==
X-Gm-Message-State: APjAAAUlhsqpdG6eailHKEhv2wYMaqtNXiCVHg5TmoWINqhHn0Kyi45f
        NemmK/9mjygt5nCauqz8jJG6eptF
X-Google-Smtp-Source: APXvYqzndII+gIF4mbKGB3nxHTznsTnkmans7gFyWr1K4x8WcAp+lWrhJ8dW1oLRGaUf7PyOZyJCJA==
X-Received: by 2002:a50:b1bc:: with SMTP id m57mr4417611edd.116.1552919396665;
        Mon, 18 Mar 2019 07:29:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w24sm3464100edb.72.2019.03.18.07.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:29:55 -0700 (PDT)
Date:   Mon, 18 Mar 2019 07:29:55 -0700 (PDT)
X-Google-Original-Date: Mon, 18 Mar 2019 14:29:51 GMT
Message-Id: <pull.166.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] multi-pack-index: fix verify on large repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "multi-pack-index verify" to handle cases where the number of
packfiles exceeds the open file handle limit.

The first commit fixes a problem that prevented the LRU-style
close_one_pack() mechanism from working which caused midx verify to run out
of file descriptors.

The second commit teaches midx verify to sort the set of objects to verify
by packfile rather than verifying them in OID order. This eliminates the
need to have more than one packfile/idx open at the same time.

With the second commit, runtime on 3600 packfiles went from 12 minutes to 25
seconds.

Thanks, Jeff

Jeff Hostetler (3):
  midx: verify: add midx packfiles to the packed_git list
  midx: verify: group objects by packfile to speed up object
    verification
  trace2:data: add trace2 data to midx

 builtin/multi-pack-index.c |  3 ++
 midx.c                     | 60 ++++++++++++++++++++++++++++++++++----
 packfile.c                 |  2 +-
 packfile.h                 |  2 ++
 4 files changed, 61 insertions(+), 6 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-166%2Fjeffhostetler%2Fupstream-midx-verify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-166/jeffhostetler/upstream-midx-verify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/166
-- 
gitgitgadget
