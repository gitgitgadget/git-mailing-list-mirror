Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389CA20401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdFVAkb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:31 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34863 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFVAka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:30 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so883328pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WxeHiWxnG6g57MxkZ0xIUt4ZFDmZ5KspsVljh7YX/GE=;
        b=VmsWUsxBIUTZ5j3GL0nLtW/opf4ANZHleHtYlEFGWBkYySQamaEJXK1sV1AIppiN60
         osv44zn2yITLzbcmfQO3fAOqVdybh1Tg/I3MGKqVqt4gpXOKb93mD11bMdypCrqHjW68
         esF1z7wNcSB6/ikPtIN5WlfPkApMcpnYoIPLePlTt0AMTf0Z6uKJtnwGDrFn9d3ihSVE
         GsrLRi9gEA1EuRPVDM11JoJeUWO/aVM2/RJssV1GNz5yMRwXeWYd42sR06i9/N/B0NcV
         FL3TSQmk0z8eJaRZ6U530JOnuE49Syx0YrJGMzm4OJBde9CDNr6Locp5mdMdms7mSh6x
         +XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WxeHiWxnG6g57MxkZ0xIUt4ZFDmZ5KspsVljh7YX/GE=;
        b=JkrCLKquCq+agY8+6T+i2mIFfwuMiuq5OULvOdbN74uyPHBm3Uzw7HOvFiz5rPHa3U
         0wsAjYBJLwE3JZRQMewbV8UE5B3CgC2OlIWtnt8GN43PP+MJZXcfh/w6T71eUiAogLoS
         dv7lCvIcnOgp5BLIR6n8Ry9huuGX2ZsOXH4u+G5T6B9m7efZfYjVBFI04JtDLIECiUmu
         Yrbn3Rpth0D4DiSqsVObLpTRGp+SCjtzRTyv5PeqSb6/wdVu2lnsHDBchywPcRWxVv4j
         HljXNyfDGGUgxJxCH/Fu8ZB6R7XwTYNr4aA5RBGwKA7kV8ef183fFyiBH7n7NkKIPoNo
         k93A==
X-Gm-Message-State: AKS2vOySB+L1h9f2RNNnGVrgsZvc635rs0MA6wRf6KGjX81G8d+50LUg
        2cAE/IXmZHxrIIWkP5M8mg==
X-Received: by 10.98.210.199 with SMTP id c190mr39729361pfg.157.1498092029588;
        Wed, 21 Jun 2017 17:40:29 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 0/8] Improvements to sha1_file
Date:   Wed, 21 Jun 2017 17:40:16 -0700
Message-Id: <cover.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio. A reply to your comment on patch 7:

> ... this "if" statement feels like a maintenance nightmare.  The
> intent of the guard, I think, is "when the call wants absolutely
> nothing but whence", but the implementation of the guard will not
> stay true to the intent whenever somebody adds a new field to oi.
> 
> I wonder if it makes more sense to have a new field "whence_only",
> which is set only by such a specialized caller, which this guard
> checks (and no other fields).

After some more thought, I think I came up with a better solution -
allow sha1_object_info_extended() to take a NULL struct object_info
pointer, and immediately assign it (if NULL) a blank struct, but use the
NULL-ness as an indication that we can skip accessing the packfile. The
last patch actually doesn't even need the "whence", so we can do this.

Changes from v4:
 - patch 2
   - Updated commit message to explain why
     OBJECT_INFO_ALLOW_UNKNOWN_TYPE is defined to be 2, not 1.
 - patch 3
   - Made all invocations of sha1_object_info_extended() compare "< 0".
 - patch 5
   - Made all invocations of sha1_object_info_extended() compare "< 0".
 - patch 7
   - Rewrote patch to make sha1_object_info_extended() accept NULL
     struct object_info pointer.
 - patch 8
   - Made has_sha1_file_with_flags send NULL instead of blank struct
     object_info.

Jonathan Tan (8):
  sha1_file: teach packed_object_info about typename
  sha1_file: rename LOOKUP_UNKNOWN_OBJECT
  sha1_file: rename LOOKUP_REPLACE_OBJECT
  sha1_file: move delta base cache code up
  sha1_file: refactor read_object
  sha1_file: improve sha1_object_info_extended
  sha1_file: do not access pack if unneeded
  sha1_file: refactor has_sha1_file_with_flags

 builtin/cat-file.c   |   7 +-
 builtin/fetch.c      |  10 +-
 builtin/index-pack.c |   3 +-
 cache.h              |  36 +++--
 sha1_file.c          | 385 ++++++++++++++++++++++++++-------------------------
 5 files changed, 224 insertions(+), 217 deletions(-)

-- 
2.13.1.611.g7e3b11ae1-goog

