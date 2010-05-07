From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/6] Add test_harness make target for testing with prove(1)
Date: Fri,  7 May 2010 19:37:05 +0000
Message-ID: <1273261025-31523-6-git-send-email-avarab@gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:40:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATPP-0003CZ-LJ
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0EGTkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:40:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0EGTkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:40:03 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1043881fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Jj3Y/IYkFI6kHZbsFZgdUmwxlp5AW+xNanfK+GhDlLA=;
        b=jkBUyHAyoMmWTQQGo8h8FHMxfGY4y8iLSPu/z9yY9QpMy8ho1V47s6vP3wLDlkIB1o
         6Mxdmn9eCFVIZw/EPC3SDvyBwigS+4IzA1+RH+21OhG6QaneybJCGoHqPx3w5INJK6kV
         K54IIt/nJG5wAwRYJdKqgQd1kA4rCX51mYZzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dAhQgzBVYcMW94JI0G2g8xW4XN6ajE/f25AxsTHA63F+Z0XcFVOe4HkFkpsVLnxQQq
         C23l7erNu1Zno9OY4Yqx3Q3fkLtZq3jvLoPZcdNXHlsWlFvRv1NAUD7XwcD5zH5kQdeN
         SveNlpF7/EJFGSNqVT4x9Zwa7Kfoz8GgTwX+A=
Received: by 10.223.4.217 with SMTP id 25mr553689fas.60.1273261202537;
        Fri, 07 May 2010 12:40:02 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm8000128faj.5.2010.05.07.12.40.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:40:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146566>

The --jobs option I'm supplying to prove(1) is not supported in all
prove versions, some older ones (before Perl 5.10.1) don't have
it. Anyone that's hacking Git probably has 5.10.1, and you can always
use the old `make test` for non-parallel tests.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile   |    3 +++
 t/Makefile |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..c72c3d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1912,6 +1912,9 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
=20
+test_harness: all
+	$(MAKE) -C t/ test_harness
+
 test-ctype$X: ctype.o
=20
 test-date$X: date.o ctype.o
diff --git a/t/Makefile b/t/Makefile
index 25c559b..ef876e4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -19,6 +19,9 @@ TSVN =3D $(wildcard t91[0-9][0-9]-*.sh)
 all: pre-clean
 	$(MAKE) aggregate-results-and-cleanup
=20
+test_harness:
+	prove --jobs 9 ./t[0-9]*.sh
+
 $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=3D.git/config '$(SHELL_PATH_SQ)' $@ $(=
GIT_TEST_OPTS)
=20
--=20
1.7.1.dirty
