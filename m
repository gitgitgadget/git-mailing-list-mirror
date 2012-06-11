From: konglu@minatec.inpg.fr
Subject: Re: [PATCH v3] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 21:07:45 +0200
Message-ID: <20120611210745.Horde.72y3YnwdC4BP1kIBup3BWrA@webmail.minatec.grenoble-inp.fr>
References: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 21:08:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9xy-00040f-IC
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab2FKTHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 15:07:50 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:43793 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711Ab2FKTHu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 15:07:50 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 58CD01A02EF;
	Mon, 11 Jun 2012 21:07:46 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 11 Jun
 2012 21:07:45 +0200
In-Reply-To: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199705>


Javier.Roucher-Iglesias@ensimag.imag.fr a =C3=A9crit=C2=A0:

> +Git-credential permits to the user of the script to save:
> +username, password, host, path and protocol. When the user of script
> +invoke git-credential, the script can ask for a password, using the =
command
> +'git credential fill'.
> +Taking data from the standard input, the program treats each line as=
 a
> +separate data item, and the end of series of data item is signalled =
by a
> +blank line.
> +
> +		username=3Dadmin\n
> +		protocol=3D[http|https]\n
> +		host=3Dlocalhost\n
> +		path=3D/dir\n\n
> +
> +-If git-credential system has the password already stored
> +git-credential will answer with by STDOUT:
> +
> +		username=3Dadmin
> +		password=3D*****
> +
> +-If it is not stored, the user will be prompt for a password:
> +
> +		> Password for '[http|https]admin@localhost':

Whitespaces detected (and also some more after in the doc)

> diff --git a/builtin/credential.c b/builtin/credential.c
> new file mode 100644
> index 0000000..a6b6962
> --- /dev/null
> +++ b/builtin/credential.c
> @@ -0,0 +1,37 @@
> +#include <stdio.h>
> +#include "cache.h"
> +#include "credential.h"
> +#include "string-list.h"
> +
> +static const char usage_msg[] =3D
> +"credential <fill|approve|reject>";
> +
> +void cmd_credential (int argc, char **argv, const char *prefix) {
> +	const char *op;
> +	struct credential c =3D CREDENTIAL_INIT;
> +	int i;
> +
> +	op =3D argv[1];
> +	if (!op)
> +		usage(usage_msg);
> +
> +	if (credential_read(&c, stdin) < 0)
> +		die("unable to read credential from stdin");
> +
> +	if (!strcmp(op, "fill")) {
> +		credential_fill(&c);
> +		if (c.username)
> +			printf("username=3D%s\n", c.username);
> +		if (c.password)
> +			printf("password=3D%s\n", c.password);
> +	}
> +	else if (!strcmp(op, "approve")) {
> +		credential_approve(&c);
> +	}
> +	else if (!strcmp(op, "reject")) {
> +		credential_reject(&c);
> +	}
> +	else {
> +		usage(usage_msg);
> +	}
> +}

Structure:

	if (!strcmp(op, "fill")) {
		credential_fill(&c);
		if (c.username)
			printf("username=3D%s\n", c.username);
		if (c.password)
			printf("password=3D%s\n", c.password);
	} else if (!strcmp(op, "approve")) {
		credential_approve(&c);
	} else if (!strcmp(op, "reject")) {
		credential_reject(&c);
	} else {
		usage(usage_msg);
	}
