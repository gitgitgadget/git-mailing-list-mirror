From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Wed,  9 Jun 2010 15:22:21 +0000
Message-ID: <1276096943-32671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 17:23:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMN7v-000267-B1
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab0FIPX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 11:23:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39263 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab0FIPX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 11:23:26 -0400
Received: by bwz11 with SMTP id 11so1590842bwz.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/5POUrnMEOQLpwNh609PiNcDDoNNKf5U0CjaTdi2ous=;
        b=clyeV7jgmFyF9dOrQc8J7bSXrfxnjejBaO9tRUVKGWw4XQtATkwBs4mMWzeGBrUf1S
         JpDx9pNq+FZDnyVLPm1fAQgTRo9ItY50NVi9VqiIsNgu5diKL1MNtXCr4o59YdkKZl8D
         BO43KAMp45Q37vVUnTzDDuAVQjNmQyLjORpnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EFDDNZsE41/8s93OxUGZosIMLWQwuu4DzxH/55Pppp+fbVCmdqFtBfuVkGQUrjVuoX
         gFMH0cNZjowWk2e1K3dsv/zfxp8GJ/RGbZ2K0OmYanZN0yTdBWwUuAqYDq3ionfXAT1X
         5C6Dkk1MWqPWNa7TZibbAVovZLGXfQ3COMQRw=
Received: by 10.204.84.18 with SMTP id h18mr6708927bkl.13.1276097005133;
        Wed, 09 Jun 2010 08:23:25 -0700 (PDT)
Received: from localhost.localdomain ([188.110.74.26])
        by mx.google.com with ESMTPS id f13sm4817541bka.5.2010.06.09.08.23.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 08:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148783>

This is a re-submission of my previous TAP patch series to apply
cleanly to the 'next' branch. 2/6 patches from the series already made
it into 'next', so I've rebased the series accordingly. I've also
removed the "Add test_harness make target for testing with prove(1)"
that allowed running `make test_harness' at the top-level sinc Junio
didn't see much point in it.

To recap on what this series is all about:
   =20
    TAP, the Test Anything Protocol, is a simple text-based interface
    between testing modules in a test harness. test-lib.sh's output was
    already very close to being valid TAP. This change brings it all th=
e
    way there.

All this series does is slightly adjust the raw text output of our
tests so that it conforms. to the TAP standard, i.e. instead of this:

   $ ./t0005-signals.sh
   *   ok 1: sigchain works
   * passed all 1 test(s)

We get this:

   $ ./t0005-signals.sh
   ok 1 - sigchain works
   # passed all 1 test(s)
   1..1

Changing the output format like this gives us the ability to run the
Git tests with any TAP tool (like prove(1)) at no extra cost. Every
other existing way of running the tests continues to work, it's just
easier for machines to read the output now.
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  Make test-lib.sh emit valid TAP format
  Skip tests in a way that makes sense under TAP
  We use TAP so the Perl test can run without scaffolding

 t/README                               |   49 +++++++++++------
 t/lib-git-svn.sh                       |    4 +-
 t/lib-httpd.sh                         |    3 +-
 t/t1304-default-acl.sh                 |    9 ++-
 t/t1509-root-worktree.sh               |    6 +-
 t/t2007-checkout-symlink.sh            |    2 +-
 t/t3300-funny-names.sh                 |    2 +-
 t/t3302-notes-index-expensive.sh       |    2 +-
 t/t3600-rm.sh                          |    2 +-
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
 t/t9700-perl-git.sh                    |   11 ++--
 t/t9700/test.pl                        |    9 +++
 t/test-lib.sh                          |   92 ++++++------------------=
-------
 43 files changed, 119 insertions(+), 148 deletions(-)
