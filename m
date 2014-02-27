From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Thu, 27 Feb 2014 11:21:53 +0100
Message-ID: <530F11C1.7040407@alum.mit.edu>
References: <1393491610-19476-1-git-send-email-cmn@elego.de> <1393491610-19476-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 27 11:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIy6O-00079Y-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 11:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbaB0KV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 05:21:59 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63147 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026AbaB0KV6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 05:21:58 -0500
X-AuditID: 12074413-f79076d000002d17-14-530f11c5a61b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A0.16.11543.5C11F035; Thu, 27 Feb 2014 05:21:57 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RALrBl025944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 05:21:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393491610-19476-2-git-send-email-cmn@elego.de>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHtUkD/Y4Pt8KYvpXatZLLqudDM5
	MHlcWveSyePzJrkApihum6TEkrLgzPQ8fbsE7ozPnUvYCrYoVNyZ1sTYwLhUsouRk0NCwERi
	ysp1jBC2mMSFe+vZuhi5OIQELjNKHJ7yhQXCOc8ksWPuVLAqXgFtifaPi4ASHBwsAqoSbx9G
	goTZBHQlFvU0M4HYogLBEqsvP2CBKBeUODnzCZgtImAt0d+4FKyVWUBcov8fWFhYwFVi36E7
	YLaQQK7EnWPb2UFsTgFbiYnfnjCDlEsAlfc0BkF0qkusnycEUsEsIC/RvHU28wRGwVlIds1C
	qJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJDAFd7BuOuk3CFG
	AQ5GJR7eE8x8wUKsiWXFlbmHGCU5mJREefew8wcL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFd
	zwSU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8OoDI1RIsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhS58cXA2AVJ8QDttQRp5y0uSMwFikK0nmLU5bjd
	9usToxBLXn5eqpQ4r70AUJEASFFGaR7cCliaesUoDvSxMC8nyCgeYIqDm/QKaAkT0JKj0jwg
	S0oSEVJSDYzLF/c4Puztcz3N6uZwReuLeJnX9ZXX+PxkbXsZj7nbrOvfUmb/Yf4Om7B9cUIq
	E3QrX6maHWOtmZ5998oG6Qpn3VWfDc3Nbia8TJiuVVy17sQKkysPVT3nn9UO2Jj8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242800>

On 02/27/2014 10:00 AM, Carlos Mart=C3=ADn Nieto wrote:
> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>=20
> We need to consider that a remote-tracking branch may match more than
> one rhs of a fetch refspec. In such a case, it is not enough to stop =
at
> the first match but look at all of the matches in order to determine
> whether a head is stale.
>=20
> To this goal, introduce a variant of query_refspecs which returns all=
 of
> the matching refspecs and loop over those answers to check for
> staleness.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>=20
> There is an unfortunate duplication of code here, as
> query_refspecs_multiple is mostly query_refspecs but we only care
> about the other side of matching refspecs and disregard the 'force'
> information which query_refspecs does want.
>=20
> I thought about putting both together via callbacks and having
> query_refspecs stop at the first one, but I'm not sure that it would
> make it easier to read or manage.
>=20
>  remote.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  t/t5510-fetch.sh |  2 +-
>  2 files changed, 48 insertions(+), 6 deletions(-)
>=20
> diff --git a/remote.c b/remote.c
> index 9f1a8aa..26140c7 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -821,6 +821,33 @@ static int match_name_with_pattern(const char *k=
ey, const char *name,
>  	return ret;
>  }
> =20
> +static void query_refspecs_multiple(struct refspec *refs, int ref_co=
unt, struct refspec *query, struct string_list *results)
> +{
> +	int i;
> +	int find_src =3D !query->src;
> +
> +	if (find_src && !query->dst)
> +		error("query_refspecs_multiple: need either src or dst");
> +
> +	for (i =3D 0; i < ref_count; i++) {
> +		struct refspec *refspec =3D &refs[i];
> +		const char *key =3D find_src ? refspec->dst : refspec->src;
> +		const char *value =3D find_src ? refspec->src : refspec->dst;
> +		const char *needle =3D find_src ? query->dst : query->src;
> +		char **result =3D find_src ? &query->src : &query->dst;
> +
> +		if (!refspec->dst)
> +			continue;
> +		if (refspec->pattern) {
> +			if (match_name_with_pattern(key, needle, value, result)) {
> +				string_list_append_nodup(results, *result);
> +			}
> +		} else if (!strcmp(needle, key)) {
> +			string_list_append(results, value);
> +		}
> +	}
> +}
> +
>  static int query_refspecs(struct refspec *refs, int ref_count, struc=
t refspec *query)
>  {
>  	int i;
> @@ -1954,25 +1981,40 @@ static int get_stale_heads_cb(const char *ref=
name,
>  	const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	struct stale_heads_info *info =3D cb_data;
> +	struct string_list matches =3D STRING_LIST_INIT_DUP;
>  	struct refspec query;
> +	int i, stale =3D 1;
>  	memset(&query, 0, sizeof(struct refspec));
>  	query.dst =3D (char *)refname;
> =20
> -	if (query_refspecs(info->refs, info->ref_count, &query))
> +	query_refspecs_multiple(info->refs, info->ref_count, &query, &match=
es);
> +	if (matches.nr =3D=3D 0)
>  		return 0; /* No matches */
> =20
>  	/*
>  	 * If we did find a suitable refspec and it's not a symref and
>  	 * it's not in the list of refs that currently exist in that
> -	 * remote we consider it to be stale.
> +	 * remote we consider it to be stale. In order to deal with
> +	 * overlapping refspecs, we need to go over all of the
> +	 * matching refs.
>  	 */
> -	if (!((flags & REF_ISSYMREF) ||
> -	      string_list_has_string(info->ref_names, query.src))) {
> +	if (flags & REF_ISSYMREF)
> +		return 0;
> +
> +	for (i =3D 0; i < matches.nr; i++) {
> +		if (string_list_has_string(info->ref_names, matches.items[i].strin=
g)) {
> +			stale =3D 0;
> +			break;
> +		}
> +	}
> +
> +	string_list_clear(&matches, 0);
> +
> +	if (stale) {
>  		struct ref *ref =3D make_linked_ref(refname, &info->stale_refs_tai=
l);
>  		hashcpy(ref->new_sha1, sha1);
>  	}
> =20
> -	free(query.src);
>  	return 0;
>  }

I didn't have time to review this fully, but I think you are missing
calls to string_list_clear(&matches) on a couple of code paths.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
