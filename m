From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] Makefile: Add help target
Date: Wed, 25 Aug 2010 02:51:53 -0700
Message-ID: <1282729913-25114-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 11:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoCeU-0003UP-32
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 11:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab0HYJwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 05:52:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43187 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab0HYJwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 05:52:05 -0400
Received: by gwj17 with SMTP id 17so128366gwj.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ePQqAtAQdacjbh22GUIPnBxhIhL2Il6Sb/jzlB4kOLE=;
        b=VjYe7OLeTVyYieH6hr6yd25S/Otenihkh2VeCRsmZNZ7XKhK8HlNYoGthN9uPRPd4u
         krbFQJDvaLKR337aWTxY3ahhinR39fRsezvbW9LIGFnkH6rUw/ayIUgRIMZRax+ITeKq
         V9vwvcXryXpzATWsxSNnBTrno0YbDNXvTojaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qmrzFQRrQ18X8JyiUVluf1B4U0jcnliOnyKyMjlSyIA5agImitz724qb0VEONWq+Nw
         vHF1rNJSaphIcNrrtjwfXKhFGvfaEB6XBhINBidWFEqHj4TTb/6cxOWXot2ikO780uNB
         QD5uz8SPylpxfhdKdQZVJGuF3kyuNtDboy8v8=
Received: by 10.151.4.11 with SMTP id g11mr8073973ybi.262.1282729924152;
        Wed, 25 Aug 2010 02:52:04 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id 18sm6015724ybk.7.2010.08.25.02.52.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 02:52:02 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 25 Aug 2010 02:51:53 -0700
X-Mailer: git-send-email 1.7.2.2.169.gb5442
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154436>

Today I forgot whether the target was quick-install-doc or
install-quick-doc and had to open the Makefile again to find out. I'd
rather not do that and just use:

	$ make help

to get a quick summary of the interesting targets when my brain fails to
refresh. Add a help target, but don't add uninteresting things like
strip, install-gitweb, or targets which alias (install-man).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Some things I noticed:

 * make V=0 is verbose

 * sparse checking looks broken for the builtin/ directory structure

 * t/Makefile has a target for valgrind, but the toplevel makefile doesn't

 * 'make tags/TAGS/cscope' is always verbose

 * I stay up late on Tuesdays

 Makefile |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4745a5..8c90c33 100644
--- a/Makefile
+++ b/Makefile
@@ -2307,3 +2307,43 @@ coverage-report:
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
+
+help:
+	@echo 'Cleaning targets:'
+	@echo '  clean      - Remove generated files but keep the configure script'
+	@echo '  distclean  - Remove generated files and the configure script'
+	@echo
+	@echo 'Packaging targets:'
+	@echo '  dist       - Build git-$(GIT_VERSION).tar.gz source tarball'
+	@echo '  rpm        - Build source and binary RPM packages'
+	@echo '  dist-doc   - Build $(manpages).tar.gz and $(htmldocs).tar.gz'
+	@echo
+	@echo 'Documentation targets:'
+	@echo '  doc     - Build man pages and HTML docs'
+	@echo '  man     - Build man pages'
+	@echo '  html    - Build HTML docs'
+	@echo '  info    - Build info docs'
+	@echo '  pdf     - Build PDF docs'
+	@echo
+	@echo 'Installation targets:'
+	@echo '  install             - Install the git suite'
+	@echo '  install-doc         - Install man pages'
+	@echo '  install-html        - Install HTML docs'
+	@echo '  install-info        - Install info docs'
+	@echo '  install-pdf         - Install PDF docs'
+	@echo '  quick-install-doc   - Install pregenerated man pages from origin/man'
+	@echo '  quick-install-html  - Install pregenerated HTML pages from origin/html'
+	@echo
+	@echo 'Common targets:'
+	@echo '  all            - Build the git suite'
+	@echo '  test           - Run the git test suite'
+	@echo
+	@echo 'Other targets:'
+	@echo '  tags/TAGS      - Generate tags for editors'
+	@echo '  cscope         - Generate cscope index'
+	@echo '  coverage       - Build git with gcov support, run the test suite, and'
+	@echo '                   report untested functions'
+	@echo '  check          - Check C sources with sparse'
+	@echo
+	@echo '  make V=1 [targets] verbose build'
+	@echo
-- 
1.7.2.2.169.gb5442
