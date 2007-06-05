From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Show html help with git-help --html
Date: Tue, 05 Jun 2007 13:40:05 -0700
Message-ID: <7vzm3e9lui.fsf@assigned-by-dhcp.cox.net>
References: <20070605183420.GA8450@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvfp3-0002VR-Iq
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765479AbXFEUkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765520AbXFEUkH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:40:07 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47126 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765479AbXFEUkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 16:40:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605204006.UMH1540.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 5 Jun 2007 16:40:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7wg51X00G1kojtg0000000; Tue, 05 Jun 2007 16:40:05 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49227>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This patch was inspired by ClearCase command 'ct man',...

> diff --git a/help.c b/help.c
> index 6a9af4d..78b1023 100644
> --- a/help.c
> +++ b/help.c
> @@ -9,6 +9,14 @@
>  #include "common-cmds.h"
>  #include <sys/ioctl.h>
>  
> +#ifndef HTML_DIR
> +#define HTML_DIR "/usr/share/html/"
> +#endif
> +
> +#ifndef HTML_PROGRAM
> +#define HTML_PROGRAM "xdg-open"
> +#endif
> +
>  /* most GUI terminals set COLUMNS (although some don't export it) */
>  static int term_columns(void)
>  {
> @@ -183,6 +191,145 @@ static void show_man_page(const char *git_cmd)
>  	execlp("man", "man", page, NULL);
>  }
>  
> +static void show_html_page(const char *git_cmd)
> +{
> +	const char *html_dir;
> +	int len, ret, nr_quotes;
> +	char *p, *p2;
> +	const char *cp, *cp2;
> +	struct stat st;
> +	char *quoted_git_cmd;
> +	char *default_command = NULL;
> +	const char *command;
>...
> +	/* append %p if there is not any %x */
> +	if (!strchr(command, '%')) {
> +		len = strlen(command);
> +		default_command = xmalloc(len + 3 + 1); /* space %p */
> +		strcpy(default_command, command);
> +		strcat(default_command, " %p");
> +		command = default_command;
> +	}
> +
> +	/* first pass, calculate command length */
> ...

Hmmm.  Makes one wonder why interpolate is not used....
