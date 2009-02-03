From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Tue, 3 Feb 2009 23:53:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 23:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUU9t-0005DT-8x
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZBCWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZBCWwz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:52:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:57396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751274AbZBCWwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 17:52:55 -0500
Received: (qmail invoked by alias); 03 Feb 2009 22:52:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 03 Feb 2009 23:52:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19X5+tJc3RXG5jXsY5sLAOEAm8PelQAECh3FLBp49
	GHAeLUlShnkhUZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108258>

Hi,

On Wed, 4 Feb 2009, Felipe Contreras wrote:

> The idea was originated by discussion about usability of manually
> editing the config file in 'special needs' systems such as Windows. Now
> the user can forget a bit about where the config files actually are.

Cute...

> diff --git a/builtin-config.c b/builtin-config.c
> index f710162..b0a86b1 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -3,7 +3,7 @@
>  #include "color.h"
>  
>  static const char git_config_set_usage[] =
> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
> +"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";

This line is getting way too long...  (Not nit-picking your current patch, 
but maybe you could provide another patch to break the line, while you're 
at builtin-config.c already.  Maybe even parseopt'ifying it... ;-)

> @@ -362,6 +362,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			return get_color(argc-2, argv+2);
>  		} else if (!strcmp(argv[1], "--get-colorbool")) {
>  			return get_colorbool(argc-2, argv+2);
> +		} else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
> +			char *config_filename;
> +			if (config_exclusive_filename)
> +				config_filename = xstrdup(config_exclusive_filename);
> +			else
> +				config_filename = git_pathdup("config");
> +			launch_editor(config_filename, NULL, NULL);
> +			free(config_filename);
> +			return 0;

Does launch_editor() not take a 'const char *' on purpose?  IOW you do not 
need to xstrdup() the filename.  You do not even need git_pathdup(), as 
launch_editor() does not use git_path() itself.

However, a test case would be nice...

Ciao,
Dscho
