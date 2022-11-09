Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC510C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKITep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKITen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B6225
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a5so28572969edb.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEvPe1zmyAgP0Gq7OQzQstRdlMO01XAgk0HUCY5kPME=;
        b=ImMr0An50vHleEg5BGOmUpo1Qc8l55l2P8EkLNegnHnlozvLNIII2FvKG1thJdJUED
         D/glFiSNv0wrdhga3dUZLBG39ia9EPh8wpE72Wq3qSsM02HBJDZ3jXoCuoIjyBLSP/Hp
         CZlObbaGkHS8+s9Rcx773uutxmxzjNSJeSLu/aXLip4oeeYyAt9PUCkJnWSUJiPHyZQF
         SELpfKRb7YMYCQ7NXYToPpICN90PqJwZR7ltgd+PWU5g/8/ndcONDjtbldmgKntbU3tx
         nmSv1zMgYcS4XHDAN9eqCaLKHVO7mU/oh4Z5TF+dwC9i+LTVMX9/BEuJxttQJWt1HQ8t
         FNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEvPe1zmyAgP0Gq7OQzQstRdlMO01XAgk0HUCY5kPME=;
        b=GeSH6hIrUq/4Lnk/IgwtCTszYseQ+OE+GQKbQSZWT9xyYVNiQu38LO6BGLHxIY9hWv
         /cIvTVYkeqHREK7LGPfJDE74p0vSiAMD0nO4oqQjP1+yNgn0umfMRrEEhNFHc7Feij8a
         AAtAZsasRV95uSv2NqDpowIXS+MpRz9ZkEVH/DRTIx7xtW94TQdSPnkB9VbB1KkFACQO
         iHSclZNx67PBzumkEveBkeY+uUjkcUFu4WkFlUTufhOUtv2Feo2nvLP5T7u7pc4nSYFS
         /LW2j/OSfBZ3RROYLWypcbAWuLVwz7EdBR9AG+8EQdNrsaStOrDg9yYZ9QbFoQ7gZejJ
         guxA==
X-Gm-Message-State: ACrzQf0/vr/ZfXSAsyoB0PoaBuSZ+itcig22ZLPu8p0elfWDI6aZ9f60
        D0m9uejvKzQUudExF80oasYRlRXbCMHo9Q==
X-Google-Smtp-Source: AMsMyM5BbK2iK0tBqlxorfs1pXIZHGBt53lEYBM6dKkwg2Zng//C5dmo6VeSg9pjJl0rLhPnURdW9A==
X-Received: by 2002:a05:6402:2285:b0:462:cabf:5a0a with SMTP id cw5-20020a056402228500b00462cabf5a0amr59693398edb.279.1668022480244;
        Wed, 09 Nov 2022 11:34:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Wed,  9 Nov 2022 20:34:28 +0100
Message-Id: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <20221109004708.97668-1-chooglen@google.com>
References: <20221109004708.97668-1-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An RFC alternative to Glen's [1], and what I *thought* he might be be
going for in the earlier discussion[2].

The difference is that in Glen's there's no "git --super-prefix", but
rather each set of commands still using it ("submodule--helper",
"read-tree" etc.) geit their own command-level option.

But it still works substantially the same, in that we're juggling a
global variable that we set, and read out later somewhere down the
stack.

Whereas here there's no renaming of the option, but:

 * For "submodule--helper" only the sub-commands that need it take the
   option, it's not an option to "submodule--helper" itself.

 * There's no passing of the "super_prefix" as a global, instead we
   pass it all the way along until we recurse to ourselves. For
   "submodule--helper" this is quite straightforward.

 * Then in 8/8 we're left with just "read-tree" needing the remaining
   "--super-prefix", and we likewise don't pass it as a global, but
   instead add it to the "struct unpack_trees_options", which will
   pass it all the way down into unpack-trees.c and entry.c, until
   we're going to recursively invoke another "read-tree".

This is on top of my "ab/submodule-helper-prep-only" which is now in
"next", and can make use of (but doesn't need) the better test
coverage for "absorbgitdirs" that I submitted in [3].

A non-RFC version of this should really steal Glen's tests, in
particular the "partial clone" one from [4]. That test passes with
this series.

1. https://lore.kernel.org/git/20221109004708.97668-1-chooglen@google.com/
2. https://lore.kernel.org/git/kl6l8rkqy7no.fsf@chooglen-macbookpro.roam.corp.google.com/
3. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
4. https://lore.kernel.org/git/20221109004708.97668-4-chooglen@google.com/.

Ævar Arnfjörð Bjarmason (8):
  submodule--helper: don't use global --super-prefix in "absorbgitdirs"
  submodule--helper: "deinit" has never used "--super-prefix"
  submodule--helper: convert "foreach" to its own "--super-prefix"
  submodule--helper: convert "sync" to its own "--super-prefix"
  submodule--helper: convert "status" to its own "--super-prefix"
  submodule--helper: convert "{update,clone}" to their own
    "--super-prefix"
  submodule tests: test "git branch -t" output and stderr
  read-tree: add "--super-prefix" option, eliminate global

 Documentation/git.txt       |  8 +--
 builtin.h                   |  4 --
 builtin/checkout.c          |  2 +-
 builtin/read-tree.c         |  1 +
 builtin/submodule--helper.c | 95 ++++++++++++++++++++---------------
 cache.h                     |  2 -
 entry.c                     | 12 ++---
 entry.h                     |  6 ++-
 environment.c               | 13 -----
 git.c                       | 37 ++------------
 parse-options.h             |  4 ++
 submodule.c                 | 47 ++++++++----------
 submodule.h                 | 12 +++--
 t/lib-submodule-update.sh   | 98 +++++++++++++++++++++----------------
 t/t1001-read-tree-m-2way.sh |  2 +-
 unpack-trees.c              | 23 +++++----
 unpack-trees.h              |  1 +
 17 files changed, 177 insertions(+), 190 deletions(-)

-- 
2.38.0.1467.g709fbdff1a9

