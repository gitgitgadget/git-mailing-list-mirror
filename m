From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] count-objects: report garbage files in pack
 directory too
Date: Wed, 13 Feb 2013 07:55:32 -0800
Message-ID: <7vehgkb43v.fsf@alter.siamese.dyndns.org>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
 <1360746799-3668-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 16:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5egi-0003Qx-3F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 16:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934292Ab3BMPzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 10:55:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934199Ab3BMPze convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2013 10:55:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CA6DB41E;
	Wed, 13 Feb 2013 10:55:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=welnUcJzdTut
	nYLzOCE4te5N2aQ=; b=okmFP6oh+Cf91bHzfLSNXBzPRda29yxt4+XQDwydnQDJ
	i/1OTo15fQxI/Egr/Gn/5+I6XT30a3aQFytgu32rwepaBvYDlfT87OuPF6/QJw67
	6++tK0i3CQQK/KvvGzPyUG4z5fKXaWnwI+tVZsLyM4VKnpBhTkiUJyjLvEerz6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FuRjqM
	N8ydwc9o1CmbXLxzn07NaP5uGkFkiNzYAsvttATQlDTRz9kqDQs0FsYb6jd69K3w
	Snb7zoHw7GVvc/tGxhTshVDDmNwG3pqgBfBbqpJKhAQrM1uLBBks+lmD4MOe/vY2
	LYPJ40Q76SE5Ebx+DPLtZK9dEiiRirJv39OdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61F16B41D;
	Wed, 13 Feb 2013 10:55:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 763E4B41B; Wed, 13 Feb 2013
 10:55:33 -0500 (EST)
In-Reply-To: <1360746799-3668-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13 Feb
 2013 16:13:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC9E94C4-75F5-11E2-AE72-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216263>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> prepare_packed_git_one() is modified to allow count-objects to hook a
> report function to so we don't need to duplicate the pack searching
> logic in count-objects.c. When report_pack_garbage is NULL, the
> overhead is insignificant.
>
> The garbage is reported with warning() instead of error() in packed
> garbage case because it's not an error to have garbage. Loose garbage
> is still reported as errors and will be converted to warnings later.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

Tests look good and the series is getting much closer.

> diff --git a/sha1_file.c b/sha1_file.c
> index 239bee7..5bedf78 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -21,6 +21,7 @@
>  #include "sha1-lookup.h"
>  #include "bulk-checkin.h"
>  #include "streaming.h"
> +#include "dir.h"
> =20
>  #ifndef O_NOATIME
>  #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
> @@ -1000,6 +1001,57 @@ void install_packed_git(struct packed_git *pac=
k)
>  	packed_git =3D pack;
>  }
> =20
> +void (*report_garbage)(const char *desc, const char *path);
> +
> +static void report_helper(const struct string_list *list,
> +			  int seen_bits, int first, int last)
> +{
> +	const char *msg;
> +	switch (seen_bits) {
> +	case 0: msg =3D "no corresponding .idx nor .pack"; break;
> +	case 1: msg =3D "no corresponding .idx"; break;
> +	case 2: msg =3D "no corresponding .pack"; break;

That's dense.

> +	default:
> +		return;
> +	}
> +	for (; first <=3D last; first++)

This looks odd.  If you use the usual last+1 convention between the
caller and callee, you do not have to do this, or call this function
with "i - 1" and "list->nr -1" as the last parameter.

> +static void report_pack_garbage(struct string_list *list)
> +{
> +	int i, baselen =3D -1, first =3D 0, seen_bits =3D 0;
> +
> +	if (!report_garbage)
> +		return;
> +
> +	sort_string_list(list);
> +
> +	for (i =3D 0; i < list->nr; i++) {
> +		const char *path =3D list->items[i].string;
> +		if (baselen !=3D -1 &&
> +		    strncmp(path, list->items[first].string, baselen)) {
> +			report_helper(list, seen_bits, first, i - 1);
> +			baselen =3D -1;
> +			seen_bits =3D 0;
> +		}
> +		if (baselen =3D=3D -1) {
> +			const char *dot =3D strrchr(path, '.');
> +			if (!dot) {
> +				report_garbage("garbage found", path);
> +				continue;
> +			}
> +			baselen =3D dot - path + 1;
> +			first =3D i;
> +		}
> +		if (!strcmp(path + baselen, "pack"))
> +			seen_bits |=3D 1;
> +		else if (!strcmp(path + baselen, "idx"))
> +			seen_bits |=3D 2;
> +	}
> +	report_helper(list, seen_bits, first, list->nr - 1);
> +}

> @@ -1009,6 +1061,7 @@ static void prepare_packed_git_one(char *objdir=
, int local)
>  	int len;
>  	DIR *dir;
>  	struct dirent *de;
> +	struct string_list garbage =3D STRING_LIST_INIT_DUP;
> =20
>  	sprintf(path, "%s/pack", objdir);
>  	len =3D strlen(path);
> ...
> @@ -1043,8 +1106,20 @@ static void prepare_packed_git_one(char *objdi=
r, int local)
>  			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
>  				install_packed_git(p);
>  		}
> +
> +		if (!report_garbage)
> +			continue;
> +
> +		if (has_extension(de->d_name, ".idx") ||
> +		    has_extension(de->d_name, ".pack") ||
> +		    has_extension(de->d_name, ".keep"))
> +			string_list_append(&garbage, path);

It might be OK to put .pack and .keep in the same "if (A || B)" as
it may happen to be that they do not need any special treatment
right now, but I do not think this is a good idea in general.

You would want to do things differently for ".idx", e.g.

diff --git a/sha1_file.c b/sha1_file.c
index 5bedf78..450521f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1076,6 +1076,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	while ((de =3D readdir(dir)) !=3D NULL) {
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
+		int is_a_bad_idx =3D 0;
=20
 		if (len + namelen + 1 > sizeof(path)) {
 			if (report_garbage) {
@@ -1105,12 +1106,14 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 			     */
 			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
 				install_packed_git(p);
+			else
+				is_a_bad_idx =3D 1;
 		}
=20
 		if (!report_garbage)
 			continue;
=20
-		if (has_extension(de->d_name, ".idx") ||
+		if ((has_extension(de->d_name, ".idx") && !is_a_bad_idx) ||
 		    has_extension(de->d_name, ".pack") ||
 		    has_extension(de->d_name, ".keep"))
 			string_list_append(&garbage, path);


so that you can say something about .pack/.keep files that do not
have a working .idx file.  In the above example, the only special
thing you would do for .idx is just to check if it is a bad one, but
in later patches you may have to do different things in the body
(i.e. something else in addition to string_list_append(&garbage))
not just in the condition.  Collapsing these into a condition to a
single "if (A||B||C)" may be suffering from a lack of foresight.

> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index d645328..e4bb3a1 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -195,4 +195,30 @@ test_expect_success 'gc: prune old objects after=
 local clone' '
>  	)
>  '
> =20
> +test_expect_success 'garbage report in count-objects -v' '
> +	: >.git/objects/pack/foo &&
> +	: >.git/objects/pack/foo.bar &&
> +	: >.git/objects/pack/foo.keep &&
> +	: >.git/objects/pack/foo.pack &&
> +	: >.git/objects/pack/fake.bar &&
> +	: >.git/objects/pack/fake.keep &&
> +	: >.git/objects/pack/fake.pack &&
> +	: >.git/objects/pack/fake.idx &&
> +	: >.git/objects/pack/fake2.keep &&
> +	: >.git/objects/pack/fake3.idx &&
> +	git count-objects -v 2>stderr &&
> +	grep "index file .git/objects/pack/fake.idx is too small" stderr &&

The above suggested change will make a difference to
fake.{pack,keep} because of this breakage, I think.

> +	grep "^warning:" stderr | sort >actual &&
> +	cat >expected <<\EOF &&
> +warning: garbage found: .git/objects/pack/fake.bar
> +warning: garbage found: .git/objects/pack/foo
> +warning: garbage found: .git/objects/pack/foo.bar
> +warning: no corresponding .idx nor .pack: .git/objects/pack/fake2.ke=
ep
> +warning: no corresponding .idx: .git/objects/pack/foo.keep
> +warning: no corresponding .idx: .git/objects/pack/foo.pack
> +warning: no corresponding .pack: .git/objects/pack/fake3.idx
> +EOF
> +	test_cmp expected actual
> +'
> +
>  test_done
