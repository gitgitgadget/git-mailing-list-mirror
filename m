From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/8] archive: add tests for directory selection
Date: Wed, 08 Apr 2009 21:52:07 +0200
Message-ID: <49DD0067.1070002@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <1239185133-4181-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 21:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrdqH-0005Bi-Vp
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 21:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbZDHTwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 15:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765552AbZDHTwV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 15:52:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:59115 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765528AbZDHTwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 15:52:20 -0400
Received: from [10.0.1.101] (p57B7EF55.dip.t-dialin.net [87.183.239.85])
	by india601.server4you.de (Postfix) with ESMTPSA id C138C2F8043;
	Wed,  8 Apr 2009 21:52:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239185133-4181-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116117>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> While in archive.c, it says "pathspec". It's not really pathspec.
> Make a few tests to catch this point.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  archive.c               |   17 +++++++++++++++++
>  t/t0024-crlf-archive.sh |   30 +++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletions(-)
>=20
> diff --git a/archive.c b/archive.c
> index e87fed7..5b54d95 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -15,6 +15,8 @@ static char const * const archive_usage[] =3D {
> =20
>  #define USES_ZLIB_COMPRESSION 1
> =20
> +static int list_archive(struct archiver_args *args);
> +
>  static const struct archiver {
>  	const char *name;
>  	write_archive_fn_t write_archive;
> @@ -22,8 +24,23 @@ static const struct archiver {
>  } archivers[] =3D {
>  	{ "tar", write_tar_archive },
>  	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
> +	{ "dump-file-list", list_archive },
>  };
> =20
> +static int list_archive_entry(struct archiver_args *args,
> +		const unsigned char *sha1, const char *path, size_t pathlen,
> +		unsigned int mode, void *buffer, unsigned long size)
> +{
> +	printf("%s\n", path);
> +	return 0;
> +}

git archive dumps all its output, so I think "file-list" would be a
better name for an archiver creating lists of files.

However, if you only need it for tests (I can't imagine other uses at
the moment), you could do something like this instead:

	$ git archive -v HEAD >/dev/null 2>file-list

It might be wasteful since it creates a full archive (including file
contents) and throws it away, but it's OK for testing purposes.

Ren=C3=A9
