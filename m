From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Fri, 30 Oct 2009 22:26:47 -0500
Message-ID: <20091031032647.GA5583@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031014441.GH5160@progeny.tock>
 <7vfx90co1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 04:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N44SI-0006Vv-2G
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 04:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbZJaDQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 23:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbZJaDQ2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 23:16:28 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:58740 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbZJaDQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 23:16:27 -0400
X-Greylist: delayed 3780 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2009 23:16:27 EDT
Received: by gxk26 with SMTP id 26so954446gxk.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YoKW2oUAR/O+nmlSXOGobzUgdJ5fb2LirhL//5RktDk=;
        b=WUEVKMOT2uI4foCJDjlwQuVG09ySBVFrlvRiZejAFWjccZRqf5s0u2cbrD1hZ0IRcw
         0YLZxZx9CGqgLclmT3iYbVjiJfqWLr4hU4D5RzF0gog8y2vkzfSRQRSZ3IXb0gj1fuCz
         CoZ7gw5fhg/OGiUy5WDF3tca3H2ZAYRFAGghY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KhTlVjIrUsPE53gV4JDulpEDGP7wjEWvTfIx8UTRnHXR3nRKGeCJPA1hqWmQpXBQIp
         OxgnguacFYfyxWM/i+fRI46ftyUWMLXoZIii5tmYGEzr6qVEAOas1+2aWrDZQECekA/Z
         ANsLnDjgosLLQ8MSPOb1GcFNnrXOXmLE7eLNM=
Received: by 10.91.148.16 with SMTP id a16mr6163805ago.119.1256958992152;
        Fri, 30 Oct 2009 20:16:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1641436yxe.18.2009.10.30.20.16.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 20:16:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfx90co1e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131829>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
=20
>> +test_expect_success 'does editor have a simple name (no slashes, et=
c)?' '
>> +
>> +	editor=3D$(TERM=3Dvt100 git var GIT_EDITOR) &&
>> +	test -n "$editor" &&
>> +	simple=3Dt &&
>> +	case "$editor" in
>> +	*/* | core_editor | [A-Z]*)
>=20
> Hmm, what are the latter two cases designed to catch?

Both are meant to allow the test to work without too many changes.
The core_editor case is a little pedantic, since it is unlikely to
actually come up in practice.  With a default editor of core_editor,
the initial loop will overwrite e-core_editor.sh (to be used through
the core.editor configuration) with e-core_editor.sh (to be used as a
fallback editor) before renaming it to core_editor.

I missed some other cases: If editor is .git, e-GIT_EDITOR.sh, etc,
the mv will still misbehave.

The [A-Z]* test is to avoid changing the loop around line 86:

| unset EDITOR VISUAL GIT_EDITOR
| git config --unset-all core.editor
| for i in "$editor" EDITOR VISUAL core_editor GIT_EDITOR
| do
|	echo "Edited by $i" >expect
|	case "$i" in
|	core_editor)
|		git config core.editor ./e-core_editor.sh
|		;;
|	[A-Z]*)
|		eval "$i=3D./e-$i.sh"
|		export $i
|		;;
|	esac
|	test_expect_success "Using $i (override)" '
|		git --exec-path=3D. commit --amend &&
|		git show -s --pretty=3Doneline |
|		sed -e "s/^[0-9a-f]* //" >actual &&
|		diff actual expect
|	'
| done

which I do not think is worth making more complicated.

Maybe it would be better to just check for an editor consisting only
of alphabetical characters.  Perhaps something like the following:

-- %< --
=46rom: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Provide a build time default-editor setting

Provide a DEFAULT_EDITOR knob to allow setting the fallback
editor to use instead of vi (when VISUAL, EDITOR, and GIT_EDITOR
are unset).  The value can be set at build time according to a
system=E2=80=99s policy.  For example, on Debian systems, the default
editor should be the 'editor' command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile          |   17 +++++++++++++++++
 editor.c          |    6 +++++-
 t/t7005-editor.sh |   27 ++++++++++++++++++++-------
 3 files changed, 42 insertions(+), 8 deletions(-)

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
index 4f98b72..2aac807 100644
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
index b647957..13c37de 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,7 +4,22 @@ test_description=3D'GIT_EDITOR, core.editor, and stuff=
'
=20
 . ./test-lib.sh
=20
-for i in GIT_EDITOR core_editor EDITOR VISUAL vi
+unset EDITOR VISUAL GIT_EDITOR
+
+test_expect_success 'determine default editor' '
+
+	editor=3D$(TERM=3Dvt100 git var GIT_EDITOR) &&
+	test -n "$editor"
+
+'
+
+if ! test -z "$(printf '%s\n' "$editor" | sed '/^[a-z]*$/d')"
+then
+	say 'skipping editor tests, default editor name too complicated'
+	test_done
+fi
+
+for i in GIT_EDITOR core_editor EDITOR VISUAL "$editor"
 do
 	cat >e-$i.sh <<-EOF
 	#!$SHELL_PATH
@@ -12,15 +27,13 @@ do
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
@@ -44,7 +57,7 @@ test_expect_success 'dumb should error out when falli=
ng back on vi' '
=20
 TERM=3Dvt100
 export TERM
-for i in vi EDITOR VISUAL core_editor GIT_EDITOR
+for i in "$editor" EDITOR VISUAL core_editor GIT_EDITOR
 do
 	echo "Edited by $i" >expect
 	unset EDITOR VISUAL GIT_EDITOR
@@ -68,7 +81,7 @@ done
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
