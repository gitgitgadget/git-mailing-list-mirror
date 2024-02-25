Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E012EEC4
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864263; cv=none; b=G0wMU9/43Wt06SgfxYUeVY3w30EL0jKwgzYHoyS6VibHh01J0lfpIxckIPK7gX20Wa1ZSKzzTKOQvUVObDNpXqx8KDnLt2SfbXebfF2gmAHrHU/6Dd9Zvu5G1O2LxX0yhY8PRCtUh4PRR5Jv+ibVqs7zsjINIafGoKB47FxyHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864263; c=relaxed/simple;
	bh=8Jr2PHecEV94Jw6y3rbRUZkHs+52Bz2VS5LnRQ4K1SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv7rDi+dD1jwGSUujAB2MW69BQfPhcc2q+hrRMfBur0GLXcXJsvFK9Yhjq3k1wgnoRgkuAZtus8jqfmQmrlR0NLcTln02AM4GPNU1C+i0NE6KSWvrA18E+YhSXAUez9vkYP4Z0olpQ5dKySvwdcoA9MTtV5Mce2Q0nrACuWBqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=TcjFWOn5; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="TcjFWOn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708864252; x=1709469052; i=tboegi@web.de;
	bh=8Jr2PHecEV94Jw6y3rbRUZkHs+52Bz2VS5LnRQ4K1SM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=TcjFWOn5pjRtYzpdCoul257RD6+ChLlS+lB9ExOoKVw3eDoa11J2knQmT1o759IM
	 6A2qQtEQ7k8uDWtN8NgDoyv4JwrElFNsbMR7o5904tEcOu12lMNcpQXeSJrKhJP1s
	 tn80rSfj43DgtlK50ti5Il2B6ZN2kow/1nv3rwUm2NLm878mlKWb8ee+R4pD4EqdT
	 31x9G11LKcBaw9H5FrR0SckPkv9qyMiJexm8m+vfvr8W6uKQEvw67ifoY/TX5RIvM
	 DFjVX0lTlJeqxBciy3aFKOUP8ZTpxL91JB7tYRy9LwuHstlNBg2/B4AyNqRMQSGkS
	 +KOtDKeNLPhlnJFwgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPZd-1rHzw50BCz-00MML8; Sun, 25
 Feb 2024 13:30:52 +0100
Date: Sun, 25 Feb 2024 13:30:51 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff Hostetler <git@jeffhostetler.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 06/16] fsmonitor: refactor refresh callback for
 non-directory events
Message-ID: <20240225123050.GA1952@tb-raspi4>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee6ca1aefd34a37d749300e317df10d80ef2b29.1708658300.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:EhmC4JF57/8pc9bD5GqZfodQVduEtrQBlIppwmoyEYGnQQi2ldK
 0S0C66IRjRdSHWgJoe+m1qtUJteBpZkj5Vv8WufxogVOUCd6o1CnBNFKHWCkFHxhd40Curv
 NUZFxheKeT84gSoYG3nm41lQ8yLrtrmo2usdfr5i1VvyOusmktEQ1v2rxO4vWv6RRD5LYAB
 3Me2pk8AYVUGudjiedafA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mBTNl5XqcTY=;NSVKWbO+r/4fcEbYnEk6dxymTin
 q11Q+GnauCFLFuQMlhFmgIQ9GTkkI33LAw9jO3ur11lwzZyLnWTMF52e43KappXULm0rOeeeO
 lsZOh9z+XasG6EcVaBOamFz3WeOuJm+Vn5QAvB61Jc1wtuqZfKyJrh0GiULJgw9Qxhb3I/6oK
 xEBZAxMFZu3zOaVAiYbkocrkLsyvSMHsC+43QAeC9u38Yo1r+Nt9Voq45TKZhZ8c/KUng2+eR
 BruKvUoJQPXE/1DVsZD654Ov6f1Xj0TCcDVUAHAjxQi7oRQjKXNUjii68U9JqzyZKw0DJQDxv
 OntYHXAyOMVXgIiVrChZ9XbFrnBhUTAdb6hZmv5Y7ojwlbt9bCwxJggSaaQM75nmzIeekpXof
 9tlbzeNFiB4HA45Eq5MwMVPpfk5MoKKo69JlV/Qu0/iIfSV8Eayk5ZqvHygmBNmEN8/6iMLbe
 efxU1p5d+90JbkU8/gy5eK/TUCXfpAL3JHU4YBkz0i6qxJD3Qx0Q7WFzD2OL9uyqmleqmk9r+
 RhTCt+RDODa0+6PIo56BbD196l3TzrKQ2ZzV7RPTgJwPosyTlwLLDIgUREJ86tVzOOjoavUq8
 KcWZXPyNNPgBxFdRIYEh1eNcEXdZbO6H8NIEMXR0VxuY2ue/RIAeCq47G46VJajvC22uttYHF
 qOUJlNSBOahGy8gXo4z+Rsq9Rgkwrr5LyQPJqPu2sNYrfViNK7DT74kEnbWIglfLkIaRobAla
 c8pQEfucEBulKJrVx1DCIJ6trwjkhxmMjNcvvU22JALO5VmFPU1GqkbIwBnmgCB8eVjlaP1dl
 t8AApmlP4Svvq2p25mkeWDMTjDqHKcrvGNKzXtAzY1Bo8=
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:18:10AM +0000, Jeff Hostetler via GitGitGadget =
wrote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Move the code handle unqualified FSEvents (without a trailing slash)
> into a helper function.
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 67 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 29cce32d81c..364198d258f 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,6 +183,43 @@ static int query_fsmonitor_hook(struct repository *=
r,
>  	return result;
>  }
>
> +static void handle_path_without_trailing_slash(
> +	struct index_state *istate, const char *name, int pos)
> +{
> +	int i;
> +
> +	if (pos >=3D 0) {
> +		/*
> +		 * We have an exact match for this path and can just
> +		 * invalidate it.
> +		 */
> +		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	} else {
> +		/*
> +		 * The path is not a tracked file -or- it is a
> +		 * directory event on a platform that cannot
> +		 * distinguish between file and directory events in
> +		 * the event handler, such as Windows.
> +		 *
> +		 * Scan as if it is a directory and invalidate the
> +		 * cone under it.  (But remember to ignore items
> +		 * between "name" and "name/", such as "name-" and
> +		 * "name.".
> +		 */
> +		int len =3D strlen(name);

should this be
	size_t len =3D strlen(name);

> +		pos =3D -pos - 1;
> +
> +		for (i =3D pos; i < istate->cache_nr; i++) {
> +			if (!starts_with(istate->cache[i]->name, name))
> +				break;
> +			if ((unsigned char)istate->cache[i]->name[len] > '/')
> +				break;

Hm, this covers all digits, letters, :;<=3D>?
but not e.g. !+-. (and others). What do i miss ?


> +			if (istate->cache[i]->name[len] =3D=3D '/')
> +				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		}
> +	}
> +}
> +
>  /*
>   * The daemon can decorate directory events, such as a move or rename,
>   * by adding a trailing slash to the observed name.  Use this to
> @@ -225,7 +262,7 @@ static void handle_path_with_trailing_slash(
>
>  static void fsmonitor_refresh_callback(struct index_state *istate, char=
 *name)
>  {
> -	int i, len =3D strlen(name);
> +	int len =3D strlen(name);

Same here: size_t len =3D strlen() ?

>  	int pos =3D index_name_pos(istate, name, len);
>
>  	trace_printf_key(&trace_fsmonitor,
> @@ -240,34 +277,8 @@ static void fsmonitor_refresh_callback(struct index=
_state *istate, char *name)
>  		 * for the untracked cache.
>  		 */
>  		name[len - 1] =3D '\0';
> -	} else if (pos >=3D 0) {
> -		/*
> -		 * We have an exact match for this path and can just
> -		 * invalidate it.
> -		 */
> -		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>  	} else {
> -		/*
> -		 * The path is not a tracked file -or- it is a
> -		 * directory event on a platform that cannot
> -		 * distinguish between file and directory events in
> -		 * the event handler, such as Windows.
> -		 *
> -		 * Scan as if it is a directory and invalidate the
> -		 * cone under it.  (But remember to ignore items
> -		 * between "name" and "name/", such as "name-" and
> -		 * "name.".
> -		 */
> -		pos =3D -pos - 1;
> -
> -		for (i =3D pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			if ((unsigned char)istate->cache[i]->name[len] > '/')
> -				break;
> -			if (istate->cache[i]->name[len] =3D=3D '/')
> -				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> -		}
> +		handle_path_without_trailing_slash(istate, name, pos);
>  	}
>
>  	/*
> --
> gitgitgadget
>
>

