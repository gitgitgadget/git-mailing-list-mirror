From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] Provide a build time default-editor setting
Date: Wed, 11 Nov 2009 18:03:55 -0600
Message-ID: <20091112000355.GI1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8N0Y-0000fR-E3
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382AbZKKXxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbZKKXxh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:53:37 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:62075 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbZKKXxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:53:36 -0500
Received: by ywh6 with SMTP id 6so1463850ywh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ayxuIjUBHQ+PxaYC54dB1Cs0sxIutY2vDe9VmboycCU=;
        b=W7qcm35bBQFKo/uAUNkR5iWuNCSKSJdfYT/nFTzZbJjwitoyspU7aVgCzAX5QwHbtB
         ChXfzIJuWN7CAMtB8o/Syc/dST8Jh0OPwZo+uzyDYHgoQNBpRb9ZD1P6f8LeSAWTHZst
         vtbq+a+McYUM53QM6NzJRfWehP1eMYoJk8QJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OevyFn8AscIXrzT0fXV6poYPMPPDQDOoj6cOfcs6GBoDkfnHog45kRAYJhIZ4rChkr
         2fEiOHRzxvdTfRag0PHAsU0tk1Ony6tZc+vEuIMO3qD81nDnqLvI2xdGgj87wf49ZoRo
         gi4CEny49ragbArZ0Y7a3wAMW73BdnxSMeO+c=
Received: by 10.91.18.24 with SMTP id v24mr3346035agi.61.1257983622390;
        Wed, 11 Nov 2009 15:53:42 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 9sm1029007yxf.41.2009.11.11.15.53.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:53:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132729>

Provide a DEFAULT_EDITOR knob to allow setting the fallback
editor to use instead of vi (when VISUAL, EDITOR, and GIT_EDITOR
are unset).  The value can be set at build time according to a
system=E2=80=99s policy.  For example, on Debian systems, the default
editor should be the 'editor' command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Unchanged.

 Makefile          |   17 +++++++++++++++++
 editor.c          |    6 +++++-
 t/t7005-editor.sh |   37 +++++++++++++++++++++++++------------
 3 files changed, 47 insertions(+), 13 deletions(-)

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
index 70618f1..615f575 100644
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
 	const char *editor =3D getenv("GIT_EDITOR");
@@ -19,7 +23,7 @@ const char *git_editor(void)
 		return NULL;
=20
 	if (!editor)
-		editor =3D "vi";
+		editor =3D DEFAULT_EDITOR;
=20
 	return editor;
 }
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index a95fe19..5257f4d 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,7 +4,21 @@ test_description=3D'GIT_EDITOR, core.editor, and stuff=
'
=20
 . ./test-lib.sh
=20
-for i in GIT_EDITOR core_editor EDITOR VISUAL vi
+unset EDITOR VISUAL GIT_EDITOR
+
+test_expect_success 'determine default editor' '
+
+	vi=3D$(TERM=3Dvt100 git var GIT_EDITOR) &&
+	test -n "$vi"
+
+'
+
+if ! expr "$vi" : '^[a-z]*$' >/dev/null
+then
+	vi=3D
+fi
+
+for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
 do
 	cat >e-$i.sh <<-EOF
 	#!$SHELL_PATH
@@ -12,19 +26,18 @@ do
 	EOF
 	chmod +x e-$i.sh
 done
-unset vi
-mv e-vi.sh vi
-unset EDITOR VISUAL GIT_EDITOR
+
+if ! test -z "$vi"
+then
+	mv e-$vi.sh $vi
+fi
=20
 test_expect_success setup '
=20
-	msg=3D"Hand edited" &&
+	msg=3D"Hand-edited" &&
+	test_commit "$msg" &&
 	echo "$msg" >expect &&
-	git add vi &&
-	test_tick &&
-	git commit -m "$msg" &&
-	git show -s --pretty=3Doneline |
-	sed -e "s/^[0-9a-f]* //" >actual &&
+	git show -s --format=3D%s > actual &&
 	diff actual expect
=20
 '
@@ -54,7 +67,7 @@ test_expect_success 'dumb should prefer EDITOR to VIS=
UAL' '
=20
 TERM=3Dvt100
 export TERM
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	unset EDITOR VISUAL GIT_EDITOR
@@ -78,7 +91,7 @@ done
=20
 unset EDITOR VISUAL GIT_EDITOR
 git config --unset-all core.editor
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	case "$i" in
--=20
1.6.5.2
