From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: add --quiet option to suppress "rm 'file'" messages
Date: Mon, 26 Mar 2007 15:56:40 -0700
Message-ID: <7v8xdjvck7.fsf@assigned-by-dhcp.cox.net>
References: <11747590062554-git-send-email-tilman@code-monkey.de>
	<7vodmhc06f.fsf@assigned-by-dhcp.cox.net>
	<20070325210418.GA29221@code-monkey.de>
	<Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<1174904904.5662.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tilman Sauerbeck <tilman@code-monkey.de>, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVy7J-0006Ao-RE
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933648AbXCZW4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933699AbXCZW4m
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:56:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59128 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648AbXCZW4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:56:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326225642.IPVU1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 18:56:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fawg1W00B1kojtg0000000; Mon, 26 Mar 2007 18:56:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43199>

Eric Lesh <eclesh@ucla.edu> writes:

> Signed-off-by: Eric Lesh <eclesh@ucla.edu>
>
> ---
>
> On Sun, 2007-03-25 at 23:36 +0200, Johannes Schindelin wrote:
>> > Too bad, I find it rather annoying and irritating.
>> 
>> Why not do the common thing, and add a "--quiet" option? You can even add 
>> a config variable to enable it by default (for git-rm). It's not like 
>> git-rm is performance critical...
>
> Is something like this right?
>
>  builtin-rm.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-rm.c b/builtin-rm.c
> index 00dbe39..d193fb0 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> @@ -114,7 +114,7 @@ static struct lock_file lock_file;
>  int cmd_rm(int argc, const char **argv, const char *prefix)
>  {
>  	int i, newfd;
> -	int show_only = 0, force = 0, index_only = 0, recursive = 0;
> +	int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
>  	const char **pathspec;
>  	char *seen;
>  
> @@ -197,7 +199,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	 */
>  	for (i = 0; i < list.nr; i++) {
>  		const char *path = list.name[i];
> -		printf("rm '%s'\n", path);
> +		if (!quiet)
> +			printf("rm '%s'\n", path);
>  
>  		if (remove_file_from_cache(path))
>  			die("git-rm: unable to remove %s", path);

I wonder how this would interact with show_only...
