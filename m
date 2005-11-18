From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: current HEAD in bash prompt
Date: Fri, 18 Nov 2005 15:57:48 +0100
Message-ID: <81b0412b0511180657h6c5a66f8y4a41f3fa20a8b238@mail.gmail.com>
References: <9C44605A-4F0F-42FA-A8ED-A4F7EFA24C32@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3836_1753326.1132325868784"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 15:58:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed7gY-0001Dp-1M
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 15:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKRO5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 09:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVKRO5v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 09:57:51 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:38349 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbVKRO5u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 09:57:50 -0500
Received: by nproxy.gmail.com with SMTP id l37so460591nfc
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 06:57:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=a2izXgBm2xCRxO0Stzmy8eOPOIZQwJN45kF0mnu+Kohtc0D9LUKzQ2iYXLBJel8i1BFnLBNr7UBN8QsBl/npq9EtgDblOFMaFm+WMDPOrRJKfA6BmDzAHMvN6FZFgQQSOjYPuOiUuULIoPJRMo9OCl70xoutuyZclA4pyX0jhEQ=
Received: by 10.48.226.5 with SMTP id y5mr76395nfg;
        Fri, 18 Nov 2005 06:57:48 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Fri, 18 Nov 2005 06:57:48 -0800 (PST)
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <9C44605A-4F0F-42FA-A8ED-A4F7EFA24C32@hawaga.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12234>

------=_Part_3836_1753326.1132325868784
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/17/05, Ben Clifford <benc@hawaga.org.uk> wrote:
> After getting a bit confused when having too many branches, and for
> people who don't mind extra forks and like too much info in their
> prompt, I've recently started using this:
>
> export PS1=3D'!\! [\j] \u@\h:\w$(output-git-head-or-blank)\$ '
>

I did almost the same, but in .c (attached).

------=_Part_3836_1753326.1132325868784
Content-Type: application/octet-stream; name=current-branch.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="current-branch.c"

#include "cache.h"

static const char * basename(const char *p)
{
	const char *f = strrchr(p, '/');
	return f ? ++f: p;
}

int main(int argc, const char **argv)
{
	argv0 = *argv;
	setup_git_directory();

	if ( argc < 2 ) {
		static const char *def[] = { NULL, "HEAD", NULL };
		argv = def;
	}

	while ( *++argv ) {
		unsigned char sha1[20];
		char *ref = strdup(git_path("%s", *argv));
		const char *deref = resolve_ref(ref, sha1, 0);
		puts(deref ? basename(deref): *argv);
		free(ref);
	}
	return 0;
}

------=_Part_3836_1753326.1132325868784--
