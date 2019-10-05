Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87FC31F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfJEVMR (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36282 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfJEVMR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6362F61C60;
        Sat,  5 Oct 2019 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309935;
        bh=wy4xUCpI7SfJB3HnlGevx8fTehkzuFzJek5Cz6mLL/M=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Jxl0XLTGZ7L7jqppVQYrx9h0A2PBMjYz2HHut8OSehKzfehskmtPvlZ/OkfVOFwQy
         cKNLRZMgUIaBLm450r6fsUreTwbo1980LnQhRPRhvdi2jbheHyp5KRK7nQcYIizK46
         6NTzmPhg1+S51RsMAlW/w98EprmYPE3tD/RD0XiLbzDyQwRGXZF0wVAgFAW4Plq1/p
         dx9fOnJeY9k5jESYM8CZkg9JwSL2ZQkrFFy6KULi2WDYhPNhG8bD5iskcgx3ivBl2/
         kwqe/VGg8/rzPzVuxEe40qLt8KrfNSjZPC4MkolOJZWtjxnsHeE95lwev0dxrHKmZc
         rSJ4H7luoqyVxdnD52maPIteS9pA2DoveunF6owSXm+uE8YipOtGjHkUfZVImgL9KB
         bPkiUQBMei7QJfa7GUQHceIDSwL0+jBWtxg3nmlChBC3hH7dzwAOFCJMMg4Pjx3CA8
         oDHLJtZtAY0OE9PjPx1SNihR7G4e3tySgu6r/E/Zn0KEYk4TzT7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/15] SHA-256 test fixes, part 6
Date:   Sat,  5 Oct 2019 21:11:54 +0000
Message-Id: <20191005211209.18237-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series consists mostly of additional test fixes for SHA-256, plus
some test framework improvements and a new option to rev-parse.

Up until now, most of the test changes have been directly related to
fixing hash values or sizes in some way.  In other words, previous test
fixes would be required even for a Git binary that supported only
SHA-256 and not SHA-1.

In this series, we also introduce some test changes that deal with the
extension that will allow the same binary to handle both.  The changes
themselves are relatively uninteresting, but changes like these will be
making appearances in future test fix series as well.  They may appear
bizarre and out of place at times, but rest assured that they will be
useful in the future.

The other notable thing in this series is the introduction of a new
rev-parse option, --object-format.  We know, according to the transition
plan, that we'll need to support users working with input and output
in different hash algorithms.  Since we're starting to see this kind of
code appear in the codebase, it makes sense to introduce a helper that
lets scripters determine the appropriate value, and we should introduce
this code sooner, rather than later, so people can start using it.

We had had some discussions about the name of options to be used for
hash algorithms but I don't recall us coming to a definitive conclusion.
Opinions about the name[0] are of course welcome.  I'm not particularly
attached to any name, so whatever the consensus is works for me.

[0] Possibilities include --object-format, --show-object-format, --hash,
--show-hash, --hash-algorithm, --show-hash-algorithm, and more.

brian m. carlson (15):
  t/oid-info: allow looking up hash algorithm name
  t/oid-info: add empty tree and empty blob values
  rev-parse: add an --object-format option
  t1305: avoid comparing extensions
  t3429: remove SHA1 annotation
  t4010: abstract away SHA-1-specific constants
  t4011: abstract away SHA-1-specific constants
  t4015: abstract away SHA-1-specific constants
  t4027: make hash-size independent
  t4034: abstract away SHA-1-specific constants
  t4038: abstract away SHA-1 specific constants
  t4039: abstract away SHA-1-specific constants
  t4044: update test to work with SHA-256
  t4045: make hash-size independent
  t4048: abstract away SHA-1-specific constants

 Documentation/git-rev-parse.txt     |  7 +++
 builtin/rev-parse.c                 | 11 ++++
 t/oid-info/hash-info                |  9 +++
 t/t1305-config-include.sh           |  2 +-
 t/t1500-rev-parse.sh                | 15 +++++
 t/t3429-rebase-edit-todo.sh         |  2 +-
 t/t4010-diff-pathspec.sh            | 20 ++++---
 t/t4011-diff-symlink.sh             | 31 ++++++----
 t/t4015-diff-whitespace.sh          | 89 ++++++++++++++++-----------
 t/t4027-diff-submodule.sh           | 16 ++---
 t/t4034-diff-words.sh               | 93 +++++++++++++++++------------
 t/t4038-diff-combined.sh            | 19 ++++--
 t/t4039-diff-assume-unchanged.sh    |  3 +-
 t/t4044-diff-index-unique-abbrev.sh | 46 +++++++++-----
 t/t4045-diff-relative.sh            |  2 +-
 t/t4048-diff-combined-binary.sh     | 58 ++++++++++--------
 16 files changed, 268 insertions(+), 155 deletions(-)

