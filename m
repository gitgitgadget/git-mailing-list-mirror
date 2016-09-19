Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBE52070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbcISVJC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:09:02 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34452 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbcISVJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:09:01 -0400
Received: by mail-pa0-f44.google.com with SMTP id wk8so52187640pab.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Os8EEfwWkL+vLk+sy4mxgcwkdep1maEPwCjKbOdSbd0=;
        b=RG6KTsVCTD9sQKM1RugWGWIG8Gais4gQG2AIwxOjuvQpPaW+hlA0uYddYi5JUWCNGD
         V+uezqpvrW82RO0ilaOOUlEiMmX6MAQ4+Va+eEx/rWuZQeGjclzpQAFDlwre8rxm7lCm
         ceLFtEJtrIJ/mvHt2wKwtZ0xmr57siwR9drlGXFrPU11rMqynzMyOqoZJA2ZmB7s/Bkw
         cXrX25l2nPLFPrFnsRVr6qVQdg2q4KJLYBVSeZ/md0TMnJKJs7FBFAq20Gu9/XBe7r59
         5UXvgyFlyrvREH5vGOsWjf2BAsNB64Jw45XhfhQ1aUNtu9WTKeI+OmEvWZgwyyTUpfr5
         s3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Os8EEfwWkL+vLk+sy4mxgcwkdep1maEPwCjKbOdSbd0=;
        b=FAJv5GxdZ6bD0/DNgDsnA3+brWAGzsoebUDKT6wCST3Bw3m/mm3ZS49EByiVqRhHTB
         p56qZKNUqea7T1Be3qpg52zWS4k080XV9eGtu3plebyMa0ngh9IMpV6ujKYkiGPrnHuT
         5NDxMEeJYp5VqP9jYidQxOtaOw5hEVRzn14dcDu+semwJ5XTWy2NvFAcjaRzynx5saXe
         kZzxPcOZjFlAKh0f0BFAKWun+HIkFBjhJoHOdYeFz1YFcMmYtVRkMwFQ8imsn9vSgx2K
         61gC5z4WZr4TcFpJRN0HGHG5VuDI1aGztI3UjkdNfusnHhGnTOHQ6k+EUUlCNx9gFamb
         q2aQ==
X-Gm-Message-State: AE9vXwMyTDceO/s7Mx4ZlJE9OhPYs6V3UkVM95UBnsXgFlYk6ZMgHYWQ/FYI7E7yBE1CO22L
X-Received: by 10.67.8.41 with SMTP id dh9mr49850658pad.132.1474319340730;
        Mon, 19 Sep 2016 14:09:00 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id q14sm54484171pfg.63.2016.09.19.14.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:08:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 0/4] handle multiline in-body headers
Date:   Mon, 19 Sep 2016 14:08:49 -0700
Message-Id: <cover.1474319086.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an iteration of the patch set after the discussion in
 <cover.1474047135.git.jonathantanmy@google.com>.

Changes:
o largely rewritten to follow Junio's suggested design (refactor of
  check_header to separate out ">From" and "[PATCH]", and an
  is_inbody_header function performing an airtight check on whether a
  line is an in-body header)
o simpler try_convert_to_utf8 API
o one file of the expected output of t/t5100/*0015 is modified (instead
  of the input)
o t/t5100/*0018--no-inbody-headers test files added
o example in commit message improved following Peff's suggestion

Jonathan Tan (4):
  mailinfo: separate in-body header processing
  mailinfo: refactor to support utf8 decode attempts
  mailinfo: make is_scissors_line take plain char *
  mailinfo: handle in-body header continuations

 mailinfo.c                           | 164 ++++++++++++++++++++++++++---------
 mailinfo.h                           |   1 +
 t/t4150-am.sh                        |  23 +++++
 t/t5100-mailinfo.sh                  |   2 +-
 t/t5100/info0018                     |   5 ++
 t/t5100/info0018--no-inbody-headers  |   5 ++
 t/t5100/msg0015                      |   2 -
 t/t5100/msg0018                      |   2 +
 t/t5100/msg0018--no-inbody-headers   |   8 ++
 t/t5100/patch0018                    |   6 ++
 t/t5100/patch0018--no-inbody-headers |   6 ++
 t/t5100/sample.mbox                  |  19 ++++
 12 files changed, 198 insertions(+), 45 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/info0018--no-inbody-headers
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/msg0018--no-inbody-headers
 create mode 100644 t/t5100/patch0018
 create mode 100644 t/t5100/patch0018--no-inbody-headers

-- 
2.10.0.rc2.20.g5b18e70

