From: "Scott R Parish" <srp@srparish.net>
Subject: Re: [PATCH] Deduce exec_path also from calls to git with a 
     relative path
Date: Sat, 20 Oct 2007 03:13:26 -0500 (CDT)
Message-ID: <1192868006.v2.fusewebmail-240137@f>
Reply-To: srp@srparish.net
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 20 10:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij9Sn-0001lu-FU
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 10:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbXJTINa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 04:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbXJTIN2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 04:13:28 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:51010 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbXJTIN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 04:13:27 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtpa (MailAnyone extSMTP srp)
	id 1Ij9SY-0002xD-E1; Sat, 20 Oct 2007 03:13:26 -0500
Received: from 127.0.0.1
        (FuseMail web AccountID 240137)
        by webmail.fusemail.com with HTTP;
        Sat, 20 Oct 2007 03:13:26 -0500 (CDT)
User-Agent: FuseMail W
X-Priority: 3
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61811>


Wow, that sure cleaned up nicely! :)

Thanks
sRp


----- Original Message -----
Subject: [PATCH] Deduce exec_path also from calls to git with a relative path
Date: Sat, October 20, 2007 0:21
From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>

> There is already logic in the git wrapper to deduce the exec_path from
> argv[0], when the git wrapper was called with an absolute path.  Extend
> that logic to handle relative paths as well.
>
> For example, when you call "../../hello/world/git", it will not turn
> "../../hello/world" into an absolute path, and use that.
>
> Initial implementation by Scott R Parish.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>         On Fri, 19 Oct 2007, Scott R Parish wrote:
>
>         >  Signed-off-by: Scott R Parish <srp@srparish.net>
>
>         That is a little short for a commit message ;-)
>
>         >  git.c |   35 +++++++++++++++++++++++++++++++++--
>         >  1 files changed, 33 insertions(+), 2 deletions(-)
>
>         I had commented on this before.  Probably I did a very bad job
>         at explaining things, so hopefully this is better:
>
>  git.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index d7c6bca..1dad764 100644
> --- a/git.c
> +++ b/git.c
> @@ -414,13 +414,14 @@ int main(int argc, const char **argv)
>          /*
>           * Take the basename of argv[0] as the command
>           * name, and the dirname as the default exec_path
> -         * if it's an absolute path and we don't have
> -         * anything better.
> +         * if we don't have anything better.
>           */
>          if (slash) {
>                  *slash++ = 0;
>                  if (*cmd == '/')
>                          exec_path = cmd;
> +                else
> +                        exec_path = xstrdup(make_absolute_path(cmd));
>                  cmd = slash;
>          }
>
> --
> 1.5.3.4.1287.g8b31e
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
