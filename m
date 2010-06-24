From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 0/5] TAP support for Git
Date: Thu, 24 Jun 2010 17:44:44 +0000
Message-ID: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 19:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqU7-00050P-2v
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab0FXRo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 13:44:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49779 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0FXRo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:44:58 -0400
Received: by wwi17 with SMTP id 17so442610wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Fy17JHb7vedOAZCkLsL9ZtInJcgef1cQZQWAHCrc05Q=;
        b=gNI/trJUwWErRmV5iTj3E13rX/sfh3sX7/62w8+U/sA8SvbuSleuYkDc0QFksJhQpo
         blfwIg3+IYmRQUzI6bJ1SELP2z4/flBeaM3xRu1WsGHIPHUuAj+eJcsaCli8ygQXo3Bl
         CVzploA7uQIAg1AkMD/neaqwg05DR4rPtXd4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=hTznEaCfO77c7XcqyNSGG3U6LjsxGML3fAzonsMXrA0p7wpIhMPaiWV5yF3jzOLcDD
         /KTTvPO0IvN2jv5QAMHxkdbkd7llrEob0ibRNkUagwjI8BIHubG7Mrtp2XPF/+UhJ8e+
         dSEYpo2UhFAm5+LrdutcJU1v9+G37NA0R+08Y=
Received: by 10.227.142.140 with SMTP id q12mr9322397wbu.161.1277401497263;
        Thu, 24 Jun 2010 10:44:57 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id h1sm1043062wee.31.2010.06.24.10.44.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 10:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149608>

This is v4 of the TAP series for Git. This version fixes the failure
Junio had with it (see <7v6319duky.fsf@alter.siamese.dyndns.org>).

It does this by reverting the removal of the test_external_*
functions. Now they're made TAP aware instead with a global
`test_external_has_tap' that can be set by tests who wish to output
their own TAP.

Thus t9700-perl-git.sh will again fail if it has any output on stderr,
but since it sets `test_external_has_tap=3D1' we'll let it finalize its
own TAP plan.

Not removing the test_external_* makes the impact of this series
smaller, and preserves compatibility with other topics in-flight, such
as the Gettext series.

This is the diff --stat from v3:

 t/t9700-perl-git.sh |   11 ++++--
 t/test-lib.sh       |   97 +++++++++++++++++++++++++++++++++++++++++++=
+++++--
 2 files changed, 101 insertions(+), 7 deletions(-)

Most of the additions are the restorations of the test_external_*
functions, in slightly altered form.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  test-lib: Adjust output to be valid TAP format
  test-lib: Make the test_external_* functions TAP-aware
  test-lib: output a newline before "ok" under a TAP harness
  tests: Skip tests in a way that makes sense under TAP
  tests: Say "pass" rather than "ok" on empty lines for TAP

 t/README                               |   55 ++++++++++++++++-------
 t/lib-git-svn.sh                       |    4 +-
 t/lib-httpd.sh                         |    3 +-
 t/t1020-subdirectory.sh                |   12 +++---
 t/t1304-default-acl.sh                 |    9 +++-
 t/t1509-root-worktree.sh               |    6 +-
 t/t2007-checkout-symlink.sh            |    2 +-
 t/t2102-update-index-symlinks.sh       |    2 +-
 t/t3300-funny-names.sh                 |    2 +-
 t/t3302-notes-index-expensive.sh       |    2 +-
 t/t3600-rm.sh                          |    2 +-
 t/t3700-add.sh                         |   12 +++---
 t/t3701-add-interactive.sh             |    4 +-
 t/t3902-quoted.sh                      |    2 +-
 t/t4004-diff-rename-symlink.sh         |    2 +-
 t/t4011-diff-symlink.sh                |    2 +-
 t/t4016-diff-quote.sh                  |    2 +-
 t/t4023-diff-rename-typechange.sh      |    2 +-
 t/t4114-apply-typechange.sh            |    2 +-
 t/t4115-apply-symlink.sh               |    2 +-
 t/t4122-apply-symlink-inside.sh        |    2 +-
 t/t5302-pack-index.sh                  |    2 +-
 t/t5503-tagfollow.sh                   |    2 +-
 t/t5522-pull-symlink.sh                |    2 +-
 t/t5540-http-push.sh                   |    2 +-
 t/t5541-http-push.sh                   |    2 +-
 t/t5550-http-fetch.sh                  |    2 +-
 t/t5551-http-fetch.sh                  |    2 +-
 t/t5561-http-backend.sh                |    2 +-
 t/t5705-clone-2gb.sh                   |    2 +-
 t/t6035-merge-dir-to-symlink.sh        |    2 +-
 t/t7004-tag.sh                         |    2 +-
 t/t7006-pager.sh                       |    2 +-
 t/t7800-difftool.sh                    |    2 +-
 t/t9001-send-email.sh                  |    4 +-
 t/t9100-git-svn-basic.sh               |    2 +-
 t/t9119-git-svn-info.sh                |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
 t/t9143-git-svn-gc.sh                  |    2 +-
 t/t9200-git-cvsexportcommit.sh         |    4 +-
 t/t9400-git-cvsserver-server.sh        |    6 +-
 t/t9401-git-cvsserver-crlf.sh          |    6 +-
 t/t9600-cvsimport.sh                   |    2 +-
 t/t9700-perl-git.sh                    |    7 ++-
 t/t9700/test.pl                        |   11 +++++
 t/test-lib.sh                          |   76 +++++++++++++++++++++++-=
-------
 46 files changed, 178 insertions(+), 103 deletions(-)
