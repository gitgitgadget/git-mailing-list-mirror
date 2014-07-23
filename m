From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] prune --repos: fix uninitialized access
Date: Wed, 23 Jul 2014 12:59:24 -0700
Message-ID: <xmqq61inetib.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:01:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2jV-0004s2-4L
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 22:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbaGWUBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 16:01:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64729 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932665AbaGWUBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 16:01:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 028FF2B2E1;
	Wed, 23 Jul 2014 16:01:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M09boOT+1JVO
	Spq6Oe8y1vXg560=; b=I5RDIOMtQmha2ufwkgIttoEI3djkZVFNB/vvLvoocL9d
	Cl+JG120EaxjUgAz5j+s2HU3Lgn1pX7v+UjAfHvVX9ANyMEYimViITn+k0wDTENY
	H0StLV9sxqjRczANvY48x4oYYLeyhKsc07i0s8wOfexvwevEAKIMDqXqLZ9N3L8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LKLxNG
	qdLwsMk2Ma7ehw83Jh3u09XZ1BrPOEJlEzgtzl3wCslEOFBFngmkHcOwmTwz/68V
	YgnkPbrXZ2rnThHVGZBq2vq8PljpJ+Mwd6v+w+wXBxMSvpaEfDh0Kyt0SDBS7SLu
	vMfa4j/v8MrS2MDmUwcQRPwAAv+UEpZ+P2Oeg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9A112B2DF;
	Wed, 23 Jul 2014 16:01:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 659AA2B0F0;
	Wed, 23 Jul 2014 15:59:26 -0400 (EDT)
In-Reply-To: <1406115795-24082-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23
 Jul 2014 18:43:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9666640-12A3-11E4-8529-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254118>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There's a code path in prune_repo_dir() that does not initialize 'st'
> buffer, which is checked by the caller, prune_repos_dir(). Instead
> of leaking some prune logic out to prune_repos_dir(), move 'st' into
> prune_repo_dir().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The return value from the function used to be "should .git/repos/$x
be removed if it is stale enough?" and now it is just "should it be
removed?", so the change makes sense.

It does not explain what the change to the test is about, though.

Thanks.

>  builtin/prune.c                   | 16 ++++++----------
>  t/t2026-prune-linked-checkouts.sh |  2 +-
>  2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 28b7adf..e72c391 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -112,8 +112,9 @@ static void prune_object_dir(const char *path)
>  	}
>  }
> =20
> -static int prune_repo_dir(const char *id, struct stat *st, struct st=
rbuf *reason)
> +static int prune_repo_dir(const char *id, struct strbuf *reason)
>  {
> +	struct stat st;
>  	char *path;
>  	int fd, len;
> =20
> @@ -123,26 +124,23 @@ static int prune_repo_dir(const char *id, struc=
t stat *st, struct strbuf *reason
>  	}
>  	if (file_exists(git_path("repos/%s/locked", id)))
>  		return 0;
> -	if (stat(git_path("repos/%s/gitdir", id), st)) {
> -		st->st_mtime =3D expire;
> +	if (stat(git_path("repos/%s/gitdir", id), &st)) {
>  		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exi=
st"), id);
>  		return 1;
>  	}
>  	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
>  	if (fd < 0) {
> -		st->st_mtime =3D expire;
>  		strbuf_addf(reason, _("Removing repos/%s: unable to read gitdir fi=
le (%s)"),
>  			    id, strerror(errno));
>  		return 1;
>  	}
> -	len =3D st->st_size;
> +	len =3D st.st_size;
>  	path =3D xmalloc(len + 1);
>  	read_in_full(fd, path, len);
>  	close(fd);
>  	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\=
r'))
>  		len--;
>  	if (!len) {
> -		st->st_mtime =3D expire;
>  		strbuf_addf(reason, _("Removing repos/%s: invalid gitdir file"), i=
d);
>  		free(path);
>  		return 1;
> @@ -162,7 +160,7 @@ static int prune_repo_dir(const char *id, struct =
stat *st, struct strbuf *reason
>  		return 1;
>  	}
>  	free(path);
> -	return 0;
> +	return st.st_mtime <=3D expire;
>  }
> =20
>  static void prune_repos_dir(void)
> @@ -172,15 +170,13 @@ static void prune_repos_dir(void)
>  	DIR *dir =3D opendir(git_path("repos"));
>  	struct dirent *d;
>  	int ret;
> -	struct stat st;
>  	if (!dir)
>  		return;
>  	while ((d =3D readdir(dir)) !=3D NULL) {
>  		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>  			continue;
>  		strbuf_reset(&reason);
> -		if (!prune_repo_dir(d->d_name, &st, &reason) ||
> -		    st.st_mtime > expire)
> +		if (!prune_repo_dir(d->d_name, &reason))
>  			continue;
>  		if (show_only || verbose)
>  			printf("%s\n", reason.buf);
> diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked=
-checkouts.sh
> index 4ccfa4e..79d84cb 100755
> --- a/t/t2026-prune-linked-checkouts.sh
> +++ b/t/t2026-prune-linked-checkouts.sh
> @@ -77,7 +77,7 @@ test_expect_success 'not prune recent checkouts' '
>  	mkdir zz &&
>  	mkdir -p .git/repos/jlm &&
>  	echo "$TRASH_DIRECTORY"/zz >.git/repos/jlm/gitdir &&
> -	git prune --repos --verbose &&
> +	git prune --repos --verbose --expire=3D2.days.ago &&
>  	test -d .git/repos/jlm
>  '
