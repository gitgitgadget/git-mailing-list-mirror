From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv2 3/4] commit: --squash option for use with rebase --autosquash
Date: Wed, 22 Sep 2010 12:02:16 -0600
Message-ID: <AANLkTi=QnVX9=uPWQPbQWGtw+qu2tqhij47t7Z6_NX=O@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1285100703-49087-4-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 20:02:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTeV-0003D8-W6
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab0IVSCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:02:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0IVSCh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:02:37 -0400
Received: by fxm12 with SMTP id 12so218286fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=r69eIAaZfpEsCCabvIzqkBniJgitF00I5Dk3sYEsNLU=;
        b=Bcq7e3vEE0O84KgPSMxVxHGUnin1lpck3i4CO0QPu4ySN2eADQElJTK3qiXeyZ/7XQ
         WFx/n/6Le6b5vKLR2iuP0i41UZe+xb1FwBeaPTC/QZab/xzFJZQk3RBey+GtbmVPLolx
         VDHdF9tDhz70TXRUMfzF9+myJQ8aH8Cng//S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=J8st0Gi2aZUFMQ4Qqil4rQMQ7ELsBllknXViGriay8DIwDAxb0366Id9OR30mzay2B
         hVt3JPqeoCax+OZId9r7wl+CIpOGnp9B3Wkvi0M1LuWfTdjyjSgPBiz6ZBCuVir/4svn
         kTBx9fJJ+GTiW3Ynj/VV9f1nPk7E4/x6Q/hUM=
Received: by 10.239.168.68 with SMTP id j4mr35333hbe.115.1285178556415; Wed,
 22 Sep 2010 11:02:36 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 11:02:16 -0700 (PDT)
In-Reply-To: <1285100703-49087-4-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156815>

On Tue, Sep 21, 2010 at 2:25 PM, Pat Notz <patnotz@gmail.com> wrote:
> This option makes it convenient to construct commit messages for use
> with 'rebase --autosquash'. =A0The resulting commit message will be
> "squash! ..." where "..." is the subject line of the specified commit
> message. =A0This option can be used with other commit message options
> such as -m, -c, -C and -F.
>
> If an editor is invoked (as with -c or -eF or no message options) the
> commit message is seeded with the correctly formatted subject line.
>
> Example usage:
> =A0$ git commit --squash HEAD~2
> =A0$ git commit --squash HEAD~2 -m "clever comment"
> =A0$ git commit --squash HEAD~2 -F msgfile
> =A0$ git commit --squash HEAD~2 -C deadbeef
>
> Signed-off-by: Pat Notz <patnotz@gmail.com>
> ---
> =A0Documentation/git-commit.txt | =A0 =A08 +++++++-
> =A0builtin/commit.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 37 ++++++++++++++++=
+++++++++++++++++++--
> =A02 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 3367f8f..b621dc4 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
> =A0--------
> =A0[verse]
> =A0'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [=
--dry-run]
> - =A0 =A0 =A0 =A0 =A0[(-c | -C | --fixup) <commit>] [-F <file> | -m <=
msg>]
> + =A0 =A0 =A0 =A0 =A0[(-c | -C | --fixup | --squash) <commit>] [-F <f=
ile> | -m <msg>]
> =A0 =A0 =A0 =A0 =A0 [--reset-author] [--allow-empty] [--allow-empty-m=
essage] [--no-verify]
> =A0 =A0 =A0 =A0 =A0 [-e] [--author=3D<author>] [--date=3D<date>] [--c=
leanup=3D<mode>]
> =A0 =A0 =A0 =A0 =A0 [--status | --no-status] [--] [[-i | -o ]<file>..=
=2E]
> @@ -75,6 +75,12 @@ OPTIONS
> =A0 =A0 =A0 =A0The commit message will be the subject line from the s=
pecified
> =A0 =A0 =A0 =A0commit with a prefix of "fixup! ".
>
> +--squash=3D<commit>::
> + =A0 =A0 =A0 Construct a commit message for use with `rebase --autos=
quash`.
> + =A0 =A0 =A0 The commit message subject line is taken from the speci=
fied
> + =A0 =A0 =A0 commit with a prefix of "squash! ". =A0Can be used with=
 additional
> + =A0 =A0 =A0 commit message options (`-m`/`-c`/`-C`/`-F`).
> +

Ditto - I should add links to the git-rebase man page here.

> =A0--reset-author::
> =A0 =A0 =A0 =A0When used with -C/-c/--amend options, declare that the
> =A0 =A0 =A0 =A0authorship of the resulting commit now belongs of the =
committer.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0901616..d28b2ff 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -69,7 +69,7 @@ static enum {
> =A0static const char *logfile, *force_author;
> =A0static const char *template_file;
> =A0static char *edit_message, *use_message;
> -static char *fixup_message;
> +static char *fixup_message, *squash_message;
> =A0static char *author_name, *author_email, *author_date;
> =A0static int all, edit_flag, also, interactive, only, amend, signoff=
;
> =A0static int quiet, verbose, no_verify, allow_empty, dry_run, renew_=
authorship;
> @@ -126,6 +126,7 @@ static struct option builtin_commit_options[] =3D=
 {
> =A0 =A0 =A0 =A0OPT_STRING('c', "reedit-message", &edit_message, "COMM=
IT", "reuse and edit message from specified commit"),
> =A0 =A0 =A0 =A0OPT_STRING('C', "reuse-message", &use_message, "COMMIT=
", "reuse message from specified commit"),
> =A0 =A0 =A0 =A0OPT_STRING(0, "fixup", &fixup_message, "COMMIT", "use =
autosquash formatted message to fixup specified commit"),
> + =A0 =A0 =A0 OPT_STRING(0, "squash", &squash_message, "COMMIT", "use=
 autosquash formatted message to squash specified commit"),
> =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the=
 commit is authored by me now (used with -C-c/--amend)"),
> =A0 =A0 =A0 =A0OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-=
by:"),
> =A0 =A0 =A0 =A0OPT_FILENAME('t', "template", &template_file, "use spe=
cified template file"),
> @@ -567,6 +568,27 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
> =A0 =A0 =A0 =A0if (!no_verify && run_hook(index_file, "pre-commit", N=
ULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 if (squash_message) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Insert the proper subject line bef=
ore other commit
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* message options add their content.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char sha1[20];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct commit *commit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pretty_print_context ctx =3D {0}=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (get_sha1(squash_message, sha1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not lookup c=
ommit %s", squash_message);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit =3D lookup_commit_reference(sha1=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!commit || parse_commit(commit))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("could not parse co=
mmit %s", squash_message);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(use_message && strcmp(use_message, s=
quash_message) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(&sb,"squa=
sh! ");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format_commit_message(c=
ommit, "squash! %s\n\n", &sb, &ctx);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (message.len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addbuf(&sb, &message);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hook_arg1 =3D "message";
> @@ -620,6 +642,16 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
> =A0 =A0 =A0 =A0else if (in_merge)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hook_arg1 =3D "merge";
>
> + =A0 =A0 =A0 if (squash_message) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If squash_commit was used for the =
commit subject,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* then we're possibly hijacking othe=
r commit log options.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reset the hook args to tell the re=
al story.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hook_arg1 =3D "message";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hook_arg2 =3D "";
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0fp =3D fopen(git_path(commit_editmsg), "w");
> =A0 =A0 =A0 =A0if (fp =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die_errno("could not open '%s'", git_p=
ath(commit_editmsg));
> @@ -891,7 +923,8 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You have nothing to amend.");
> =A0 =A0 =A0 =A0if (amend && in_merge)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You are in the middle of a merge =
-- cannot amend.");
> -
> + =A0 =A0 =A0 if (fixup_message && squash_message)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Options --squash and --fixup canno=
t be used together");
> =A0 =A0 =A0 =A0if (use_message)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f++;
> =A0 =A0 =A0 =A0if (edit_message)
> --
> 1.7.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
