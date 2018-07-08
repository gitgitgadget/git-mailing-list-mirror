Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99131F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 22:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeGHWRV (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 18:17:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54190 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754377AbeGHWRV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 18:17:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C850C6073C;
        Sun,  8 Jul 2018 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531088240;
        bh=EaiiRpWCdW6ZnDcKB9HWM04C0D9LMVuKy3akUS2EsIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gw57nR3H9moTIZz30Y9DChipFIhJ42zxCjw/DtxFFVOjV5QfjTynjjGsr4yV6Ad27
         7f3SFGKxQGfitTUV+VCknnMSLqI4Ldc95nQoAhBH3h6UqSPqMV0Lkewt4ic6zpLoNU
         IY0rFjiSDgZCX0XN2vmloRMIQmTAiDae6QoV8hH7MTc+TqsmC+qD5riD8OLtS7LszH
         eoMWWsX49aGD3bsyVjDQxLPiwsAQksD/w+pmTBowOXl2dHB0CrThw18QJ4XqNBMh/u
         dbDLVEAckx5Mv4zABu5AHkG0aJbD1ps/sCO7f26ssadO7fkl+yeo6YITWUErYl1ovH
         85Cj/NEy7nNOMmesKmQkWrKSQrsnUdrIeW19nUFmFP7kttpIUXASulcard1hT9ZIS1
         xa8O/t/1AzyxAPdU1OBhO7zN01774XcojEw9kg+3LdLDZJeYogwVt01LD7yK3itThs
         6perqPOR+5NGUVVLHaCE/q/CupiiYCUjCC1fZtm5z/uS2UVbPgE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] Automatic transfer encoding for patches
Date:   Sun,  8 Jul 2018 22:17:09 +0000
Message-Id: <20180708221713.518276-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180706022357.739657-1-sandals@crustytoothpaste.net>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces an "auto" value for git send-email
--transfer-encoding that uses 8bit when possible (i.e. when lines are
998 octets or shorter) and quoted-printable otherwise; it then makes
this the default behavior.  It also makes --validate aware of transfer
encoding so it doesn't complain when using quoted-printable or base64.

Changes from v1:
* Update commit messages to refer to RFC 5322.
* Add a missing space.
* Remove the needless capture of stderr.
* Define "suitable transfer encoding".
* Invert test to better capture failures.
* Wrap --validate code in an if block instead of returning early.
* Update documentation to reflect correct, modern RFC.

brian m. carlson (4):
  send-email: add an auto option for transfer encoding
  send-email: accept long lines with suitable transfer encoding
  send-email: automatically determine transfer-encoding
  docs: correct RFC specifying email line length

 Documentation/git-send-email.txt | 17 ++++++----
 git-send-email.perl              | 46 +++++++++++++-------------
 t/t9001-send-email.sh            | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 29 deletions(-)

