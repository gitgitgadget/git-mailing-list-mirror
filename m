Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CBB20248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDJCNK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38113 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so386756plb.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VPgQr7LNrS/q+iQfPFxUjXsc51rZKHMI/8qawnMPG/Q=;
        b=CZkTRpVlhxzVxIsAVtFwiRyc7dbDL0nV32xLyaR+dCiPROBFkkwFuK1AiB3vv5RjCq
         bpjZGvN3sUnJ0eZX+jtrPlMdRKA0cpZEdo9wlV9sFl6MjIecgXnX6y0Kpa9K60XpYtxi
         OD1ytxGkRNHKgW1ttNP/3da8581nTHRuWzlP4r9Dpo2PB1dlPSBL1N2QPFudSjt4fW+O
         5mc6eQY7erS7Y6j2nupT/XDqe9O60gkBqLQeOZKL5tcNleJH4qt0+Lve+dqFreqgyTAc
         XneHFahRXwWTJGkGTPi1Q3txJaXFQSG7+1zDvWynJO2z0/Uwtit3caUyE2W0AD5+18BY
         Upgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VPgQr7LNrS/q+iQfPFxUjXsc51rZKHMI/8qawnMPG/Q=;
        b=IDXF81hyfuEsZvMQdBMNm9KU6trlU7VQ3S8BfrOn3AaNvNEm8osjYDGI1rH3s6TV2q
         GwazX6i5fRakuYXHgWAur2KvSJl9iYl6rUgOZGBJfIWr2ptuGrqJuGai673SIm6w4K+t
         UWSRlw9JWvaIZKXZVZDkuFmWBD4mAIMvcFb1IyvJp8j7k1+SmC0X3/Q8hqaySNBJxhcv
         pcByVIie5IdeZZ2FIe25o0aHftjBMQqPT8CFK6jqcI1BzaosvywS9SX+fm97omuHE1ix
         X/t4FkswOwEBdUGiFcdaIymJ5DYK8Lg5itpiM8ECUb9ALq/kYfEzqCK41zeVkU62l0D4
         qH7g==
X-Gm-Message-State: APjAAAUrKjZsYBxmkvuksVAMiky11gQE9yPPJntpj40nMyHcUYwPqVQW
        BU8SS+Bok3V0KPVe5b+4dzpmZ4//kfUWLZbM
X-Google-Smtp-Source: APXvYqyY8+/3gessNFsRxJHc4JcIZ5hemusr6oLB9QLhRg+g8B/rJ7dkT/ds7wnAlpv3QZ1y3+RFSQ==
X-Received: by 2002:a17:902:7841:: with SMTP id e1mr40393142pln.303.1554862388378;
        Tue, 09 Apr 2019 19:13:08 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id v1sm53607119pff.81.2019.04.09.19.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:07 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:06 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 0/7] harden unexpected object types checks
Message-ID: <cover.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Here is 'v2' of mine and Peff's series to add tests for and fix some
cases when object connections are malformed in various ways.

There aren't many major changes from the initial version, but what has
changed is described briefly here, and in complete detail in the
range-diff at the bottom of this message:

  - [2/7] was amended with Peff's suggestion to be a little clearer about
    what 'lone' and 'seen' mean

  - [2/7] was changed to replace all instances of:

      git cat-file ... | sed -e ... >broken-obj

    with:

      git cat-file ... >good-obj &&
      sed -e ... <good-obj >broken-obj

  - [4/7] was cleaned up to include the right test after a faulty
    rebase.

Thanks as always for your review :-).


Thanks,
Taylor

Jeff King (3):
  get_commit_tree(): return NULL for broken tree
  rev-list: let traversal die when --missing is not in use
  rev-list: detect broken root trees

Taylor Blau (4):
  t: move 'hex2oct' into test-lib-functions.sh
  t: introduce tests for unexpected object types
  list-objects.c: handle unexpected non-blob entries
  list-objects.c: handle unexpected non-tree entries

 builtin/rev-list.c                     |   4 +-
 commit.c                               |   6 +-
 list-objects.c                         |  13 +++
 t/t1007-hash-object.sh                 |   4 -
 t/t1450-fsck.sh                        |   4 -
 t/t5601-clone.sh                       |   4 -
 t/t6102-rev-list-unexpected-objects.sh | 127 +++++++++++++++++++++++++
 t/test-lib-functions.sh                |   6 ++
 8 files changed, 152 insertions(+), 16 deletions(-)
 create mode 100755 t/t6102-rev-list-unexpected-objects.sh

Range-diff against v1:
1:  2104508e42 = 1:  f09c374557 t: move 'hex2oct' into test-lib-functions.sh
2:  909cbcd4a1 ! 2:  137e2df24d t: introduce tests for unexpected object types
    @@ -20,21 +20,19 @@
         cases that are not broken (i.e., they have NULL-ness checks or similar),
         mark these as expecting success.

    -    Let A be the object referenced with an unexpected type, and B be the
    -    object doing the referencing. Do the following:
    -
    -      - test 'git rev-list --objects A B'. This causes A to be "cached", and
    -        presents the above scenario.
    -
    -    Likewise, if we have a tree entry that claims to be a tree (for example)
    -    but points to another object type (say, a blob), there are two ways we
    -    might find out:
    +    We might hit an unexpected type in two different ways (imagine we have a
    +    tree entry that claims to be a tree but actually points to a blob):

           - when we call lookup_tree(), we might find that we've already seen
    -        the object referenced as another type, in which case we'd get NULL
    +        the object referenced as a blob, in which case we'd get NULL. We
    +        can exercise this with "git rev-list --objects $blob $tree", which
    +        guarantees that the blob will have been parsed before we look in
    +        the tree. These tests are marked as "seen" in the test script.

           - we call lookup_tree() successfully, but when we try to read the
    -        object, we find out it's something else.
    +        object, we find out it's something else. We construct our tests
    +        such that $blob is not otherwise mentioned in $tree. These tests
    +        are marked as "lone" in the script.

         We should check that we behave sensibly in both cases (especially
         because it is easy for a malicious actor to provoke one case or the
    @@ -58,7 +56,8 @@
     +test_expect_success 'setup well-formed objects' '
     +	blob="$(printf "foo" | git hash-object -w --stdin)" &&
     +	tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
    -+	commit="$(git commit-tree $tree -m "first commit")"
    ++	commit="$(git commit-tree $tree -m "first commit")" &&
    ++	git cat-file commit $commit >good-commit
     +'
     +
     +test_expect_success 'setup unexpected non-blob entry' '
    @@ -84,12 +83,11 @@
     +'
     +
     +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
    -+	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
    ++	test_must_fail git rev-list --objects $blob $broken_tree
     +'
     +
     +test_expect_success 'setup unexpected non-commit parent' '
    -+	git cat-file commit $commit |
    -+		perl -lpe "/^author/ && print q(parent $blob)" \
    ++	sed "/^author/ { h; s/.*/parent $blob/; G; }" <good-commit \
     +		>broken-commit &&
     +	broken_commit="$(git hash-object -w --literally -t commit \
     +		broken-commit)"
    @@ -107,8 +105,7 @@
     +'
     +
     +test_expect_success 'setup unexpected non-tree root' '
    -+	git cat-file commit $commit |
    -+	sed -e "s/$tree/$blob/" >broken-commit &&
    ++	sed -e "s/$tree/$blob/" <good-commit >broken-commit &&
     +	broken_commit="$(git hash-object -w --literally -t commit \
     +		broken-commit)"
     +'
    @@ -123,8 +120,9 @@
     +
     +test_expect_success 'setup unexpected non-commit tag' '
     +	git tag -a -m "tagged commit" tag $commit &&
    ++	git cat-file tag tag >good-tag &&
     +	test_when_finished "git tag -d tag" &&
    -+	git cat-file -p tag | sed -e "s/$commit/$blob/" >broken-tag &&
    ++	sed -e "s/$commit/$blob/" <good-tag >broken-tag &&
     +	tag=$(git hash-object -w --literally -t tag broken-tag)
     +'
     +
    @@ -139,9 +137,9 @@
     +
     +test_expect_success 'setup unexpected non-tree tag' '
     +	git tag -a -m "tagged tree" tag $tree &&
    ++	git cat-file tag tag >good-tag &&
     +	test_when_finished "git tag -d tag" &&
    -+	git cat-file -p tag |
    -+	sed -e "s/$tree/$blob/" >broken-tag &&
    ++	sed -e "s/$tree/$blob/" <good-tag >broken-tag &&
     +	tag=$(git hash-object -w --literally -t tag broken-tag)
     +'
     +
    @@ -156,9 +154,9 @@
     +
     +test_expect_success 'setup unexpected non-blob tag' '
     +	git tag -a -m "tagged blob" tag $blob &&
    ++	git cat-file tag tag >good-tag &&
     +	test_when_finished "git tag -d tag" &&
    -+	git cat-file -p tag |
    -+	sed -e "s/$blob/$commit/" >broken-tag &&
    ++	sed -e "s/$blob/$commit/" <good-tag >broken-tag &&
     +	tag=$(git hash-object -w --literally -t tag broken-tag)
     +'
     +
3:  42f1b5d5fd = 3:  1d1ac9b7a7 list-objects.c: handle unexpected non-blob entries
4:  62c9a6f2e0 ! 4:  97c7e23ec9 list-objects.c: handle unexpected non-tree entries
    @@ -31,7 +31,7 @@
      '

     -test_expect_failure 'traverse unexpected non-tree entry (seen)' '
    --	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
    +-	test_must_fail git rev-list --objects $blob $broken_tree
     +test_expect_success 'traverse unexpected non-tree entry (seen)' '
     +	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1 &&
     +	test_i18ngrep "is not a tree" output
5:  d0ae70542d = 5:  e9400a9f77 get_commit_tree(): return NULL for broken tree
6:  a0c23c8c16 = 6:  88ca5dfe68 rev-list: let traversal die when --missing is not in use
7:  2a25796147 = 7:  e0bd479e82 rev-list: detect broken root trees
--
2.21.0.203.g358da99528
