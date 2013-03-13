From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] wt-status: move strbuf into
 read_and_strip_branch()
Date: Wed, 13 Mar 2013 09:20:57 -0700
Message-ID: <7va9q746fq.fsf@alter.siamese.dyndns.org>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoQj-0003bK-Os
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391Ab3CMQVC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:21:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab3CMQVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 12:21:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F43B8F0;
	Wed, 13 Mar 2013 12:21:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VOwC36TJRRwh
	ywaw77oCpaaDW2I=; b=U9GBR6RF+cmBLsVgM5dLNB9GavobV46bjuUSr+DF8LJf
	1CxWQT+L+rZHRjx/9VQ6X1UY9+le36x9AajpgJRKAI0jHC9vtfakXb9Py5Ef3pZy
	zw7S/sQIxeWYl5X9i5bh44tXgDprqx66Ee2Rr6qm7LsXbc+Gz62Ql4yM/G3CuSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gVWPgZ
	X5bJLTEThTYjDJnpt9l7+9NW++Qi0wcWR61QKC9aWlrKbaZpWcqQj4Q8/2ESwRZA
	JVme/KpSqCV4Ex6sErgOSVW4CCeMOIYh5eiBVS6/DegOoW6gbUkSUlp2Tw2b43/q
	aTYZQ/hyeHxi5McpBcg0VEeJvvUsq7zzA+URk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDACDB8ED;
	Wed, 13 Mar 2013 12:20:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC5C6B8E9; Wed, 13 Mar 2013
 12:20:58 -0400 (EDT)
In-Reply-To: <1363174973-17597-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13 Mar
 2013 18:42:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD72090E-8BF9-11E2-A9E4-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218067>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

You do not have anything to say above the S-o-b line?  The primary
effect of this patch is to change the lifespan and ownership rule of
the piece of memory used for state.branch/state.onto and moving the
strbuf is a mere logical consequence of that change.  It is not
explained why this change is a good idea.

> ---
>  wt-status.c | 65 ++++++++++++++++++++++++++++-----------------------=
----------
>  wt-status.h |  4 ++--
>  2 files changed, 32 insertions(+), 37 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ef405d0..6cac27b 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -969,41 +969,41 @@ static void show_bisect_in_progress(struct wt_s=
tatus *s,
>  /*
>   * Extract branch information from rebase/bisect
>   */
> -static void read_and_strip_branch(struct strbuf *sb,
> -				  const char **branch,
> -				  const char *path)
> +static char *read_and_strip_branch(const char *path)
>  {
> +	struct strbuf sb =3D STRBUF_INIT;
>  	unsigned char sha1[20];
> =20
> -	strbuf_reset(sb);
> -	if (strbuf_read_file(sb, git_path("%s", path), 0) <=3D 0)
> -		return;
> +	if (strbuf_read_file(&sb, git_path("%s", path), 0) <=3D 0)
> +		goto got_nothing;
> =20
> -	while (sb->len && sb->buf[sb->len - 1] =3D=3D '\n')
> -		strbuf_setlen(sb, sb->len - 1);
> -	if (!sb->len)
> -		return;
> -	if (!prefixcmp(sb->buf, "refs/heads/"))
> -		*branch =3D sb->buf + strlen("refs/heads/");
> -	else if (!prefixcmp(sb->buf, "refs/"))
> -		*branch =3D sb->buf;
> -	else if (!get_sha1_hex(sb->buf, sha1)) {
> +	while (&sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
> +		strbuf_setlen(&sb, sb.len - 1);
> +	if (!sb.len)
> +		goto got_nothing;
> +	if (!prefixcmp(sb.buf, "refs/heads/"))
> +		strbuf_remove(&sb,0, strlen("refs/heads/"));
> +	else if (!prefixcmp(sb.buf, "refs/"))
> +		;
> +	else if (!get_sha1_hex(sb.buf, sha1)) {
>  		const char *abbrev;
>  		abbrev =3D find_unique_abbrev(sha1, DEFAULT_ABBREV);
> -		strbuf_reset(sb);
> -		strbuf_addstr(sb, abbrev);
> -		*branch =3D sb->buf;
> -	} else if (!strcmp(sb->buf, "detached HEAD")) /* rebase */
> -		;
> +		strbuf_reset(&sb);
> +		strbuf_addstr(&sb, abbrev);
> +	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
> +		goto got_nothing;
>  	else			/* bisect */
> -		*branch =3D sb->buf;
> +		;
> +	return strbuf_detach(&sb, NULL);
> +
> +got_nothing:
> +	strbuf_release(&sb);
> +	return NULL;
>  }
> =20
>  static void wt_status_print_state(struct wt_status *s)
>  {
>  	const char *state_color =3D color(WT_STATUS_HEADER, s);
> -	struct strbuf branch =3D STRBUF_INIT;
> -	struct strbuf onto =3D STRBUF_INIT;
>  	struct wt_status_state state;
>  	struct stat st;
> =20
> @@ -1018,27 +1018,22 @@ static void wt_status_print_state(struct wt_s=
tatus *s)
>  				state.am_empty_patch =3D 1;
>  		} else {
>  			state.rebase_in_progress =3D 1;
> -			read_and_strip_branch(&branch, &state.branch,
> -					      "rebase-apply/head-name");
> -			read_and_strip_branch(&onto, &state.onto,
> -					      "rebase-apply/onto");
> +			state.branch =3D read_and_strip_branch("rebase-apply/head-name");
> +			state.onto =3D read_and_strip_branch("rebase-apply/onto");
>  		}
>  	} else if (!stat(git_path("rebase-merge"), &st)) {
>  		if (!stat(git_path("rebase-merge/interactive"), &st))
>  			state.rebase_interactive_in_progress =3D 1;
>  		else
>  			state.rebase_in_progress =3D 1;
> -		read_and_strip_branch(&branch, &state.branch,
> -				      "rebase-merge/head-name");
> -		read_and_strip_branch(&onto, &state.onto,
> -				      "rebase-merge/onto");
> +		state.branch =3D read_and_strip_branch("rebase-merge/head-name");
> +		state.onto =3D read_and_strip_branch("rebase-merge/onto");
>  	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
>  		state.cherry_pick_in_progress =3D 1;
>  	}
>  	if (!stat(git_path("BISECT_LOG"), &st)) {
>  		state.bisect_in_progress =3D 1;
> -		read_and_strip_branch(&branch, &state.branch,
> -				      "BISECT_START");
> +		state.branch =3D read_and_strip_branch("BISECT_START");
>  	}
> =20
>  	if (state.merge_in_progress)
> @@ -1051,8 +1046,8 @@ static void wt_status_print_state(struct wt_sta=
tus *s)
>  		show_cherry_pick_in_progress(s, &state, state_color);
>  	if (state.bisect_in_progress)
>  		show_bisect_in_progress(s, &state, state_color);
> -	strbuf_release(&branch);
> -	strbuf_release(&onto);
> +	free(state.branch);
> +	free(state.onto);
>  }
> =20
>  void wt_status_print(struct wt_status *s)
> diff --git a/wt-status.h b/wt-status.h
> index 81e1dcf..b8c3512 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -79,8 +79,8 @@ struct wt_status_state {
>  	int rebase_interactive_in_progress;
>  	int cherry_pick_in_progress;
>  	int bisect_in_progress;
> -	const char *branch;
> -	const char *onto;
> +	char *branch;
> +	char *onto;
>  };
> =20
>  void wt_status_prepare(struct wt_status *s);
