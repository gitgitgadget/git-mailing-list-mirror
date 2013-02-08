From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] count-objects: report how much disk space taken
 by garbage files
Date: Fri, 08 Feb 2013 10:47:31 -0800
Message-ID: <7vsj561w3g.fsf@alter.siamese.dyndns.org>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3szN-0007nj-QM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946796Ab3BHSre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 13:47:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760179Ab3BHSre convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 13:47:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA90CFAB;
	Fri,  8 Feb 2013 13:47:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kzHfTJDaAEFE
	c/4gUYMUYSh8idM=; b=hhZjedQyDtu8vfbw3msaKm1g6XbwHpcUMyL2h9I1zQP7
	6C4C4BqOYzDzQiffwkpxZDHKtDfLUFFH5jrD3UocJm4MbuEl3bEp1JLqgvl2YJcL
	yoqE68hGBohCYBX0ztdTOc60MBE+6/bzblZmnvIlSMqLOCO0EIKdKtUN03/b3xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cmLHST
	tlRyNnHOYUoi0fit75m6mc1XEZfQbE4E4bs3111knw6KCfFHC4K4d0Ft2aED5bvm
	tutgCd4/agQBx2CHoZjzTFTNBODxuzMLAdIEddky5kFwcfQOj1/q6GRI+QA+e40y
	X5Mu8sxfDW8wNVLODlFaAvY2ppnYtccqkhkxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F102CFAA;
	Fri,  8 Feb 2013 13:47:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1252CFA9; Fri,  8 Feb 2013
 13:47:32 -0500 (EST)
In-Reply-To: <1360295307-5469-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Feb
 2013 10:48:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF572D42-721F-11E2-B6F7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215802>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  We may do some redundant stat() here, but I don't think it can slow
>  count-objects down much to worry about.

I don't either.  Looks like a good change to me.

It appears that the sb.buf refactoring is better done to the
previous patch, but that is minor.

>  Documentation/git-count-objects.txt |  2 ++
>  builtin/count-objects.c             | 29 ++++++++++++++++++---------=
--
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-=
count-objects.txt
> index 1611d7c..da6e72e 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> @@ -35,6 +35,8 @@ the packs. These objects could be pruned using `git=
 prune-packed`.
>  +
>  garbage: the number of files in object database that are not valid
>  loose objects nor valid packs
> ++
> +size-garbage: disk space consumed by garbage files, in KiB
> =20
>  GIT
>  ---
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 118b2ae..90d476d 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -10,24 +10,33 @@
>  #include "parse-options.h"
> =20
>  static unsigned long garbage;
> +static off_t size_garbage;
> =20
>  extern void (*report_pack_garbage)(const char *path, int len, const =
char *name);
>  static void real_report_pack_garbage(const char *path, int len, cons=
t char *name)
>  {
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct stat st;
> +
>  	if (len && name)
> -		error("garbage found: %.*s/%s", len, path, name);
> +		strbuf_addf(&sb, "%.*s/%s", len, path, name);
>  	else if (!len && name)
> -		error("garbage found: %s%s", path, name);
> +		strbuf_addf(&sb, "%s%s", path, name);
>  	else
> -		error("garbage found: %s", path);
> +		strbuf_addf(&sb, "%s", path);
> +	error(_("garbage found: %s"), sb.buf);
> +
> +	if (!stat(sb.buf, &st))
> +		size_garbage +=3D st.st_size;
> +
>  	garbage++;
> +	strbuf_release(&sb);
>  }
> =20
>  static void count_objects(DIR *d, char *path, int len, int verbose,
>  			  unsigned long *loose,
>  			  off_t *loose_size,
> -			  unsigned long *packed_loose,
> -			  unsigned long *garbage)
> +			  unsigned long *packed_loose)
>  {
>  	struct dirent *ent;
>  	while ((ent =3D readdir(d)) !=3D NULL) {
> @@ -59,11 +68,8 @@ static void count_objects(DIR *d, char *path, int =
len, int verbose,
>  				(*loose_size) +=3D xsize_t(on_disk_bytes(st));
>  		}
>  		if (bad) {
> -			if (verbose) {
> -				error("garbage found: %.*s/%s",
> -				      len + 2, path, ent->d_name);
> -				(*garbage)++;
> -			}
> +			if (verbose)
> +				report_pack_garbage(path, len + 2, ent->d_name);
>  			continue;
>  		}
>  		(*loose)++;
> @@ -113,7 +119,7 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
>  		if (!d)
>  			continue;
>  		count_objects(d, path, len, verbose,
> -			      &loose, &loose_size, &packed_loose, &garbage);
> +			      &loose, &loose_size, &packed_loose);
>  		closedir(d);
>  	}
>  	if (verbose) {
> @@ -138,6 +144,7 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
>  		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
>  		printf("prune-packable: %lu\n", packed_loose);
>  		printf("garbage: %lu\n", garbage);
> +		printf("size-garbage: %lu\n", (unsigned long) (size_garbage / 1024=
));
>  	}
>  	else
>  		printf("%lu objects, %lu kilobytes\n",
