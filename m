Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A293F1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbdFTBDX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:23 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33239 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTBDW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:22 -0400
Received: by mail-pf0-f177.google.com with SMTP id 83so61666967pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrH53LyNN7wH5lmruOQJ1O8eWZ+d5oxAC8v/0hUj8ks=;
        b=mI+YjZ7ZgMZrX4Dz7z31NsuA35XV+IppeLFhwULG8B8PzjHUGBm5NwrdtpcxaJHDQr
         cdu+GAGFmPCSkvgp8idzhLa/x3/EM4tSBfJhiygDnR8nTsXKiVd+AzQoGIw1JqlEv3b5
         ubQZEFx6m/5SZpXWzQdN3pGAwDA2byEr8lX/IfUgxa6kSe1zdA8KVigmt9FONRRn+Xdk
         /f787oGKLQb37DlR71SJSA7jqE19M1Ye9TFlW+wl5oTJzsp8t9Kn6GzIQLjgWu0O4uCa
         whnNpF+3tKVBSLf9qFW0X3s/NtxaQhg/tmejXWxZzKLIcCjXG7z7A1gMhtiIp9EmTMB+
         vLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrH53LyNN7wH5lmruOQJ1O8eWZ+d5oxAC8v/0hUj8ks=;
        b=ccdINUcdhN8tVVV++WyQIhph7UobN3oVAWEDl3wkciUR9kUAHBNPFaAsqbBWEf1kl0
         wUBz3l5bmZuovMTEjOoI5kSOdeG+NibQOYyqPop3lbehU33xDdmzxFsF6Ngm6YNGlree
         3QLV1TUYjbrUjn2uAgwStdetnJH44tjYkKI7UXlL4Bj+E+yyh0rImflze1IZzH/+mIKH
         zU7R/a5wNzD8SaVjMh2AjP3cXXTvM9+l7IAHHpnpRfHfd/RYs7Sz4UxlLuuCQRmQF2+C
         6KGLb6j9CrTelvrTSLDbh/yjNbQTAzX1OGhB88YRGyf5EqUwePLpIW/CECLVcuVjtcPJ
         YlwA==
X-Gm-Message-State: AKS2vOw832cbOltIwpEvhSDVMArqcfJf/dLM1Ezdf+lFLgVdvec4TdJB
        SMninE9xI+j+SzznakKqxg==
X-Received: by 10.98.130.3 with SMTP id w3mr28229321pfd.128.1497920600865;
        Mon, 19 Jun 2017 18:03:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:19 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 0/8] Improvements to sha1_file
Date:   Mon, 19 Jun 2017 18:03:07 -0700
Message-Id: <cover.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff and Junio for your comments. Here's an updated version and
some replies to comments.

> I also found this quite subtle. However, I don't think that
> has_sha1_file() actually freshens. It's a bit confusing because
> has_loose_object() reuses the check_and_freshen() function to do the
> lookup, but it actually sets the "freshen" flag to false.
> 
> That's why in 33d4221c7 (write_sha1_file: freshen existing objects,
> 2014-10-15), which introduced the freshening functions and converted
> has_loose_object(), the actual write_sha1_file() function switched to
> using the freshening functions directly (and obviously sets the freshen
> parameter to true).

Good catch.

> I actually think all of that infrastructure could become part of
> Jonathan's consolidated lookup, too. We would just need:
> 
>   1. A QUICK flag to avoid re-reading objects/pack when we don't find
>      anything (which it looks like he already has).
> 
>   2. A FRESHEN flag to update the mtime of any item that we do find.
> 
> I suspect we may also need something like ONLY_LOOSE and ONLY_NONLOCAL
> to meet all the callers (e.g., has_loose_object_nonlocal). Those should
> be easy to implement, I'd think.

For things like FRESHEN, ONLY_LOOSE, and ONLY_NONLOCAL, I was thinking
that I would like to restrict these patches to only handle the cases
that are agnostic to the type of storage (in preparation for missing
blob handling patches).

> I had the same thoughts (both on the name and the "vocabularies"). IMHO
> we should consider allocating the bits from the same set. There's only
> one HAS_SHA1 flag, and it has an exact match in OBJECT_INFO_QUICK.

Agreed - in this patch set, I have also consolidated the relevant flags,
including LOOKUP_REPLACE_OBJECT and LOOKUP_UNKNOWN_OBJECT.

In addition, Junio has mentioned the potential confusion in behavior
between a NULL and an empty struct passed to
sha1_object_info_extended(). In this patch set, I require non-NULL, and
have added an optimization that avoids accessing the pack in certain
situations, but this optimization requires checking a lot of fields. Let
me know what you think.

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
 cache.h              |  37 +++--
 sha1_file.c          | 391 ++++++++++++++++++++++++++-------------------------
 streaming.c          |   1 +
 6 files changed, 228 insertions(+), 221 deletions(-)

-- 
2.13.1.611.g7e3b11ae1-goog

