From: Jonathan Nieder <jrnieder@gmail.com>
Subject: nd/setup
Date: Sat, 3 Apr 2010 00:00:57 -0500
Message-ID: <20100403050057.GA20525@progeny.tock>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
 <j2wfcaeb9bf1004020423nc5b7a73cq2278d41d1675dc8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 07:01:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxvTl-0003qf-FG
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 07:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab0DCFA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 01:00:58 -0400
Received: from mail-gx0-f209.google.com ([209.85.217.209]:48405 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0DCFAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 01:00:54 -0400
Received: by gxk1 with SMTP id 1so2023697gxk.16
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zCqF2JSYgPBdoSCuV9eXzEVPY/QDZeBLMJqgQjXN//I=;
        b=oxgAiu+fYxaK0vrD+rAr378UX17GfoLfXCjsV6gqDChgaxK2o/4y9fo/VJrEpPRWSj
         rMJwpQ2taXNsP1xSw/qFIepXOvDrMasoDDzv7i4grCkmW16KR+418KA5okHghxt2y99/
         hJ9z8WXGMVOCcmsYPjEUdcAMhE3mD8yWxWqxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xUGhdt83e9hN7okYrGhay4BloUnAUA4/lWBp6iOFz9C1eE4/llsJTfhvLyGY16/Hqm
         FlH8drEVf/yu/X67CEL1nQUVTX72AJzEAxmM6LVeqgsSsNPjfW4EoYGdhGpLjMCMjCOG
         rmNOrkatFB1q+D6WnF5Ajh9N3E7ce8zejNxbE=
Received: by 10.101.145.4 with SMTP id x4mr7858068ann.11.1270270852179;
        Fri, 02 Apr 2010 22:00:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm756411iwn.14.2010.04.02.22.00.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 22:00:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <j2wfcaeb9bf1004020423nc5b7a73cq2278d41d1675dc8f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143880>

Nguyen Thai Ngoc Duy wrote:

> I haven't forgotten the "git init" with alias bug Jonathan found. Jus=
t
> a little busy with other stuff.

You already fixed it, I think. ;-)

Unfortunately, I have also run into a double-initialization bug with
clone.  I haven=E2=80=99t figured out how to reproduce it yet; once I d=
o, I=E2=80=99ll
send a patch.

Overall, I think this series does a good thing, so I am anxious to find
all the bugs I can so the wrinkles get ironed out.

Here=E2=80=99s another tiny issue.

-- %< --
Subject: Revert "help: use RUN_SETUP_GENTLY"

Commit 717b8850580ecb9009505f71ea43ecda51ac1f0e taught =E2=80=98git hel=
p=E2=80=99
to unconditionally looks for a git directory, with the justification:

    So the sooner we set up gitdir, the less trouble we may have to
    deal with.

In the case of =E2=80=98git help -a=E2=80=99, that is not quite true.  =
In automount
setups like that which prompted v1.6.0-rc0~121^2~1 (Add support for
GIT_CEILING_DIRECTORIES, 2008-05-19), if GIT_CEILING_DIRECTORIES is
unset, then probing for the Git directory can take a long time.  Thus
unnecessarily searching for a git directory can slow down =E2=80=98git =
help -a=E2=80=99
(and thus bash completion).

=E2=80=98git help=E2=80=99 does not use RUN_SETUP or USE_PAGER, and nei=
ther option
parsing nor producing output for plain =E2=80=98git help=E2=80=99 or =E2=
=80=98git help -a=E2=80=99
requires access to the git configuration.  Therefore it is safe to not
search for the git directory early in this case.

Also add some comments to document the requirements this places on
list_commands() and list_common_cmds_help().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/help.c |    7 +++++++
 git.c          |    2 +-
 help.c         |    4 ++++
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 4988629..68b72df 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -271,6 +271,11 @@ static int git_help_config(const char *var, const =
char *value, void *cb)
=20
 static struct cmdnames main_cmds, other_cmds;
=20
+/*
+ * Used for plain =E2=80=98git=E2=80=99 and =E2=80=98git help=E2=80=99=
=2E
+ * Therefore this should not use git_config(), nor any other function
+ * that requires searching for a repository.
+ */
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
@@ -414,6 +419,7 @@ static void show_html_page(const char *git_cmd)
=20
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
+	int unused_nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -436,6 +442,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 		return 0;
 	}
=20
+	setup_git_directory_gently(&unused_nongit);
 	git_config(git_help_config, NULL);
=20
 	if (parsed_help_format !=3D HELP_FORMAT_NONE)
diff --git a/git.c b/git.c
index 5c249fd..0125152 100644
--- a/git.c
+++ b/git.c
@@ -335,7 +335,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
-		{ "help", cmd_help, RUN_SETUP_GENTLY },
+		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
diff --git a/help.c b/help.c
index 7f4928e..f68ef43 100644
--- a/help.c
+++ b/help.c
@@ -221,6 +221,10 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
=20
+/*
+ * Used for =E2=80=98git help -a=E2=80=99.  Therefore this should not =
use git_config(),
+ * nor any other function that requires searching for a repository.
+ */
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds)
 {
--=20
1.7.0.3
