From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Group the default git help message by topic
Date: Tue, 25 May 2010 10:47:19 -0700
Message-ID: <AANLkTilWIRqnjjgGA3e9DDzw2MiHirjP2-W7PuPhonUs@mail.gmail.com>
References: <1274809430-36060-1-git-send-email-schacon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 19:47:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGyDw-000708-O3
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 19:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0EYRrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 13:47:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33066 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab0EYRrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 13:47:22 -0400
Received: by wyb29 with SMTP id 29so2576152wyb.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=f/GOs3bnSNUsBIVioKfQXbpMYT7+9+mzCcfuo+XjWdQ=;
        b=vrko+RDcMVQyM6xZbUtLSBt55wxvUfk34TpFtre37cOvgaz40i85fzfYQVeNSx8q3l
         R80JpR2/ziWLSlNkfTbWdXoURXvhCMlm1c4d64tgbmdJb4H2bF5Bboup+048BDLrNoWY
         3Rp1xzEwu8aBKmkFVW6wgFHoY08Kh1Iv/+74Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hJhI6QtsWc3CR+6UgZ2IuIxqp4NWinETX94RSH56HlJ/Yj0AcUprKefKZCUN9WEBi2
         fdWBIkiCmvmUtwNms7u6IPqZLchgtC4J2c0ZNTbVTsWA4sVKoBBFWz3Y9bSfplpDv/C8
         uPNHtt/axC+GrdNDGuXzYdVNXTiRbrJYUCb9k=
Received: by 10.216.88.6 with SMTP id z6mr4679317wee.79.1274809640149; Tue, 25 
	May 2010 10:47:20 -0700 (PDT)
Received: by 10.216.3.13 with HTTP; Tue, 25 May 2010 10:47:19 -0700 (PDT)
In-Reply-To: <1274809430-36060-1-git-send-email-schacon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147719>

It's difficult to process 21 commands (which is what is output
by default for git when no command is given). =C2=A0They have been
re-grouped into 4 groups of 5-6 commands each, which is clearer
and easier for new users to process. =C2=A0More advanced commands
such as bisect and rebase have also been removed as this should
be output for beginners.

Also removes the common-cmd.h generation process, including
parts of the Makefile and the generate-cmdlist.sh file.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

I sent this over a year ago, during a GitTogether, but I let it drop.
I've been thinking lately that it would be nice if the default Git
help message was a bit clearer for beginners, so I'm going to resubmit
this.  Originally, the discussion descended into what would ultimately
be really nice for a sort of built-in Git tutorial mode, but I think
this should be a good first step to making the help UI a bit
friendlier.

=C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 13 +++=
----------
=C2=A0builtin/help.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 40 ++++++++++++++++++=
++++++++--------------
=C2=A0generate-cmdlist.sh | =C2=A0 24 ------------------------
=C2=A03 files changed, 29 insertions(+), 48 deletions(-)
=C2=A0delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 07cab8f..c888c77 100644
--- a/Makefile
+++ b/Makefile
@@ -1506,7 +1506,6 @@ shell_compatibility_test:
please_set_SHELL_PATH_to_a_more_modern_shell
=C2=A0strip: $(PROGRAMS) git$X
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X

-git.o: common-cmds.h
=C2=A0git.s git.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION)"=
' \
=C2=A0 =C2=A0 =C2=A0 =C2=A0'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"'

@@ -1514,7 +1513,6 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o=
 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(BUILTIN_OBJS) =
$(ALL_LDFLAGS) $(LIBS)

-builtin/help.o: common-cmds.h
=C2=A0builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
=C2=A0 =C2=A0 =C2=A0 =C2=A0'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"' \
=C2=A0 =C2=A0 =C2=A0 =C2=A0'-DGIT_MAN_PATH=3D"$(mandir_SQ)"' \
@@ -1526,11 +1524,6 @@ $(BUILT_INS): git$X
=C2=A0 =C2=A0 =C2=A0 =C2=A0ln -s git$X $@ 2>/dev/null || \
=C2=A0 =C2=A0 =C2=A0 =C2=A0cp git$X $@

-common-cmds.h: ./generate-cmdlist.sh command-list.txt
-
-common-cmds.h: $(wildcard Documentation/git-*.txt)
- =C2=A0 =C2=A0 =C2=A0 $(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@=
+ $@
-
=C2=A0define cmd_munge_script
=C2=A0$(RM) $@ $@+ && \
=C2=A0sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1767,7 +1760,7 @@ else
=C2=A0# Dependencies on header files, for platforms that do not support
=C2=A0# the gcc -MMD option.
=C2=A0#
-# Dependencies on automatically generated headers such as common-cmds.=
h
+# Dependencies on automatically generated headers
=C2=A0# should _not_ be included here, since they are necessary even wh=
en
=C2=A0# building an object for the first time.
=C2=A0#
@@ -1940,7 +1933,7 @@ test-%$X: test-%.o $(GITLIBS)
=C2=A0check-sha1:: test-sha1$X
=C2=A0 =C2=A0 =C2=A0 =C2=A0./test-sha1.sh

-check: common-cmds.h
+check:
=C2=A0 =C2=A0 =C2=A0 =C2=A0if sparse; \
=C2=A0 =C2=A0 =C2=A0 =C2=A0then \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in *.c; \
@@ -2105,7 +2098,7 @@ clean:
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) $(TEST_PROGRAMS)
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) -r bin-wrappers
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) -r $(dep_dirs)
- =C2=A0 =C2=A0 =C2=A0 $(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-=
cmds.h TAGS tags cscope*
+ =C2=A0 =C2=A0 =C2=A0 $(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo TAGS ta=
gs cscope*
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) -r autom4te.cache
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) config.log config.mak.autogen config.m=
ak.append
config.status config.cache
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..5c25cdc 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,7 +6,6 @@
=C2=A0#include "cache.h"
=C2=A0#include "builtin.h"
=C2=A0#include "exec_cmd.h"
-#include "common-cmds.h"
=C2=A0#include "parse-options.h"
=C2=A0#include "run-command.h"
=C2=A0#include "help.h"
@@ -273,19 +272,32 @@ static struct cmdnames main_cmds, other_cmds;

=C2=A0void list_common_cmds_help(void)
=C2=A0{
- =C2=A0 =C2=A0 =C2=A0 int i, longest =3D 0;
-
- =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) =
{
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (longest < strlen=
(common_cmds[i].name))
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 longest =3D strlen(common_cmds[i].name);
- =C2=A0 =C2=A0 =C2=A0 }
-
- =C2=A0 =C2=A0 =C2=A0 puts("The most commonly used git commands are:")=
;
- =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) =
{
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(" =C2=A0 %s =C2=
=A0 ", common_cmds[i].name);
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mput_char(' ', longe=
st - strlen(common_cmds[i].name));
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(common_cmds[i].=
help);
- =C2=A0 =C2=A0 =C2=A0 }
+ =C2=A0puts("The most commonly used git commands are:\n\
+\n\
+Basic Commands\n\
+ =C2=A0init =C2=A0 =C2=A0 =C2=A0 Initialize a directory of files to be=
 a new Git repository\n\
+ =C2=A0add =C2=A0 =C2=A0 =C2=A0 =C2=A0Add new or modified files to the=
 staging area\n\
+ =C2=A0status =C2=A0 =C2=A0 Show the working directory and staging are=
a status\n\
+ =C2=A0commit =C2=A0 =C2=A0 Record a snapshot of your staged changes t=
o the repository\n\
+\n\
+Branch Commands\n\
+ =C2=A0branch =C2=A0 =C2=A0 List, create, and delete development branc=
hes\n\
+ =C2=A0checkout =C2=A0 Switch the active branch you are working in\n\
+ =C2=A0merge =C2=A0 =C2=A0 =C2=A0Join two or more development historie=
s together\n\
+ =C2=A0tag =C2=A0 =C2=A0 =C2=A0 =C2=A0Tag a point in your history\n\
+\n\
+History Commands\n\
+ =C2=A0log =C2=A0 =C2=A0 =C2=A0 =C2=A0Show commit history as a log of =
changes\n\
+ =C2=A0diff =C2=A0 =C2=A0 =C2=A0 Show changes between commits, commit =
and working tree, etc\n\
+ =C2=A0reset =C2=A0 =C2=A0 =C2=A0Reset your staging area or working di=
rectory to a
specified state\n\
+ =C2=A0show =C2=A0 =C2=A0 =C2=A0 Show various types of objects\n\
+\n\
+Remote Commands\n\
+ =C2=A0clone =C2=A0 =C2=A0 =C2=A0Clone a repository into a new directo=
ry\n\
+ =C2=A0remote =C2=A0 =C2=A0 List, add and delete aliases for remote re=
positories\n\
+ =C2=A0fetch =C2=A0 =C2=A0 =C2=A0Download new branches and data from a=
 remote repository\n\
+ =C2=A0pull =C2=A0 =C2=A0 =C2=A0 Fetch from a remote repo and try to m=
erge into the
current branch\n\
+ =C2=A0push =C2=A0 =C2=A0 =C2=A0 Push your new branches and data to a =
remote repository");
=C2=A0}

=C2=A0static int is_git_command(const char *s)
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
deleted file mode 100755
index 75c68d9..0000000
--- a/generate-cmdlist.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/sh
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help
-{
- =C2=A0 =C2=A0char name[16];
- =C2=A0 =C2=A0char help[80];
-};
-
-static struct cmdname_help common_cmds[] =3D {"
-
-sed -n -e 's/^git-\([^ =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]*\)[ =C2=A0 ].* co=
mmon.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
- =C2=A0 =C2=A0 sed -n '
- =C2=A0 =C2=A0 /^NAME/,/git-'"$cmd"'/H
- =C2=A0 =C2=A0 ${
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s/.*git-'"$cmd"' - \(.*\)/ =C2=
=A0{"'"$cmd"'", "\1"},/
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p
- =C2=A0 =C2=A0 }' "Documentation/git-$cmd.txt"
-done
-echo "};"
--
1.7.0.1
