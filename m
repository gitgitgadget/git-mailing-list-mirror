From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Add git remote set-branches
Date: Wed, 19 May 2010 13:38:50 -0500
Message-ID: <20100519183850.GA18623@progeny.tock>
References: <20070710133226.GA23751@piper.oerlikon.madduck.net>
 <20100516004538.GA5528@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@debian.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 19 20:39:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEoAZ-0007uk-0O
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 20:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0ESSi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 14:38:57 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:62751 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0ESSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 14:38:56 -0400
Received: by pzk32 with SMTP id 32so2886941pzk.21
        for <git@vger.kernel.org>; Wed, 19 May 2010 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eRhp84yz+FZaYiLxXLDxd/F2ECHRxc37Cg0vs8yO8Is=;
        b=u05NowPHUOq5xsYGKC1QHojjs1ZSHZ1+NT+HnomvJt/hnUjOYHaUHpccN+pbVc4Q4t
         dmOkg4Kop53uOfwQUNhb4upVAJ3fQHZA78r3DwV9MXHtNSqj+v9LqdooNAy/M7MglDw2
         GIo80yNkd7/wSJdzyir78+ym5JxNcWV3vcWP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KwN3yvtHyhIvsF5Epggn1vn37ugtUORKTpRNlzbzSFYrbeId5+CxsdSiwRtrAwoH0S
         DsNx++AvSeFYRoXvyquJMF/aUM3ZwH6TFRiReSf8gSKYua62pkI6u165HV09XgIEZAh7
         QuvQogdvpEC0FHNF17LsS+OVAYchoXtU/9QuQ=
Received: by 10.142.7.11 with SMTP id 11mr6450675wfg.136.1274294334512;
        Wed, 19 May 2010 11:38:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6167683pzk.3.2010.05.19.11.38.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 11:38:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100516004538.GA5528@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147338>

Add =E2=80=98git remote set-branches=E2=80=99 for changing the list of =
tracked refs
for a remote repository with one "porcelain-level" command.  This
complements the longstanding =E2=80=98git remote add --track=E2=80=99 o=
ption.

The interface is based on the =E2=80=98git remote set-url=E2=80=99 subc=
ommand.

   git remote set-branches base --add C
   git remote set-branches base A B D
   git remote set-branches base --delete D; # not implemented

Suggested-by: martin f. krafft <madduck@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> This, and the other patch, look Ok except these unsightly debbugs cru=
ft in
> the commit log message.  Could you redo them please?

Sorry about that.  Hoping someone would take inspiration from my rough
sketch and finish it off, I didn=E2=80=99t even bother to consider whet=
her it
might be usable as-is.

 Documentation/git-remote.txt |   13 +++++
 builtin/remote.c             |  102 ++++++++++++++++++++++++++++++++++=
+++-----
 t/t5505-remote.sh            |   88 ++++++++++++++++++++++++++++++++++=
++
 3 files changed, 192 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 3fc599c..de4386b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
+'git remote set-branches' <name> [--add] <branch>...
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
@@ -104,6 +105,18 @@ remote set-head origin master" will set `$GIT_DIR/=
refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master` already exists; if not it must be fetched=
 first.
 +
=20
+'set-branches'::
+
+Changes the list of branches tracked by the named remote.
+This can be used to track a subset of the available remote branches
+after the initial setup for a remote.
++
+The named branches will be interpreted as if specified with the
+`-t` option on the 'git remote add' command line.
++
+With `--add`, instead of replacing the list of currently tracked
+branches, adds to that list.
+
 'set-url'::
=20
 Changes URL remote points to. Sets first URL remote points to matching
diff --git a/builtin/remote.c b/builtin/remote.c
index 277765b..c4d17b5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [group | remote]",
+	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
 	"git remote set-url --delete <name> <url>",
@@ -42,6 +43,12 @@ static const char * const builtin_remote_sethead_usa=
ge[] =3D {
 	NULL
 };
=20
+static const char * const builtin_remote_setbranches_usage[] =3D {
+	"git remote set-branches <name> <branch>...",
+	"git remote set-branches --add <name> <branch>...",
+	NULL
+};
+
 static const char * const builtin_remote_show_usage[] =3D {
 	"git remote show [<options>] <name>",
 	NULL
@@ -104,6 +111,20 @@ static int fetch_remote(const char *name)
 	return 0;
 }
=20
+static int add_branch(const char *key, const char *branchname,
+		const char *remotename, int mirror, struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addch(tmp, '+');
+	if (mirror)
+		strbuf_addf(tmp, "refs/%s:refs/%s",
+				branchname, branchname);
+	else
+		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
+				branchname, remotename, branchname);
+	return git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static int add(int argc, const char **argv)
 {
 	int fetch =3D 0, mirror =3D 0;
@@ -151,17 +172,8 @@ static int add(int argc, const char **argv)
 	if (track.nr =3D=3D 0)
 		string_list_append("*", &track);
 	for (i =3D 0; i < track.nr; i++) {
-		struct string_list_item *item =3D track.items + i;
-
-		strbuf_reset(&buf2);
-		strbuf_addch(&buf2, '+');
-		if (mirror)
-			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->string, item->string);
-		else
-			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->string, name, item->string);
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+		if (add_branch(buf.buf, track.items[i].string,
+				name, mirror, &buf2))
 			return 1;
 	}
=20
@@ -1265,6 +1277,72 @@ static int update(int argc, const char **argv)
 	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
 }
=20
+static int remove_all_fetch_refspecs(const char *remote, const char *k=
ey)
+{
+	return git_config_set_multivar(key, NULL, NULL, 1);
+}
+
+static int add_branches(struct remote *remote, const char **branches,
+			const char *key)
+{
+	const char *remotename =3D remote->name;
+	int mirror =3D remote->mirror;
+	struct strbuf refspec =3D STRBUF_INIT;
+
+	for (; *branches; branches++)
+		if (add_branch(key, *branches, remotename, mirror, &refspec)) {
+			strbuf_release(&refspec);
+			return 1;
+		}
+
+	strbuf_release(&refspec);
+	return 0;
+}
+
+static int set_remote_branches(const char *remotename, const char **br=
anches,
+				int add_mode)
+{
+	struct strbuf key =3D STRBUF_INIT;
+	struct remote *remote;
+
+	strbuf_addf(&key, "remote.%s.fetch", remotename);
+
+	if (!remote_is_configured(remotename))
+		die("No such remote '%s'", remotename);
+	remote =3D remote_get(remotename);
+
+	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
+		strbuf_release(&key);
+		return 1;
+	}
+	if (add_branches(remote, branches, key.buf)) {
+		strbuf_release(&key);
+		return 1;
+	}
+
+	strbuf_release(&key);
+	return 0;
+}
+
+static int set_branches(int argc, const char **argv)
+{
+	int add_mode =3D 0;
+	struct option options[] =3D {
+		OPT_BOOLEAN('\0', "add", &add_mode, "add branch"),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, NULL, options,
+			     builtin_remote_setbranches_usage, 0);
+	if (argc =3D=3D 0) {
+		error("no remote specified");
+		usage_with_options(builtin_remote_seturl_usage, options);
+	}
+	argv[argc] =3D NULL;
+
+	return set_remote_branches(argv[0], argv + 1, add_mode);
+}
+
 static int set_url(int argc, const char **argv)
 {
 	int i, push_mode =3D 0, add_mode =3D 0, delete_mode =3D 0;
@@ -1430,6 +1508,8 @@ int cmd_remote(int argc, const char **argv, const=
 char *prefix)
 		result =3D rm(argc, argv);
 	else if (!strcmp(argv[0], "set-head"))
 		result =3D set_head(argc, argv);
+	else if (!strcmp(argv[0], "set-branches"))
+		result =3D set_branches(argc, argv);
 	else if (!strcmp(argv[0], "set-url"))
 		result =3D set_url(argc, argv);
 	else if (!strcmp(argv[0], "show"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 230c0cd..8aaf53e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -534,6 +534,94 @@ test_expect_success 'show empty remote' '
 	)
 '
=20
+test_expect_success 'remote set-branches requires a remote' '
+	test_must_fail git remote set-branches &&
+	test_must_fail git remote set-branches --add
+'
+
+test_expect_success 'remote set-branches' '
+	echo "+refs/heads/*:refs/remotes/scratch/*" >expect.initial &&
+	sort <<-\EOF >expect.add &&
+	+refs/heads/*:refs/remotes/scratch/*
+	+refs/heads/other:refs/remotes/scratch/other
+	EOF
+	sort <<-\EOF >expect.replace &&
+	+refs/heads/maint:refs/remotes/scratch/maint
+	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	EOF
+	sort <<-\EOF >expect.add-two &&
+	+refs/heads/maint:refs/remotes/scratch/maint
+	+refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	+refs/heads/pu:refs/remotes/scratch/pu
+	+refs/heads/t/topic:refs/remotes/scratch/t/topic
+	EOF
+	sort <<-\EOF >expect.setup-ffonly &&
+	refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	EOF
+	sort <<-\EOF >expect.respect-ffonly &&
+	refs/heads/master:refs/remotes/scratch/master
+	+refs/heads/next:refs/remotes/scratch/next
+	+refs/heads/pu:refs/remotes/scratch/pu
+	EOF
+
+	git clone .git/ setbranches &&
+	(
+		cd setbranches &&
+		git remote rename origin scratch &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.initial &&
+
+		git remote set-branches scratch --add other &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.add &&
+
+		git remote set-branches scratch maint master next &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.replace &&
+
+		git remote set-branches --add scratch pu t/topic &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.add-two &&
+
+		git config --unset-all remote.scratch.fetch &&
+		git config remote.scratch.fetch \
+			refs/heads/master:refs/remotes/scratch/master &&
+		git config --add remote.scratch.fetch \
+			+refs/heads/next:refs/remotes/scratch/next &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.setup-ffonly &&
+
+		git remote set-branches --add scratch pu &&
+		git config --get-all remote.scratch.fetch >config-result &&
+		sort <config-result >../actual.respect-ffonly
+	) &&
+	test_cmp expect.initial actual.initial &&
+	test_cmp expect.add actual.add &&
+	test_cmp expect.replace actual.replace &&
+	test_cmp expect.add-two actual.add-two &&
+	test_cmp expect.setup-ffonly actual.setup-ffonly &&
+	test_cmp expect.respect-ffonly actual.respect-ffonly
+'
+
+test_expect_success 'remote set-branches with --mirror' '
+	echo "+refs/*:refs/*" >expect.initial &&
+	echo "+refs/heads/master:refs/heads/master" >expect.replace &&
+	git clone --mirror .git/ setbranches-mirror &&
+	(
+		cd setbranches-mirror &&
+		git remote rename origin scratch &&
+		git config --get-all remote.scratch.fetch >../actual.initial &&
+
+		git remote set-branches scratch heads/master &&
+		git config --get-all remote.scratch.fetch >../actual.replace
+	) &&
+	test_cmp expect.initial actual.initial &&
+	test_cmp expect.replace actual.replace
+'
+
 test_expect_success 'new remote' '
 	git remote add someremote foo &&
 	echo foo >expect &&
--=20
1.7.1
