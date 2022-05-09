Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FBC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiEIR4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiEIR4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:56:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED52AD74F
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:52:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so28257413ejo.12
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdMKlcvIwKJe0KkOPeHtsIvpenkDQkILAomn0x3HzT0=;
        b=M+qLEJoYZWaVqpwRbE9qdSFarnyAIsP+7JfwTpEBgpfec1Jfxl5XmhV4jpoxdWlbYP
         m/V+rQgEq9955peZsBIgHWA9Sz3bUQkpTEqLovfPKoitVnD7oEXX2d9dO3cANcyX49LD
         tYMjf00yDEqnKzy05+GD7yRXRcFrlLkV5ikmFOZwIZYWkT+0a0B7E0QKTSV16W2ETYPP
         0vjO73kgYM68z+f9/vbtK/PsjAwJbPrad42IKmflMBXHF8PNgdRmvGPei99xebSF58/0
         CiTL3HIZ0HyWI/osYnbCftYp6YWTSCcaeQ0IHHKGVjfb4s8G3mwSKn9JrCITlyMCKYrF
         4C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdMKlcvIwKJe0KkOPeHtsIvpenkDQkILAomn0x3HzT0=;
        b=nMj0U8PxavDW5jYhiMeRFep84byuVxtapNmYcfAlzH8+ds+gwlILsFkSnBnmpMEHpl
         E4mmcWWJmUPWMTjJbf0AbJAhfOZ94qAWWST53YkkUTYDKDqBzUFTkEFKvuUX1VlOOD6d
         GlgyO9d0lYEJ+ps6YmmVhO7vBbcvYMinKjPjca95/RzcGpSZ0WuNcTPCmqYr8mOTdzff
         QXFkuJ0R1QL7MqwDMYsSwkwx0eO6uHWPEWaIT6uiKq9NqR8h1pW8gL6FPEbNJEflKun/
         X8YRNd9xpUfVT/DxFmtSzk8ZmiN8fey00rsFfNQEdtocy87McsFCwexPa+eEgMTHylRo
         C9eQ==
X-Gm-Message-State: AOAM5304NsTQ8Q++PI0O39uTvZFLaHp07VcwxgcphhdKQVaPxBfYaMWN
        5PS7cL8J28f4ivhI9LrJUuQG5VSuSKI=
X-Google-Smtp-Source: ABdhPJyd+pO6TWxdTNlLe3WF4uy4jq6oAoVP/62RxSz/sUkUQYqmIc1NKGWmBvcOmfzBLjexL3xyjQ==
X-Received: by 2002:a17:906:6a29:b0:6f4:3389:9094 with SMTP id qw41-20020a1709066a2900b006f433899094mr15844875ejc.323.1652118733875;
        Mon, 09 May 2022 10:52:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:52:13 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 00/15][GSoC] iterate dirs before or after their contents
Date:   Mon,  9 May 2022 20:51:44 +0300
Message-Id: <20220509175159.2948802-1-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of a patch series which implements pre-order and
post-order iteration over directories. In this version I use the new iteration
scheme to convert entry.c remove_subtree() function from using opendir/readdir/
closedir API to dir-iterator API.

v1: https://lore.kernel.org/git/20220410111852.2097418-1-kioplato@gmail.com/

Fork: https://github.com/kioplato/git/tree/dir-iterator-v2
CI: https://github.com/kioplato/git/actions/runs/2295239114
I've ran the full test suite for each commit.

In comparison to v1 I changed/fixed/improved:

* In this version I followed Phillip's suggestion[1] to explain why I'm making
the changes in each commit's description and create smaller, targeted commits.
In v1 I did a lot of renaming to directory paths, test descriptions and files.
In this version these renames have their own commits.

* Explained why I converted dir_iterator_advance() from iterative implementation
to recursive in the related commit. Ævar[2] and Phillip[3] asked about why I did
this conversion, so I thought it was appropriate to include an explanation in
the commit's description.

* I talked about a subtle unexpected behavior of dir_iterator_begin() [4]. I was
wrong about the two new states for the deepest directory. I introduced those
states in order to implement recursive dir_iterator_advance() and not to deal
with the unexpected behavior of dir_iterator_begin(). Therefore I splitted the
conversion of dir_iteartor_advance() and the changes to deal with the unexpected
behavior of dir_iteartor_begin() into two different commits. They need their own
commits since they are two unrelated changes.

* Split the commit that introduces pre-order and post-order iteration into two.
Like Phillip suggested here[5] the first changes dir-iterator default behavior
and the second implements post-order iterator over directories. This helps split
the tests introduced, which helps generate smaller diffs.

* Like Phillip suggested [6], I'll work with the existing code and change one
aspect at a time in stages. In this series I converted entry.c remove_subtree()
to use dir-iterator API instead of opendir/readdir/closedir API.

* The redundant tests [7] in this version were not removed. Instead I kept them
for more detailed testing which helps in case a test fails.

* Ævar's idea[8] to change the default swich case in test-dir-iterator made me
realize that test-dir-iterator does not print errno codes set by failed calls to
dir_iterator_advance(). Therefore I made test-dir-iterator print them which
makes all tests test_cmp for the errno code set by either dir_iteartor_begin()
or dir_iterator_advance(). This presumably has the same effect as changing the
default switch case to use BUG() macro. This change also led to two others, one
that makes test-dir-iterator explicitly print ELOOP errno and the second that
improves readability by consistently returning, C standard constants, either
EXIT_SUCCESS or EXIT_FAILURE, instead of mixed integers and exit() calls.

* fixed coding style and introduces an enum for returning constants instead of
more integers which worsens readability, as suggested by Ævar [9].

I also didn't CC Michael and Matheus in this version, since they weren't
interested in v1 where I did CC them.

[1]: https://lore.kernel.org/git/ed6656e0-a865-319e-0f56-23ab1da3eef3@gmail.com/
[2]: https://lore.kernel.org/git/220411.86o817j2dt.gmgdl@evledraar.gmail.com/
[3]: https://lore.kernel.org/git/35160d46-d337-2110-f968-238abb7e9f0e@gmail.com/
[4]: https://lore.kernel.org/git/20220427154526.uuhpkoee322l7kmz@compass/
[5]: https://lore.kernel.org/git/b75aaee8-c037-e8e0-6ee0-729922059352@gmail.com/
[6]: https://lore.kernel.org/git/df287d4f-e9da-4ce0-d7e9-1b1fe7671aab@gmail.com/
[7]: https://lore.kernel.org/git/220411.86sfqjj2o0.gmgdl@evledraar.gmail.com/
[8]: https://lore.kernel.org/git/220411.86wnfvj2q6.gmgdl@evledraar.gmail.com/
[9]: https://lore.kernel.org/git/220411.86o817j2dt.gmgdl@evledraar.gmail.com/

Plato Kiorpelidis (15):
  t0066: refactor dir-iterator tests
  t0066: remove dependency between unrelated tests
  t0066: shorter expected and actual output file names
  test-dir-iterator: consistently return EXIT_FAILURE or EXIT_SUCCESS
  test-dir-iterator: print EACCES and ELOOP errno set by dir_iterator
  test-dir-iterator: print errno name set by dir_iterator_advance
  t0066: better test coverage for dir-iterator
  t0066: reorder tests from simple to more complex
  t0066: rename test directories
  dir-iterator: refactor dir_iterator_advance()
  dir-iterator: open root dir in dir_iterator_begin()
  t0066: rename subtest descriptions
  dir-iterator: option to iterate dirs in pre-order
  dir-iterator: option to iterate dirs in post-order
  entry.c: use dir-iterator to avoid explicit dir traversal

 builtin/clone.c              |    4 +-
 dir-iterator.c               |  334 ++++++--
 dir-iterator.h               |   36 +-
 entry.c                      |   38 +-
 refs/files-backend.c         |    2 +-
 t/helper/test-dir-iterator.c |   24 +-
 t/t0066-dir-iterator.sh      | 1478 +++++++++++++++++++++++++++++++---
 7 files changed, 1704 insertions(+), 212 deletions(-)

-- 
2.36.1

