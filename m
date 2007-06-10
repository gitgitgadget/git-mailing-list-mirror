From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 15:14:14 +0200
Message-ID: <200706101514.14954.johan@herland.net>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNFW-0006ut-Qk
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbXFJNOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 09:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757874AbXFJNOT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:14:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35402 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbXFJNOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:14:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF00K058RT1C00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:14:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF0053S8RR4X60@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:14:15 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF00DU48RRC010@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 15:14:15 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49726>

On Saturday 09 June 2007, Johannes Schindelin wrote:
> With the provided script, edit-commit-annotations, you can add
> after-the-fact annotations to commits, which will be shown by
> the log if the config variable core.showannotations is set.
> 
> The annotations are tracked in a new ref, refs/annotations/commits,
> in the same fan-out style as .git/objects/??/*, only that they only
> exist in the object database now.

Very interesting. I have to say that after having played around with
it a couple of minutes, I really like it. Needs some polishing here
and there (i.e. cleaning up the COMMIT_ANNOTATION.NNNN* files), but
it is a very good proof-of-concept.

> 	I have the hunch that this will be relatively fast and scalable,
> 	since the tree objects are sorted by name (the name being the
> 	object name of the to-be-annotated commit).

I think I agree with your hunch, although I initially thought that your
solution was a bit heavy on the number of objects created. But, hey, git
is _designed_ to handle massive amounts of objects. :)

> diff --git a/config.c b/config.c
> index 58d3ed5..34db9b2 100644
> --- a/config.c
> +++ b/config.c
> @@ -356,6 +356,11 @@ int git_default_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.showannotaions")) {
> +		show_commit_annotations = git_config_bool(var, value);
> +		return 0;
> +	}
> +

Small typo here. "core.showannotaions" should be "core.showannotations",
I guess.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
