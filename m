From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Summary of core GIT while you are away.
Date: Fri, 27 May 2005 01:59:44 +0200
Message-ID: <20050526235944.GB6215@vrfy.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org> <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org> <20050526202712.GA6024@vrfy.org> <7vy8a18w1e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 01:59:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbSFG-0001lW-Rh
	for gcvg-git@gmane.org; Fri, 27 May 2005 01:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVE0AAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVE0AAU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:00:20 -0400
Received: from soundwarez.org ([217.160.171.123]:32463 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261857AbVEZX7s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 19:59:48 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 8898C3A3C4; Fri, 27 May 2005 01:59:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8a18w1e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2005 at 03:25:17PM -0700, Junio C Hamano wrote:
> >>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:
> 
> KS> Nice, thanks. Here is a very first try. It searches the commit messages
> KS> and uses pickaxe to search in the file content:
> KS>   http://ehlo.org/~kay/gitweb.cgi?p=git/git.git;a=search;s=symlink
> 
> Nice, thanks for using pickaxe ;-).  One request, knowing well
> that what you have on ehlo is your first cut.

Yeah, I like it a lot. Nice work.

Any idea, what's the reason, it doesn't find anything here in the
kernel tree:
  git-rev-list HEAD | git-diff-tree -S'TIMEOUT' --stdin

while:
  git-rev-list --header HEAD | grep -z TIMEOUT

prints the commit:
  6897089c5f7989603ccb9c696050470ba1dbd262

with the following change:
  git-diff-tree -p 6897089c5f7989603ccb9c696050470ba1dbd262 6f31e42221c7deae4527136ce0dd73990d8bc1d1
  diff --git a/drivers/base/firmware_class.c
  b/drivers/base/firmware_class.c
  --- a/drivers/base/firmware_class.c
  +++ b/drivers/base/firmware_class.c
  @@ -102,9 +102,6 @@ firmware_class_hotplug(struct class_devi
          if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
                          "FIRMWARE=%s", fw_priv->fw_id))
                  return -ENOMEM;
  -       if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
          &len,
  -                       "TIMEOUT=%i", loading_timeout))
  -               return -ENOMEM;
   
          envp[i] = NULL;

> The pickaxe really shines when you can paste a couple of lines
> of code in the version you are having trouble with (or just you
> are curious about) in order to see where they came from.  For
> example, I did an equivalent of the following command back to
> figure out which patch and author to give credit to when I stole
> the tagged output format for git-ls-files from Cogito branch:
> 
> git-rev-list pasky |
> git-diff-tree -v -p --stdin \
> -S'static const char *tag_cached = "";
> static const char *tag_unmerged = "";
> static const char *tag_removed = "";'

Nice feature, maybe we can add it later (see next).

> Since this is primarily about program code, forbidding '*' is
> rather nasty, and not being able to do multiple lines makes it
> quite less useful than it could be.

I see what you mean, but allow to pass any charater through a cgi to a
invoked shell as a command-line option is a nightmare without being very
carful. That's why only a few character allowed now. I'm not sure how
to do that without creating possibly a big hole in the webserver. :)

Kay
