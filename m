From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH] New commit option --fixup.
Date: Wed, 6 Oct 2010 18:38:58 -0600
Message-ID: <AANLkTimHz3sCDh-aicw1agi_mrL8pUztfi32vWv1pXUM@mail.gmail.com>
References: <1286405901-13586-1-git-send-email-rodolfo.borges@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Rodolfo Borges <rodolfo.borges@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 02:39:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3eW8-0003AP-5O
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 02:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904Ab0JGAjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 20:39:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60478 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573Ab0JGAjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 20:39:22 -0400
Received: by fxm4 with SMTP id 4so86461fxm.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=As51H9cRZeQ3VX2TaFlZ1v9XxZxifJMZTdowgAaZBE4=;
        b=CRAte9nZiqCSXts+MZcI+BTp/+9z3EreA9vff2Vs7QL5dzsqIWDsqmTN0wm4jeMOH9
         7bP4oTFyci5T6tkthKf5I/mw1WoVFi/0gxa1ZphIFBYyewP1oUZjlXQcVvMKkYzt25+F
         EjoIYEepo68UMb1ph3BQ91TNvIoPEiQFA96Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T6bDONkY05WTXGOkyg4WrfieGxBsK3D3PUyVn6ja0caQJD0k+VpMzghEtVm5ntSt6+
         lfoxyT2N35a10w23Ug2BGZF1wv24RzgcfrGET9rip7osOcfGyPTtueDiJAbbuNEqJAGA
         jpbTMYFIvAo/Wr4sycr3InHjVWzNUL9CQN8lE=
Received: by 10.239.162.11 with SMTP id j11mr138hbd.129.1286411958770; Wed, 06
 Oct 2010 17:39:18 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 6 Oct 2010 17:38:58 -0700 (PDT)
In-Reply-To: <1286405901-13586-1-git-send-email-rodolfo.borges@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158359>

On Wed, Oct 6, 2010 at 4:58 PM, Rodolfo Borges <rodolfo.borges@gmail.co=
m> wrote:
> Equivalent of '-C HEAD --amend'.
> Inspired by new 'fixup' rebase -i action.
>
> Signed-off-by: Rodolfo Borges <rodolfo.borges@gmail.com>
> ---
> =A0Documentation/git-commit.txt | =A0 =A04 ++++
> =A0builtin/commit.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +++++++-
> =A02 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 42fb1f5..faba634 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -180,6 +180,10 @@ You should understand the implications of rewrit=
ing history if you
> =A0amend a commit that has already been published. =A0(See the "RECOV=
ERING
> =A0FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
>
> +--fixup::
> + =A0 =A0 =A0 Like '--amend', but use previous commit message.
> + =A0 =A0 =A0 (Equivalent to `--amend -C HEAD`.)
> +

Why not just use an alias for this?  I do:

git config alias.fixup "commit --amend -C HEAD"

Also, I've been working on --fixup and --squash options for commit,
under the same inspiration.  See,
http://thread.gmane.org/gmane.comp.version-control.git/156883

I'm hoping to submit v5 patch series tomorrow night.

> =A0-i::
> =A0--include::
> =A0 =A0 =A0 =A0Before making a commit out of staged contents so far,
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 66fdd22..fd7c145 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -70,7 +70,7 @@ static const char *logfile, *force_author;
> =A0static const char *template_file;
> =A0static char *edit_message, *use_message;
> =A0static char *author_name, *author_email, *author_date;
> -static int all, edit_flag, also, interactive, only, amend, signoff;
> +static int all, edit_flag, also, interactive, only, amend, fixup, si=
gnoff;
> =A0static int quiet, verbose, no_verify, allow_empty, dry_run, renew_=
authorship;
> =A0static int no_post_rewrite, allow_empty_message;
> =A0static char *untracked_files_arg, *force_date, *ignore_submodule_a=
rg;
> @@ -147,6 +147,7 @@ static struct option builtin_commit_options[] =3D=
 {
> =A0 =A0 =A0 =A0OPT_BOOLEAN('z', "null", &null_termination,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"terminate entries with NUL"),
> =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "amend", &amend, "amend previous commit=
"),
> + =A0 =A0 =A0 OPT_BOOLEAN(0, "fixup", &fixup, "fixup previous commit"=
),
> =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "b=
ypass post-rewrite hook"),
> =A0 =A0 =A0 =A0{ OPTION_STRING, 'u', "untracked-files", &untracked_fi=
les_arg, "mode", "show untracked files, optional modes: all, normal, no=
 (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> =A0 =A0 =A0 =A0/* end commit contents options */
> @@ -863,6 +864,11 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
> =A0 =A0 =A0 =A0if (force_author && renew_authorship)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Using both --reset-author and --a=
uthor does not make sense");
>
> + =A0 =A0 =A0 if (fixup) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 amend =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_message =3D "HEAD";
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (logfile || message.len || use_message)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_editor =3D 0;
> =A0 =A0 =A0 =A0if (edit_flag)
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
