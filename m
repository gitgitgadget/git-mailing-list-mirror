From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH v9] git on Mac OS and precomposed unicode
Date: Thu, 26 Jul 2012 22:49:14 +0200
Message-ID: <5011AD4A.8060901@dewire.com>
References: <201207081550.25850.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:49:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuV0I-00062w-GU
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab2GZUtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jul 2012 16:49:16 -0400
Received: from mail.dewire.com ([83.140.172.130]:2859 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab2GZUtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 50EE38FC74;
	Thu, 26 Jul 2012 22:49:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WR-qCa+DlNZG; Thu, 26 Jul 2012 22:49:14 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id 154D48FC73;
	Thu, 26 Jul 2012 22:49:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:15.0) Gecko/20120717 Thunderbird/15.0
In-Reply-To: <201207081550.25850.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202309>

Just a couple of nitpicks.

Torsten B=C3=B6gershausen skrev 2012-07-08 15.50:
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
[...]
> +static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_=
c)
> +{
> +	const uint8_t *utf8p =3D (const uint8_t*) s;
> +	size_t strlen_chars =3D 0;
> +	size_t ret =3D 0;
> +
> +	if ((!utf8p) || (!*utf8p)) {
Style: Drop the extra parentheses
> +		return 0;
> +	}
> +
> +	while((*utf8p) && maxlen) {
Style: Drop the extra parentheses
[...]

> +void probe_utf8_pathname_composition(char *path, int len)
> +{
> +	const static char *auml_nfc =3D "\xc3\xa4";
> +	const static char *auml_nfd =3D "\x61\xcc\x88";
> +	int output_fd;
> +	if (precomposed_unicode !=3D -1)
> +		return; /* We found it defined in the global config, respect it */
> +	path[len] =3D 0;
Not needed, will be overwritten by strcpy

> +	strcpy(path + len, auml_nfc);
> +	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
> +	if (output_fd >=3D0) {
> +		close(output_fd);
> +		path[len] =3D 0;
Not needed, will be overwritten by strcpy

> +		strcpy(path + len, auml_nfd);
> +		/* Indicate to the user, that we can configure it to true */
> +		if (0 =3D=3D access(path, R_OK))
> +			git_config_set("core.precomposeunicode", "false");
> +			/* To be backward compatible, set precomposed_unicode to 0 */
> +		precomposed_unicode =3D 0;
> +		path[len] =3D 0;
Not needed, will be overwritten by strcpy

> +		strcpy(path + len, auml_nfc);
> +		unlink(path);
Err out if path cannot be deleted?

-- robin
