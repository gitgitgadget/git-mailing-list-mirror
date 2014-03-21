From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 00/10] userdiff: cpp pattern simplification and test framework
Date: Fri, 21 Mar 2014 22:07:12 +0100
Message-ID: <cover.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6fu-0002UC-W4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaCUVIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:19 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23325 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750710AbaCUVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:18 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.108])
	by lbmfmo03.bon.at (Postfix) with ESMTP id A090ACEA57
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:16 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0108913004D;
	Fri, 21 Mar 2014 22:08:00 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2EDCD19F6A4;
	Fri, 21 Mar 2014 22:08:00 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <53282741.5010609@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244738>

Here is a series that makes the hunk header pattern for C and C++ even
simpler than suggested by Peff in [1] to catch a lot more C++ functions
and two more C patterns.

As a preparatory work, the test cases are totally rewritten to make it
a lot simpler to drop in new tests. There was an earlier attempt to
change the infrastructure [2], and it is the reason for the widened Cc
list.

Two patches also extend the word regexp.

[1] http://article.gmane.org/gmane.comp.version-control.git/243408
[2] http://thread.gmane.org/gmane.comp.version-control.git/187269/focus=187497

Johannes Sixt (10):
  userdiff: support C++ ->* and .* operators in the word regexp
  userdiff: support unsigned and long long suffixes of integer constants
  t4018: an infrastructure to test hunk headers
  t4018: convert perl pattern tests to the new infrastructure
  t4018: convert java pattern test to the new infrastructure
  t4018: convert custom pattern test to the new infrastructure
  t4018: reduce test files for pattern compilation tests
  t4018: test cases for the built-in cpp pattern
  t4018: test cases showing that the cpp pattern misses many anchor
    points
  userdiff: have 'cpp' hunk header pattern catch more C++ anchor points

 t/t4018-diff-funcname.sh                   | 230 ++++++++++-------------------
 t/t4018/README                             |  18 +++
 t/t4018/cpp-c++-function                   |   4 +
 t/t4018/cpp-class-constructor              |   4 +
 t/t4018/cpp-class-constructor-mem-init     |   5 +
 t/t4018/cpp-class-definition               |   4 +
 t/t4018/cpp-class-definition-derived       |   5 +
 t/t4018/cpp-class-destructor               |   4 +
 t/t4018/cpp-function-returning-global-type |   4 +
 t/t4018/cpp-function-returning-nested      |   5 +
 t/t4018/cpp-function-returning-pointer     |   4 +
 t/t4018/cpp-function-returning-reference   |   4 +
 t/t4018/cpp-gnu-style-function             |   5 +
 t/t4018/cpp-namespace-definition           |   4 +
 t/t4018/cpp-operator-definition            |   4 +
 t/t4018/cpp-skip-access-specifiers         |   8 +
 t/t4018/cpp-skip-comment-block             |   9 ++
 t/t4018/cpp-skip-labels                    |   8 +
 t/t4018/cpp-struct-definition              |   9 ++
 t/t4018/cpp-struct-single-line             |   7 +
 t/t4018/cpp-template-function-definition   |   4 +
 t/t4018/cpp-union-definition               |   4 +
 t/t4018/cpp-void-c-function                |   4 +
 t/t4018/custom1-pattern                    |  17 +++
 t/t4018/custom2-match-to-end-of-line       |   8 +
 t/t4018/custom3-alternation-in-pattern     |  17 +++
 t/t4018/java-class-member-function         |   8 +
 t/t4018/perl-skip-end-of-heredoc           |   8 +
 t/t4018/perl-skip-forward-decl             |  10 ++
 t/t4018/perl-skip-sub-in-pod               |  18 +++
 t/t4018/perl-sub-definition                |   4 +
 t/t4018/perl-sub-definition-kr-brace       |   4 +
 userdiff.c                                 |  12 +-
 33 files changed, 303 insertions(+), 160 deletions(-)
 create mode 100644 t/t4018/README
 create mode 100644 t/t4018/cpp-c++-function
 create mode 100644 t/t4018/cpp-class-constructor
 create mode 100644 t/t4018/cpp-class-constructor-mem-init
 create mode 100644 t/t4018/cpp-class-definition
 create mode 100644 t/t4018/cpp-class-definition-derived
 create mode 100644 t/t4018/cpp-class-destructor
 create mode 100644 t/t4018/cpp-function-returning-global-type
 create mode 100644 t/t4018/cpp-function-returning-nested
 create mode 100644 t/t4018/cpp-function-returning-pointer
 create mode 100644 t/t4018/cpp-function-returning-reference
 create mode 100644 t/t4018/cpp-gnu-style-function
 create mode 100644 t/t4018/cpp-namespace-definition
 create mode 100644 t/t4018/cpp-operator-definition
 create mode 100644 t/t4018/cpp-skip-access-specifiers
 create mode 100644 t/t4018/cpp-skip-comment-block
 create mode 100644 t/t4018/cpp-skip-labels
 create mode 100644 t/t4018/cpp-struct-definition
 create mode 100644 t/t4018/cpp-struct-single-line
 create mode 100644 t/t4018/cpp-template-function-definition
 create mode 100644 t/t4018/cpp-union-definition
 create mode 100644 t/t4018/cpp-void-c-function
 create mode 100644 t/t4018/custom1-pattern
 create mode 100644 t/t4018/custom2-match-to-end-of-line
 create mode 100644 t/t4018/custom3-alternation-in-pattern
 create mode 100644 t/t4018/java-class-member-function
 create mode 100644 t/t4018/perl-skip-end-of-heredoc
 create mode 100644 t/t4018/perl-skip-forward-decl
 create mode 100644 t/t4018/perl-skip-sub-in-pod
 create mode 100644 t/t4018/perl-sub-definition
 create mode 100644 t/t4018/perl-sub-definition-kr-brace

-- 
1.8.5.2.244.g9fb3fb1
