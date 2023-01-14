Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7163AC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjANIat (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjANIar (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:30:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707B59F1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:30:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u9so57348911ejo.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCqoAoi3fHVBTU1HuqHmkIvCL38FxsFbhbg1wztVb94=;
        b=HaCMS2zvo1C2UIB+QMPKgzO5GfGT3PzJBVIV52Xl+iMaMAJ/npE1IQXeW5bPEIaRWK
         WmekOImZlgC/TntnRiCa2MezPEbn4rWfRqCOi3X+cUNkCBX8pyPRfMDATR8KdKXQzkuw
         OnEtKwuz+Np1twUoxd0IViVBEafVv55Z+jSrhwDgQFTu6lFy6ISpx+G/Dcb3I4Km/6Rx
         0lknbs0arTGBsOQJKeclqe/I5CW9zb3Ynd/q+X+NIVS+ZDiIOrFrfyl5xFScnAcC5dcd
         agsXu+RVIB+neJdgSaR21rHJZYBaBlZ9dxC1haQLAosdBKhBHFcVn5htJztgT9D2UijD
         vuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCqoAoi3fHVBTU1HuqHmkIvCL38FxsFbhbg1wztVb94=;
        b=QI4Dmqoqt7KWYaZnwL0uvqtsWKD/m1TnQX12Xg51sos1YOYcRg1FSI7aG+a+SJ151H
         woh59RS813dr47MXqm28AisD9kUAhXxAaVJNWvfP95u8pCGK4VSVASko/QaYLECVoSJY
         upbNuuZspLo3Mns9X2mF8ZhkZgufMSNUWdJeGKdgeyQeOOD/18HyeGoKdqIwSRjzvqQk
         UNvq4H2YxZqx8+Z7JEjI+nNIKbFk+BI5JKRiNs9kqxtvnboXMPnyz00BBea/4xykbW7G
         lYdyML1s2sMvjLG1Y3+Hxv2vQ310gAmzUj5b/MnR6Sajc0YYaaugQ2f6o03Uas9OLrZE
         ClJg==
X-Gm-Message-State: AFqh2krkBhyIAFbAqEEx1v2i8Nd08Z1YXSXK4NjMElGU/OrdBkhvJLDy
        H8MM2b3xmdJBjmh+yNknthRKqRxnvV8=
X-Google-Smtp-Source: AMrXdXuwoO8ySpIkk1OHtD5/kVRC7GipDJLPVdNdOX1ovUW1++RE79IkBPy5T/2l6FhNell9pfFcdg==
X-Received: by 2002:a17:906:854:b0:86c:a3fc:597c with SMTP id f20-20020a170906085400b0086ca3fc597cmr2405283ejd.27.1673685042051;
        Sat, 14 Jan 2023 00:30:42 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm6519089ejb.99.2023.01.14.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 00:30:41 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/2] check-attr: add support to work with tree-ish
Date:   Sat, 14 Jan 2023 09:30:36 +0100
Message-Id: <cover.1673684790.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <https://lore.kernel.org/git/cover.1673521102.git.karthik.188@gmail.com/>
References: <https://lore.kernel.org/git/cover.1673521102.git.karthik.188@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
v3: https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/
v4: https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com
v5: https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/
v6: https://lore.kernel.org/git/cover.1673521102.git.karthik.188@gmail.com/

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a tree-ish to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `--source` to git-check-attr(1) which
allows us to read gitattributes from the specified tree-ish.

Changes since v6:
- s/read_object_file/repo_read_object_file to make it more consistent
- In attr.h define 'struct object_id' instead of including 'hash.h' 

Range-diff against v5:

1:  6224754179 = 1:  6224754179 t0003: move setup for `--all` into new block
2:  57f5957127 ! 2:  0ca8b24589 attr: add flag `--source` to work with tree-ish
    @@ attr.c: static struct attr_stack *read_attr_from_file(const char *path, unsigned
     +	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
     +		return NULL;
     +
    -+	buf = read_object_file(&oid, &type, &sz);
    ++	buf = repo_read_object_file(istate->repo, &oid, &type, &sz);
     +	if (!buf || type != OBJ_BLOB) {
     +		free(buf);
     +		return NULL;
    @@ attr.c: void git_check_attr(struct index_state *istate,
     
      ## attr.h ##
     @@
    - #ifndef ATTR_H
    - #define ATTR_H
    +  */
    + 
    + struct index_state;
    ++struct object_id;
      
    -+#include "hash.h"
    -+
      /**
    -  * gitattributes mechanism gives a uniform way to associate various attributes
    -  * to set of paths.
    +  * An attribute is an opaque object that is identified by its name. Pass the
     @@ attr.h: void attr_check_free(struct attr_check *check);
      const char *git_attr_name(const struct git_attr *);
      


Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `--source` to work with tree-ish

 Documentation/git-check-attr.txt |  9 ++-
 archive.c                        |  2 +-
 attr.c                           | 97 +++++++++++++++++++++++---------
 attr.h                           |  6 +-
 builtin/check-attr.c             | 35 +++++++-----
 builtin/pack-objects.c           |  2 +-
 convert.c                        |  2 +-
 ll-merge.c                       |  4 +-
 pathspec.c                       |  2 +-
 t/t0003-attributes.sh            | 48 +++++++++++++++-
 userdiff.c                       |  2 +-
 ws.c                             |  2 +-
 12 files changed, 156 insertions(+), 55 deletions(-)

-- 
2.39.0

