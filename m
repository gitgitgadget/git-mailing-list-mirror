From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sat, 10 Feb 2007 21:34:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu>
 <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
 <20070210181357.GE25607@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 10 21:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFyvk-0008Qb-CF
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 21:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbXBJUel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbXBJUel
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 15:34:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:39815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751850AbXBJUek (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 15:34:40 -0500
Received: (qmail invoked by alias); 10 Feb 2007 20:34:39 -0000
X-Provags-ID: V01U2FsdGVkX1/C7IgsCkvClDuV0/hJ5sJ0IV/jFu1PZyWGIFyklZ
	kNlg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070210181357.GE25607@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39257>

Hi,

On Sat, 10 Feb 2007, Theodore Tso wrote:

> diff --git a/git.c b/git.c
> index c43d4ff..fc08396 100644
> --- a/git.c
> +++ b/git.c
> @@ -159,6 +159,16 @@ static int handle_alias(int *argcp, const char ***argv)
>  	alias_command = (*argv)[0];
>  	git_config(git_alias_config);
>  	if (alias_string) {
> +		if (alias_string[0] == '!') {
> +			trace_printf("trace: alias to shell cmd: %s => %s\n",
> +				     alias_command, alias_string+1);

Here, you add 1 to alias string (though I would put spaces around the 
plus, but that's really a nit).

> +			ret = system(alias_string+1);
> +			if (ret >= 0 && WIFEXITED(ret) && 
> +			    WEXITSTATUS(ret) != 127)
> +				exit(WEXITSTATUS(ret));
> +			die("Failed to run '%s' when expanding alias '%s'\n", 
> +			    alias_string, alias_command);

So, shouldn't you here, too?

It made me feel a little uneasy that we can execute _any_ command now, but 
I can only find one way to exploit this, when an attacker does not have 
shell access anyway: git-shell.

Ciao,
Dscho
