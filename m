From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/4] Fix i18n -o option in msvc engine.pl
Date: Fri, 21 Nov 2014 10:41:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411211038570.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Wookey <michaelwookey@gmail.com>,
	Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrkjM-0002WR-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405AbaKUJln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 04:41:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:63462 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758391AbaKUJlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 04:41:40 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LztHH-1Y4O3f3HRz-0153b5;
 Fri, 21 Nov 2014 10:41:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1416526682-6024-2-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:6KLR3gWiyr+rIlJcceY0hDMK071hutTwddtit+x+CnTJveU+88q
 IlAe0oczgllVrBSP26kBCXZaD2m1iWTALYid69Y65RnXw7YwUNDdwfV42PGMcQdLME/4k8q
 JTfetB9kuQ+aZ6QZHIKmMHx6V9V0y2YCf4M6E/+/2G2tdZnYW98wlNH+nwImLyLPNkNZdWh
 JwKXoArzFovcBL4wyNHNA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 20 Nov 2014, Philip Oakley wrote:

>     The i18n 5e9637c6 introduced an extra '-o' option
>     into the make file,

I take it you are referring to

	https://github.com/git/git/commit/5e9637c6#diff-b67911656ef5d18c4ae36cb6741b7965R2195

> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index 23da787..9144ea7 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -140,6 +140,18 @@ sub parseMakeOutput
>              next;
>          }
>  
> +        if ($text =~ /^mkdir /) {
> +            # options to the Portable Object translations in the line
> +            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken for linker options

Maybe better

		# the line "mkdir ... && msgfmt ..." contains no linker options

> +            next;
> +        }
> +
> +        if ($text =~ /^msgfmt /) {
> +            # options to the Portable Object translations in the line
> +            # mkdir -p po/... && msgfmt ... (eg -o) may be mistaken for linker options
> +            next;
> +        }

These two if clauses do the same, maybe call it

	if ($test =~ /^(mkdir|msgfmt) /)

Ciao,
Johannes
