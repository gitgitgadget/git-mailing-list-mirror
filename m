From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in
 prepare_shell_cmd on Windows
Date: Tue, 17 Apr 2012 15:14:50 -0700
Message-ID: <20120417221449.GC10797@sigill.intra.peff.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <4F8D15B9.70803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, jrnieder@gmail.com,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:14:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGfp-0008VV-B6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab2DQWOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:14:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37399
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab2DQWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:14:53 -0400
Received: (qmail 9158 invoked by uid 107); 17 Apr 2012 22:15:02 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 18:15:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 15:14:50 -0700
Content-Disposition: inline
In-Reply-To: <4F8D15B9.70803@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195816>

On Tue, Apr 17, 2012 at 09:03:21AM +0200, Johannes Sixt wrote:

> diff --git a/run-command.c b/run-command.c
> index 2af3e0f..e4edede 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -94,7 +94,11 @@ static const char **prepare_shell_cmd(const char **argv)
>  		die("BUG: shell command is empty");
>  
>  	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
> +#ifndef WIN32
>  		nargv[nargc++] = SHELL_PATH;
> +#else
> +		nargv[nargc++] = "sh";
> +#endif
>  		nargv[nargc++] = "-c";
>  
>  		if (argc < 2)

It sounds like the real problem is not the use of a configurable shell,
but rather the use of an absolute path. Should you maybe try to pass the
basename of SHELL_PATH? Or maybe that is not even worth worrying about,
as somebody on Windows is not going to ever set SHELL_PATH, since it is
not like they are working around a non-POSIX "sh" included with the
operating system (which is why people on Solaris typically set
SHELL_PATH).

-Peff
