Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07281F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeCWOAc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:00:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39827 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeCWOAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:00:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id f125so3713424wme.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sB0Q1gLDTG8+zBsI9ElPe82wNNjKUMbhN8tv7yZl+tg=;
        b=DakXSvFs/8SJSEUW2oi4xWJpSDAnm5pR5ZaIAS1Jd7i6ed6giKnqo46EWO8o7DDwJ1
         CjqtSC4bMC7xuzbecGfijHPOusAxn476iUtRQp6d2np+mJf3WBacc9ozQr5mcPqBFu3n
         cf/qcLNDNrFbGxh1OQHyoDI2YsnkpgVwGVansXqlfNa9eibsIhu36fjCrg863H/Y7caa
         IbVNOBpOsOT3GCnwnB1FUfk/LmwFfNrNTg3XSI7COEIs8ug6JhJCFvZP/691OlFBE5UI
         xuybuHO8N9FPoqEmgZwEpqdvilDBeAFYjnSKgI62+Orj9sno46CWWxnEQghuxdI1/8cE
         P/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sB0Q1gLDTG8+zBsI9ElPe82wNNjKUMbhN8tv7yZl+tg=;
        b=L0zDzqQEcZKvL59MLgdmM7V58k897Z/jefXNM7K3tbq1h15gfiWAZ4G6BcHfLybdlM
         r2q84JeynF4BXWeJcbbHZdIXXcF5W0EgOgZrvugrV9duM2J2XtoTcG9h7aJvSwLCDmZR
         WD8sRMAKZkKEmCbJtTCZYwspcnzNcBFTkeZDSAPIE5Imkh5/3jEu9Tq8eRq1c1U1DkbB
         LMQrbapbiE/1Db8QV3/K/r364fVnVPDthZ2XMGkyFM+jmyz/qhCiDK4xALdG0AHTOP2k
         UuIqtgXE1XKyEZy8mDnvQV0rJGF/akfBtf2Ww9Zh997xBwI4ueFOlkWaGdSjmq1iS4M4
         q3Zw==
X-Gm-Message-State: AElRT7HwfEErUaNLL0MoeBlbThFJGlDRk+u/AbowjijAYqZxsL8moarv
        V1YO+gzz9zavhbdq3x8kitBtRsgx
X-Google-Smtp-Source: AG47ELsccFqa7V9jmTKsYkzUweW87l/Odc4K/8Q/VPh5Qai1tbFAXghDzbExH1r+aIP+fiku5cpvHg==
X-Received: by 10.80.165.227 with SMTP id b32mr29209077edc.116.1521813628267;
        Fri, 23 Mar 2018 07:00:28 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id d89sm6245930edc.75.2018.03.23.07.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 07:00:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 0/2] perf/aggregate: sort result by regression
Date:   Fri, 23 Mar 2018 15:00:05 +0100
Message-Id: <20180323140007.12096-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small patch series makes it easy to spot big performance
regressions, so that they can later be investigated.

For example:

$ ./aggregate.perl --sortbyregression --subsection "without libpcre" v2.14.3 v2.15.1 v2.16.2 p4220-log-grep-engines.sh 
+5.0% p4220-log-grep-engines.2 0.60(0.58+0.02) 0.63(0.59+0.04) v2.14.3 v2.15.1
+4.5% p4220-log-grep-engines.10 0.67(0.64+0.03) 0.70(0.67+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.5 0.58(0.57+0.01) 0.59(0.59+0.00) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.6 0.58(0.58+0.00) 0.59(0.56+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.17 0.58(0.57+0.01) 0.59(0.56+0.02) v2.14.3 v2.15.1
+1.7% p4220-log-grep-engines.1 0.60(0.58+0.01) 0.61(0.60+0.01) v2.14.3 v2.15.1
+1.6% p4220-log-grep-engines.13 0.64(0.63+0.02) 0.65(0.63+0.01) v2.14.3 v2.15.1
+1.5% p4220-log-grep-engines.9 0.67(0.66+0.01) 0.68(0.67+0.01) v2.14.3 v2.15.1
+0.0% p4220-log-grep-engines.14 0.65(0.62+0.02) 0.65(0.63+0.02) v2.14.3 v2.15.1
+0.0% p4220-log-grep-engines.18 0.58(0.57+0.00) 0.58(0.56+0.02) v2.14.3 v2.15.1
-1.5% p4220-log-grep-engines.13 0.65(0.63+0.01) 0.64(0.62+0.01) v2.15.1 v2.16.2
-1.5% p4220-log-grep-engines.14 0.65(0.63+0.02) 0.64(0.60+0.03) v2.15.1 v2.16.2
-1.6% p4220-log-grep-engines.1 0.61(0.60+0.01) 0.60(0.58+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.5 0.59(0.59+0.00) 0.58(0.55+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.6 0.59(0.56+0.02) 0.58(0.55+0.02) v2.15.1 v2.16.2
-1.7% p4220-log-grep-engines.18 0.58(0.56+0.02) 0.57(0.55+0.02) v2.15.1 v2.16.2
-2.9% p4220-log-grep-engines.9 0.68(0.67+0.01) 0.66(0.64+0.02) v2.15.1 v2.16.2
-3.4% p4220-log-grep-engines.17 0.59(0.56+0.02) 0.57(0.55+0.01) v2.15.1 v2.16.2
-4.3% p4220-log-grep-engines.10 0.70(0.67+0.02) 0.67(0.66+0.01) v2.15.1 v2.16.2
-4.8% p4220-log-grep-engines.2 0.63(0.59+0.04) 0.60(0.57+0.03) v2.15.1 v2.16.2

Christian Couder (2):
  perf/aggregate: add display_dir()
  perf/aggregate: add --sortbyregression option

 t/perf/aggregate.perl | 59 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

-- 
2.17.0.rc0.37.g8f476fabe9

