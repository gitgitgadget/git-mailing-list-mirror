Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEDC1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdGaVC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:02:56 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33117 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdGaVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:02:55 -0400
Received: by mail-pf0-f180.google.com with SMTP id d67so57638798pfc.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DYnb/dQpSRnoMvsF208n3qFM3OMl+v98c2JM8TJUqlo=;
        b=eXXoE+fsrgvel62oq9BwROZIkTR1DvbeOSmnd9o37yQNe2Asfy5Py6unOXM+JWZHh9
         AVe837V2SoFmf9WLjcaSYaylr5TjgWgyUrCtM8gXHCrXsfw2Awi/SFYigv95WZwEpLaK
         qGDylN9AfUAzwJmkRhRdpPUpxUEEKwKPwKauWKB1psoecOelNNjJQLOxwum2gx6vkzhA
         SGBfaBRRSVdZPAk2sAV3FBzREqECTu3YhjnVld5/d9OphXIqHylmKp6cj9pKC246sbGP
         Ph8i5WrTgpOgerGhUerMUl0YKNVdr2auuZQ4ldVSfXBjHxzCtJE3tQC/ih48QC5EWqn7
         c5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYnb/dQpSRnoMvsF208n3qFM3OMl+v98c2JM8TJUqlo=;
        b=mQCKoSdTyTX1q+YXpkWZdKJFi5qrVxwlsJuqi/7be6a4oaezBwK0kCNL4nOH9MUZzI
         Voxd5slHh7L97jebj9mPLFSdGKDgUUrBaaIFnLjLzZBt3ObCSSTMVZ9DI7MSo64R/7Qe
         Heck42SxQIJXTqnZ0NgUoLvJt6yo4PUea3JhTMXbS/XFYA9r7ya10ltX2JiGR3y89hdG
         nNy3wSJupXmAuov6/icB0M8Pn/tqMxugujIqp6qNFPxYiQ2yEyeRzFstJaPNnT2x3utq
         TVo2SjYowxDluLJoECMSaEUBrjvO4ryxgTBuXETRlIr92T5qru4hiZXOWXYyNbA/L9vP
         8xdg==
X-Gm-Message-State: AIVw110DnWLOs4mCgTDB/m5M2llB7mEDpDbKQS9/XDcW+/fppZvNdkGg
        riDQ/D+Lk7tX84FajP1KCQ==
X-Received: by 10.99.97.144 with SMTP id v138mr16832786pgb.117.1501534973957;
        Mon, 31 Jul 2017 14:02:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:02:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
Date:   Mon, 31 Jul 2017 14:02:42 -0700
Message-Id: <cover.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides review changes, this patch set now includes my rewritten
lazy-loading sha1_file patch, so you can now do this (excerpted from one
of the tests):

    test_create_repo server
    test_commit -C server 1 1.t abcdefgh
    HASH=$(git hash-object server/1.t)
    
    test_create_repo client
    test_must_fail git -C client cat-file -p "$HASH"
    git -C client config core.repositoryformatversion 1
    git -C client config extensions.lazyobject \
        "\"$TEST_DIRECTORY/t0410/lazy-object\" \"$(pwd)/server/.git\""
    git -C client cat-file -p "$HASH"

with fsck still working. Also, there is no need for a list of promised
blobs, and the long-running process protocol is being used.

Changes from v1:
 - added last patch that supports lazy loading
 - clarified documentation in "introduce lazyobject extension" patch
   (following Junio's comments [1])

As listed in the changes above, I have rewritten my lazy-loading
sha1_file patch to no longer use the list of promises. Also, I have
added documentation about the protocol used to (hopefully) the
appropriate places.

This is a minimal implementation, hopefully enough of a foundation to be
built upon. In particular, I haven't added the environment variable to
suppress lazy loading, and the lazy loading protocol only supports one
object at a time.

Other work
----------

This differs slightly from Ben Peart's patch [2] in that the
lazy-loading functionality is provided through a configured shell
command instead of a hook shell script. I envision commands like "git
clone", in the future, needing to pre-configure lazy loading, and I
think that it will be less surprising to the user if "git clone" wrote a
default configuration instead of a default hook.

This also differs from Christian Couder's patch set [3] that implement a
larger-scale object database, in that (i) my patch set does not support
putting objects into external databases, and (ii) my patch set requires
the lazy loader to make the objects available in the local repo, instead
of allowing the objects to only be stored in the external database.

[1] https://public-inbox.org/git/xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/20170714132651.170708-2-benpeart@microsoft.com/
[3] https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/

Jonathan Tan (5):
  environment, fsck: introduce lazyobject extension
  fsck: support refs pointing to lazy objects
  fsck: support referenced lazy objects
  fsck: support lazy objects as CLI argument
  sha1_file: support loading lazy objects

 Documentation/Makefile                             |   1 +
 Documentation/gitattributes.txt                    |  54 ++--------
 Documentation/gitrepository-layout.txt             |   3 +
 .../technical/long-running-process-protocol.txt    |  50 +++++++++
 Documentation/technical/repository-version.txt     |  23 +++++
 Makefile                                           |   1 +
 builtin/cat-file.c                                 |   2 +
 builtin/fsck.c                                     |  25 ++++-
 cache.h                                            |   4 +
 environment.c                                      |   1 +
 lazy-object.c                                      |  80 +++++++++++++++
 lazy-object.h                                      |  12 +++
 object.c                                           |   7 ++
 object.h                                           |  13 +++
 setup.c                                            |   7 +-
 sha1_file.c                                        |  44 +++++---
 t/t0410-lazy-object.sh                             | 113 +++++++++++++++++++++
 t/t0410/lazy-object                                | 102 +++++++++++++++++++
 18 files changed, 478 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/technical/long-running-process-protocol.txt
 create mode 100644 lazy-object.c
 create mode 100644 lazy-object.h
 create mode 100755 t/t0410-lazy-object.sh
 create mode 100755 t/t0410/lazy-object

-- 
2.14.0.rc1.383.gd1ce394fe2-goog

