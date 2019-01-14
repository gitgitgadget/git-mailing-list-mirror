Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2641F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 23:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfANXzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 18:55:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34738 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfANXzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:55:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so225144wmd.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6k2sq67NuOcyrdce1NPmE4cAGNYpEUb5x+u9mUIRzM=;
        b=eY3kiSgAjxFlbajI66Hq81S9xp2tBeS2bqYpzE5jCVs4O1hBYo0X7JXqoQzP6nxx5C
         bzXuwCcWUjbKxC8F/4QFdjQylnIssescI+WMWqifCe0GqMFKTgdLH852PlOp8EzowSi/
         R7504nm+x7PXPCgK+WaNj8FGyESH82p6X6KT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6k2sq67NuOcyrdce1NPmE4cAGNYpEUb5x+u9mUIRzM=;
        b=kWQNXJNfhk1SWPrDFdpJDVIf2lDbUOfDTEgYMUHG5hLBYs3x7XJ850t1OfWNlidqoO
         I47nz9f8GGP2M5H6T+bo8iiI/jGa4T7+tuts6fCXKEk8qv5n6JD9r3kIgRKfYyl7Pk6J
         BuXwSQZBAW3bqKFFIvcAqx1k1ueluc3drN4ovU81anaO+uGiN+/kBYYl16SFy4ksa0ha
         hjT3qgq7tbhVVdDgaqjMnMZxfkKkLI9O7fDCGNGXlXq9zTYp6ZW8vsuIjUhZhF1///RK
         w1TMpCensawCPZH7cR07epoqbr1xEi1we/hLTkM3Khre6uAjDBkMXZedTOVb/DLdffcu
         Itdw==
X-Gm-Message-State: AJcUukdW/O+eYE4/ZwjwGUWim9QDgCNCthd3zjyFM8mUzIZ41cIyjiwj
        YYiZrZdXY+U1+Us2NySfA06PVPtjm88=
X-Google-Smtp-Source: ALg8bN6ZVp7fTAzs3pXIDncC3TzrMewEGXRSuJnpqzSGlw4Rrxo0rR+QGCM4j5bMi2C0yCCEaorMbA==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr1044117wme.119.1547510131524;
        Mon, 14 Jan 2019 15:55:31 -0800 (PST)
Received: from ethel.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id x10sm89224806wrn.29.2019.01.14.15.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 15:55:30 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Oakley <aoakley@roku.com>,
        Romain Merland <merlorom@yahoo.fr>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/2] git-p4: handle moved files when updating a P4 shelve
Date:   Mon, 14 Jan 2019 23:55:22 +0000
Message-Id: <20190114235524.3947-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.100.g9ee79a14a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated as per comments from Junio, Eric.

https://public-inbox.org/git/20190113135815.11286-1-luke@diamand.org/

Luke Diamand (2):
  git-p4: add failing test for shelved CL update involving move
  git-p4: handle update of moved files when updating a shelve

 git-p4.py                |  1 +
 t/t9807-git-p4-submit.sh | 51 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

-- 
2.20.1.100.g9ee79a14a8

