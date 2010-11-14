From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/4] Makefile: move "Platform specific tweaks" above LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 14:44:14 +0000
Message-ID: <1289745857-16704-2-git-send-email-avarab@gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 15:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHdpg-0003SW-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 15:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0KNOpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 09:45:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0KNOpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 09:45:20 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so3561989wyb.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1wVbTmB66hh7y7j7qtLAclsdjzmkRleTy5ZyIydrajY=;
        b=xhnta20KNyJYQ50STASvBfBKgve6wuE26NkXSydl0I/eGeSDaGetBNY/ufna1kuBX5
         CisiVRS2ZKHBp0U25rpqrdYw8Re35RSrHjCa/LOv4vkVrAhtcGyq09Y7yNeTnFk+6Pk/
         vnqhfkCGJD+TdaqlJF8MEqG/4BZhbSYP/rJcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=x6driRhqonjvgKWVRpD+5qwloQC8e3NVY7pEtrPTWU8oRZewPWm45Pa/xRD0cLOgfO
         S+WGGbGfdL4zFiRCbnvQpvUHBJ9ogKMchk1ujxBUc0/4tJtU6U7O86YjJkkj6y6IIXBN
         pYQ9SMfPxZj/3sO8fVZT3Hl2siFe58YYiHH64=
Received: by 10.216.141.79 with SMTP id f57mr3956362wej.101.1289745918253;
        Sun, 14 Nov 2010 06:45:18 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id y15sm3208613weq.6.2010.11.14.06.45.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 06:45:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
In-Reply-To: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161410>

Change the Makefile so that the "Platform specific tweaks" section
comes before the assignments to LIB_H and LIB_OBJS.

In the ab/i18n series I only want to build gettext.o (by adding it to
LIB_OBJS) if NO_GETTEXT is unset. It's not possible to do that without
an ugly hack if we haven't applied our platform specific tweaks before
LIB_{H,OBJS} gets assigned to.

See <201008140002.40587.j6t@kdbg.org> (subject: "[PATCH] Do not build
i18n on Windows.") for Johannes's original report, and my follow-up in
<AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com> where I
suggested that the problem be solved in the manner of this patch.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |  687 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 files changed, 344 insertions(+), 343 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..b1f5d8c 100644
--- a/Makefile
+++ b/Makefile
@@ -483,278 +483,6 @@ LIB_FILE=3Dlibgit.a
 XDIFF_LIB=3Dxdiff/lib.a
 VCSSVN_LIB=3Dvcs-svn/lib.a
=20
-LIB_H +=3D advice.h
-LIB_H +=3D archive.h
-LIB_H +=3D attr.h
-LIB_H +=3D blob.h
-LIB_H +=3D builtin.h
-LIB_H +=3D cache.h
-LIB_H +=3D cache-tree.h
-LIB_H +=3D color.h
-LIB_H +=3D commit.h
-LIB_H +=3D compat/bswap.h
-LIB_H +=3D compat/cygwin.h
-LIB_H +=3D compat/mingw.h
-LIB_H +=3D compat/win32/pthread.h
-LIB_H +=3D csum-file.h
-LIB_H +=3D decorate.h
-LIB_H +=3D delta.h
-LIB_H +=3D diffcore.h
-LIB_H +=3D diff.h
-LIB_H +=3D dir.h
-LIB_H +=3D exec_cmd.h
-LIB_H +=3D fsck.h
-LIB_H +=3D git-compat-util.h
-LIB_H +=3D graph.h
-LIB_H +=3D grep.h
-LIB_H +=3D hash.h
-LIB_H +=3D help.h
-LIB_H +=3D levenshtein.h
-LIB_H +=3D list-objects.h
-LIB_H +=3D ll-merge.h
-LIB_H +=3D log-tree.h
-LIB_H +=3D mailmap.h
-LIB_H +=3D merge-recursive.h
-LIB_H +=3D notes.h
-LIB_H +=3D notes-cache.h
-LIB_H +=3D object.h
-LIB_H +=3D pack.h
-LIB_H +=3D pack-refs.h
-LIB_H +=3D pack-revindex.h
-LIB_H +=3D parse-options.h
-LIB_H +=3D patch-ids.h
-LIB_H +=3D pkt-line.h
-LIB_H +=3D progress.h
-LIB_H +=3D quote.h
-LIB_H +=3D reflog-walk.h
-LIB_H +=3D refs.h
-LIB_H +=3D remote.h
-LIB_H +=3D rerere.h
-LIB_H +=3D resolve-undo.h
-LIB_H +=3D revision.h
-LIB_H +=3D run-command.h
-LIB_H +=3D sha1-lookup.h
-LIB_H +=3D sideband.h
-LIB_H +=3D sigchain.h
-LIB_H +=3D strbuf.h
-LIB_H +=3D string-list.h
-LIB_H +=3D submodule.h
-LIB_H +=3D tag.h
-LIB_H +=3D transport.h
-LIB_H +=3D tree.h
-LIB_H +=3D tree-walk.h
-LIB_H +=3D unpack-trees.h
-LIB_H +=3D userdiff.h
-LIB_H +=3D utf8.h
-LIB_H +=3D xdiff-interface.h
-LIB_H +=3D xdiff/xdiff.h
-
-LIB_OBJS +=3D abspath.o
-LIB_OBJS +=3D advice.o
-LIB_OBJS +=3D alias.o
-LIB_OBJS +=3D alloc.o
-LIB_OBJS +=3D archive.o
-LIB_OBJS +=3D archive-tar.o
-LIB_OBJS +=3D archive-zip.o
-LIB_OBJS +=3D attr.o
-LIB_OBJS +=3D base85.o
-LIB_OBJS +=3D bisect.o
-LIB_OBJS +=3D blob.o
-LIB_OBJS +=3D branch.o
-LIB_OBJS +=3D bundle.o
-LIB_OBJS +=3D cache-tree.o
-LIB_OBJS +=3D color.o
-LIB_OBJS +=3D combine-diff.o
-LIB_OBJS +=3D commit.o
-LIB_OBJS +=3D config.o
-LIB_OBJS +=3D connect.o
-LIB_OBJS +=3D convert.o
-LIB_OBJS +=3D copy.o
-LIB_OBJS +=3D csum-file.o
-LIB_OBJS +=3D ctype.o
-LIB_OBJS +=3D date.o
-LIB_OBJS +=3D decorate.o
-LIB_OBJS +=3D diffcore-break.o
-LIB_OBJS +=3D diffcore-delta.o
-LIB_OBJS +=3D diffcore-order.o
-LIB_OBJS +=3D diffcore-pickaxe.o
-LIB_OBJS +=3D diffcore-rename.o
-LIB_OBJS +=3D diff-delta.o
-LIB_OBJS +=3D diff-lib.o
-LIB_OBJS +=3D diff-no-index.o
-LIB_OBJS +=3D diff.o
-LIB_OBJS +=3D dir.o
-LIB_OBJS +=3D editor.o
-LIB_OBJS +=3D entry.o
-LIB_OBJS +=3D environment.o
-LIB_OBJS +=3D exec_cmd.o
-LIB_OBJS +=3D fsck.o
-LIB_OBJS +=3D graph.o
-LIB_OBJS +=3D grep.o
-LIB_OBJS +=3D hash.o
-LIB_OBJS +=3D help.o
-LIB_OBJS +=3D hex.o
-LIB_OBJS +=3D ident.o
-LIB_OBJS +=3D levenshtein.o
-LIB_OBJS +=3D list-objects.o
-LIB_OBJS +=3D ll-merge.o
-LIB_OBJS +=3D lockfile.o
-LIB_OBJS +=3D log-tree.o
-LIB_OBJS +=3D mailmap.o
-LIB_OBJS +=3D match-trees.o
-LIB_OBJS +=3D merge-file.o
-LIB_OBJS +=3D merge-recursive.o
-LIB_OBJS +=3D name-hash.o
-LIB_OBJS +=3D notes.o
-LIB_OBJS +=3D notes-cache.o
-LIB_OBJS +=3D object.o
-LIB_OBJS +=3D pack-check.o
-LIB_OBJS +=3D pack-refs.o
-LIB_OBJS +=3D pack-revindex.o
-LIB_OBJS +=3D pack-write.o
-LIB_OBJS +=3D pager.o
-LIB_OBJS +=3D parse-options.o
-LIB_OBJS +=3D patch-delta.o
-LIB_OBJS +=3D patch-ids.o
-LIB_OBJS +=3D path.o
-LIB_OBJS +=3D pkt-line.o
-LIB_OBJS +=3D preload-index.o
-LIB_OBJS +=3D pretty.o
-LIB_OBJS +=3D progress.o
-LIB_OBJS +=3D quote.o
-LIB_OBJS +=3D reachable.o
-LIB_OBJS +=3D read-cache.o
-LIB_OBJS +=3D reflog-walk.o
-LIB_OBJS +=3D refs.o
-LIB_OBJS +=3D remote.o
-LIB_OBJS +=3D replace_object.o
-LIB_OBJS +=3D rerere.o
-LIB_OBJS +=3D resolve-undo.o
-LIB_OBJS +=3D revision.o
-LIB_OBJS +=3D run-command.o
-LIB_OBJS +=3D server-info.o
-LIB_OBJS +=3D setup.o
-LIB_OBJS +=3D sha1-lookup.o
-LIB_OBJS +=3D sha1_file.o
-LIB_OBJS +=3D sha1_name.o
-LIB_OBJS +=3D shallow.o
-LIB_OBJS +=3D sideband.o
-LIB_OBJS +=3D sigchain.o
-LIB_OBJS +=3D strbuf.o
-LIB_OBJS +=3D string-list.o
-LIB_OBJS +=3D submodule.o
-LIB_OBJS +=3D symlinks.o
-LIB_OBJS +=3D tag.o
-LIB_OBJS +=3D trace.o
-LIB_OBJS +=3D transport.o
-LIB_OBJS +=3D transport-helper.o
-LIB_OBJS +=3D tree-diff.o
-LIB_OBJS +=3D tree.o
-LIB_OBJS +=3D tree-walk.o
-LIB_OBJS +=3D unpack-trees.o
-LIB_OBJS +=3D url.o
-LIB_OBJS +=3D usage.o
-LIB_OBJS +=3D userdiff.o
-LIB_OBJS +=3D utf8.o
-LIB_OBJS +=3D walker.o
-LIB_OBJS +=3D wrapper.o
-LIB_OBJS +=3D write_or_die.o
-LIB_OBJS +=3D ws.o
-LIB_OBJS +=3D wt-status.o
-LIB_OBJS +=3D xdiff-interface.o
-
-BUILTIN_OBJS +=3D builtin/add.o
-BUILTIN_OBJS +=3D builtin/annotate.o
-BUILTIN_OBJS +=3D builtin/apply.o
-BUILTIN_OBJS +=3D builtin/archive.o
-BUILTIN_OBJS +=3D builtin/bisect--helper.o
-BUILTIN_OBJS +=3D builtin/blame.o
-BUILTIN_OBJS +=3D builtin/branch.o
-BUILTIN_OBJS +=3D builtin/bundle.o
-BUILTIN_OBJS +=3D builtin/cat-file.o
-BUILTIN_OBJS +=3D builtin/check-attr.o
-BUILTIN_OBJS +=3D builtin/check-ref-format.o
-BUILTIN_OBJS +=3D builtin/checkout-index.o
-BUILTIN_OBJS +=3D builtin/checkout.o
-BUILTIN_OBJS +=3D builtin/clean.o
-BUILTIN_OBJS +=3D builtin/clone.o
-BUILTIN_OBJS +=3D builtin/commit-tree.o
-BUILTIN_OBJS +=3D builtin/commit.o
-BUILTIN_OBJS +=3D builtin/config.o
-BUILTIN_OBJS +=3D builtin/count-objects.o
-BUILTIN_OBJS +=3D builtin/describe.o
-BUILTIN_OBJS +=3D builtin/diff-files.o
-BUILTIN_OBJS +=3D builtin/diff-index.o
-BUILTIN_OBJS +=3D builtin/diff-tree.o
-BUILTIN_OBJS +=3D builtin/diff.o
-BUILTIN_OBJS +=3D builtin/fast-export.o
-BUILTIN_OBJS +=3D builtin/fetch-pack.o
-BUILTIN_OBJS +=3D builtin/fetch.o
-BUILTIN_OBJS +=3D builtin/fmt-merge-msg.o
-BUILTIN_OBJS +=3D builtin/for-each-ref.o
-BUILTIN_OBJS +=3D builtin/fsck.o
-BUILTIN_OBJS +=3D builtin/gc.o
-BUILTIN_OBJS +=3D builtin/grep.o
-BUILTIN_OBJS +=3D builtin/hash-object.o
-BUILTIN_OBJS +=3D builtin/help.o
-BUILTIN_OBJS +=3D builtin/index-pack.o
-BUILTIN_OBJS +=3D builtin/init-db.o
-BUILTIN_OBJS +=3D builtin/log.o
-BUILTIN_OBJS +=3D builtin/ls-files.o
-BUILTIN_OBJS +=3D builtin/ls-remote.o
-BUILTIN_OBJS +=3D builtin/ls-tree.o
-BUILTIN_OBJS +=3D builtin/mailinfo.o
-BUILTIN_OBJS +=3D builtin/mailsplit.o
-BUILTIN_OBJS +=3D builtin/merge.o
-BUILTIN_OBJS +=3D builtin/merge-base.o
-BUILTIN_OBJS +=3D builtin/merge-file.o
-BUILTIN_OBJS +=3D builtin/merge-index.o
-BUILTIN_OBJS +=3D builtin/merge-ours.o
-BUILTIN_OBJS +=3D builtin/merge-recursive.o
-BUILTIN_OBJS +=3D builtin/merge-tree.o
-BUILTIN_OBJS +=3D builtin/mktag.o
-BUILTIN_OBJS +=3D builtin/mktree.o
-BUILTIN_OBJS +=3D builtin/mv.o
-BUILTIN_OBJS +=3D builtin/name-rev.o
-BUILTIN_OBJS +=3D builtin/notes.o
-BUILTIN_OBJS +=3D builtin/pack-objects.o
-BUILTIN_OBJS +=3D builtin/pack-redundant.o
-BUILTIN_OBJS +=3D builtin/pack-refs.o
-BUILTIN_OBJS +=3D builtin/patch-id.o
-BUILTIN_OBJS +=3D builtin/prune-packed.o
-BUILTIN_OBJS +=3D builtin/prune.o
-BUILTIN_OBJS +=3D builtin/push.o
-BUILTIN_OBJS +=3D builtin/read-tree.o
-BUILTIN_OBJS +=3D builtin/receive-pack.o
-BUILTIN_OBJS +=3D builtin/reflog.o
-BUILTIN_OBJS +=3D builtin/remote.o
-BUILTIN_OBJS +=3D builtin/replace.o
-BUILTIN_OBJS +=3D builtin/rerere.o
-BUILTIN_OBJS +=3D builtin/reset.o
-BUILTIN_OBJS +=3D builtin/rev-list.o
-BUILTIN_OBJS +=3D builtin/rev-parse.o
-BUILTIN_OBJS +=3D builtin/revert.o
-BUILTIN_OBJS +=3D builtin/rm.o
-BUILTIN_OBJS +=3D builtin/send-pack.o
-BUILTIN_OBJS +=3D builtin/shortlog.o
-BUILTIN_OBJS +=3D builtin/show-branch.o
-BUILTIN_OBJS +=3D builtin/show-ref.o
-BUILTIN_OBJS +=3D builtin/stripspace.o
-BUILTIN_OBJS +=3D builtin/symbolic-ref.o
-BUILTIN_OBJS +=3D builtin/tag.o
-BUILTIN_OBJS +=3D builtin/tar-tree.o
-BUILTIN_OBJS +=3D builtin/unpack-file.o
-BUILTIN_OBJS +=3D builtin/unpack-objects.o
-BUILTIN_OBJS +=3D builtin/update-index.o
-BUILTIN_OBJS +=3D builtin/update-ref.o
-BUILTIN_OBJS +=3D builtin/update-server-info.o
-BUILTIN_OBJS +=3D builtin/upload-archive.o
-BUILTIN_OBJS +=3D builtin/var.o
-BUILTIN_OBJS +=3D builtin/verify-pack.o
-BUILTIN_OBJS +=3D builtin/verify-tag.o
-BUILTIN_OBJS +=3D builtin/write-tree.o
-
-GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =3D
=20
 #
@@ -1077,78 +805,351 @@ ifeq ($(uname_S),Windows)
 	BLK_SHA1 =3D YesPlease
 	NATIVE_CRLF =3D YesPlease
=20
-	CC =3D compat/vcbuild/scripts/clink.pl
-	AR =3D compat/vcbuild/scripts/lib.pl
-	CFLAGS =3D
-	BASIC_CFLAGS =3D -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbu=
ild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNING=
S -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS =3D compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi=
=2Eo compat/win32/pthread.o
-	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE=
_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Ic=
ompat/win32 -DSTRIP_EXTENSION=3D\".exe\"
-	BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOL=
E -NODEFAULTLIB:MSVCRT.lib
-	EXTLIBS =3D advapi32.lib shell32.lib wininet.lib ws2_32.lib
-	PTHREAD_LIBS =3D
-	lib =3D
-ifndef DEBUG
-	BASIC_CFLAGS +=3D -GL -Os -MT
-	BASIC_LDFLAGS +=3D -LTCG
-	AR +=3D -LTCG
-else
-	BASIC_CFLAGS +=3D -Zi -MTd
-endif
-	X =3D .exe
-endif
-ifneq (,$(findstring MINGW,$(uname_S)))
-	pathsep =3D ;
-	NO_PREAD =3D YesPlease
-	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
-	NO_LIBGEN_H =3D YesPlease
-	NO_SYMLINK_HEAD =3D YesPlease
-	NO_SETENV =3D YesPlease
-	NO_UNSETENV =3D YesPlease
-	NO_STRCASESTR =3D YesPlease
-	NO_STRLCPY =3D YesPlease
-	NO_STRTOK_R =3D YesPlease
-	NO_MEMMEM =3D YesPlease
-	NEEDS_LIBICONV =3D YesPlease
-	OLD_ICONV =3D YesPlease
-	NO_C99_FORMAT =3D YesPlease
-	NO_STRTOUMAX =3D YesPlease
-	NO_MKDTEMP =3D YesPlease
-	NO_MKSTEMPS =3D YesPlease
-	NO_SVN_TESTS =3D YesPlease
-	NO_PERL_MAKEMAKER =3D YesPlease
-	RUNTIME_PREFIX =3D YesPlease
-	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
-	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
-	NO_NSEC =3D YesPlease
-	USE_WIN32_MMAP =3D YesPlease
-	USE_NED_ALLOCATOR =3D YesPlease
-	UNRELIABLE_FSTAT =3D UnfortunatelyYes
-	OBJECT_CREATION_USES_RENAMES =3D UnfortunatelyNeedsTo
-	NO_REGEX =3D YesPlease
-	NO_PYTHON =3D YesPlease
-	BLK_SHA1 =3D YesPlease
-	ETAGS_TARGET =3D ETAGS
-	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnm=
atch -Icompat/win32
-	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
-	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winan=
si.o \
-		compat/win32/pthread.o
-	EXTLIBS +=3D -lws2_32
-	PTHREAD_LIBS =3D
-	X =3D .exe
-ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
-	htmldir=3Ddoc/git/html/
-	prefix =3D
-	INSTALL =3D /bin/install
-	EXTLIBS +=3D /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER =3D YesPlease
-	INTERNAL_QSORT =3D YesPlease
-else
-	NO_CURL =3D YesPlease
-endif
-endif
+	CC =3D compat/vcbuild/scripts/clink.pl
+	AR =3D compat/vcbuild/scripts/lib.pl
+	CFLAGS =3D
+	BASIC_CFLAGS =3D -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbu=
ild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNING=
S -D_CRT_NONSTDC_NO_DEPRECATE
+	COMPAT_OBJS =3D compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi=
=2Eo compat/win32/pthread.o
+	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE=
_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Ic=
ompat/win32 -DSTRIP_EXTENSION=3D\".exe\"
+	BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOL=
E -NODEFAULTLIB:MSVCRT.lib
+	EXTLIBS =3D advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	PTHREAD_LIBS =3D
+	lib =3D
+ifndef DEBUG
+	BASIC_CFLAGS +=3D -GL -Os -MT
+	BASIC_LDFLAGS +=3D -LTCG
+	AR +=3D -LTCG
+else
+	BASIC_CFLAGS +=3D -Zi -MTd
+endif
+	X =3D .exe
+endif
+ifneq (,$(findstring MINGW,$(uname_S)))
+	pathsep =3D ;
+	NO_PREAD =3D YesPlease
+	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
+	NO_LIBGEN_H =3D YesPlease
+	NO_SYMLINK_HEAD =3D YesPlease
+	NO_SETENV =3D YesPlease
+	NO_UNSETENV =3D YesPlease
+	NO_STRCASESTR =3D YesPlease
+	NO_STRLCPY =3D YesPlease
+	NO_STRTOK_R =3D YesPlease
+	NO_MEMMEM =3D YesPlease
+	NEEDS_LIBICONV =3D YesPlease
+	OLD_ICONV =3D YesPlease
+	NO_C99_FORMAT =3D YesPlease
+	NO_STRTOUMAX =3D YesPlease
+	NO_MKDTEMP =3D YesPlease
+	NO_MKSTEMPS =3D YesPlease
+	NO_SVN_TESTS =3D YesPlease
+	NO_PERL_MAKEMAKER =3D YesPlease
+	RUNTIME_PREFIX =3D YesPlease
+	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
+	NO_NSEC =3D YesPlease
+	USE_WIN32_MMAP =3D YesPlease
+	USE_NED_ALLOCATOR =3D YesPlease
+	UNRELIABLE_FSTAT =3D UnfortunatelyYes
+	OBJECT_CREATION_USES_RENAMES =3D UnfortunatelyNeedsTo
+	NO_REGEX =3D YesPlease
+	NO_PYTHON =3D YesPlease
+	BLK_SHA1 =3D YesPlease
+	ETAGS_TARGET =3D ETAGS
+	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnm=
atch -Icompat/win32
+	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
+	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winan=
si.o \
+		compat/win32/pthread.o
+	EXTLIBS +=3D -lws2_32
+	PTHREAD_LIBS =3D
+	X =3D .exe
+ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
+	htmldir=3Ddoc/git/html/
+	prefix =3D
+	INSTALL =3D /bin/install
+	EXTLIBS +=3D /mingw/lib/libz.a
+	NO_R_TO_GCC_LINKER =3D YesPlease
+	INTERNAL_QSORT =3D YesPlease
+else
+	NO_CURL =3D YesPlease
+endif
+endif
+
+-include config.mak.autogen
+-include config.mak
+
+LIB_H +=3D advice.h
+LIB_H +=3D archive.h
+LIB_H +=3D attr.h
+LIB_H +=3D blob.h
+LIB_H +=3D builtin.h
+LIB_H +=3D cache.h
+LIB_H +=3D cache-tree.h
+LIB_H +=3D color.h
+LIB_H +=3D commit.h
+LIB_H +=3D compat/bswap.h
+LIB_H +=3D compat/cygwin.h
+LIB_H +=3D compat/mingw.h
+LIB_H +=3D compat/win32/pthread.h
+LIB_H +=3D csum-file.h
+LIB_H +=3D decorate.h
+LIB_H +=3D delta.h
+LIB_H +=3D diffcore.h
+LIB_H +=3D diff.h
+LIB_H +=3D dir.h
+LIB_H +=3D exec_cmd.h
+LIB_H +=3D fsck.h
+LIB_H +=3D git-compat-util.h
+LIB_H +=3D graph.h
+LIB_H +=3D grep.h
+LIB_H +=3D hash.h
+LIB_H +=3D help.h
+LIB_H +=3D levenshtein.h
+LIB_H +=3D list-objects.h
+LIB_H +=3D ll-merge.h
+LIB_H +=3D log-tree.h
+LIB_H +=3D mailmap.h
+LIB_H +=3D merge-recursive.h
+LIB_H +=3D notes.h
+LIB_H +=3D notes-cache.h
+LIB_H +=3D object.h
+LIB_H +=3D pack.h
+LIB_H +=3D pack-refs.h
+LIB_H +=3D pack-revindex.h
+LIB_H +=3D parse-options.h
+LIB_H +=3D patch-ids.h
+LIB_H +=3D pkt-line.h
+LIB_H +=3D progress.h
+LIB_H +=3D quote.h
+LIB_H +=3D reflog-walk.h
+LIB_H +=3D refs.h
+LIB_H +=3D remote.h
+LIB_H +=3D rerere.h
+LIB_H +=3D resolve-undo.h
+LIB_H +=3D revision.h
+LIB_H +=3D run-command.h
+LIB_H +=3D sha1-lookup.h
+LIB_H +=3D sideband.h
+LIB_H +=3D sigchain.h
+LIB_H +=3D strbuf.h
+LIB_H +=3D string-list.h
+LIB_H +=3D submodule.h
+LIB_H +=3D tag.h
+LIB_H +=3D transport.h
+LIB_H +=3D tree.h
+LIB_H +=3D tree-walk.h
+LIB_H +=3D unpack-trees.h
+LIB_H +=3D userdiff.h
+LIB_H +=3D utf8.h
+LIB_H +=3D xdiff-interface.h
+LIB_H +=3D xdiff/xdiff.h
+
+LIB_OBJS +=3D abspath.o
+LIB_OBJS +=3D advice.o
+LIB_OBJS +=3D alias.o
+LIB_OBJS +=3D alloc.o
+LIB_OBJS +=3D archive.o
+LIB_OBJS +=3D archive-tar.o
+LIB_OBJS +=3D archive-zip.o
+LIB_OBJS +=3D attr.o
+LIB_OBJS +=3D base85.o
+LIB_OBJS +=3D bisect.o
+LIB_OBJS +=3D blob.o
+LIB_OBJS +=3D branch.o
+LIB_OBJS +=3D bundle.o
+LIB_OBJS +=3D cache-tree.o
+LIB_OBJS +=3D color.o
+LIB_OBJS +=3D combine-diff.o
+LIB_OBJS +=3D commit.o
+LIB_OBJS +=3D config.o
+LIB_OBJS +=3D connect.o
+LIB_OBJS +=3D convert.o
+LIB_OBJS +=3D copy.o
+LIB_OBJS +=3D csum-file.o
+LIB_OBJS +=3D ctype.o
+LIB_OBJS +=3D date.o
+LIB_OBJS +=3D decorate.o
+LIB_OBJS +=3D diffcore-break.o
+LIB_OBJS +=3D diffcore-delta.o
+LIB_OBJS +=3D diffcore-order.o
+LIB_OBJS +=3D diffcore-pickaxe.o
+LIB_OBJS +=3D diffcore-rename.o
+LIB_OBJS +=3D diff-delta.o
+LIB_OBJS +=3D diff-lib.o
+LIB_OBJS +=3D diff-no-index.o
+LIB_OBJS +=3D diff.o
+LIB_OBJS +=3D dir.o
+LIB_OBJS +=3D editor.o
+LIB_OBJS +=3D entry.o
+LIB_OBJS +=3D environment.o
+LIB_OBJS +=3D exec_cmd.o
+LIB_OBJS +=3D fsck.o
+LIB_OBJS +=3D graph.o
+LIB_OBJS +=3D grep.o
+LIB_OBJS +=3D hash.o
+LIB_OBJS +=3D help.o
+LIB_OBJS +=3D hex.o
+LIB_OBJS +=3D ident.o
+LIB_OBJS +=3D levenshtein.o
+LIB_OBJS +=3D list-objects.o
+LIB_OBJS +=3D ll-merge.o
+LIB_OBJS +=3D lockfile.o
+LIB_OBJS +=3D log-tree.o
+LIB_OBJS +=3D mailmap.o
+LIB_OBJS +=3D match-trees.o
+LIB_OBJS +=3D merge-file.o
+LIB_OBJS +=3D merge-recursive.o
+LIB_OBJS +=3D name-hash.o
+LIB_OBJS +=3D notes.o
+LIB_OBJS +=3D notes-cache.o
+LIB_OBJS +=3D object.o
+LIB_OBJS +=3D pack-check.o
+LIB_OBJS +=3D pack-refs.o
+LIB_OBJS +=3D pack-revindex.o
+LIB_OBJS +=3D pack-write.o
+LIB_OBJS +=3D pager.o
+LIB_OBJS +=3D parse-options.o
+LIB_OBJS +=3D patch-delta.o
+LIB_OBJS +=3D patch-ids.o
+LIB_OBJS +=3D path.o
+LIB_OBJS +=3D pkt-line.o
+LIB_OBJS +=3D preload-index.o
+LIB_OBJS +=3D pretty.o
+LIB_OBJS +=3D progress.o
+LIB_OBJS +=3D quote.o
+LIB_OBJS +=3D reachable.o
+LIB_OBJS +=3D read-cache.o
+LIB_OBJS +=3D reflog-walk.o
+LIB_OBJS +=3D refs.o
+LIB_OBJS +=3D remote.o
+LIB_OBJS +=3D replace_object.o
+LIB_OBJS +=3D rerere.o
+LIB_OBJS +=3D resolve-undo.o
+LIB_OBJS +=3D revision.o
+LIB_OBJS +=3D run-command.o
+LIB_OBJS +=3D server-info.o
+LIB_OBJS +=3D setup.o
+LIB_OBJS +=3D sha1-lookup.o
+LIB_OBJS +=3D sha1_file.o
+LIB_OBJS +=3D sha1_name.o
+LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D sideband.o
+LIB_OBJS +=3D sigchain.o
+LIB_OBJS +=3D strbuf.o
+LIB_OBJS +=3D string-list.o
+LIB_OBJS +=3D submodule.o
+LIB_OBJS +=3D symlinks.o
+LIB_OBJS +=3D tag.o
+LIB_OBJS +=3D trace.o
+LIB_OBJS +=3D transport.o
+LIB_OBJS +=3D transport-helper.o
+LIB_OBJS +=3D tree-diff.o
+LIB_OBJS +=3D tree.o
+LIB_OBJS +=3D tree-walk.o
+LIB_OBJS +=3D unpack-trees.o
+LIB_OBJS +=3D url.o
+LIB_OBJS +=3D usage.o
+LIB_OBJS +=3D userdiff.o
+LIB_OBJS +=3D utf8.o
+LIB_OBJS +=3D walker.o
+LIB_OBJS +=3D wrapper.o
+LIB_OBJS +=3D write_or_die.o
+LIB_OBJS +=3D ws.o
+LIB_OBJS +=3D wt-status.o
+LIB_OBJS +=3D xdiff-interface.o
+
+BUILTIN_OBJS +=3D builtin/add.o
+BUILTIN_OBJS +=3D builtin/annotate.o
+BUILTIN_OBJS +=3D builtin/apply.o
+BUILTIN_OBJS +=3D builtin/archive.o
+BUILTIN_OBJS +=3D builtin/bisect--helper.o
+BUILTIN_OBJS +=3D builtin/blame.o
+BUILTIN_OBJS +=3D builtin/branch.o
+BUILTIN_OBJS +=3D builtin/bundle.o
+BUILTIN_OBJS +=3D builtin/cat-file.o
+BUILTIN_OBJS +=3D builtin/check-attr.o
+BUILTIN_OBJS +=3D builtin/check-ref-format.o
+BUILTIN_OBJS +=3D builtin/checkout-index.o
+BUILTIN_OBJS +=3D builtin/checkout.o
+BUILTIN_OBJS +=3D builtin/clean.o
+BUILTIN_OBJS +=3D builtin/clone.o
+BUILTIN_OBJS +=3D builtin/commit-tree.o
+BUILTIN_OBJS +=3D builtin/commit.o
+BUILTIN_OBJS +=3D builtin/config.o
+BUILTIN_OBJS +=3D builtin/count-objects.o
+BUILTIN_OBJS +=3D builtin/describe.o
+BUILTIN_OBJS +=3D builtin/diff-files.o
+BUILTIN_OBJS +=3D builtin/diff-index.o
+BUILTIN_OBJS +=3D builtin/diff-tree.o
+BUILTIN_OBJS +=3D builtin/diff.o
+BUILTIN_OBJS +=3D builtin/fast-export.o
+BUILTIN_OBJS +=3D builtin/fetch-pack.o
+BUILTIN_OBJS +=3D builtin/fetch.o
+BUILTIN_OBJS +=3D builtin/fmt-merge-msg.o
+BUILTIN_OBJS +=3D builtin/for-each-ref.o
+BUILTIN_OBJS +=3D builtin/fsck.o
+BUILTIN_OBJS +=3D builtin/gc.o
+BUILTIN_OBJS +=3D builtin/grep.o
+BUILTIN_OBJS +=3D builtin/hash-object.o
+BUILTIN_OBJS +=3D builtin/help.o
+BUILTIN_OBJS +=3D builtin/index-pack.o
+BUILTIN_OBJS +=3D builtin/init-db.o
+BUILTIN_OBJS +=3D builtin/log.o
+BUILTIN_OBJS +=3D builtin/ls-files.o
+BUILTIN_OBJS +=3D builtin/ls-remote.o
+BUILTIN_OBJS +=3D builtin/ls-tree.o
+BUILTIN_OBJS +=3D builtin/mailinfo.o
+BUILTIN_OBJS +=3D builtin/mailsplit.o
+BUILTIN_OBJS +=3D builtin/merge.o
+BUILTIN_OBJS +=3D builtin/merge-base.o
+BUILTIN_OBJS +=3D builtin/merge-file.o
+BUILTIN_OBJS +=3D builtin/merge-index.o
+BUILTIN_OBJS +=3D builtin/merge-ours.o
+BUILTIN_OBJS +=3D builtin/merge-recursive.o
+BUILTIN_OBJS +=3D builtin/merge-tree.o
+BUILTIN_OBJS +=3D builtin/mktag.o
+BUILTIN_OBJS +=3D builtin/mktree.o
+BUILTIN_OBJS +=3D builtin/mv.o
+BUILTIN_OBJS +=3D builtin/name-rev.o
+BUILTIN_OBJS +=3D builtin/notes.o
+BUILTIN_OBJS +=3D builtin/pack-objects.o
+BUILTIN_OBJS +=3D builtin/pack-redundant.o
+BUILTIN_OBJS +=3D builtin/pack-refs.o
+BUILTIN_OBJS +=3D builtin/patch-id.o
+BUILTIN_OBJS +=3D builtin/prune-packed.o
+BUILTIN_OBJS +=3D builtin/prune.o
+BUILTIN_OBJS +=3D builtin/push.o
+BUILTIN_OBJS +=3D builtin/read-tree.o
+BUILTIN_OBJS +=3D builtin/receive-pack.o
+BUILTIN_OBJS +=3D builtin/reflog.o
+BUILTIN_OBJS +=3D builtin/remote.o
+BUILTIN_OBJS +=3D builtin/replace.o
+BUILTIN_OBJS +=3D builtin/rerere.o
+BUILTIN_OBJS +=3D builtin/reset.o
+BUILTIN_OBJS +=3D builtin/rev-list.o
+BUILTIN_OBJS +=3D builtin/rev-parse.o
+BUILTIN_OBJS +=3D builtin/revert.o
+BUILTIN_OBJS +=3D builtin/rm.o
+BUILTIN_OBJS +=3D builtin/send-pack.o
+BUILTIN_OBJS +=3D builtin/shortlog.o
+BUILTIN_OBJS +=3D builtin/show-branch.o
+BUILTIN_OBJS +=3D builtin/show-ref.o
+BUILTIN_OBJS +=3D builtin/stripspace.o
+BUILTIN_OBJS +=3D builtin/symbolic-ref.o
+BUILTIN_OBJS +=3D builtin/tag.o
+BUILTIN_OBJS +=3D builtin/tar-tree.o
+BUILTIN_OBJS +=3D builtin/unpack-file.o
+BUILTIN_OBJS +=3D builtin/unpack-objects.o
+BUILTIN_OBJS +=3D builtin/update-index.o
+BUILTIN_OBJS +=3D builtin/update-ref.o
+BUILTIN_OBJS +=3D builtin/update-server-info.o
+BUILTIN_OBJS +=3D builtin/upload-archive.o
+BUILTIN_OBJS +=3D builtin/var.o
+BUILTIN_OBJS +=3D builtin/verify-pack.o
+BUILTIN_OBJS +=3D builtin/verify-tag.o
+BUILTIN_OBJS +=3D builtin/write-tree.o
=20
--include config.mak.autogen
--include config.mak
+GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
=20
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =3D
--=20
1.7.2.3
