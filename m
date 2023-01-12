Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C34C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 11:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjALLJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjALLIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 06:08:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319FDF75
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:00:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so43853910ejc.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8rO4/wgknwM1M+aix7CfWi0ZofmgVqMKL3KUuHaVWY=;
        b=hXyk49WDIGaxAkJgsrrwCESQ/BFKCM5fG859RgHAxRtT9tw1IIIPIYx+2Il0znBlFt
         FANEz6aID5SdF/jmRfEQ9hQP0+tyEa+8iBgPhnMtQxETerFoQUYLEkK6K6LqCsHabJaX
         w+iy6DQKmNfqD98OFr0MHvgke3SG+uOxqeyJbkZI0sqaAxHtNcd0JF+z4Jf89VYdCFLa
         QX/lfbKYQlWfR9vZuQRuFwB1HEK1Q73uuIvHCGnVwd1M01JG16bMeI9YUtDQyJu7oa7s
         mNU7XnFcAFclrkL0QuA+v+u6BqDq0iVaI/E43VJcfvoNXBbpT7Ri0UlcDxl9BkDpJlDb
         EXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8rO4/wgknwM1M+aix7CfWi0ZofmgVqMKL3KUuHaVWY=;
        b=6jnWXTQ5RVg+ZRtjflk2itjRbk+yyG41gQAfXqXafQSYGLw+Ddhl7hctBtIYDBDJFx
         0w5WYlEW38IPZ5RU2HPeEX1j6x9ZpxhXEpiLza+t5p6Nrm97SBHhXaoe56MVTJYGC/IZ
         xxH084PRAcMje00AdNUz+mimh4BRQoWX3FFUw/BLaX06/WdMI7QQD25z3dkmWABlrT//
         mvcxvp6zOf+0QJN7UjWNKtV27VcIvOhJSQ0H8VOZuKeB+IQ9McIzlzvy2UXlz54MIJad
         wVfLImnyd/89j2DH2tTZr2JIIImsRB9ygNGU0MRvru/J10en1fzGBjhhPzw4Pfq9g6jg
         O87Q==
X-Gm-Message-State: AFqh2kro1eyydAhAylefU2VMIVgzkg7KIn5MUDw/uPBXpK0jrh3GDsz3
        B6o93WrugSd5dB+8Zj81HdzVHh2l2ic=
X-Google-Smtp-Source: AMrXdXt1IjYSaJZ3xrC3cHXH9+aLti6F7Nm7xXvswbf6Ani+pCYbcRJSaF8fmUbEfQAsRwu66UkKsg==
X-Received: by 2002:a17:906:6da:b0:84d:450b:8767 with SMTP id v26-20020a17090606da00b0084d450b8767mr13630588ejb.21.1673521235437;
        Thu, 12 Jan 2023 03:00:35 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709061c9200b007c1675d2626sm7418868ejh.96.2023.01.12.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 03:00:34 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/2] check-attr: add support to work with tree-ish
Date:   Thu, 12 Jan 2023 12:00:29 +0100
Message-Id: <cover.1673521102.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/>
References: <https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/>
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

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a tree-ish to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `--source` to git-check-attr(1) which
allows us to read gitattributes from the specified tree-ish.

Changes since v5:
- Changed the documentation and helper code to say 'tree-ish' instead of 'tree'
- Fixed broken tests because of missing `&&`

Range-diff against v5:

1:  6224754179 = 1:  6224754179 t0003: move setup for `--all` into new block
2:  d835d989ad ! 2:  57f5957127 attr: add flag `--source` to work with tree-ish
    @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
      [verse]
     -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
     -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
    -+'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
    -+'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]
    ++'git check-attr' [--source <tree-ish>] [-a | --all | <attr>...] [--] <pathname>...
    ++'git check-attr' --stdin [-z] [--source <tree-ish>] [-a | --all | <attr>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-check-attr.txt: OPTIONS
      	If `--stdin` is also given, input paths are separated
      	with a NUL character instead of a linefeed character.
      
    -+--source=<tree>::
    -+	Check attributes against the specified tree-ish. Paths provided as part
    -+	of the revision will be treated as the root directory. It is common to
    ++--source=<tree-ish>::
    ++	Check attributes against the specified tree-ish. It is common to
     +	specify the source tree by naming a commit, branch or tag associated
     +	with it.
     +
    @@ attr.c: void git_check_attr(struct index_state *istate,
      		const char *name = check->all_attrs[i].attr->name;
     
      ## attr.h ##
    +@@
    + #ifndef ATTR_H
    + #define ATTR_H
    + 
    ++#include "hash.h"
    ++
    + /**
    +  * gitattributes mechanism gives a uniform way to associate various attributes
    +  * to set of paths.
     @@ attr.h: void attr_check_free(struct attr_check *check);
      const char *git_attr_name(const struct git_attr *);
      
    @@ builtin/check-attr.c
      static const char * const check_attr_usage[] = {
     -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
     -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
    -+N_("git check-attr [--source <tree>] [-a | --all | <attr>...] [--] <pathname>..."),
    -+N_("git check-attr --stdin [-z] [--source <tree>] [-a | --all | <attr>...]"),
    ++N_("git check-attr [--source <tree-ish>] [-a | --all | <attr>...] [--] <pathname>..."),
    ++N_("git check-attr --stdin [-z] [--source <tree-ish>] [-a | --all | <attr>...]"),
      NULL
      };
      
    @@ t/t0003-attributes.sh: attr_check_quote () {
      
     +	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
     +	echo "$path: test: $expect" >expect &&
    -+	test_cmp expect actual
    ++	test_cmp expect actual &&
     +	test_must_be_empty err
      }
      
    @@ t/t0003-attributes.sh: test_expect_success 'setup' '
      
     +test_expect_success 'setup branches' '
     +	mkdir -p foo/bar &&
    -+	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
    ++	test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
     +		"f test=f\na/i test=n\n" tag-1 &&
    -+
    -+	mkdir -p foo/bar &&
    -+	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
    -+		"g test=g\na/i test=m\n" tag-2
    ++	test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
    ++		"g test=g\na/i test=m\n" tag-2 &&
    ++	rm foo/bar/.gitattributes
     +'
     +
      test_expect_success 'command line checks' '


Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `--source` to work with tree-ish

 Documentation/git-check-attr.txt |  9 ++-
 archive.c                        |  2 +-
 attr.c                           | 97 +++++++++++++++++++++++---------
 attr.h                           |  7 ++-
 builtin/check-attr.c             | 35 +++++++-----
 builtin/pack-objects.c           |  2 +-
 convert.c                        |  2 +-
 ll-merge.c                       |  4 +-
 pathspec.c                       |  2 +-
 t/t0003-attributes.sh            | 48 +++++++++++++++-
 userdiff.c                       |  2 +-
 ws.c                             |  2 +-
 12 files changed, 157 insertions(+), 55 deletions(-)

-- 
2.39.0

