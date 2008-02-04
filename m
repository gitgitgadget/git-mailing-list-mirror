From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] git-commit: support variable number of hook
 arguments
Date: Mon, 4 Feb 2008 16:43:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041637460.7372@racer.site>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org> <2885c7896ba72adee6bc5c9e2210a8881904f601.1200933409.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4R0-0006V2-LV
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbYBDQoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbYBDQoH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:44:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:38855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753906AbYBDQoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:44:06 -0500
Received: (qmail invoked by alias); 04 Feb 2008 16:44:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 04 Feb 2008 17:44:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m6p9iDvHmSkcBy4rQWN+zomIzhOmLB+ezfD+59I
	2U8lucMJ/N+IHM
X-X-Sender: gene099@racer.site
In-Reply-To: <2885c7896ba72adee6bc5c9e2210a8881904f601.1200933409.git.bonzini@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72522>

Hi,

On Mon, 21 Jan 2008, Paolo Bonzini wrote:

> +static int run_hook(const char *index_file, const char *name, ...)
> +{
> +	struct child_process hook;
> +	const char *argv[10], *env[2];
> +	char index[PATH_MAX];
> +	va_list args;
> +	int i;
> +
> +	va_start(args, name);
> +	argv[0] = git_path("hooks/%s", name);
> +	i = 0;
> +	do {

Here, an

		if (++i >= ARRAY_SIZE(argv))
			die ("run_hook(): too many arguments");

is missing.  Even nicer, you could have

	int argc = 1;
	char **argv = malloc(sizeof(*argv) * 2);

and

		if (++i >= argc)
			argc = ALLOC_GROW(argv, i + 1, argc);

in the loop.  Of course, you would have to change the "++i" to "i" in this 
line:

> +		argv[++i] = va_arg(args, const char *);

Ciao,
Dscho
