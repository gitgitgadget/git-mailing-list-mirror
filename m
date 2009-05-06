From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed, 06 May 2009 10:18:48 -0700
Message-ID: <7vab5qw3nr.fsf@alter.siamese.dyndns.org>
References: <1241620621-12188-1-git-send-email-julien@danjou.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julien Danjou <julien@danjou.info>
X-From: git-owner@vger.kernel.org Wed May 06 19:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1klo-0001no-Fl
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 19:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZEFRSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbZEFRSt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 13:18:49 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52255 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbZEFRSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 13:18:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506171850.CLDI17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 May 2009 13:18:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oHJp1b00B4aMwMQ03HJpLa; Wed, 06 May 2009 13:18:49 -0400
X-Authority-Analysis: v=1.0 c=1 a=VMD5vf70d0kA:10 a=94lC-IFnZjQA:10
 a=_7OBRpZqAAAA:8 a=s23sK-26jK6ri8Tp5C8A:9 a=bEDmetK6HPPko0Vc9I4PMUu5VCgA:4
 a=YVTi7Y1ngP4A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118357>

Julien Danjou <julien@danjou.info> writes:

> We consider that if `git remote prune` is called without a name, we
> actually want to prune all remotes.

I think we try to make an opearation that discards information from many
things at once by mistake, and it feels that this patch goes against it.

In what situation does this new short-cut make things convenient, and how
often does such a situation come up?  The only one I can think of is when
you are interacting with many volatile remotes that create and delete
branches all the time, and when you are trying to repack/pack-ref your
local repository with as much cruft removed, but in such a set-up, next
time you interact with your remotes, you will get their "branch of the
day" in your remote tracking namespace that will disappear shortly, and it
does not sound like it is such a big deal if you did not run "remote
prune" to all of them at once anyway.

Having said all that...

> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 9e2b4ea..c566061 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -15,7 +15,7 @@ SYNOPSIS
>  'git remote rm' <name>
>  'git remote set-head' <name> [-a | -d | <branch>]
>  'git remote show' [-n] <name>
> -'git remote prune' [-n | --dry-run] <name>
> +'git remote prune' [-n | --dry-run] [name]
>  'git remote update' [-p | --prune] [group | remote]...

I think you would want to say [<name>] here, but looking at this list, I
wonder if it would be more appropriate to allow "remote group" to be given
to "prune" (and perhaps "show").
