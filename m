From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/5] Add is_root_path()
Date: Fri, 12 Feb 2010 11:11:23 +0100
Message-ID: <4B75294B.8080205@kdbg.org>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com> <1265899403-15904-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 11:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfsUr-0005Ft-Op
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 11:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab0BLKLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 05:11:33 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59365 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752725Ab0BLKLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 05:11:31 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DC9EACDF91;
	Fri, 12 Feb 2010 11:11:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1265899403-15904-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139677>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> This function returns the length of the root part of a path, or zero =
if
> there is no root.

That is, the function primarily doesn't act as a predicate, and in fact=
=20
you never use it as such.

I just noticed that this function is identical to offset_1st_component(=
)=20
in sha1_file.c.

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -210,6 +210,17 @@ static inline const char *skip_prefix(const char=
 *str, const char *prefix)
>  	return strncmp(str, prefix, len) ? NULL : str + len;
>  }
> =20
> +/* path must be canonical */
> +static inline int is_root_path(const char *path)
> +{
> +	int len =3D 0;
> +	if (has_dos_drive_prefix(path))
> +		len +=3D 2;
> +	if (is_dir_sep(path[len]))
> +		len++;
> +	return len;
> +}
> +
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)

This is not a good location for this function because on Windows we get=
=20
warnings about implicitly defined function isalpha() (which is hidden i=
n=20
the macro has_dos_drive_prefix).

I suggest to move offset_1st_component() to path.c, which would not be=20
inlined anymore.

-- Hannes
