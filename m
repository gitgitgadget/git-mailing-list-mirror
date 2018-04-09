Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF10E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeDIWpj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:39 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:41870 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDIWpi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:38 -0400
Received: by mail-pf0-f179.google.com with SMTP id a2so6607921pff.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36ZlpvsbaSyHTXTrzehrVIDPoXcJMcqImoDHwXHrjDE=;
        b=ETXM4yoEfqUbnN2y6UomtENn4jm2XH+gTgbN3Jejyis39+nUTJPpKLz6Oy4bIyYvC+
         Z9Uk5M27DI8fRQdxfO6udpqpqmB5pObk5x593O0dXDgmgk8qgem4V8wdvKi/8T6+6cOx
         ee5Y7CmrdxJgdRX38lkzOEAneopGHmt76sfniAEB4Lf86ZuybhWDSd4XQHIm4cjTMY6D
         0X/505B+e+ua68HTS6QhKVHouB9fubRwIXHCMtc5V/If0zer3F8tInEK2GF/UbXJHMIw
         Nnmi1AeP09QXZBBuCsDQS+PkYUUHzDkCm5XocBn0EAoVbYKKwvY+3Sp32oMxhaTHTaPP
         fnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36ZlpvsbaSyHTXTrzehrVIDPoXcJMcqImoDHwXHrjDE=;
        b=ce6WlJQaxSVYC5Xx1xHOTn+Dl2lpHKMNIfD7oe+tax+w8IDL+yhR+U+kR9UeVMnMx1
         A68fBvZgkbRoibQk2vLTHBIul5sHJ6/5gYY24SG83AbUtG6ART8bKUTtG/cgX/jtiz5I
         3lzqrmwXB3E/+XkbKbbMKLf38pUYAvCenpdgCAYiy+JcNPseakb3SyE7dcmL7EmUWM3M
         TnPMfarT3u8ijvT+A5uNq7psUC0thh32VERg4qqVKXMWrzitxtCSutKWzVNOV4Xkun6P
         F5lePYCVr3fHASklHyUtsQgSbrwbQ+UqqAFwIxnJ4Y0ToI7qFJgl5ufHlt8fcsUx9U+h
         7BCg==
X-Gm-Message-State: ALQs6tD9159rMLl4qMAT5OzYoHtDGxpsvM62uBT4oNoPb2O59ujjXwCV
        Zx+/TVODtFIGpwMb0TUFoFGkTg==
X-Google-Smtp-Source: AIpwx4//ENDHUS5RP7rr1GjPzBMhj2LChRryfmjDkHGw/Np9K56h/AkbLiNe0wVkm7/fK2s+aFtYYQ==
X-Received: by 10.167.128.2 with SMTP id j2mr638403pfi.126.1523313937544;
        Mon, 09 Apr 2018 15:45:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 73sm1970614pgg.73.2018.04.09.15.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCHv2 00/16] object-store refactoring 3 (replace objects, main ref store)
Date:   Mon,  9 Apr 2018 15:45:17 -0700
Message-Id: <20180409224533.17764-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
This applies on top of a merge of
origin/bc/object-id and origin/sb/packfiles-in-repository,
both of which are pending merge to master. It is also available at
https://github.com/stefanbeller/git/tree/object-store-3

* removed whitespaces as noted by Stolee
* incorporated Renes patch as the first patch of this series
  (It may go independently if this series takes too long)
* Adressed Erics concern regarding sloppy commit messages
  (removed #Conflict markers), typo in comment
* I did not drop the main_ from the ref store, yet, as asked by Duy.

Thanks,
Stefan

v1:
This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
(sb/packfiles-in-repository).
It is also available at https://github.com/stefanbeller/git/tree/object-store-3

This series will bring the replacement mechanism (git replace)
into the object store.

The first patches are cleaning up a bit, and patches 6-19 are converting
one function at a time using the tick-tock pattern with the #define trick.
See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
2018-03-23) for explanation.

Thanks,
Stefan

René Scharfe (1):
  replace_object: use oidmap

Stefan Beller (15):
  replace_object.c: rename to use dash in file name
  replace-object: move replace_map to object store
  object-store: move lookup_replace_object to replace-object.h
  replace-object: eliminate replace objects prepared flag
  replace-object: check_replace_refs is safe in multi repo environment
  refs: add repository argument to get_main_ref_store
  refs: add repository argument to for_each_replace_ref
  replace-object: add repository argument to prepare_replace_object
  replace-object: add repository argument to do_lookup_replace_object
  replace-object: add repository argument to lookup_replace_object
  refs: store the main ref store inside the repository struct
  refs: allow for_each_replace_ref to handle arbitrary repositories
  replace-object: allow prepare_replace_object to handle arbitrary
    repositories
  replace-object: allow do_lookup_replace_object to handle arbitrary
    repositories
  replace-object: allow lookup_replace_object to handle arbitrary
    repositories

 Makefile                  |   2 +-
 builtin/mktag.c           |   3 +-
 builtin/pack-refs.c       |   3 +-
 builtin/replace.c         |   4 +-
 cache.h                   |  19 ------
 environment.c             |   2 +-
 object-store.h            |   8 +++
 object.c                  |   3 +-
 refs.c                    |  80 +++++++++++++------------
 refs.h                    |   4 +-
 replace-object.c          |  73 +++++++++++++++++++++++
 replace-object.h          |  36 ++++++++++++
 replace_object.c          | 120 --------------------------------------
 repository.h              |   3 +
 revision.c                |   5 +-
 sha1_file.c               |   7 ++-
 streaming.c               |   3 +-
 t/helper/test-ref-store.c |   3 +-
 18 files changed, 183 insertions(+), 195 deletions(-)
 create mode 100644 replace-object.c
 create mode 100644 replace-object.h
 delete mode 100644 replace_object.c

-- 
2.17.0.484.g0c8726318c-goog

