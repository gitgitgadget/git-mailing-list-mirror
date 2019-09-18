Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B2E1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 01:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfIRB4m (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 21:56:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45670 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIRB4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 21:56:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so6915556qtj.12
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daTwISBMptbsXGfsZIs9f1dPkcRmnf883OKBNEmdxt8=;
        b=yJfpsyFbvw1LXNayXxCBkGUSUOiUyy9B7cI3rgXU2rTWgKrkjQh2bB+VVM0+FmmD2w
         piDAkbpPEWodf/7L+uQ71al8bdTQ8yjJiOCZopIvd7eyxwALrlUxt54vWRp3RaV62azQ
         CXHfV034SjjvpQhCieWZuO0qoFik0uRygObSQcXCwT9KBElbnZrrHe39F/U7INkTcTA4
         osrPlRjyTaEwElXUmqmtSAAgHg72nsC2+0WYZ9zazTDtnwunqk7+S1emqUk8myWbZyNi
         fFHkN02FiOuykOo2j2+gQIRWjbRYIiKvHChwwydUag2pjPrkUD2BtXbMFHUsp8ZoH4GK
         zcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daTwISBMptbsXGfsZIs9f1dPkcRmnf883OKBNEmdxt8=;
        b=AZZX7QPGeL+LfkRm8MH+3lS+bJRNvFvR5Ibp+8TCJbWi2qhoilTs3zcZ2ilwFlqkQe
         OyaKQdMW6qewaiOpdRdbBr5NisqbvLCY9D5EVqm6fPiPwhHXFW2iO5MxN7b+/bh1YICA
         DbbOYZOD+HPeGXe7aFqm9F4fGLVHXyyN80gUZhlJATw8tXgY91+65NZ0Ognpe/WMX2Sm
         sQX8iC3Zs1iZxQgFQ7fCg640bO41kGcz6ICt9QQn1Ct9YM0wjGLBsdh52IT9Qcr5g21q
         j0/YUBs1yJ3u6DiEWtDTi/rvw4NJvCjRSxxlIZ5CkQDWIvRvridWFPH15NDsH4Ul/VOb
         kYWw==
X-Gm-Message-State: APjAAAU72RBtlwVua7i6LYgDmXbKJtE5QzQuX1QpXweHqb4a/kayGdOo
        uGeKTYqyjn02fJag1Q9FVk0bu/BmXxk=
X-Google-Smtp-Source: APXvYqwK66XBaGx5rI8EOpdValyCrLdcZZUqOtHS6oyWatz95AfWI78mHXMe6pasI3RL6aMcuia2jg==
X-Received: by 2002:ac8:444e:: with SMTP id m14mr1950603qtn.19.1568771800672;
        Tue, 17 Sep 2019 18:56:40 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j17sm2156371qki.99.2019.09.17.18.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:56:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
Date:   Tue, 17 Sep 2019 22:56:02 -0300
Message-Id: <cover.1568771073.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git-grep --recurse-submodules stop adding subrepos to the in-memory
alternates list and, instead, pass a reference to the subrepo struct
down to the threads.

This series is based on ew/hashmap (it uses the added container_of
macro).

There're some possibly needed changes I'm still unsure about. All
feedback will be highly appreciated:

- textconv cache is written to the_repository's object database even for
  submodules. Should it perhaps be written to submodules' odb instead?

- Considering the following call chain: grep_source_load_driver() >
  userdiff_find_by_path() > git_check_attr() > collect_some_attrs() >
  prepare_attr_stack() > bootstrap_attr_stack():

  * The last function tries to read the attributes from the
    .gitattributes and .git/info/attributes files of the_repository.
    However, for paths inside the submodule, shouldn't it try to read
    these files from the submodule?

  * This function will also call: read_attr() > read_attr_from_index() >
    read_blob_data_from_index() which might, in turn, call
    read_object_file(). Shouldn't we pass the subrepo to it so that it
    can call repo_read_object_file()? (Again, for paths inside the
    submodule, read_object_file() won't be able to find the object as
    we won't be adding to alternates anymore.)

Matheus Tavares (3):
  diff: use the given repo at diff_populate_filespec()
  object: allow parse_object_or_die() to handle any repo
  grep: don't add submodules to the alternates list

 builtin/grep.c  | 82 +++++++++++++++++++++++++++++++++++--------------
 builtin/prune.c |  4 +--
 bundle.c        | 13 +++++---
 diff.c          |  2 +-
 grep.c          | 26 ++++++++--------
 object.c        |  5 +--
 object.h        |  4 ++-
 pack-bitmap.c   |  5 +--
 reachable.c     |  4 +--
 upload-pack.c   |  2 +-
 10 files changed, 94 insertions(+), 53 deletions(-)

-- 
2.23.0

