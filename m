Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11117C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhLQNa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhLQNa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51AC06173E
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so1587017wmb.0
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+TlYVJyZXaf/gG0Evnvvj+SUJqSbTl0GIBfu7KOsdc=;
        b=U8GncbE4WbgDZvHJMGqMrnavEcG3jHAE6TzLgSxQZOkn1RKHgl45DmWZHDiN+HdauQ
         Qz0z3DXvL5sihnKVGpzjNSE4vWwD9qWuArs25Lqwgfy/+HEhQMlQWgQFA+rnBa6qN7Pk
         TYbHKjn5F86qWd4DGCvcVUex9Y95h0FpYzmPWnA53pu66yKZnAZUh1XjH90cVWkyuzm8
         furK9uFocuRW3I14wXoWwAqh2IXpjPCBz8xqsbIBPsdEzvgxaM0qRoxJWIqZU5iebcj/
         44MEhM0GNlsPNPdqTZM2aaq9ysmZMiBbInVxdff6Q8XOXDx6hWJwnLp8bAesDJKVLpNz
         aB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+TlYVJyZXaf/gG0Evnvvj+SUJqSbTl0GIBfu7KOsdc=;
        b=P+0vgo70sbA2TZUt26ak2cOhqpemKLHhe1dGqfbd/uYNNFIvz6krG0I+q1D9DIym6c
         584m20IcQx7MHW3Dq2PmGavZnyKdoBMH8rKrIHn4MDS3pl8FbbMQ7BiG9dIa4ypC7YX2
         HHLeJ0JQX570/KH0ZSwa/90yfJUp05nIB5SGRyMegmRFbxVcA9menXk8cdBgip7vcBdr
         /PDibgT5sDWMj/jiGMcblMn1mC14ej2Z7i9ALTdIX9BEBIpoZcFgcdew+0qB8fxSxcop
         RGb3+dzYmRFuTtFEnnjTLaD9vYaBMW5lGMDtZFMm2fTjEpzdcJHA2zCRqqeYaK7jjzhs
         VNJQ==
X-Gm-Message-State: AOAM532XfmHz6yHX2GBdo3NHvZ2GeavOucbzLJq4CjuSJEj9rDT8p1MO
        NvJ4k9u/RI/UqGSKaEjQYnUzxubDpbzjkQ==
X-Google-Smtp-Source: ABdhPJyYj55BI7uu4/qXJKacUb2hsbWMNmz6dkqef0u4ykq9svfXO7NzojhZftEruFhTvWMyXnd8jw==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr2776631wmq.60.1639747825909;
        Fri, 17 Dec 2021 05:30:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/7] ls-tree --format
Date:   Fri, 17 Dec 2021 14:30:16 +0100
Message-Id: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover.1639721750.git.dyroneteng@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17 2021, Teng Long wrote:

> Many thanks to Junio and Ævar for your help and patient explanation.
> I noticed Ævar suggest the solution with using `--format`, but in
> this patch, the current approach continues. If this part of code needs
> to be improved or we want to support "--format" in "ls-tree" in the
> future, I'm more than glad to continue to contribute.

FWIW here's the changes I had locally & cleaned up now that did the
alternate --format approach.

I think you'll probably want to steal some of this, e.g. you're
patching the dead comment I removed in 1/6, 2-4/6 can be skipped, but
I thought they were nice.

Back when I last looked at this series, your --object-name patch was
much shorter, but now it's about the same size as the generic --format
support. So maybe it's worth considering implementing the more generic
path.

One reason I didn't submit this before is that I couldn't get past the
performance regression this would inttroduce, i.e. if moved entirely
to strbuf_expand(). Here though I'm keeping the old code, so it's no
slower than "master", unlike your patch. But I haven't dug into why
yours is slower:
    
    $ git hyperfine -L rev origin/master,tl/object-name,avar/ls-tree-format -s 'make CFLAGS=-O3' './git -C /run/user/1001/linux ls-tree -r HEAD' --warmup 10 -r 10
    Benchmark 1: ./git -C /run/user/1001/linux ls-tree -r HEAD' in 'origin/master
      Time (mean ± σ):      67.8 ms ±   0.3 ms    [User: 48.8 ms, System: 18.9 ms]
      Range (min … max):    67.4 ms …  68.4 ms    10 runs
    
    Benchmark 2: ./git -C /run/user/1001/linux ls-tree -r HEAD' in 'tl/object-name
      Time (mean ± σ):      72.8 ms ±   0.4 ms    [User: 50.6 ms, System: 22.1 ms]
      Range (min … max):    72.0 ms …  73.2 ms    10 runs
    
    Benchmark 3: ./git -C /run/user/1001/linux ls-tree -r HEAD' in 'avar/ls-tree-format
      Time (mean ± σ):      67.6 ms ±   0.4 ms    [User: 50.5 ms, System: 17.0 ms]
      Range (min … max):    67.1 ms …  68.4 ms    10 runs
    
    Summary
      './git -C /run/user/1001/linux ls-tree -r HEAD' in 'avar/ls-tree-format' ran
        1.00 ± 0.01 times faster than './git -C /run/user/1001/linux ls-tree -r HEAD' in 'origin/master'
        1.08 ± 0.01 times faster than './git -C /run/user/1001/linux ls-tree -r HEAD' in 'tl/object-name'

I then tacket a 6/6 at the end here to implement your --object-name in
terms of --format (but didn't update the comimt message etc.). That's
slower as expected:
    
    $ git hyperfine -L rev tl/object-name,avar/ls-tree-format -s 'make CFLAGS=-O3' './git -C /run/user/1001/linux ls-tree --object-only -r HEAD' --warmup 10 -r 10
    Benchmark 1: ./git -C /run/user/1001/linux ls-tree --object-only -r HEAD' in 'tl/object-name
      Time (mean ± σ):      58.7 ms ±   0.4 ms    [User: 43.0 ms, System: 15.6 ms]
      Range (min … max):    58.4 ms …  59.6 ms    10 runs
     
    Benchmark 2: ./git -C /run/user/1001/linux ls-tree --object-only -r HEAD' in 'avar/ls-tree-format
      Time (mean ± σ):      65.6 ms ±   0.2 ms    [User: 42.4 ms, System: 23.0 ms]
      Range (min … max):    65.1 ms …  65.9 ms    10 runs
     
    Summary
      './git -C /run/user/1001/linux ls-tree --object-only -r HEAD' in 'tl/object-name' ran
        1.12 ± 0.01 times faster than './git -C /run/user/1001/linux ls-tree --object-only -r HEAD' in 'avar/ls-tree-format'

But it's not too bad, so maybe it's fine & worth making it more
generic?

Anyway. Just food for thought and and FYI in case you're
interested. Junio noted already that he'd like the --object-name
approach first, so if you still want to pursue your current
implementation I don't mind.

I do think you should be making performance testing a part of your
testing & cover letter writing though. A 8-10% slowdown isn't nothing,
especially for exactly the sort of plumbing command that'll likely to
be used to e.g. slurp up all paths in a very large repo.

These patches really aren't "ready". There's no docs, and as I noted
in some earlier thread the tests for ls-tree are really
lacking. E.g. I seem to have a rather obvious bug in how -t and the
--format interact here, but no test catches it.

Well, that one's me not having added a test, but I'm fairly sure there
might also be hidden bugs here due to lack of testing.

Teng Long (1):
  ls-tree.c: support `--object-only` option for "git-ls-tree"

Ævar Arnfjörð Bjarmason (6):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: split up the "init" part of show_tree()
  ls-tree: add a --format=<fmt> option

 Documentation/git-ls-tree.txt |   7 +-
 builtin/ls-tree.c             | 226 ++++++++++++++++++++++++++++++----
 t/t3103-ls-tree-misc.sh       |   8 ++
 t/t3104-ls-tree-oid.sh        |  51 ++++++++
 t/t3105-ls-tree-format.sh     |  49 ++++++++
 5 files changed, 313 insertions(+), 28 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh
 create mode 100755 t/t3105-ls-tree-format.sh

-- 
2.34.1.1119.g7a3fc8778ee

