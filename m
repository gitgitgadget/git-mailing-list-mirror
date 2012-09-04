From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Tue, 04 Sep 2012 14:03:02 -0700
Message-ID: <7vehmh8prt.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx>
 <5026D081.2040906@tu-clausthal.de>
 <20120830222603.GA20289@sigill.intra.peff.net>
 <5046634A.4020608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:03:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T90HE-0004aN-EB
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688Ab2IDVDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 17:03:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757610Ab2IDVDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 17:03:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 377719F8A;
	Tue,  4 Sep 2012 17:03:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l7/3pFy0U4Am
	fVkaQdQSvQI6koY=; b=ZG148KXsNCxHcI4RzwvmltF2JxFhbXeopRTw+IfzDVwc
	mTHda+zEu7/vZ8ftriKx78rjMktiE0Qv1N9O+Qu/qlKduHJ/2uTcRZkFv5ardCwr
	kpCE19vRANATPzbDlQxLaTczNRi5/bPAtt5sy0HDP3nFzSR9p2RJPbFZjV3ma5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oVMRLb
	fqdYO7K3nQk44Ff1wbz0csQYl6qMyvlMrs33idtb4ABxcFScCNIaUq9UdMMAAhGf
	+Ryrp5JwlmojiTOBsfv/ggEcCVpe3KMbtApF/18EGFYL64KSPdDFXuDaUgRQoxGR
	TgEXHMpkkDTvY9j630BV1YUgtXg+LT3yGn+ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E6E9F89;
	Tue,  4 Sep 2012 17:03:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ACEB9F86; Tue,  4 Sep 2012
 17:03:04 -0400 (EDT)
In-Reply-To: <5046634A.4020608@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 04 Sep 2012 22:23:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB49403C-F6D3-11E1-BA62-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204786>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> But now for the patch, which is a bit confusing as well.  I'm curious=
 to
> hear about results for more platforms, extractors and character class=
es.
> Based on that we can see if we need to generate the extra fields inst=
ead
> of relying on the new flag.

Thanks for keeping the ball rolling.

> Subject: [PATCH] archive-zip: support UTF-8 paths
>
> Set general purpose flag 11 if we encounter a path that contains
> non-ASCII characters.  We assume that all paths are given as UTF-8; n=
o
> conversion is done.
>
> The flag seems to be ignored by unzip unless we also mark the archive
> entry as coming from a Unix system.  This is done by setting the fiel=
d
> creator_version ("version made by" in the standard[1]) to 0x03NN.
>
> The NN part represents the version of the standard supported by us, a=
nd
> this patch sets it to 3f (for version 6.3) for Unix paths.  We keep
> creator_version set to 0 (FAT filesystem, standard version 0) in the
> non-special cases, as before.
>
> But when we declare a file to have a Unix path, then we have to set t=
he
> file mode as well, or unzip will extract the files with the permissio=
n
> set 0000, i.e. inaccessible by all.
>
> [1] http://www.pkware.com/documents/casestudies/APPNOTE.TXT
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  archive-zip.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index f5af81f..928da1d 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -4,6 +4,8 @@
>  #include "cache.h"
>  #include "archive.h"
>  #include "streaming.h"
> +#include "commit.h"
> +#include "utf8.h"
> =20
>  static int zip_date;
>  static int zip_time;
> @@ -16,7 +18,8 @@ static unsigned int zip_dir_offset;
>  static unsigned int zip_dir_entries;
> =20
>  #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
> -#define ZIP_STREAM (8)
> +#define ZIP_STREAM	(1 <<  3)
> +#define ZIP_UTF8	(1 << 11)
> =20
>  struct zip_local_header {
>  	unsigned char magic[4];
> @@ -173,7 +176,8 @@ static int write_zip_entry(struct archiver_args *=
args,
>  {
>  	struct zip_local_header header;
>  	struct zip_dir_header dirent;
> -	unsigned long attr2;
> +	unsigned int creator_version =3D 0;
> +	unsigned long attr2 =3D 0;
>  	unsigned long compressed_size;
>  	unsigned long crc;
>  	unsigned long direntsize;
> @@ -187,6 +191,13 @@ static int write_zip_entry(struct archiver_args =
*args,
> =20
>  	crc =3D crc32(0, NULL, 0);
> =20
> +	if (has_non_ascii(path)) {

Do we want to treat \033 as "ascii" in this codepath?  The function
primarily is used by the log formatter to see if we need 8-bit CTE
when writing out in the e-mail format.

> +		if (is_utf8(path))
> +			flags |=3D ZIP_UTF8;
> +		else
> +			warning("Path is not valid UTF-8: %s", path);
> +	}
> +
>  	if (pathlen > 0xffff) {
>  		return error("path too long (%d chars, SHA1: %s): %s",
>  				(int)pathlen, sha1_to_hex(sha1), path);
> @@ -204,10 +215,15 @@ static int write_zip_entry(struct archiver_args=
 *args,
>  		enum object_type type =3D sha1_object_info(sha1, &size);
> =20
>  		method =3D 0;
> -		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
> -			(mode & 0111) ? ((mode) << 16) : 0;
>  		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
>  			method =3D 8;
> +		if (S_ISLNK(mode) || (mode & 0111) || (flags & ZIP_UTF8)) {
> +			creator_version =3D 0x033f;
> +			attr2 =3D mode;
> +			if (S_ISLNK(mode))
> +				attr2 |=3D 0777;
> +			attr2 <<=3D 16;
> +		}
>  		compressed_size =3D size;
> =20
>  		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
> @@ -254,8 +270,7 @@ static int write_zip_entry(struct archiver_args *=
args,
>  	}
> =20
>  	copy_le32(dirent.magic, 0x02014b50);
> -	copy_le16(dirent.creator_version,
> -		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
> +	copy_le16(dirent.creator_version, creator_version);
>  	copy_le16(dirent.version, 10);
>  	copy_le16(dirent.flags, flags);
>  	copy_le16(dirent.compression_method, method);
