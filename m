From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Thu, 23 Feb 2012 13:43:52 +0100
Message-ID: <CABPQNSZVOjOKpqv4s1ZCEQRd_yT3us3mqC9aN-KK5PHqztYQQg@mail.gmail.com>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Y2J-0004Nm-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab2BWMoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 07:44:34 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48992 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab2BWMod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 07:44:33 -0500
Received: by daed14 with SMTP id d14so1236637dae.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 04:44:33 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.68.227.105 as permitted sender) client-ip=10.68.227.105;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.68.227.105 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.68.227.105])
        by 10.68.227.105 with SMTP id rz9mr3587443pbc.98.1330001073248 (num_hops = 1);
        Thu, 23 Feb 2012 04:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=yBbEpUne7RkgAusB26jsZlUWdao48x4qiO8ttEPmoDo=;
        b=XtCL7C/Yf0mTV4zpjG1yae9DBwT40UsmBWSvNGz4ZispoWbt11KGT3vZw/1jYwcfad
         7axlOu+DwGRz+0TPlXgW2HCemL6ynDqQEi9Bj6M3SIWGQezZDjEhLKJSoQQaKNamb5gZ
         E8PLKpczcmJug48+6KMu+Ypz7bJDAyS8TrJJA=
Received: by 10.68.227.105 with SMTP id rz9mr3034252pbc.98.1330001073159; Thu,
 23 Feb 2012 04:44:33 -0800 (PST)
Received: by 10.68.12.194 with HTTP; Thu, 23 Feb 2012 04:43:52 -0800 (PST)
In-Reply-To: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191359>

On Mon, Jan 23, 2012 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Traditionally, a cleanly resolved merge was committed by "git merge" =
using
> the auto-generated merge commit log message with invoking the editor.
>
> After 5 years of use in the field, it turns out that people perform t=
oo
> many unjustified merges of the upstream history into their topic bran=
ches.
> These merges are not just useless, but they are often not explained w=
ell,
> and making the end result unreadable when it gets time for merging th=
eir
> history back to their upstream.
>
> Earlier we added the "--edit" option to the command, so that people c=
an
> edit the log message to explain and justify their merge commits. Let'=
s
> take it one step further and spawn the editor by default when we are =
in an
> interactive session (i.e. the standard input and the standard output =
are
> pointing at the same tty device).
>
> There may be existing scripts that leave the standard input and the
> standard output of the "git merge" connected to whatever environment =
the
> scripts were started, and such invocation might trigger the above
> "interactive session" heuristics. =A0GIT_MERGE_AUTOEDIT environment v=
ariable
> can be set to "no" at the beginning of such scripts to use the histor=
ical
> behaviour while the script runs.
>
> Note that this backward compatibility is meant only for scripts, and =
we
> deliberately do *not* support "merge.edit =3D yes/no/auto" configurat=
ion
> option to allow people to keep the historical behaviour.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> =A0* With an update to the documentation, so that I won't forget, eve=
n
> =A0 though this topic came too late in the cycle and not meant for th=
e
> =A0 upcoming 1.7.9.
>
> =A0Documentation/git-merge.txt =A0 =A0 | =A0 =A02 +-
> =A0Documentation/merge-options.txt | =A0 16 +++++++++++++---
> =A0builtin/merge.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 38 +++++++++=
+++++++++++++++++++++++++----
> =A0t/test-lib.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 ++-
> =A04 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.tx=
t
> index e2e6aba..3ceefb8 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -9,7 +9,7 @@ git-merge - Join two or more development histories to=
gether
> =A0SYNOPSIS
> =A0--------
> =A0[verse]
> -'git merge' [-n] [--stat] [--no-commit] [--squash]
> +'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> =A0 =A0 =A0 =A0[-s <strategy>] [-X <strategy-option>]
> =A0 =A0 =A0 =A0[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
> =A0'git merge' <msg> HEAD <commit>...
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-op=
tions.txt
> index 6bd0b04..f2f1d0f 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -8,10 +8,20 @@ failed and do not autocommit, to give the user a ch=
ance to
> =A0inspect and further tweak the merge result before committing.
>
> =A0--edit::
> --e::
> +--no-edit::
> + =A0 =A0 =A0 Invoke an editor before committing successful mechanica=
l merge to
> + =A0 =A0 =A0 further edit the auto-generated merge message, so that =
the user
> + =A0 =A0 =A0 can explain and justify the merge. The `--no-edit` opti=
on can be
> + =A0 =A0 =A0 used to accept the auto-generated message (this is gene=
rally
> + =A0 =A0 =A0 discouraged). The `--edit` option is still useful if yo=
u are
> + =A0 =A0 =A0 giving a draft message with the `-m` option from the co=
mmand line
> + =A0 =A0 =A0 and want to edit it in the editor.
> =A0+
> - =A0 =A0 =A0 Invoke editor before committing successful merge to fur=
ther
> - =A0 =A0 =A0 edit the default merge message.
> +Older scripts may depend on the historical behaviour of not allowing=
 the
> +user to edit the merge log message. They will see an editor opened w=
hen
> +they run `git merge`. To make it easier to adjust such scripts to th=
e
> +updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can=
 be
> +set to `no` at the beginning of them.
>
> =A0--ff::
> =A0--no-ff::
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 99f1429..0006175 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -46,7 +46,7 @@ static const char * const builtin_merge_usage[] =3D=
 {
>
> =A0static int show_diffstat =3D 1, shortlog_len, squash;
> =A0static int option_commit =3D 1, allow_fast_forward =3D 1;
> -static int fast_forward_only, option_edit;
> +static int fast_forward_only, option_edit =3D -1;
> =A0static int allow_trivial =3D 1, have_message;
> =A0static struct strbuf merge_msg;
> =A0static struct commit_list *remoteheads;
> @@ -189,7 +189,7 @@ static struct option builtin_merge_options[] =3D =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"create a single commit instead of doi=
ng a merge"),
> =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "commit", &option_commit,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"perform a commit if the merge succeed=
s (default)"),
> - =A0 =A0 =A0 OPT_BOOLEAN('e', "edit", &option_edit,
> + =A0 =A0 =A0 OPT_BOOL('e', "edit", &option_edit,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"edit message before committing"),
> =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "ff", &allow_fast_forward,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"allow fast-forward (default)"),
> @@ -877,12 +877,12 @@ static void prepare_to_commit(void)
> =A0 =A0 =A0 =A0write_merge_msg(&msg);
> =A0 =A0 =A0 =A0run_hook(get_index_file(), "prepare-commit-msg",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_path("MERGE_MSG"), "merge", NULL,=
 NULL);
> - =A0 =A0 =A0 if (option_edit) {
> + =A0 =A0 =A0 if (0 < option_edit) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (launch_editor(git_path("MERGE_MSG"=
), NULL, NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abort_commit(NULL);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0read_merge_msg(&msg);
> - =A0 =A0 =A0 stripspace(&msg, option_edit);
> + =A0 =A0 =A0 stripspace(&msg, 0 < option_edit);
> =A0 =A0 =A0 =A0if (!msg.len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abort_commit(_("Empty commit message."=
));
> =A0 =A0 =A0 =A0strbuf_release(&merge_msg);
> @@ -1076,6 +1076,33 @@ static void write_merge_state(void)
> =A0 =A0 =A0 =A0close(fd);
> =A0}
>
> +static int default_edit_option(void)
> +{
> + =A0 =A0 =A0 static const char name[] =3D "GIT_MERGE_AUTOEDIT";
> + =A0 =A0 =A0 const char *e =3D getenv(name);
> + =A0 =A0 =A0 struct stat st_stdin, st_stdout;
> +
> + =A0 =A0 =A0 if (have_message)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* an explicit -m msg without --[no-]ed=
it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int v =3D git_config_maybe_bool(name, e=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (v < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Bad value '%s' in =
environment '%s'", e, name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return v;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Use editor if stdin and stdout are the same and is a=
 tty */
> + =A0 =A0 =A0 return (!fstat(0, &st_stdin) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !fstat(1, &st_stdout) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 isatty(0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_dev =3D=3D st_stdout.st_dev=
 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_ino =3D=3D st_stdout.st_ino=
 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_mode =3D=3D st_stdout.st_mo=
de);

I just stumbled over this code, and I got a bit worried; the
stat-implementation we use on Windows sets st_ino to 0, so
"st_stdin.st_ino =3D=3D st_stdout.st_ino" will always evaluate to true.

Perhaps we should add a check for isatty(1) here as well? There's max
one console per process on Windows (AllocConsole fails if one has
already been create, see
http://msdn.microsoft.com/en-us/library/windows/desktop/ms681944(v=3Dvs=
=2E85).aspx
for details), so I think if both stdin and stout are consoles, we
should be good.

Or is there something I'm missing here?

---
diff --git a/builtin/merge.c b/builtin/merge.c
index ed0f959..bef01e3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1130,6 +1130,7 @@ static int default_edit_option(void)
 	return (!fstat(0, &st_stdin) &&
 		!fstat(1, &st_stdout) &&
 		isatty(0) &&
+		isatty(1) &&
 		st_stdin.st_dev =3D=3D st_stdout.st_dev &&
 		st_stdin.st_ino =3D=3D st_stdout.st_ino &&
 		st_stdin.st_mode =3D=3D st_stdout.st_mode);
