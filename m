From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 4/4] merge: add support for merging from upstream by default
Date: Fri, 11 Feb 2011 08:37:17 +0100
Message-ID: <AANLkTi=F8E02GXDsBzne4Fbrg5a0BEK8N7zS_MoaRE+B@mail.gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
	<1297381209-6377-8-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 08:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnnZN-0007TC-OW
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 08:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1BKHhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 02:37:20 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56415 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab1BKHhT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 02:37:19 -0500
Received: by wyb28 with SMTP id 28so2199372wyb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nSvT7aNXJmiJTDlzzYABrT+csT232McjKBjbJzdR0Bw=;
        b=FSU7LrIedRl8wsxEJFDldUn9GcGLubrL16JW3juc9v1DQFkhAFSlLPK8NZ2FMDZ3Ou
         6k3o/Ab9NS7WI8i2UIsZ8t3XYJsaag0/Kp5sG3AJUTcTp14xpNfdcBTQLtzMS+oYr5NF
         Eqc7T6dhKWuZxRVTVork5Yn+rtgvH0qYVJ/u0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=njc6FvQMtM5WZczNiP/T5rKcSOjNJNhcceLs5xvHOM7Kj+zAawRlTqZwv9iFGp5DOc
         UXuwnVDqiQit+LYPsCG7CTa2vcf07UIDPyzE5URusQ8VSQLrJxtNWALndTtmAHqwgnVE
         mWLePOiDZ2b/7bmCFRJys4ZPDQJ6gEOha7yIo=
Received: by 10.227.68.205 with SMTP id w13mr140478wbi.107.1297409837679; Thu,
 10 Feb 2011 23:37:17 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Thu, 10 Feb 2011 23:37:17 -0800 (PST)
In-Reply-To: <1297381209-6377-8-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166542>

On Fri, Feb 11, 2011 at 00:40, Jared Hance <jaredhance@gmail.com> wrote=
:
> Add the option merge.defaultupstream to add support for merging from
> the upstream branch by default. The upstream branch is found using
> branch.[name].merge.
>
> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---
> =C2=A0Documentation/config.txt | =C2=A0 =C2=A06 ++++++
> =C2=A0builtin/merge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 32 +=
++++++++++++++++++++++---------
> =C2=A02 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c5e1835..4415691 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1389,6 +1389,12 @@ man.<tool>.path::
>
> =C2=A0include::merge-config.txt[]
>
> +merge.defaultUpstream::
> + =C2=A0 =C2=A0 =C2=A0 If merge is called without any ref arguments, =
merge from the branch
> + =C2=A0 =C2=A0 =C2=A0 specified in branch.<current branch>.merge, wh=
ich is considered to be
> + =C2=A0 =C2=A0 =C2=A0 the upstream branch for the current branch, po=
ssibly set by --track or
> + =C2=A0 =C2=A0 =C2=A0 --set-upstream.
> +
> =C2=A0mergetool.<tool>.path::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Override the path for the given tool. =C2=A0=
This is useful in case
> =C2=A0 =C2=A0 =C2=A0 =C2=A0your tool is not in the PATH.
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 71b392d..a3ca6a0 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -37,7 +37,7 @@ struct strategy {
> =C2=A0};
>
> =C2=A0static const char * const builtin_merge_usage[] =3D {
> - =C2=A0 =C2=A0 =C2=A0 "git merge [options] <branch>...",
> + =C2=A0 =C2=A0 =C2=A0 "git merge [options] [<branch>...]",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"git merge [options] <msg> HEAD <branch>",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL
> =C2=A0};
> @@ -58,6 +58,8 @@ static int option_renormalize;
> =C2=A0static int verbosity;
> =C2=A0static int allow_rerere_auto;
> =C2=A0static int abort_current_merge;
> +static int default_upstream;
> +static const char *upstream_branch;
>
> =C2=A0static struct strategy all_strategy[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "recursive", =C2=A0DEFAULT_TWOHEAD | NO_=
TRIVIAL },
> @@ -524,7 +526,8 @@ static int per_branch_config(const char *k, const=
 char *v, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(buf);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(variable, ".merge"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_config_=
string(&upstream_branch, k, v);

I don't think, that this is the correct way to get the "upstream" from
a branch. Please have a look into sha1_name.c:interpret_branch_name()
and builtin/for-each-ref.c:populate_value() how they resolve
"upstream".

Bert
