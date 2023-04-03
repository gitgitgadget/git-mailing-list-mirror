Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F481C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjDCWdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjDCWdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3974200
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so30933065wrd.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMwWF/1wE9/qgTdQDSrGvNed933CwygexmVlukD2wY4=;
        b=QZBiH3pjd3MSfTtvS+GpPC0yfutoeYHl1mza/50bxsxM6ogeX60tzr48gvpTutfyYz
         ZWL8yozAr5f5QaKyQOr76jcvu3KZkTxb2EBzbRL7e047Xi/HWTNUFZRVlMkryPBoOMU/
         sF/c+AELDy7FItvfIgP5Xq1lwON3Kp1GtO/RIBMkcpRrxrq/X3PVXAHIH/B2/KG5RDOP
         NRi2/MdGcdcuFBgUCdq/4CrtKI+NUkTLZWxRzP54+WHtxVdgWhnd1wX1jy3YwKaW/apC
         heBj0NK9XBm+/qI5w8XlEzvv9/UkYFwMyzM/NohjFsL1r8j2qwFxNhyHaY1koWUy+WRi
         SY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMwWF/1wE9/qgTdQDSrGvNed933CwygexmVlukD2wY4=;
        b=WQLaUkaZ7TK2Z5jnymt5YYjbUUhLNjxCOCOUAuXGklHIzcoJ85lQxEfpSBPgL+nYI8
         vd8d4dm8fvJ7Nn0WT2gK+I+idC3Lb0RpiioDedngkHI4+X0ahqoo6ltPQB+uSj16SHdD
         3vDj0vKBUEESvrXdFUERPRPcRTaSLxgDuMndXYlTv1BUGRlEXBLGzpIb2GxinX+c8mD7
         O1nvdrY3CorJq8Qw/rNRXiAF0TmBrEHhJ2peQxIYfAXwk4jcv0VLbC0A0Q2BEis9JVKF
         vL9YhfaLRmY3HbC0vC5V37pJWnqZrwurLOpOpzfQwQepQD0DBEB+bD1KvpsYP7qEVTq4
         J7Jw==
X-Gm-Message-State: AAQBX9e9/JdDaXgRgA2JnePxa9cQmJaf+aJ6Uhb4vS5nLv/DH7HL8KfI
        uHRfMOqf+r8iYZPg446wClQdDxouaDVBok1jUv0=
X-Google-Smtp-Source: AKy350Y7mLi3njiJLfFGVhU2iNJ/now+YTCii/6N4hMqw8SL27s4KTMdPrLLceUAqv8IlX9KpfpD2A==
X-Received: by 2002:a5d:48c6:0:b0:2d8:81a9:4d75 with SMTP id p6-20020a5d48c6000000b002d881a94d75mr67837wrs.32.1680561220998;
        Mon, 03 Apr 2023 15:33:40 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:40 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] t: fix unused files, part 2
Date:   Tue,  4 Apr 2023 00:33:32 +0200
Message-Id: <20230403223338.468025-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Creation of files from redirecting output of Git commands in tests has been
removed for files which aren't being used for assertions.  CC'ed are authors of
the affected tests.

v1 cover letter:
  https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.com/

Thanks to Eric Sunshine for reviewing v1.

Changes since v1:

  - Fixed typo in commit message of 1/6 found by Eric Sunshine

Range diff:

1:  516cc3fe83 ! 1:  828bb18bd7 t0300: don't create unused file
    @@ Commit message
         t0300: don't create unused file

         Test 'credential config with partial URLs' in t0300-credentials.sh
    -    contaisn three "git credential fill" invocations.  For two of the
    +    contains three "git credential fill" invocations.  For two of the
         invocations, the test asserts presence or absence of string "yep" in the
         standard output.  For the third test it checks for an error message in
         standard error.
2:  9282c9bb07 = 2:  a5b299a0c6 t1300: fix config file syntax error descriptions
3:  df0ec7ebf9 = 3:  806df16415 t1300: don't create unused files
4:  408e971b43 = 4:  6742c957e5 t1450: don't create unused files
5:  8464d0f435 = 5:  6c173a5c46 t1502: don't create unused files
6:  de2b5339d7 = 6:  d508c1def3 t2019: don't create unused files

Andrei Rybak (6):
  t0300: don't create unused file
  t1300: fix config file syntax error descriptions
  t1300: don't create unused files
  t1450: don't create unused files
  t1502: don't create unused files
  t2019: don't create unused files

 t/t0300-credentials.sh            |  2 +-
 t/t1300-config.sh                 | 10 +++++-----
 t/t1450-fsck.sh                   |  5 +----
 t/t1502-rev-parse-parseopt.sh     |  6 +++---
 t/t2019-checkout-ambiguous-ref.sh |  4 ++--
 5 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.40.0

