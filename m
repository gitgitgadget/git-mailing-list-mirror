From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/25] clone: define shallow clone boundary based on time with --shallow-since
Date: Mon, 08 Feb 2016 13:20:58 -0800
Message-ID: <xmqqmvra7vb9.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aStF6-0001Cg-5v
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbcBHVVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:21:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755478AbcBHVVC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:21:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 397EA42FCF;
	Mon,  8 Feb 2016 16:21:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3qJSCawx/sSn
	LKzTb7+7fTmG4PA=; b=qo37Qd2TIjG8naAVK6fE+/PKJpe1pAnQzyYriDNwy7qL
	hfu+r7eLR/jzQwDXEZZxL/59JEC99I2hDGthv+GTY0S05qLHP6O7ZzjgP2YY9LvZ
	OBoq666zYRsUg28B6CP5OkMDVdeLulfrcmWoOc+BuBuo6TULaI4xCjOwfqThmGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GNwFC8
	/e4E30XGntaP6Gu6YVx3H2KmEQJ/1wW2fpPnsv+xapoHRd1kftRcyRs5o3033YkN
	ppsKkTpESoih/VY+Uf/AfPfrsNWgIAuJOIe7pbG7fp62hEscZfsbEdMoD6JpRLma
	KkISaDy2kHrUA0Gb0/jWnq2JxBzAcS5grQFUY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCCC042FCE;
	Mon,  8 Feb 2016 16:21:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19C6142FCD;
	Mon,  8 Feb 2016 16:21:00 -0500 (EST)
In-Reply-To: <1454576641-29615-18-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9A93556-CEA9-11E5-AE17-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285808>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

It is kind of surprising that 16 & 17 can be so simple and does not
have to update the way the cut-off points at the client side are
computed or recorded.  We must have done something right when we
designed the initial "--depth" support ;-).

On the other hand, that probably means we have the same "we clone
once, wait for a while and then do a shallow fetch with too short a
history span--the objects in the original clone all go too stale
that they become invisible in the resulting history" property (I
would not call that "an issue") as before.  It is just the way the
shallow boundary is specified got more user friendly (from a number
of parent-child hops to timespan).

Let's keep reading...

>  Documentation/git-clone.txt |  3 +++
>  builtin/clone.c             | 16 +++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index 789b668..1b6b639 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -194,6 +194,9 @@ objects from the source repository into a pack in=
 the cloned repository.
>  	`--no-single-branch` is given to fetch the histories near the
>  	tips of all branches.
> =20
> +--shallow-since=3D<date>::
> +	Create a shallow clone with a history after the specified time.
> +
>  --[no-]single-branch::
>  	Clone only the history leading to the tip of a single branch,
>  	either specified by the `--branch` option or the primary
> diff --git a/builtin/clone.c b/builtin/clone.c
> index bcba080..dc2ef4f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -40,7 +40,8 @@ static const char * const builtin_clone_usage[] =3D=
 {
> =20
>  static int option_no_checkout, option_bare, option_mirror, option_si=
ngle_branch =3D -1;
>  static int option_local =3D -1, option_no_hardlinks, option_shared, =
option_recursive;
> -static char *option_template, *option_depth;
> +static int deepen;
> +static char *option_template, *option_depth, *option_since;
>  static char *option_origin =3D NULL;
>  static char *option_branch =3D NULL;
>  static const char *real_git_dir;
> @@ -86,6 +87,8 @@ static struct option builtin_clone_options[] =3D {
>  		   N_("path to git-upload-pack on the remote")),
>  	OPT_STRING(0, "depth", &option_depth, N_("depth"),
>  		    N_("create a shallow clone of that depth")),
> +	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
> +		    N_("create a shallow clone since a specific time")),
>  	OPT_BOOL(0, "single-branch", &option_single_branch,
>  		    N_("clone only one branch, HEAD or --branch")),
>  	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
> @@ -849,8 +852,10 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  		usage_msg_opt(_("You must specify a repository to clone."),
>  			builtin_clone_usage, builtin_clone_options);
> =20
> +	if (option_depth || option_since)
> +		deepen =3D 1;
>  	if (option_single_branch =3D=3D -1)
> -		option_single_branch =3D option_depth ? 1 : 0;
> +		option_single_branch =3D deepen ? 1 : 0;
> =20
>  	if (option_mirror)
>  		option_bare =3D 1;
> @@ -976,6 +981,8 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  	if (is_local) {
>  		if (option_depth)
>  			warning(_("--depth is ignored in local clones; use file:// instea=
d."));
> +		if (option_since)
> +			warning(_("--shallow-since is ignored in local clones; use file:/=
/ instead."));
>  		if (!access(mkpath("%s/shallow", path), F_OK)) {
>  			if (option_local > 0)
>  				warning(_("source repository is shallow, ignoring --local"));
> @@ -994,6 +1001,9 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  	if (option_depth)
>  		transport_set_option(transport, TRANS_OPT_DEPTH,
>  				     option_depth);
> +	if (option_since)
> +		transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE,
> +				     option_since);
>  	if (option_single_branch)
>  		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
> =20
> @@ -1001,7 +1011,7 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>  		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
>  				     option_upload_pack);
> =20
> -	if (transport->smart_options && !option_depth)
> +	if (transport->smart_options && !deepen)
>  		transport->smart_options->check_self_contained_and_connected =3D 1=
;
> =20
>  	refs =3D transport_get_remote_refs(transport);
