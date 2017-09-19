Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F375020281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdISGWp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:22:45 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42077 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750974AbdISGWn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:43 -0400
X-AuditID: 1207440c-7e5ff7000000143e-bf-59c0b7abbda5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id AA.37.05182.BA7B0C95; Tue, 19 Sep 2017 02:22:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1X002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/21] Read `packed-refs` using mmap()
Date:   Tue, 19 Sep 2017 08:22:08 +0200
Message-Id: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1F2z/UCkwfv9TBZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mn5MfslUcNO04sW/d2wNjDO0uhg5
        OCQETCSmd9h0MXJxCAnsYJLYe3sWI4RziknidO8q9i5GTg42AV2JRT3NTCC2iICaxMS2Qywg
        RcwCK5klJm29wgqSEBawlNj24jhYA4uAqsSO7lcsIBt4Bcwlbi9lBglLCMhLnHtwG8zmFRCU
        ODnzCVgJs4C6xPp5QiBhZqCS5q2zmScw8s5CUjULoWoWkqoFjMyrGOUSc0pzdXMTM3OKU5N1
        i5MT8/JSi3QN9XIzS/RSU0o3MUKCmWcH47d1MocYBTgYlXh4Ba7tjxRiTSwrrsw9xCjJwaQk
        yhu26UCkEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeQ4uAcrwpiZVVqUX5MClpDhYlcV7VJep+
        QgLpiSWp2ampBalFMFkZDg4lCV5FYNQKCRalpqdWpGXmlCCkmTg4QYbzAA1XAanhLS5IzC3O
        TIfIn2LU5ei4efcPkxBLXn5eqpQ47/1tQEUCIEUZpXlwc2BJ6BWjONBbwryuIFU8wAQGN+kV
        0BImoCXZG8CWlCQipKQaGAMLFHval5cpNevLxjCcu1kVO1e2W02M98jqE1LflxtWszn4McwK
        XcjC/b/pYMR/MSutgmUs6Y2ivT5MagcP7o72s+F2OdETeUE5du+sk2IcQS/aXO2aNoj0PVrn
        7s+kkHvo865L18W3LmrZX8OtlWqpeOnxq9xiFsu/fP75ASe3xr/2/zhPiaU4I9FQi7moOBEA
        f3wqSR0DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of a patch series that changes the reading and caching of
the `packed-refs` file to use `mmap()`. Thanks to Junio, Stefan, and
Johannes for their comments about v1 [1].

The main change since v1 is to accommodate Windows, which doesn't let
you replace a file using `rename()` if the file is currently mmapped.
This is unfortunate, because it means that Windows will never get the
O(N) → O(lg N) improvement for reading single references that more
capable systems can now enjoy.

The background was discussed on the mailing list [2]. The bottom line
is that on Windows, keeping the `packed-refs` lock mmapped would be
tantamount to holding reader lock on that file, preventing anybody
(even unrelated processes) from changing the `packed-refs` file while
it is mmapped. This is even worse than the situation for packfiles
(which is solved using `close_all_packs()`), because a packfile, once
created, never needs to be replaced—every packfile has a filename that
is determined from its contents. The worst that can happen if a
packfile is locked is that another process cannot remove it, but that
is not critical for correctness. The `packed-refs` file, on the other
hand, always has the same filename and needs to be overwritten for
correctness.

So the approach taken here is that a new compile-time option,
`MMAP_PREVENTS_DELETE`, is introduced. When this option is set, then
the `packed-refs` file is read quickly into memory then closed.

Even in that case, though, this branch brings significant performance
benefits, because instead of parsing the whole file and storing it
into lots of little objects in a `ref_cache` (which also involves a
lot of small memory allocations), we copy the verbatim contents of the
file into memory. Then we use the same binary search techniques to
find any references that we need to read, just as we would do if the
file were memory mapped. This means that we only have to fully parse
the references that we are interested in, and hardly have to allocate
any additional memory.

I did some more careful benchmarks of this code vs. Git 2.14.1 on a
repository that is not quite as pathological. The test repo has 110k
references that are fully packed in a `packed-refs` file that has the
`sorted` trait. The current version is compiled three ways:

* `NO_MMAP=YesPlease`—prevents all use of `mmap()`. This variant is
  O(N) when reading a single reference.

* `MMAP_PREVENTS_DELETE=YesPlease`—uses mmap for the initial read, but
  quickly copies the contents to heap-allocated memory and munmaps
  right away. This variant is also O(N) when reading a single
  reference.

* default (mmap enabled)—the `packed-refs` file is kept mmapped for as
  long as it is in use.

The commands that I timed were as follows:

# for-each-ref, warm cache:
$ git -C lots-of-refs for-each-ref --format="%(objectname) %(refname)" >/dev/null

# rev-parse, warm cache (this command was run 10 times then the total
# time divided by 10):
$ git -C lots-of-refs rev-parse --verify refs/remotes/origin/pr/38733

# rev-parse, cold cache (but git binary warm):
$ sync ; sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'; git rev-parse v1.0.0; time git -C lots-of-refs rev-parse --verify refs/remotes/origin/pr/38733

(Note that the `rev-parse` commands involve a handful of reference
lookups as the argument is DWIMmed.)

Results:

                               for-each-ref     rev-parse     rev-parse
                                 warm cache    warm cache    cold cache
                               ------------    ----------    ----------
v2.14.1                               92 ms       23.7 ms         30 ms
NO_MMAP=YesPlease                     83 ms        3.4 ms         10 ms
MMAP_PREVENTS_DELETE=YesPlease        82 ms        3.5 ms         11 ms
default (mmap enabled)                81 ms        0.8 ms          6 ms

So this branch is a little bit faster at iterating over all
references, but it really has big advantages when looking up single
references. The advantage is smaller if `NO_MMAP` or
`MMAP_PREVENTS_DELETE` is set, but is still quite significant.

This branch is also available from my fork on GitHub as branch
`mmap-packed-refs`.

My main uncertainties are:

1. Does this code actually work on Windows?

2. Did I implement the new compile-time option correctly? (I just
   cargo-culted some existing options.) Is there some existing option
   that I could piggy-back off of instead of adding a new one?

3. Is a compile-time option sufficient, or would the `mmap()` option
   need to be configurable at runtime, or even tested at repository
   create time as is done for some other filesystem properties in
   `create_default_files()`?

Michael

[1] https://public-inbox.org/git/cover.1505319366.git.mhagger@alum.mit.edu/
[2] https://public-inbox.org/git/alpine.DEB.2.21.1.1709142101560.4132@virtualbox/
    https://public-inbox.org/git/alpine.DEB.2.21.1.1709150012550.219280@virtualbox/
[3] https://github.com/mhagger/git

Jeff King (1):
  prefix_ref_iterator: break when we leave the prefix

Michael Haggerty (20):
  ref_iterator: keep track of whether the iterator output is ordered
  packed_ref_cache: add a backlink to the associated `packed_ref_store`
  die_unterminated_line(), die_invalid_line(): new functions
  read_packed_refs(): use mmap to read the `packed-refs` file
  read_packed_refs(): only check for a header at the top of the file
  read_packed_refs(): make parsing of the header line more robust
  read_packed_refs(): read references with minimal copying
  packed_ref_cache: remember the file-wide peeling state
  mmapped_ref_iterator: add iterator over a packed-refs file
  mmapped_ref_iterator_advance(): no peeled value for broken refs
  packed-backend.c: reorder some definitions
  packed_ref_cache: keep the `packed-refs` file mmapped if possible
  read_packed_refs(): ensure that references are ordered when read
  packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
  packed_read_raw_ref(): read the reference from the mmapped buffer
  ref_store: implement `refs_peel_ref()` generically
  packed_ref_store: get rid of the `ref_cache` entirely
  ref_cache: remove support for storing peeled values
  mmapped_ref_iterator: inline into `packed_ref_iterator`
  packed-backend.c: rename a bunch of things and update comments

 Makefile              |  10 +
 config.mak.uname      |   3 +
 refs.c                |  22 +-
 refs/files-backend.c  |  54 +--
 refs/iterator.c       |  47 ++-
 refs/packed-backend.c | 978 ++++++++++++++++++++++++++++++++++++++------------
 refs/ref-cache.c      |  44 +--
 refs/ref-cache.h      |  35 +-
 refs/refs-internal.h  |  26 +-
 9 files changed, 850 insertions(+), 369 deletions(-)

-- 
2.14.1

