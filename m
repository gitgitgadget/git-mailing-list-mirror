From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/48] remote-hg: fixes for next
Date: Fri, 24 May 2013 21:29:16 -0500
Message-ID: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Go-0001FF-NY
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3EYCbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:31:42 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63294 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab3EYCbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:31:42 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so6224034obb.2
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/8uhndSzkDpSFYhsp+RNcLE45xsjSGm2HNybgKMCiu0=;
        b=bzzWrG4CQrNczyIxawN7jqsYpgLwpqEWSNxco9XH7f3o3sk5iqso4YBeanbHmjwei4
         hHXV+QHMVN3//590+d31GEF7XKEsCImYbBQeaNwaS6Dg/aObkMbN/SOxasMEpAX7rdOI
         mfa1FeQxTMsmzP0MNA+RUXmfAg6MjzvckREuYFiutIOPjDbNgH3cpLzGQ6e+hJFYWrif
         MQMB9EZZNgKa5Ah8RH9tG/b/vZUQivHnLSmFNFNDCG2P4Nx5tCY5ZOygJ5EZSL4cktPt
         P4K5B0et40UIY7RzbHDu6B6U2PnMWUaz811gSUmM2d/jR2+4R4xZbowEv57rgmdxqJ02
         UfxQ==
X-Received: by 10.60.102.178 with SMTP id fp18mr13412568oeb.35.1369449101696;
        Fri, 24 May 2013 19:31:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm20545468oeb.7.2013.05.24.19.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225414>

Hi,

Since v1 there's a few backward compatibility fixes, and new patches at the end
for new feature, some which require patches to the remote helper
infraestructure.

I've been cooking these for some time now, and they seem to be mostly ready.
The major changes are:

 1) Use our own custom push() method that allows us to push bookmarks without
    having to force a push.

 2) Switch from revision numbers to SHA-1s in the marks.

 3) Use a common repsitory so multiple remotes chan share the same objects.

 4) Cleaned up and add a ton of tests

 5) Much improved push feedback reporting

With these, we pass all the tests from gitifyhg as well as our own.

Felipe Contreras (48):
  remote-hg: test: be a little more quiet
  remote-hg: trivial reorganization
  remote-helpers: test: cleanup white-spaces
  remote-helpers: test: cleanup style
  remote-helpers: tests: general improvements
  remote-helpers: test: simplify remote URLs
  remote-hg: test: simplify previous branch checkout
  remote-hg: load all extensions
  remote-hg: use a shared repository store
  remote-hg: shuffle some code
  remote-hg: improve node traversing
  remote-hg: add version checks to the marks
  remote-hg: switch from revisions to SHA-1 noteids
  remote-hg: upgrade version 1 marks
  remote-hg: ensure remote rebasing works
  remote-hg: trivial cleanups
  remote-hg: improve progress calculation
  remote-hg: always point HEAD to master
  remote-hg: add tests for 'master' bookmark
  remote-bzr: simplify test checks
  remote-hg: add check_bookmark() test helper
  remote-hg: update bookmarks when using a remote
  remote-hg: add remote tests
  remote-hg: add test to push new bookmark
  remote-hg: add test for diverged push
  remote-hg: add test for bookmark diverge
  remote-hg: add test for new bookmark special
  remote-hg: add test for big push
  remote-hg: add test for failed double push
  remote-hg: reorganize bookmark handling
  remote-hg: force remote bookmark push selectively
  remote-hg: only update necessary revisions
  remote-hg: implement custom push()
  remote-hg: implement custom checkheads()
  remote-hg: pass around revision refs
  remote-hg: check diverged bookmarks
  remote-hg: simplify branch_tip()
  remote-hg: improve branch listing
  remote-hg: use remote 'default' not local one
  remote-hg: improve lightweight tag author
  remote-hg: remove files before modifications
  remote-hg: add setup_big_push() helper
  remote-hg: add check_push() helper
  remote-helpers: improve marks usage
  remote-hg: trivial cleanup
  remote-hg: check if a fetch is needed
  remote-hg: add support for --dry-run
  remote-hg: add support for --force

 contrib/remote-helpers/git-remote-bzr    |   5 +-
 contrib/remote-helpers/git-remote-hg     | 510 ++++++++++++++++------
 contrib/remote-helpers/test-bzr.sh       | 490 +++++++++++----------
 contrib/remote-helpers/test-hg-bidi.sh   |  33 +-
 contrib/remote-helpers/test-hg-hg-git.sh |  44 +-
 contrib/remote-helpers/test-hg.sh        | 723 +++++++++++++++++++++++++++----
 6 files changed, 1291 insertions(+), 514 deletions(-)

-- 
1.8.3.rc3.312.g47657de
