Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F1E7B618
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbjJDNSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjJDNSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:18:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867798
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:18:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27751ac0653so1459682a91.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425497; x=1697030297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjBJ2xRzI6BM/ev4KeFSjAZOc1XV1RKLtC3W07ufb4g=;
        b=nnKZWm6ZSdDfyaynPInT2/EiYofNmF8JqU8U5VP9Hney1402ilBo1sSua6kUe5bS3F
         jYQzeTkJfzrSQFzQ0M1KzN47SS0hvl7nKO0JMDjfd2dafRe6KvFr3TBnSRL+SP2fBx5n
         6H8W2x6uwLRxwip3A9fgqzhgoG30WKrzHo8PwkU5NtB6oFaRX9HMiB/Pse5k3NERH9Ev
         /6YxJwylC1+SuO/A4Ve/qr0c8qQeBLMa/5MdPNFGrX3Kcd2ZMzbGXSdAolA8GgFc7urI
         Ms3ZW9T/2tqOTD6o/l6YqP3wSHOZiSpUPxpQN/jOkB4XaOgimRyf6syYqh7wzsDRUV9p
         1nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425497; x=1697030297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjBJ2xRzI6BM/ev4KeFSjAZOc1XV1RKLtC3W07ufb4g=;
        b=WLUIfrYnxSXWy/TQUHh82u+U2Uoqjdejz6WpAClwVZLvNO4LxbNBHULFVWt/TpFFJC
         ZxpB/pr85TZeY61Li4c5KnTz7TdcQiKXuxppbb2YHm0T/PUl/k2hZXO7RfisBGoPN0J3
         WAmVatpVCJB1EJDCDzLGETylviww+UI6PB1HddodZ1TgnxnxgAuRo5gA9YKF4jrCScTo
         akEeIZ4FcMfru7cDIagf6tBJCmyYmlKmcDmH1EzlEbapSsY9VAkX2ThPvnGWjZ6SC17C
         V9FYVvkRMqWa7XMcV53jaXIx+jKeJM4zpONCX0h7kOWYFNXvXkM4wS31XEs55faxmDNz
         raQQ==
X-Gm-Message-State: AOJu0YxeJ3Jy6KkhgdXnoD+vfdfzXpgwbyAWfhaRqzC6UAZyGZssIGUo
        YGSfNxPiubDKRQ5dlB1KY6PEF21zjuc=
X-Google-Smtp-Source: AGHT+IFy8DwkjTfltFpBCDQww/9rrQfJuPyuqP9rR5d+by/DaUQp+nHrcy09tAbOPOk2sybgko6+BQ==
X-Received: by 2002:a17:90b:f8b:b0:274:6f67:e7a8 with SMTP id ft11-20020a17090b0f8b00b002746f67e7a8mr2048431pjb.45.1696425497389;
        Wed, 04 Oct 2023 06:18:17 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00260a5ecd273sm1465496pjf.1.2023.10.04.06.18.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:18:16 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/3] Sideband demultiplexer fixes
Date:   Wed,  4 Oct 2023 21:18:11 +0800
Message-Id: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <ZRKax7Me5uIHKHoC@ugly>
References: <ZRKax7Me5uIHKHoC@ugly>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Sideband demultiplexer fixes.

Range-diff v2...v3

1:  fd6d61893d ! 1:  68ac3ea711 pkt-line: do not chomp newlines for sideband messages
    @@ Commit message
         to prevent mangling newline characters in sideband messages.
     
         Helped-by: Jonathan Tan <jonathantanmy@google.com>
    +    Helped-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## pkt-line.c ##
    @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
     +				len--;
     +				break;
     +			case 2:
    -+				/* fallthrough */
     +			case 3:
     +				/*
     +				 * Do not chomp newline for progress and error

---

Jiang Xin (3):
  test-pkt-line: add option parser for unpack-sideband
  pkt-line: memorize sideband fragment in reader
  pkt-line: do not chomp newlines for sideband messages

 pkt-line.c               | 36 +++++++++++++++++++++----
 pkt-line.h               |  4 +++
 t/helper/test-pkt-line.c | 58 ++++++++++++++++++++++++++++++++++++----
 t/t0070-fundamental.sh   | 58 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 10 deletions(-)

-- 
2.40.1.50.gf560bcc116.dirty

