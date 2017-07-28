Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A911F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 17:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbdG1RS0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 13:18:26 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33963 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdG1RSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 13:18:25 -0400
Received: by mail-pg0-f49.google.com with SMTP id u185so7822358pgb.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IcUfuTTvXWoYDWOJlS7aW1XngVnSpYlZVbqLG17Ws2s=;
        b=Hsnm+HXFryuZZSnvnzg8l0xMFEl4PRYg0XhcikUABlzty4DH/8SQFsvlVUlvZXfDef
         5X/yXaO42LYIfGksSs8mf8yN91I4Ef8AczNIFMBP/tcdjkyYbN1Y5dVTr++wiDK8KDfM
         qPSaFgM4shhViEuaDR4XpQ5ss+NheY40cVwcqUio2fwQWHS1UcYqFOeRieOQ670C0dg7
         aGW8p3Ab8VnRSUqjhH/4oPldTLOv4a15p9wqJy0ykXQ/Ot4HKbiNnWtp30RdyiRv7zkO
         4TiW6xbZ+DvQozLGtZTB9MS3KUVYvaTClRm6Nbp+wXYpnRVyVsGv/jawWgnfI+Ns1Zjg
         t++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IcUfuTTvXWoYDWOJlS7aW1XngVnSpYlZVbqLG17Ws2s=;
        b=dpNUKFa4ZbOvJIXxIqb7aK8m3SIz+w2eFVJQHVVjyhsHXRmT2L4h7Hnb7V1DRXajM8
         Tt3s0hQVeB9uqU0PcEEw2QGtj+NVmLQpb5urcLL5PW2kPgH0yTncafhPIhJ/Z9Am1OqY
         9ZkCuRSpuFznPRChnw3oVf3TW8zuouXR8fP1/d8hNGXX6+Hwm4hxO3lmSuQ2qltM0Mlw
         e9w9cmHVTe8Wq13eWg2uzxW+sVLNGbWCk04vD51/oQmnwyj/RjuJp3jIoJByuXaUCrV7
         0XJYI/PJ+6xBJ20pJIRP69DdJ73CSg/OpaLoGfdaxOYW3+xNgsonDYXzd++ontEOvx0X
         wHxA==
X-Gm-Message-State: AIVw110O9Jr9CUkv29FTUA0hNc7Qf1iDyA39lQc7ipZh+xRZgZNhr5QZ
        /tLRT4bHj9oSBFiVV/3yYw==
X-Received: by 10.84.164.106 with SMTP id m39mr8861621plg.178.1501262304582;
        Fri, 28 Jul 2017 10:18:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d9da:4cf2:5968:beb4])
        by smtp.gmail.com with ESMTPSA id v21sm42363311pfk.152.2017.07.28.10.18.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 10:18:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFD PATCH 0/2] How to migrate our test infrastructure away from sha1
Date:   Fri, 28 Jul 2017 10:18:15 -0700
Message-Id: <20170728171817.21458-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian got the ball rolling with his object-id patches
to fixup the code base, but we also need to discuss how
we approach our test infrastructure eventually.

C.f.:
* jb/t8008-cleanup (2017-07-26) 1 commit
 - t8008: rely on rev-parse'd HEAD instead of sha1 value
* sb/t4005-modernize (Remove hard coded sha1 values.)

This presents an alternative approach in the second patch,
which just marks tests as "SHA1" required instead of making
the test hash-agnostic.

The first patch is just an aid to show which tests need
addressing, although there are some false positives (i.e.
the test fails for other reasons than the hash dependency,
such as corruption of data.)

Stefan 

Stefan Beller (2):
  alter hash function: expose test dependencies on sha1
  t6500: mark tests as SHA1 reliant

 sha1dc/sha1.c | 2 +-
 t/t6500-gc.sh | 6 +++---
 t/test-lib.sh | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.14.0.rc0.3.g6c2e499285

