From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Add default merge options for all branches
Date: Mon, 2 May 2011 15:12:07 -0300
Message-ID: <BANLkTikgcwL6KRNAvxyAiHxLPzG7jeU6Vg@mail.gmail.com>
References: <4DBED99E.3050709@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, vmiklos@frugalware.org, deskinm@umich.edu,
	gitster@pobox.com
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:12:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGxbT-0002kl-R3
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 20:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab1EBSMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 14:12:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43300 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab1EBSMI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 14:12:08 -0400
Received: by wwa36 with SMTP id 36so6602682wwa.1
        for <git@vger.kernel.org>; Mon, 02 May 2011 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=chrciwkCQkFfvp1m94TCjDHOJv0uk/a+1B+Y+usW4GY=;
        b=vWldLrc1bLTFJE2bNb/To2B8nLssJO2zKdfAOAdhx78IQSeQsYyiw16mk/ptVba9Kt
         +MpZTyoTEIZ62Euti1LECBCPBkCc9JyPOju8LYswxTf0aBrbR97qyPm+auqF/F6+FDfH
         ATnfB4MLFW/J5aHwwpvZ1d7WHnENPNYK/oC34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f/4pwCZ1SfYmInk11Losl28/qKM1qFEfZ0z8VHhLY+sLGzbMufV8Tl9D7DUHGP8cuv
         GCltri+xaHQ3a48UKw0CQh0F1Guj3gxc2A29ifdwhFSgM28TY51yY8cH+4GSPYAuK6oe
         4fKH9gto2URdCEQZaAt9N48vAH4lQ5OED6s24=
Received: by 10.216.229.82 with SMTP id g60mr2695601weq.70.1304359927165; Mon,
 02 May 2011 11:12:07 -0700 (PDT)
Received: by 10.216.164.4 with HTTP; Mon, 2 May 2011 11:12:07 -0700 (PDT)
In-Reply-To: <4DBED99E.3050709@dailyvoid.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172611>

On Mon, May 2, 2011 at 1:19 PM, Michael Grubb <devel@dailyvoid.com> wro=
te:
> Introduce a new configuration variable, merge.mergeoptions.
> The semantics of this new variable are the same as the branch specifi=
c
> branch.<branch>.mergeoptions. =C2=A0However, if a branch specific set=
ting is
> found, this option will not override it.
>
> The need for this arises from the fact that there is currently not an
> easy way to set merge options for all branches. Instead of having to
> specify merge options for each individual branch there should be a wa=
y
> to set defaults for all branches and then override a specific branch'=
s
> options.
>
> The approach taken is to make note of whether a branch specific
> mergeoptions key has been seen and only apply the global value if it
> hasn't. An alternative method would be to keep the
> branch.<branch>.mergeoptions semantics, but assign a special value fo=
r
> <branch> to be the global default.
>
> Signed-off-by: Michael Grubb <devel@dailyvoid.com>
> ---
> =C2=A0Documentation/merge-config.txt | =C2=A0 =C2=A07 +++++++
> =C2=A0builtin/merge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 27 ++++++++++++++++++++++-----
> =C2=A0t/t7600-merge.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 27 +++++++++++++++++++++++++++
> =C2=A03 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-con=
fig.txt
> index 8920258..0fc7511 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -57,6 +57,13 @@ merge.verbosity::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0above outputs debugging information. =C2=A0=
The default is level 2.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Can be overridden by the 'GIT_MERGE_VERBOS=
ITY' environment variable.
> =C2=A0+merge.mergeoptions::
> + =C2=A0 =C2=A0 =C2=A0 Sets default options for merging any branch. T=
his value is only
> + =C2=A0 =C2=A0 =C2=A0 used if there is not a branch.<name>.mergeopti=
ons value set.
> + =C2=A0 =C2=A0 =C2=A0 The syntax and supported options are the same =
as those of 'git
> + =C2=A0 =C2=A0 =C2=A0 merge', but option values containing whitespac=
e characters are
> + =C2=A0 =C2=A0 =C2=A0 currently not supported.
> +
> =C2=A0merge.<driver>.name::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Defines a human-readable name for a custom=
 low-level
> =C2=A0 =C2=A0 =C2=A0 =C2=A0merge driver. =C2=A0See linkgit:gitattribu=
tes[5] for details.
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0bdd19a..1d4f852 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -505,9 +505,18 @@ cleanup:
> =C2=A0static int git_merge_config(const char *k, const char *v, void =
*cb)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (branch && !prefixcmp(k, "branch.") &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !prefixcmp(k + 7, =
branch) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcmp(k + 7 + st=
rlen(branch), ".mergeoptions")) {
> + =C2=A0 =C2=A0 =C2=A0 static int branch_merge_options_set =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int merge_option_mode =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 if ( !strcmp(k, "merge.mergeoptions") )

please, no need of spaces between if ( ... )

There are more cases in this change below.

I don't know if Junio is strong about this and if you need to resend.
But at least that is not consistent with the rest of the file.

Just my 0.02 cents.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge_option_mode =
=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 else if ( branch && !prefixcmp(k, "branch.") &=
&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0!prefixcmp(k + 7, branch) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0!strcmp(k + 7 + strlen(branch), ".mergeoptions"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge_option_mode =
=3D 2;
> +
> + =C2=A0 =C2=A0 =C2=A0 if ( (merge_option_mode =3D=3D 1 && !branch_me=
rge_options_set) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 merge_optio=
n_mode =3D=3D 2) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char **a=
rgv;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int argc;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf;
> @@ -515,14 +524,22 @@ static int git_merge_config(const char *k, cons=
t
> char *v, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D xstrdu=
p(v);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argc =3D split=
_cmdline(buf, &argv);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc < 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 split_cmdline_strerror(argc));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if ( merge_option_mode =3D=3D 1 )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Bad merge.mergeoptions strin=
g: %s"), +
> split_cmdline_strerror(argc));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("Bad branch.%s.mergeoptions s=
tring: %s"), branch,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 split_c=
mdline_strerror(argc));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv =3D xreal=
loc(argv, sizeof(*argv) * (argc + 2));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memmove(argv +=
 1, argv, sizeof(*argv) * (argc + 1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argc++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_options(=
argc, argv, NULL, builtin_merge_options,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0builtin_merge_usage, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( merge_option_=
mode =3D=3D 2 )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 branch_merge_options_set =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(k, "merge.diffstat") || !strcm=
p(k, "merge.stat"))
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 87d5d78..15e9418 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -415,6 +415,33 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
> =C2=A0test_debug 'git log --graph --decorate --oneline --all'
> =C2=A0+test_expect_success 'merge c0 with c1 (global no-ff)' '
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard c0 &&
> + =C2=A0 =C2=A0 =C2=A0 git config --unset branch.master.mergeoptions =
&&
> + =C2=A0 =C2=A0 =C2=A0 git config merge.mergeoptions "--no-ff" &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git merge c1 &&
> + =C2=A0 =C2=A0 =C2=A0 git config --remove-section merge &&
> + =C2=A0 =C2=A0 =C2=A0 verify_merge file result.1 &&
> + =C2=A0 =C2=A0 =C2=A0 verify_parents $c0 $c1
> +'
> +
> +test_debug 'git log --graph --decorate --oneline --all'
> +
> +test_expect_success 'combine merge.mergeoptions with
> branch.x.mergeoptions' '
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard c0 &&
> + =C2=A0 =C2=A0 =C2=A0 git config --remove-section branch.master &&
> + =C2=A0 =C2=A0 =C2=A0 git config merge.mergeoptions "--no-ff" &&
> + =C2=A0 =C2=A0 =C2=A0 git config branch.master.mergeoptions "--ff" &=
&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git merge c1 &&
> + =C2=A0 =C2=A0 =C2=A0 git config --remove-section merge &&
> + =C2=A0 =C2=A0 =C2=A0 verify_merge file result.1 &&
> + =C2=A0 =C2=A0 =C2=A0 verify_parents "$c0"
> +'
> +
> +test_debug 'git log --graph --decorate --oneline --all'
> +
> =C2=A0test_expect_success 'combining --squash and --no-ff is refused'=
 '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git merge --squash --no-ff =
c1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git merge --no-ff --squash =
c1
> --
> 1.7.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
