Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1BED1F428
	for <e@80x24.org>; Mon, 30 Apr 2018 01:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeD3BsN (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 21:48:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52603 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750938AbeD3BsM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Apr 2018 21:48:12 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AF0F21C1D
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 21:40:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 29 Apr 2018 21:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=sSmik6rQD7DZdoGAzHmLAGqBMJ+uC
        +aPlu3u4SOL/wM=; b=mzneiBxVB8xjvkW9yD6EpuHshRbW1a/QMr3zGoBUyWcVw
        +YBcjYv/dPzlEffhyns2JS/aV8+8t1p+9+gVTksq139CvNZJY6eLPB08QSGLHb1a
        Z8P5ghglleRyej0b+SvQ0w0+KBbn62wv9ZqWsKV6cz6et2SUmXALig1LSbRFFIra
        Sgn/7/vmRdkoLaKWHqZKwnuIaRJtuio6lyFCApGdVyNKVWPf/RX0+0zlo/InWpbr
        OTVT5mUGZjC8HK6HkMe/+ouqnAVZO8yr6HpbKV3cE+rHAX8XnyvDBRc/0xRUQ2rJ
        m71FnWiKjAqlblAqlx5WAgLLf+76Uoc3NLdhyPJXQ==
X-ME-Sender: <xms:_3PmWvIm8ZuLl12PndW5FogT0i2UIp_j5TrScEsMwzwutJuz6yCPgw>
Received: from fll1000539l-2.hsd1.fl.comcast.net (c-73-204-24-211.hsd1.fl.comcast.net [73.204.24.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B8BCE4F68
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 21:40:15 -0400 (EDT)
To:     git@vger.kernel.org
From:   Patrick Hemmer <git@stormcloud9.net>
Subject: Bug: format-patch MIME boundary not added to cover letter when attach
 enabled
Openpgp: preference=signencrypt
Message-ID: <5e409069-835f-3c85-f55e-c27f534dc9e2@stormcloud9.net>
Date:   Sun, 29 Apr 2018 21:40:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you use `git format-patch --cover-letter --attach`, the cover
letter does not have the trailing MIME boundary. RFC2046 states that the
last part must be followed by a closing boundary. This causes some email
clients (Thunderbird in my case) to discard the message body.
This is experienced with git 2.16.3.

For example:

$ git format-patch --cover-letter --attach --root -o /tmp/out
/tmp/out/0000-cover-letter.patch
/tmp/out/0001-hello-world.patch

$ cat /tmp/out/0000-cover-letter.patch
From a25ac88e6216131e8b000335d32bb99d4e5185ac Mon Sep 17 00:00:00 2001
From: Patrick Hemmer <git@stormcloud9.net>
Date: Sun, 29 Apr 2018 21:26:45 -0400
Subject: [PATCH 0/1] *** SUBJECT HERE ***
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.16.3"

This is a multi-part message in MIME format.
--------------2.16.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


*** BLURB HERE ***

Patrick Hemmer (1):
  hello world

-- 
2.16.3
