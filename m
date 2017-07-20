Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606FF20288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932973AbdGTAVx (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:21:53 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33178 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdGTAVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:21:53 -0400
Received: by mail-pg0-f47.google.com with SMTP id k14so7001646pgr.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0yxZushqSQiwhOYdjoDZNvXmM6Vn/nNL5SLDbFyYMMM=;
        b=TplSnNHi3z5NwscN2lpoW/YYZZyV10m/A/Et9M1AlYycD34HdsGZLN6ztWeWAo6Abj
         Tzk3xeNgqrAHVCMO0GIloyiLaTKECf1cXBMqm19VHF4M7DsJvkYz4Wj5NTV/VU4j6MYW
         LBJh3EPTiUNduNk3QK6JHus+j9VUjkMaoq2ve7wMYzIMe9N0clpBbUvYps8EHhZ2VtO6
         oZNxOK17h3Z8F2A596kUROwVHt+w7T9NU20agRJ42anbkpNzNfVIemjFyf3MGxG6iyXe
         U+8KsLH/LAu74TPnTSLIgFxeR078nkH5GumVHcQfkOZCLWRc+T0XWck1c+FdCIHWmOcI
         JvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0yxZushqSQiwhOYdjoDZNvXmM6Vn/nNL5SLDbFyYMMM=;
        b=VOFF8qCgmEWpW+wkl551vMU+khFp3/Tol4kd7b/S/4uoS7kpHb4CTFHaEmsSl9kz1p
         e7zMB0kEUuDr2elk7zIQu8FQ4VG6yIw2IngOfheNLhYhZMzh2/h91mS2sg15iOjnK90q
         e7xxIaJPo3umgoBkaweeSzLVxKm3hO7nMdCukamKhX7m/fgJjfw9P2ooZ6p16ThaAQiO
         nb12yn7O9QaB5UmmXHx23q+Nl+7EY7JFyE4z32O3jS8HcXRQ2lw5PZlUaKYxJKl8yWFq
         QebxVdENZ1We5pFKlUYtIoO4hSWtM6JHf9OqY5YQvRFNZ0/nsQNamDNagq5fXNVmeKO/
         yq/Q==
X-Gm-Message-State: AIVw113poP3NAn4/38IuNDk6Wh3athsb0IF2cUwL8zCS7aS5bDOX+aqB
        oqfUdwBIIGTViTedQC6fcA==
X-Received: by 10.99.125.11 with SMTP id y11mr1880610pgc.19.1500510111897;
        Wed, 19 Jul 2017 17:21:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id n129sm1285891pfn.27.2017.07.19.17.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 17:21:50 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, git@jeffhostetler.com, peartben@gmail.com,
        philipoakley@iee.org
Subject: [RFC PATCH v2 0/4] Partial clone: promised objects (not only blobs)
Date:   Wed, 19 Jul 2017 17:21:43 -0700
Message-Id: <cover.1500508695.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa4-goog
In-Reply-To: <cover.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all your comments on the earlier version. This is a
substantially different version. In particular:
 - Now supports all types (tag, commit, tree) of objects, not only blobs
 - fsck works
 - Incorporates Ben Peart's code that uses a long-living process
   (lifetime of the Git invocation) to obtain objects
 - Implemented as a repository extension

If anyone would like to comment on the overall direction of this
approach, that would be great. In particular, I'm not too sure on the
names of things. I know that I have some things to still work on
(documentation and coding style, more improvements to and tests for
fsck, maybe division of commits?) but I would like some early feedback
on the bigger picture first.

If you want to patch this in, this is built off my recent cleanup patch
[1].

About inability to scale if we have the list of promised blobs: In this
design, we will have a promised blob entry only if we have a concrete
tree, so in a repository in which many trees are omitted, there will not
be many promised blob entry objects. In fact, the minimal partial clone
will be one in which there will be one promised commit for each ref
(assuming no duplicates), no promised trees, and no promised blobs.
(I'm not planning to implement such a clone, but someone else could do
so.)

About having multiple promise lists: I have retained the single list,
but am still open to change. The support of all the object types might
be sufficient mitigation for the issues that caused us to investigate
multiple promise lists in the first place.

[1] https://public-inbox.org/git/20170718222848.1453-1-jonathantanmy@google.com/

Jonathan Tan (4):
  object: remove "used" field from struct object
  promised-object, fsck: introduce promised objects
  sha1-array: support appending unsigned char hash
  sha1_file: support promised object hook

 Documentation/config.txt                         |   8 +
 Documentation/gitrepository-layout.txt           |   8 +
 Documentation/technical/read-object-protocol.txt | 102 +++++++
 Documentation/technical/repository-version.txt   |   6 +
 Makefile                                         |   1 +
 builtin/cat-file.c                               |   9 +
 builtin/fsck.c                                   |  42 ++-
 cache.h                                          |   4 +
 environment.c                                    |   1 +
 fsck.c                                           |   6 +-
 object.c                                         |  21 +-
 object.h                                         |  21 +-
 promised-object.c                                | 324 +++++++++++++++++++++++
 promised-object.h                                |  34 +++
 setup.c                                          |   7 +-
 sha1-array.c                                     |   7 +
 sha1-array.h                                     |   1 +
 sha1_file.c                                      |  44 ++-
 t/t3907-promised-object.sh                       |  73 +++++
 t/t3907/read-object                              | 114 ++++++++
 t/test-lib-functions.sh                          |   6 +
 21 files changed, 808 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/technical/read-object-protocol.txt
 create mode 100644 promised-object.c
 create mode 100644 promised-object.h
 create mode 100755 t/t3907-promised-object.sh
 create mode 100755 t/t3907/read-object

-- 
2.14.0.rc0.284.gd933b75aa4-goog

