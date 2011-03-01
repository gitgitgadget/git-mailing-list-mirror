From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 2/2] git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
Date: Tue,  1 Mar 2011 22:49:37 +0000
Message-ID: <1299019777-19033-3-git-send-email-avarab@gmail.com>
References: <1299019777-19033-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 23:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYON-0003wy-7a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab1CAWuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 17:50:00 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43216 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab1CAWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:50:00 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so5073648bwz.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 14:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=a26h6ZHP0wUKMLgrI1ZO6ZMMXy/3Fbt6lnVGousAWZI=;
        b=v1AH+1kl2WMEEk0wdSyDrhg30joUI8tN5nEu/OKv+b7ACYldm5sYkpFwNWLT3+Ng4/
         0GRflWZ59CyrSBFTthZBQwqi7zstBZa5sXzu4vdBTeCA4+UUCGXrlB5sb0TUndDwoKJw
         3SQ9Jmg9ZZVfgOEOC9mRO1NmrDncWG4O/aPsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qIKlKvJRAv4JxeVKmPX52ag37MC++S1IE5lrw0hg9enar/ml7rxKFjUt0aTpmg3/xK
         nSX8sG8HQGTTwy/SKdCew5PIGsu3YtgwyP1LyEPMm//U9fxV6AkmL4dV+Toyq8B1qckb
         5ZEmv3Z2QPb8lB0aV7KBWLP01Uc4aIyDWldvk=
Received: by 10.204.152.220 with SMTP id h28mr6440779bkw.158.1299019799316;
        Tue, 01 Mar 2011 14:49:59 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm3733741bkf.8.2011.03.01.14.49.57
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 14:49:57 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1299019777-19033-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168272>

Add a no-op wrapper library for Git's shell scripts. To split up the
gettext series I'm first submitting patches to gettextize the source
tree before I add any of the Makefile and Shell library changes needed
to actually use them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This documentation doesn't accurately reflect what it does *now*, but
what it'll do eventually later in the series.

 .gitignore                    |    1 +
 Documentation/git-sh-i18n.txt |   57 +++++++++++++++++++++++++++++++++=
++++++++
 Makefile                      |    1 +
 git-sh-i18n.sh                |   17 ++++++++++++
 4 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh

diff --git a/.gitignore b/.gitignore
index dad653d..e9ab0af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,6 +130,7 @@
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
+/git-sh-i18n
 /git-shell
 /git-shortlog
 /git-show
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.=
txt
new file mode 100644
index 0000000..b41b3af
--- /dev/null
+++ b/Documentation/git-sh-i18n.txt
@@ -0,0 +1,57 @@
+git-sh-i18n(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-sh-i18n - Git's i18n setup code for shell scripts
+
+SYNOPSIS
+--------
+'. "$(git --exec-path)/git-sh-i18n"'
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+Porcelain-ish scripts and/or are writing new ones.
+
+The 'git sh-i18n scriptlet is designed to be sourced (using
+`.`) by Git's porcelain programs implemented in shell
+script. It provides wrappers for the GNU `gettext` and
+`eval_gettext` functions accessible through the `gettext.sh`
+script, and provides pass-through fallbacks on systems
+without GNU gettext.
+
+FUNCTIONS
+---------
+
+gettext::
+	On GNU systems this will be the `gettext` function from
+	`gettext.sh`, on Solaris it`ll be the `gettext(1)`
+	command.
+
+	If neither of those implementations are available a
+	dummy fall-through function is provided.
+   =20
+eval_gettext::
+	On GNU systems this will be the `eval_gettext` function
+	from `gettext.sh`, on Solaris we provide an
+	`eval_gettext` using the
+	linkgit:git-sh-i18n--envsubst[1] helper.
+
+	If neither of those implementations are available a
+	dummy fall-through function is provided.
+
+Author
+------
+Written by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+
+Documentation
+--------------
+Documentation by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and the git-li=
st
+<git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index c002c08..f5fa8a6 100644
--- a/Makefile
+++ b/Makefile
@@ -386,6 +386,7 @@ SCRIPT_SH +=3D git-web--browse.sh
 SCRIPT_LIB +=3D git-mergetool--lib
 SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-sh-setup
+SCRIPT_LIB +=3D git-sh-i18n
=20
 SCRIPT_PERL +=3D git-add--interactive.perl
 SCRIPT_PERL +=3D git-difftool.perl
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
new file mode 100644
index 0000000..ea05e16
--- /dev/null
+++ b/git-sh-i18n.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+# This is a skeleton no-op implementation of gettext for Git. It'll be
+# replaced by something that uses gettext.sh in a future patch series.
+
+gettext () {
+	printf "%s" "$1"
+}
+
+eval_gettext () {
+	printf "%s" "$1" | (
+		export PATH $(git sh-i18n--envsubst --variables "$1");
+		git sh-i18n--envsubst "$1"
+	)
+}
--=20
1.7.4.1
