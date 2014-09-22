From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 28/32] gc: support prune --worktrees
Date: Mon, 22 Sep 2014 17:06:32 -0400
Message-ID: <54208F58.1040604@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-29-git-send-email-pclouds@gmail.com> <20140921104330.GA10475@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:06:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWAoM-0006gH-HL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbaIVVGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2014 17:06:14 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:33280 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbaIVVGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:06:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp31.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id B33EF380224;
	Mon, 22 Sep 2014 17:06:11 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp31.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6CA9F38024A;
	Mon, 22 Sep 2014 17:06:11 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Mon, 22 Sep 2014 21:06:11 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140921104330.GA10475@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257383>

On 14-09-21 06:43 AM, Duy Nguyen wrote:
> And this is the update as suggested in 23/32 [1]
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/256210/foc=
us=3D256849

Looks good!

=46WIW:
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

		M.


> -- 8< --
> Subject: [PATCH] gc: support prune --worktrees
>=20
> Helped-by: Marc Branchaud <marcnarc@xiplink.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt       |  7 +++++++
>  Documentation/git-checkout.txt | 11 +++++++----
>  builtin/gc.c                   | 10 ++++++++++
>  3 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 98b8ef0..8351c8a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1212,6 +1212,13 @@ gc.pruneexpire::
>  	"now" may be used to disable this  grace period and always prune
>  	unreachable objects immediately.
> =20
> +gc.pruneworktreesexpire::
> +	When 'git gc' is run, it will call
> +	'prune --worktrees --expire 3.months.ago'.
> +	Override the grace period with this config variable. The value
> +	"now" may be used to disable the grace period and prune
> +	$GIT_DIR/worktrees immediately.
> +
>  gc.reflogexpire::
>  gc.<pattern>.reflogexpire::
>  	'git reflog expire' removes reflog entries older than
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 0fd3bab..6c14710 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -435,8 +435,11 @@ $GIT_DIR or $GIT_COMMON_DIR when you need to dir=
ectly access something
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
> =20
>  When you are done with a linked working tree you can simply delete i=
t.
> -You can clean up any stale $GIT_DIR/worktrees entries via `git prune
> ---worktrees` in the main worktree or any linked worktree.
> +The working tree's entry in the repository's $GIT_DIR/worktrees
> +directory will eventually be removed automatically (see
> +`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
> +`git prune --worktrees` in the main worktree or any linked worktree =
to
> +clean up any stale entries in $GIT_DIR/worktrees.
> =20
>  If you move a linked working directory to another file system, or
>  within a file system that does not support hard links, you need to r=
un
> @@ -444,8 +447,8 @@ at least one git command inside the linked workin=
g directory
>  (e.g. `git status`) in order to update its entry in $GIT_DIR/worktre=
es
>  so that it does not get automatically removed.
> =20
> -To prevent `git prune --worktrees` from deleting a $GIT_DIR/worktree=
s
> -entry (which can be useful in some situations, such as when the
> +To prevent a $GIT_DIR/worktrees entry from from being pruned (which
> +can be useful in some situations, such as when the
>  entry's working tree is stored on a portable device), add a file nam=
ed
>  'locked' to the entry's directory. The file contains the reason in
>  plain text. For example, if a linked working tree's `.git` file poin=
ts
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 849a87c..35542f3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -33,11 +33,13 @@ static int gc_auto_threshold =3D 6700;
>  static int gc_auto_pack_limit =3D 50;
>  static int detach_auto =3D 1;
>  static const char *prune_expire =3D "2.weeks.ago";
> +static const char *prune_worktrees_expire =3D "3.months.ago";
> =20
>  static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
>  static struct argv_array reflog =3D ARGV_ARRAY_INIT;
>  static struct argv_array repack =3D ARGV_ARRAY_INIT;
>  static struct argv_array prune =3D ARGV_ARRAY_INIT;
> +static struct argv_array prune_worktrees =3D ARGV_ARRAY_INIT;
>  static struct argv_array rerere =3D ARGV_ARRAY_INIT;
> =20
>  static char *pidfile;
> @@ -83,6 +85,7 @@ static void gc_config(void)
>  	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_date_string("gc.pruneexpire", &prune_expire);
> +	git_config_date_string("gc.pruneworktreesexpire", &prune_worktrees_=
expire);
>  	git_config(git_default_config, NULL);
>  }
> =20
> @@ -290,6 +293,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
>  	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
>  	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
>  	argv_array_pushl(&prune, "prune", "--expire", NULL);
> +	argv_array_pushl(&prune_worktrees, "prune", "--worktrees", "--expir=
e", NULL);
>  	argv_array_pushl(&rerere, "rerere", "gc", NULL);
> =20
>  	gc_config();
> @@ -359,6 +363,12 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>  			return error(FAILED_RUN, prune.argv[0]);
>  	}
> =20
> +	if (prune_worktrees_expire) {
> +		argv_array_push(&prune_worktrees, prune_worktrees_expire);
> +		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
> +			return error(FAILED_RUN, prune_worktrees.argv[0]);
> +	}
> +
>  	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
>  		return error(FAILED_RUN, rerere.argv[0]);
> =20
>=20
