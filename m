Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789A11F42D
	for <e@80x24.org>; Wed, 23 May 2018 07:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeEWHWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 03:22:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753985AbeEWHWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 03:22:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id o78-v6so6287436wmg.0
        for <git@vger.kernel.org>; Wed, 23 May 2018 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eao327CSTPEehJa00UFl64EP5i79vBxA2zUd8XoxF80=;
        b=ebgKHuc2rk2zwwjmgzy//CjIu2y8Y64o12g/KvMy50TNtV55V68o/jm+QKKOr5mL+V
         IMjrTCPkpoJrM6THTAW5aUnBYP7RMyrKgPseUvqvhLoTFGpiOSl8tY3HAY8upqhQMhJi
         hqKQJRJEUIukKX20crm2e5vp39SAebzTqdggo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eao327CSTPEehJa00UFl64EP5i79vBxA2zUd8XoxF80=;
        b=C7zDQR7btRFqX3SbUJwSaIjwp7Lxg2HJCyNTmr3TLc6FEYzSNsi7TkYjcpgN1Pusof
         4kzYTwrV/M61R6HtkAiBWRCYQ7CQE9haVOsCX78jqATkIGrKA783cXCgqd4keErGWzT8
         Aa8RzwjUdNfXOqnoxJvjZD9bG8CFABDnDREP6cH3ALWxp8u210D7478ONk5cYTJBNQk6
         aX9wYK1pYAu75oC3L/RKNfyjfry5eql1LGOqUs9hwBFj2DxqYLG28ZNS3VjHudXj5kHo
         FN8oqz3uTB+aihEesLZAsE8sxGhHdk2gtoeenH6sblPmMz7ceiNazdit75pvsQ0YUo5I
         ujuA==
X-Gm-Message-State: ALKqPwcNCSxBgXjjInjq4c396f7eaJkO280yb7p72G1E+ZuQjiQ4aWLs
        F3Zibjc4eP/GmCeSjRRCu1rPbidY
X-Google-Smtp-Source: AB8JxZqt7XNUiK9m/wRFbnIl+OkzOmlv2NR6eR3WyxKnwwhYuX3eFPxw0FXH64QQb4GjLVbJiHhLxA==
X-Received: by 2002:a1c:7e87:: with SMTP id z129-v6mr3567042wmc.131.1527060119710;
        Wed, 23 May 2018 00:21:59 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id 32-v6sm8996247wrf.33.2018.05.23.00.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 May 2018 00:21:58 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv5 0/1] git-p4: unshelve: fix problem with newer p4d
Date:   Wed, 23 May 2018 08:21:52 +0100
Message-Id: <20180523072153.24157-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v5 of my git-p4 unshelve patch. It fixes a problem found by
SZEDER Gábor with newer versions of Perforce (2016 vs 2015).  

Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  32 ++++++
 git-p4.py                | 215 ++++++++++++++++++++++++++++++++-------
 t/t9832-unshelve.sh      | 138 +++++++++++++++++++++++++
 3 files changed, 348 insertions(+), 37 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.17.0.392.gdeb1a6e9b7

