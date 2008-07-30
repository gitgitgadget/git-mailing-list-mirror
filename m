From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] builtin-help: always load_command_list() in cmd_help()
Date: Wed, 30 Jul 2008 15:50:46 -0700
Message-ID: <871A4541-3980-4C82-8A4A-CF9BE066946D@sb.org>
References: <1217457487-6509-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKWp-0001LA-D7
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYG3WvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYG3WvS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:51:18 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:36219 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbYG3WvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:51:17 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id DEB0D1250341;
	Wed, 30 Jul 2008 15:51:16 -0700 (PDT)
Received: from [192.168.1.80] (unknown [192.168.1.80])
	by mail.rapleaf.com (Postfix) with ESMTP id B223212500B6;
	Wed, 30 Jul 2008 15:51:16 -0700 (PDT)
In-Reply-To: <1217457487-6509-1-git-send-email-vmiklos@frugalware.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90868>

This patch works great for me.

Heck, after these help changes, git-help behaves even better in its  
error message.

 > git help merge-recursive
No manual entry for git-merge-recursive
 > git help sdfkjl
No manual entry for gitsdfkjl

It used to complain No manual entry for gitmerge-recursive.

Acked-by: Kevin Ballard <kevin@sb.org>

-Kevin Ballard

On Jul 30, 2008, at 3:38 PM, Miklos Vajna wrote:

> When cmd_help() is called, we always need the list of main and other
> commands, not just when the list of all commands is shown. Before this
> patch 'git help diff' invoked 'man gitdiff' because cmd_to_page()
> thought 'diff' is not a git command.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Wed, Jul 30, 2008 at 01:52:26PM -0700, Kevin Ballard  
> <kevin@sb.org> wrote:
>> `git help diff` no longer finds the git-diff manpage (as of tip of
>> next branch). I haven't tested, but I suspect
>> 940208a771066229bc6a486f6a058e332b71cfe4 is responsible.
>
> This fixed the issue for me.
>
> Thanks!
>
> help.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/help.c b/help.c
> index 88c0d5b..968f368 100644
> --- a/help.c
> +++ b/help.c
> @@ -690,6 +690,7 @@ int cmd_help(int argc, const char **argv, const  
> char *prefix)
> {
> 	int nongit;
> 	const char *alias;
> +	unsigned int longest = load_command_list("git-", &main_cmds,  
> &other_cmds);
>
> 	setup_git_directory_gently(&nongit);
> 	git_config(git_help_config, NULL);
> @@ -698,7 +699,6 @@ int cmd_help(int argc, const char **argv, const  
> char *prefix)
> 			builtin_help_usage, 0);
>
> 	if (show_all) {
> -		unsigned int longest = load_command_list("git-", &main_cmds,  
> &other_cmds);
> 		printf("usage: %s\n\n", git_usage_string);
> 		list_commands("git commands", longest, &main_cmds, &other_cmds);
> 		printf("%s\n", git_more_info_string);
> -- 
> 1.6.0.rc0.14.g95f8.dirty
>

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
