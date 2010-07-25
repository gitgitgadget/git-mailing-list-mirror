From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 0/7] Detailed test coverage reports for Git
Date: Sun, 25 Jul 2010 19:52:38 +0000
Message-ID: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 21:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7G9-0003sr-B9
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab0GYTxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:05 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45797 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab0GYTxC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:02 -0400
Received: by eya25 with SMTP id 25so351985eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=BOd1x4/JreMDH2GtbO0heEZhucGZJxGvvNpsXMn7FaI=;
        b=drkswgJ5TWGXF2jIDuCiqTUpMYrSm1FSfJoGDm1pI6wwh3nN+j1Svz1EUG+j+I8niD
         y3TWTIzvOyoh3rxErn+EYodYn7iGoaG9V/PaAa7uxdYj1TSZBARwR99cbp7fF2GO9upJ
         8kCBZggkgNAk6K6puednJNZ4Rmj6lIJjXOfdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=USyGG9Al/QRrL8cnJ/j6MKCZUq6jSXF3IIchGQPH2i2K6jnm5ARkDHSUDDevN9uWut
         WiMO4Ht4gAlAgjPETKPqnQEZK8eBF88bTs+BAwo0u1HjTwOKIr0AWasXDV7CW13TuUxz
         YjxWWNRwf+6PrDSPHc24sP49ReCjgtZP8BIS8=
Received: by 10.213.7.2 with SMTP id b2mr2857675ebb.43.1280087580594;
        Sun, 25 Jul 2010 12:53:00 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.52.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:52:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151781>

Here's v3 of the patch. It's almost entirely changes from Jonathan
Nieder mentioned in the review for v2 (minus the bugs). Thanks
Jonathan!

Here's the stat from v2:
  =20
    .gitignore |   12 ++++++------
    Makefile   |   15 ++++++++++-----
    t/README   |    8 ++++----
    3 files changed, 20 insertions(+), 15 deletions(-)
  =20
And the diff:
   =20
    diff --git a/.gitignore b/.gitignore
    index baed247..0a30a7e 100644
    --- a/.gitignore
    +++ b/.gitignore
    @@ -183,0 +184,6 @@
    +*.gcda
    +*.gcno
    +*.gcov
    +/coverage-untested-functions
    +/cover_db/
    +/cover_db_html/
    @@ -207,6 +212,0 @@
    -*.gcda
    -*.gcno
    -*.gcov
    -/coverage-untested-functions
    -/cover_db
    -/cover_db_html
    diff --git a/Makefile b/Makefile
    index b6975aa..fdfa4fe 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -1487,0 +1488 @@ ifndef V
    +	QUIET_GCOV     =3D @echo '   ' GCOV $@;
    @@ -2287,0 +2289,3 @@ coverage-clean:
    +	$(RM) coverage-untested-functions
    +	$(RM) -r cover_db/
    +	$(RM) -r cover_db_html/
    @@ -2290,0 +2295 @@ COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
    +GCOVFLAGS =3D --preserve-paths --branch-probabilities --all-blocks
    @@ -2298,2 +2303,2 @@ coverage-report:
    -	for dir in $(object_dirs); do \
    -		gcov --preserve-paths --branch-probabilities --all-blocks --obje=
ct-directory=3D$$dir $$dir*.c; \
    +	$(QUIET_GCOV)for dir in $(object_dirs); do \
    +		gcov $(GCOVFLAGS) --object-directory=3D$$dir $$dir*.c || exit; \
    @@ -2305 +2310 @@ coverage-untested-functions: coverage-report
    -		| tee coverage-untested-functions
    +		> coverage-untested-functions
    @@ -2307 +2312 @@ coverage-untested-functions: coverage-report
    -coverage-report-cover-db: coverage-report
    +cover_db: coverage-report
    @@ -2310 +2315 @@ coverage-report-cover-db: coverage-report
    -coverage-report-cover-db-html: coverage-report-cover-db
    +cover_db_html: cover_db
    diff --git a/t/README b/t/README
    index 400e2da..4fe8d50 100644
    --- a/t/README
    +++ b/t/README
    @@ -270 +270 @@ Do:
    -   =20
    +
    @@ -534 +534 @@ directory):
    -   =20
    +
    @@ -554 +554 @@ Devel::Cover module. To install it do:
    -  =20
    +
    @@ -557 +557 @@ Then, at the top-level:
    -    make coverage-report-cover-db-html
    +    make cover_db_html
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  gitignore: Ignore files generated by "make coverage"
  Makefile: Include subdirectories in "make cover" reports
  Makefile: Split out the untested functions target
  Makefile: Add coverage-report-cover-db target
  Makefile: Add coverage-report-cover-db-html target
  t/README: A new section about test coverage
  t/README: Add a note about the dangers of coverage chasing

 .gitignore |    6 ++++++
 Makefile   |   24 +++++++++++++++++++++---
 t/README   |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 3 deletions(-)
