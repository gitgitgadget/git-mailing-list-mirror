From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify worktrees by basename
Date: Tue, 31 May 2016 10:51:05 -0700
Message-ID: <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 19:51:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7np2-0001t1-6x
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 19:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbcEaRvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 13:51:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755650AbcEaRvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 13:51:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D15B1F4B2;
	Tue, 31 May 2016 13:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yvfYrEXih/BA
	dqyzJW63KcSIsWs=; b=E0kV6/meZ+rvHPRle+NSiuS4tFV64EWWOcjjpdjecAm4
	SsBCNiYW0CaQORO0uwnr0Z7AP5AwYT54HBD4SEGTU7o1I29tcQ8txEyH1Ih19ibJ
	zYZRvh2tbnESsrg7pIjIHQtBCuLUz4TUcZ1DdLPbyCk0888pl2C2D7d931ZnO4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oSXmeS
	47s65hFoNevqJMoi0OoT+jqWXhqaWiZSG+kfrR9yMxl9DqliolL8BQl/aF889ya0
	1NhPQ8gZVU9FR/4qs+OQGCSlRCweBdYAj4Q0PZK+SfUoQVQ5E7fpNV1M6mzrSoCi
	ZUu7h47/KjJs5zNa1fUfj04ACsLRRzLme+sAU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B4671F4B1;
	Tue, 31 May 2016 13:51:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 203901F4AE;
	Tue, 31 May 2016 13:51:07 -0400 (EDT)
In-Reply-To: <20160530104939.28407-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4056B45C-2758-11E6-ADC9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295998>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This allows the user to do something like "worktree lock foo" instead=
 of
> "worktree lock <path/to/foo>". With completion support it could be qu=
ite
> convenient. While this base name search can be done in the same workt=
ree
> iteration loop, the code is split into a separate function for clarit=
y.

Makes me wonder if you want to do this without calling basename(3)
function at all.  I do not think such a feature would cost that much
over what we see in this patch.

That is, wouldn't you rather see "worktree lock to/foo" work when
'foo' is ambiguous but 'to/foo' is not?

>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  worktree.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 0782e00..4dd7b77 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -214,12 +214,33 @@ const char *get_worktree_git_dir(const struct w=
orktree *wt)
>  		return git_common_path("worktrees/%s", wt->id);
>  }
> =20
> +static struct worktree *find_worktree_by_basename(struct worktree **=
list,
> +						  const char *base_name)
> +{
> +	struct worktree *found =3D NULL;
> +	int nr_found =3D 0;
> +
> +	for (; *list && nr_found < 2; list++) {
> +		char *path =3D xstrdup((*list)->path);
> +		if (!fspathcmp(base_name, basename(path))) {
> +			found =3D *list;
> +			nr_found++;
> +		}
> +		free(path);
> +	}
> +	return nr_found =3D=3D 1 ? found : NULL;
> +}
> +
>  struct worktree *find_worktree(struct worktree **list,
>  			       const char *prefix,
>  			       const char *arg)
>  {
> +	struct worktree *wt;
>  	char *path;
> =20
> +	if ((wt =3D find_worktree_by_basename(list, arg)))
> +		return wt;
> +
>  	arg =3D prefix_filename(prefix, strlen(prefix), arg);
>  	path =3D xstrdup(real_path(arg));
>  	for (; *list; list++)
