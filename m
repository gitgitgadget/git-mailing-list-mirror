From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] Provide a build time default-editor setting
Date: Fri, 30 Oct 2009 05:35:58 -0500
Message-ID: <20091030103558.GH1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3og6-000821-VV
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbZJ3KZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 06:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756762AbZJ3KZo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:25:44 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38751 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbZJ3KZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:25:43 -0400
Received: by yxe17 with SMTP id 17so2540923yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3GJA8wucVXxUR4K/ml5RnWy1/CDcIQ5pm741hyqBoJ0=;
        b=ebIxxGVXdI4sIneaJ7h0RjP8VkYY3K63J1ClbSIcYVtJxVqTbP5CrEsbv8+U7bMmIF
         LDuSI1bef51zSJMfTADplAhjtTNmtb2T5fWfSew1G4zlY9gHi5xJAXC+vt4ujX9WSPjX
         /99W7IGf7vbHThUNL9OCwV84ZrOkrMM3oUMOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pQykpJj36gLm5Ud2E4bYLas0MZEazCh123qZ1H0RXA5LFl2NnZdYmQTuYcJgYYsPCQ
         PaLSN85mYRUcrt9UTikHtFaYI3CtP9JF3+wFpdyowuujPQ2Kh/OCWIIptpJs0bT0SJbE
         HoGaDxE3T8Kt4ZZhpLBtkKbAFAN9VTD0YLAzU=
Received: by 10.150.81.5 with SMTP id e5mr2604287ybb.146.1256898348486;
        Fri, 30 Oct 2009 03:25:48 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm528505gxk.8.2009.10.30.03.25.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:25:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131691>

Provide a DEFAULT_EDITOR knob to allow setting the fallback
editor to use instead of vi (when VISUAL, EDITOR, and GIT_EDITOR
are unset).  The value can be set at build time according to a
system=E2=80=99s policy.  For example, on Debian systems, the default
editor should be the 'editor' command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile          |   17 +++++++++++++++++
 editor.c          |   11 ++++++++---
 t/t7005-editor.sh |   31 ++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 268aede..625866c 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,14 @@ all::
 # memory allocators with the nedmalloc allocator written by Niall Doug=
las.
 #
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
+#
+# Define DEFAULT_EDITOR to a sensible editor command (defaults to "vi"=
) if you
+# want to use something different.  The value will be interpreted by t=
he shell
+# if necessary when it is used.  Examples:
+#
+#   DEFAULT_EDITOR=3D'~/bin/vi',
+#   DEFAULT_EDITOR=3D'$GIT_FALLBACK_EDITOR',
+#   DEFAULT_EDITOR=3D'"C:\Program Files\Vim\gvim.exe" --nofork'
=20
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1363,6 +1371,15 @@ BASIC_CFLAGS +=3D -DSHA1_HEADER=3D'$(SHA1_HEADER=
_SQ)' \
 	$(COMPAT_CFLAGS)
 LIB_OBJS +=3D $(COMPAT_OBJS)
=20
+# Quote for C
+
+ifdef DEFAULT_EDITOR
+DEFAULT_EDITOR_CQ =3D "$(subst ",\",$(subst \,\\,$(DEFAULT_EDITOR)))"
+DEFAULT_EDITOR_CQ_SQ =3D $(subst ','\'',$(DEFAULT_EDITOR_CQ))
+
+BASIC_CFLAGS +=3D -DDEFAULT_EDITOR=3D'$(DEFAULT_EDITOR_CQ_SQ)'
+endif
+
 ALL_CFLAGS +=3D $(BASIC_CFLAGS)
 ALL_LDFLAGS +=3D $(BASIC_LDFLAGS)
=20
diff --git a/editor.c b/editor.c
index 9dcf95c..fcf35a8 100644
--- a/editor.c
+++ b/editor.c
@@ -2,6 +2,10 @@
 #include "strbuf.h"
 #include "run-command.h"
=20
+#ifndef DEFAULT_EDITOR
+#define DEFAULT_EDITOR "vi"
+#endif
+
 const char *git_editor(void)
 {
 	const char *editor, *terminal;
@@ -19,15 +23,16 @@ const char *git_editor(void)
 		/* Terminal is dumb but no VISUAL nor EDITOR defined. */
 		error(
 		  "No editor specified in GIT_EDITOR, core.editor, VISUAL,\n"
-		  "or EDITOR. Tried to fall back to vi but terminal is dumb.\n"
+		  "or EDITOR. Tried to fall back to %s but terminal is dumb.\n"
 		  "Please set one of these variables to an appropriate\n"
 		  "editor or run again with options that will not cause an\n"
-		  "editor to be invoked (e.g., -m or -F for git commit).");
+		  "editor to be invoked (e.g., -m or -F for git commit).",
+		  DEFAULT_EDITOR);
 		return NULL;
 	}
=20
 	if (!editor)
-		editor =3D "vi";
+		editor =3D DEFAULT_EDITOR;
=20
 	return editor;
 }
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b647957..73ba44c 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,7 +4,26 @@ test_description=3D'GIT_EDITOR, core.editor, and stuff=
'
=20
 . ./test-lib.sh
=20
-for i in GIT_EDITOR core_editor EDITOR VISUAL vi
+unset EDITOR VISUAL GIT_EDITOR
+
+test_expect_success 'does editor have a simple name (no slashes, etc)?=
' '
+
+	editor=3D$(TERM=3Dvt100 git var GIT_EDITOR) &&
+	test -n "$editor" &&
+	simple=3Dt &&
+	case "$editor" in
+	*/* | core_editor | [A-Z]*)
+		unset simple;;
+	esac
+
+'
+if test -z "${simple+set}"
+then
+	say 'skipping editor tests, default editor is not sought on PATH'
+	test_done
+fi
+
+for i in GIT_EDITOR core_editor EDITOR VISUAL "$editor"
 do
 	cat >e-$i.sh <<-EOF
 	#!$SHELL_PATH
@@ -12,15 +31,13 @@ do
 	EOF
 	chmod +x e-$i.sh
 done
-unset vi
-mv e-vi.sh vi
-unset EDITOR VISUAL GIT_EDITOR
+mv "e-$editor.sh" "$editor"
=20
 test_expect_success setup '
=20
 	msg=3D"Hand edited" &&
 	echo "$msg" >expect &&
-	git add vi &&
+	git add "$editor" &&
 	test_tick &&
 	git commit -m "$msg" &&
 	git show -s --pretty=3Doneline |
@@ -44,7 +61,7 @@ test_expect_success 'dumb should error out when falli=
ng back on vi' '
=20
 TERM=3Dvt100
 export TERM
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in "$editor" EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	unset EDITOR VISUAL GIT_EDITOR
@@ -68,7 +85,7 @@ done
=20
 unset EDITOR VISUAL GIT_EDITOR
 git config --unset-all core.editor
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in "$editor" EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	case "$i" in
--=20
1.6.5.2
