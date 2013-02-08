From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] count-objects: report garbage files in pack
 directory too
Date: Fri, 08 Feb 2013 10:44:43 -0800
Message-ID: <7vwqui1w84.fsf@alter.siamese.dyndns.org>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3sx0-0005fv-8y
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946834Ab3BHSos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2013 13:44:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946798Ab3BHSoq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 13:44:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9032ECE91;
	Fri,  8 Feb 2013 13:44:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9/na9IqsT8Eo
	+cRElynKUahDH5A=; b=J3Xaw3W6XN9pvRPePte7Cg8udAMwRypQHUWWxkeHlWqR
	mN0g0cvXRp28BNBsXtIjnwdoy7f2rkiCKoxG1neuZ9o9IqRE8hT+M4aRR/svI3tJ
	t5b0AVEa3TmfiKRGJSgg+MXMRnDMwvV0i1KTZuyEMGAlNGg0kmjEvxJb/7AqfDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u5wbKc
	oPuBueZGN8C01Jc08+4BGQuuDSQbQzomcnaSlyCvI7Fugy1gEVIiGiHeNuCWyN0E
	1y3lnhs0zc3bcgHTZ5sSzqFq0xSjfDj4ZKSbtpl75f7rwad7pHQCdEDAFWRtqukx
	syC+wOErmb14OEhsEL8juj43lE10jDI+m2RK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B04CE90;
	Fri,  8 Feb 2013 13:44:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B40C1CE8F; Fri,  8 Feb 2013
 13:44:44 -0500 (EST)
In-Reply-To: <1360295307-5469-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Feb
 2013 10:48:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B2C1094-721F-11E2-A782-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215801>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> prepare_packed_git_one() is modified to allow count-objects to hook a
> report function to so we don't need to duplicate the pack searching
> logic in count-objects.c. When report_pack_garbage is NULL, the
> overhead is insignificant.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-count-objects.txt |  4 +-
>  builtin/count-objects.c             | 18 ++++++++-
>  sha1_file.c                         | 81 +++++++++++++++++++++++++++=
++++++++--
>  3 files changed, 97 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-=
count-objects.txt
> index e816823..1611d7c 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> @@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB
>  prune-packable: the number of loose objects that are also present in
>  the packs. These objects could be pruned using `git prune-packed`.
>  +
> -garbage: the number of files in loose object database that are not
> -valid loose objects
> +garbage: the number of files in object database that are not valid
> +loose objects nor valid packs
> =20
>  GIT
>  ---
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 9afaa88..118b2ae 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -9,6 +9,20 @@
>  #include "builtin.h"
>  #include "parse-options.h"
> =20
> +static unsigned long garbage;
> +
> +extern void (*report_pack_garbage)(const char *path, int len, const =
char *name);
> +static void real_report_pack_garbage(const char *path, int len, cons=
t char *name)
> +{

Don't some callers call this on paths outside objects/pack/
directory?  Is it still report-pack-garbage?

> +	if (len && name)
> +		error("garbage found: %.*s/%s", len, path, name);
> +	else if (!len && name)
> +		error("garbage found: %s%s", path, name);
> +	else
> +		error("garbage found: %s", path);
> +	garbage++;
> +}
> +
>  static void count_objects(DIR *d, char *path, int len, int verbose,
>  			  unsigned long *loose,
>  			  off_t *loose_size,
> @@ -76,7 +90,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
>  	const char *objdir =3D get_object_directory();
>  	int len =3D strlen(objdir);
>  	char *path =3D xmalloc(len + 50);
> -	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0, garbag=
e =3D 0;
> +	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0;
>  	off_t loose_size =3D 0;
>  	struct option opts[] =3D {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -87,6 +101,8 @@ int cmd_count_objects(int argc, const char **argv,=
 const char *prefix)
>  	/* we do not take arguments other than flags for now */
>  	if (argc)
>  		usage_with_options(count_objects_usage, opts);
> +	if (verbose)
> +		report_pack_garbage =3D real_report_pack_garbage;
>  	memcpy(path, objdir, len);
>  	if (len && objdir[len-1] !=3D '/')
>  		path[len++] =3D '/';
> diff --git a/sha1_file.c b/sha1_file.c
> index 40b2329..cc6ef03 100644
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
> @@ -1000,6 +1001,54 @@ void install_packed_git(struct packed_git *pac=
k)
>  	packed_git =3D pack;
>  }
> =20
> +/* A hook for count-objects to report invalid files in pack director=
y */
> +void (*report_pack_garbage)(const char *path, int len, const char *n=
ame);
> +
> +static const char *known_pack_extensions[] =3D { ".pack", ".keep", N=
ULL };

This sounds wrong.  Isn't ".idx" also known?

> +static void report_garbage(struct string_list *list)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct packed_git *p;
> +	int i;
> +
> +	if (!report_pack_garbage)
> +		return;
> +
> +	sort_string_list(list);
> +
> +	for (p =3D packed_git; p; p =3D p->next) {
> +		struct string_list_item *item;
> +		if (!p->pack_local)
> +			continue;
> +		strbuf_reset(&sb);
> +		strbuf_add(&sb, p->pack_name,
> +			   strlen(p->pack_name) - strlen(".pack"));
> +		item =3D string_list_lookup(list, sb.buf);
> +		if (!item)
> +			continue;
> +		/*
> +		 * string_list_lookup does not guarantee to return the
> +		 * first matched string if it's duplicated.
> +		 */
> +		while (item - list->items &&
> +		       !strcmp(item[-1].string, item->string))
> +			item--;
> +		while (item - list->items < list->nr &&
> +		       !strcmp(item->string, sb.buf)) {
> +			item->util =3D NULL; /* non-garbage mark */
> +			item++;
> +		}
> +	}
> +	for (i =3D 0; i < list->nr; i++) {
> +		struct string_list_item *item =3D list->items + i;
> +		if (!item->util)
> +			continue;
> +		report_pack_garbage(item->string, 0, item->util);
> +	}
> +	strbuf_release(&sb);
> +}
> +
>  static void prepare_packed_git_one(char *objdir, int local)
>  {
>  	/* Ensure that this buffer is large enough so that we can
> @@ -1009,6 +1058,7 @@ static void prepare_packed_git_one(char *objdir=
, int local)
>  	int len;
>  	DIR *dir;
>  	struct dirent *de;
> +	struct string_list garbage =3D STRING_LIST_INIT_DUP;
> =20
>  	sprintf(path, "%s/pack", objdir);
>  	len =3D strlen(path);
> @@ -1024,14 +1074,37 @@ static void prepare_packed_git_one(char *objd=
ir, int local)
>  		int namelen =3D strlen(de->d_name);
>  		struct packed_git *p;
> =20
> -		if (!has_extension(de->d_name, ".idx"))
> +		if (len + namelen + 1 > sizeof(path)) {
> +			if (report_pack_garbage)
> +				report_pack_garbage(path, len - 1, de->d_name);

A pack/in/a/very/long/path/pack-000000000000000000000000000000000000000=
0.pack
may pass when fed to "git verify-pack", but this will report it as "gar=
bage",
without reporting what is wrong with it.  Wouldn't that confuse users?

>  			continue;
> +		}
> +
> +		strcpy(path + len, de->d_name);
> =20
> -		if (len + namelen + 1 > sizeof(path))
> +		if (!has_extension(de->d_name, ".idx")) {
> +			struct string_list_item *item;
> +			int i, n;
> +			if (!report_pack_garbage)
> +				continue;
> +			if (is_dot_or_dotdot(de->d_name))
> +				continue;
> +			for (i =3D 0; known_pack_extensions[i]; i++)
> +				if (has_extension(de->d_name,
> +						  known_pack_extensions[i]))
> +					break;
> +			if (!known_pack_extensions[i]) {
> +				report_pack_garbage(path, 0, NULL);
> +				continue;
> +			}
> +			n =3D strlen(path) - strlen(known_pack_extensions[i]);
> +			item =3D string_list_append_nodup(&garbage,
> +							xstrndup(path, n));
> +			item->util =3D (void*)known_pack_extensions[i];
>  			continue;
> +		}

Why isn't this part more like this?

		if (dot-or-dotdot) {
			continue;
		} else if (has_extension(de->d_name, ".idx")) {
			do things for the .idx file;
		} else if (has_extension(de->d_name, ".pack") {
			do things for the .pack file, including
                        queuing the name if we haven't seen
			corresponding .idx for later examination;
		} else if (has_extension(de->d_name, ".keep") {
                	nothing special for now but we may
                        want to add some other checks later
		} else {
                	everything else is a garbage
                        report_pack_garbage();
		}
                       =20

> =20
>  		/* Don't reopen a pack we already have. */
> -		strcpy(path + len, de->d_name);
>  		for (p =3D packed_git; p; p =3D p->next) {
>  			if (!memcmp(path, p->pack_name, len + namelen - 4))
>  				break;
> @@ -1047,6 +1120,8 @@ static void prepare_packed_git_one(char *objdir=
, int local)
>  		install_packed_git(p);
>  	}
>  	closedir(dir);
> +	report_garbage(&garbage);
> +	string_list_clear(&garbage, 0);
>  }
> =20
>  static int sort_pack(const void *a_, const void *b_)
