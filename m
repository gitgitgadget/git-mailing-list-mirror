From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Fri, 08 Aug 2008 02:31:03 -0700
Message-ID: <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Aug 08 11:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KROKV-0008Us-4n
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 11:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYHHJbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYHHJbN
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 05:31:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbYHHJbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 05:31:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C83EA59D62;
	Fri,  8 Aug 2008 05:31:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D858359D61; Fri,  8 Aug 2008 05:31:05 -0400 (EDT)
In-Reply-To: <7vprojgbbu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Aug 2008 01:28:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC98A45E-652C-11DD-B354-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91642>

I'll push this out as 'test-deeper' branch to repo.or.cz (alt-git.git)
because the test suite has unprintable bytes that are inappropriate for
e-mail transmission.

-- >8 --
Many test scripts assumed that they will start in a 'trash' subdirectory
that is a single level down from the t/ directory, and referred to their
test vector files by asking for files like "../t9999/expect".  This will
break if we move the 'trash' subdirectory elsewhere.

To solve this, we earlier introduced "$TEST_DIRECTORY" so that they can
refer to t/ directory reliably.  This finally makes all the tests use
it to refer to the outside environment.

With this patch, and a one-liner not included here (because it would
contradict with what Dscho really wants to do):

| diff --git a/t/test-lib.sh b/t/test-lib.sh
| index 70ea7e0..60e69e4 100644
| --- a/t/test-lib.sh
| +++ b/t/test-lib.sh
| @@ -485,7 +485,7 @@ fi
|  . ../GIT-BUILD-OPTIONS
|
|  # Test repository
| -test="trash directory"
| +test="trash directory/another level/yet another"
|  rm -fr "$test" || {
|         trap - exit
|         echo >&5 "FATAL: Cannot prepare test area"

all the tests still pass, but we would want extra sets of eyeballs on this
type of change to really make sure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0022-crlf-rename.sh                   |    4 ++--
 t/t1000-read-tree-m-3way.sh              |    2 +-
 t/t3900-i18n-commit.sh                   |   18 +++++++++---------
 t/t3901-i18n-patch.sh                    |   28 ++++++++++++++--------------
 t/t4000-diff-format.sh                   |    2 +-
 t/t4001-diff-rename.sh                   |    2 +-
 t/t4002-diff-basic.sh                    |    2 +-
 t/t4003-diff-rename-1.sh                 |    6 +++---
 t/t4004-diff-rename-symlink.sh           |    2 +-
 t/t4005-diff-rename-2.sh                 |    6 +++---
 t/t4007-rename-3.sh                      |    4 ++--
 t/t4008-diff-break-rewrite.sh            |    6 +++---
 t/t4009-diff-rename-4.sh                 |    6 +++---
 t/t4010-diff-pathspec.sh                 |    2 +-
 t/t4011-diff-symlink.sh                  |    2 +-
 t/t4012-diff-binary.sh                   |    2 +-
 t/t4013-diff-various.sh                  |    2 +-
 t/t4015-diff-whitespace.sh               |    2 +-
 t/t4020-diff-external.sh                 |    2 +-
 t/t4022-diff-rewrite.sh                  |    4 ++--
 t/t4023-diff-rename-typechange.sh        |   14 +++++++-------
 t/t4027-diff-submodule.sh                |    2 +-
 t/t4100-apply-stat.sh                    |    4 ++--
 t/t4101-apply-nonl.sh                    |    2 +-
 t/t5100-mailinfo.sh                      |   18 +++++++++---------
 t/t5515-fetch-merge-logic.sh             |    4 ++--
 t/t5540-http-push.sh                     |    2 +-
 t/t6002-rev-list-bisect.sh               |    2 +-
 t/t6003-rev-list-topo-order.sh           |    2 +-
 t/t6023-merge-file.sh                    |    2 +-
 t/t6027-merge-binary.sh                  |    2 +-
 t/t6101-rev-parse-parents.sh             |    2 +-
 t/t6200-fmt-merge-msg.sh                 |    4 ++--
 t/t7001-mv.sh                            |    4 ++--
 t/t7004-tag.sh                           |    2 +-
 t/t7101-reset.sh                         |   10 +++++-----
 t/t7500-commit.sh                        |   16 ++++++++--------
 t/t8001-annotate.sh                      |    2 +-
 t/t8002-blame.sh                         |    2 +-
 t/t9110-git-svn-use-svm-props.sh         |    2 +-
 t/t9111-git-svn-use-svnsync-props.sh     |    2 +-
 t/t9115-git-svn-dcommit-funky-renames.sh |    2 +-
 t/t9121-git-svn-fetch-renamed-dir.sh     |    2 +-
 t/t9200-git-cvsexportcommit.sh           |   14 +++++++-------
 t/t9300-fast-import.sh                   |    2 +-
 t/t9301-fast-export.sh                   |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |   16 ++++++++--------
 t/t9700-perl-git.sh                      |    2 +-
 t/t9700/test.pl                          |    3 ---
 t/test-lib.sh                            |    2 +-
 50 files changed, 123 insertions(+), 126 deletions(-)
