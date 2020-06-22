Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FA4C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E693C20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BC0B6qxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFVSE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730104AbgFVSEZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02AFE60436;
        Mon, 22 Jun 2020 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849064;
        bh=7rdBg4U5LvbbzcyGcdEkKGLAbnjgMLw3H/lVeRgZVeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BC0B6qxNaOOlDgdKNpSjSAyCXVh+nj5W4Y8hWNv0nPyXBfw/8LM1qll1Ywnx4QdBG
         Qb7qxhgk+uVR7CDuvedGgLhztyeepS2YrNLQ13P8p4X0rvyE9AYDvzPglQBzv2u4uQ
         MxM79vxyCho5DOKKJgqTFVVZFoKNtaqTO2CbQfk2+LIFJEEqTkCu7dtnXussfQebUN
         aE5Lp6JM2npFUvhbXUPVMtdNsWBgB3lE6c8Sj8YLZsIFuGlR7NwvHxuaJikffZWQFy
         nnfWRomD4mXsxuUvnHqKBT18rWP74QouhYaHDt3qflnT8q5IkCyHLQxVZp426B792H
         sgJiLzJz5v0LlXeqGtyzMwmfiwF57nS7fn/+LrQTr8P62FS7ujG3eeuJQ9kSacOArM
         GtUsdOk2bzMGCUUtF6RXPi1Trek46i7KPdfSHyWqgGuC4vxFZM0GQOdg2zsPz+vnXT
         X94SOd1U5DsCvc4EP4fZQaV8Q8UtOai9XKDy1OFi3R3r6wDijec
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/14] SHA-256 CVS and SVN patches
Date:   Mon, 22 Jun 2020 18:04:04 +0000
Message-Id: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently sent out part 2/3 of the SHA-256 work and then I realized
that I hadn't built with the CVS and SVN adapters.  So this is part
2.5/3 (or, to be pedantic, 3/4).

The patches are ordered roughly with test-only fixes, then SVN, and then
CVS.  There are no additional tests here because everything fails with
SHA-256 before and passes afterwards.

Changes from v1:
* Adopt Andreas's suggestion to preserve more of the structure of the
  original function.

Range-diff below.

brian m. carlson (14):
  t9109: make test hash independent
  t9168: make test hash independent
  t9108: make test hash independent
  t9100: make test work with SHA-256
  t9104: make hash size independent
  t9101: make hash independent
  t/lib-git-svn: make hash size independent
  perl: create and switch variables for hash constants
  perl: make Git::IndexInfo work with SHA-256
  perl: make SVN code hash independent
  git-svn: set the OID length based on hash algorithm
  git-cvsserver: port to SHA-256
  git-cvsimport: port to SHA-256
  git-cvsexportcommit: port to SHA-256

 git-cvsexportcommit.perl                   | 14 ++--
 git-cvsimport.perl                         |  8 +--
 git-cvsserver.perl                         | 37 +++++-----
 git-svn.perl                               | 25 ++++---
 perl/Git/IndexInfo.pm                      |  6 +-
 perl/Git/SVN.pm                            | 83 +++++++++++-----------
 perl/Git/SVN/Editor.pm                     |  8 +--
 perl/Git/SVN/Fetcher.pm                    |  6 +-
 perl/Git/SVN/Log.pm                        |  2 +-
 perl/Git/SVN/Ra.pm                         |  4 +-
 t/lib-git-svn.sh                           | 17 +++--
 t/t9100-git-svn-basic.sh                   | 19 ++++-
 t/t9101-git-svn-props.sh                   | 12 ++--
 t/t9104-git-svn-follow-parent.sh           |  3 +-
 t/t9108-git-svn-glob.sh                    |  4 +-
 t/t9109-git-svn-multi-glob.sh              |  6 +-
 t/t9168-git-svn-partially-globbed-names.sh |  8 +--
 17 files changed, 151 insertions(+), 111 deletions(-)

Range-diff against v1:
 1:  cc8a204394 =  1:  cc8a204394 t9109: make test hash independent
 2:  814c3423ef =  2:  814c3423ef t9168: make test hash independent
 3:  81b1f48671 =  3:  81b1f48671 t9108: make test hash independent
 4:  8571f65b17 =  4:  8571f65b17 t9100: make test work with SHA-256
 5:  d93ded4e74 =  5:  d93ded4e74 t9104: make hash size independent
 6:  3e401f3e48 =  6:  3e401f3e48 t9101: make hash independent
 7:  02cb87e4be !  7:  17cc278f1d t/lib-git-svn: make hash size independent
    @@ t/lib-git-svn.sh: maybe_start_httpd () {
      
      convert_to_rev_db () {
     -	perl -w -- - "$@" <<\EOF
    --use strict;
    -+	perl -w -e "use strict; my \$oidlen = $(test_oid rawsz);" -e '
    ++	perl -w -- - "$(test_oid rawsz)" "$@" <<\EOF
    + use strict;
    ++my $oidlen = shift;
      @ARGV == 2 or die "usage: convert_to_rev_db <input> <output>";
    --open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
    --open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
     +my $record_size = $oidlen + 4;
     +my $hexlen = $oidlen * 2;
    -+open my $wr, "+>", $ARGV[1] or die "$!: couldn'\''t open: $ARGV[1]";
    -+open my $rd, "<", $ARGV[0] or die "$!: couldn'\''t open: $ARGV[0]";
    + open my $wr, '+>', $ARGV[1] or die "$!: couldn't open: $ARGV[1]";
    + open my $rd, '<', $ARGV[0] or die "$!: couldn't open: $ARGV[0]";
      my $size = (stat($rd))[7];
     -($size % 24) == 0 or die "Inconsistent size: $size";
     -while (sysread($rd, my $buf, 24) == 24) {
    @@ t/lib-git-svn.sh: maybe_start_httpd () {
      		}
      	}
      	seek $wr, $offset, 0 or die $!;
    - 	print $wr $c,"\n" or die $!;
    - }
    - close $wr or die $!;
    --close $rd or die $!;
    --EOF
    -+close $rd or die $!;' \
    -+	-- "$@"
    - }
    - 
    - require_svnserve () {
 8:  d59b8ac38e =  8:  a59dbf9637 perl: create and switch variables for hash constants
 9:  d3c991fb52 =  9:  c2ff48efa4 perl: make Git::IndexInfo work with SHA-256
10:  7f87880cb2 = 10:  2b5d83ad2f perl: make SVN code hash independent
11:  9100fbd4cf = 11:  66a46baf27 git-svn: set the OID length based on hash algorithm
12:  9655d1f0ea = 12:  b2309179f6 git-cvsserver: port to SHA-256
13:  618abf0af1 = 13:  0d5680f2e6 git-cvsimport: port to SHA-256
14:  290f0ec11f = 14:  fecbc1fbf9 git-cvsexportcommit: port to SHA-256
