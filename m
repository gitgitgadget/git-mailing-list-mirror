From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 24/27] prune: strategies for linked checkouts
Date: Sat, 01 Mar 2014 18:12:59 +0100
Message-ID: <5312151B.6080605@web.de>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com> <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 18:13:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJnTJ-0007ke-4n
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 18:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbaCARNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 12:13:04 -0500
Received: from mout.web.de ([212.227.15.3]:60598 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbaCARND (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 12:13:03 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LuuC9-1XJuNp1rnt-0103pu; Sat, 01 Mar 2014 18:13:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393675983-3232-25-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:9+XQgjnOKtO9S1UIJ82oOsGggRqF1MUgR5RLaqqP7S3Zjx+7Fai
 jKa3+CSEQbjE0YR/SMfJNTl27smIAQogrnGNkeCQVxFtLYJLv2TvuvP3XEw3dVkNOfW3n1h
 QdZ5hD63oSaDM8nF4nzvzxV8ooSQPW5IpyKSVi+2jEIhCBIU8byJ+1ht0zF02RCrtsJ/CFf
 Bl30vMMM/eLk2oN3QOucQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243106>

On 2014-03-01 13.13, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[]
> =20
> +static dev_t get_device_or_die(const char *path)
> +{
> +	struct stat buf;
> +	if (stat(path, &buf))
> +		die_errno("failed to stat '%s'", path);
> +	/* Ah Windows! Make different drives different "partitions" */
> +	if (is_windows())
> +		buf.st_dev =3D toupper(real_path(path)[0]);
> +	return buf.st_dev;

Is this only related to Windows ?
Do we have other file systems, which return st_dev =3D=3D 0 ?
Should we check that path[0] !=3D '/', or better !is_dir_sep(path[0]) ?
Do we need has_dos_drive_prefix() ?

As a first suggestion, would this be better:

> +	if (!buf.st_dev)
> +		buf.st_dev =3D toupper(real_path(path)[0]);

(End of loose thinking)
