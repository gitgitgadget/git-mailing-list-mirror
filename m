From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 13:14:34 -0700
Message-ID: <7vskvecv6d.fsf@gitster.siamese.dyndns.org>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
 <m3od63ozuf.fsf@localhost.localdomain>
 <200806151505.27686.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7yeH-0002hD-Ks
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYFOUOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbYFOUOs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:14:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYFOUOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 16:14:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C6FA6C95;
	Sun, 15 Jun 2008 16:14:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC2086C93; Sun, 15 Jun 2008 16:14:37 -0400 (EDT)
In-Reply-To: <200806151505.27686.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sun, 15 Jun 2008 15:05:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1B97818-3B17-11DD-8EC1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85112>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> Clarify that a clone is not an exact copy.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/git-clone.txt |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 7973e6a..c9bc627 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -31,7 +31,12 @@ This default configuration is achieved by creating references to
>  the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
>  by initializing `remote.origin.url` and `remote.origin.fetch`
>  configuration variables.
> -
> ++
> +*NOTE*: Although this command is called clone, the clone is not identical
> +in all respects. Local branches in the repository being cloned
> +becomes remote tracking branches in the clone and remote tracking
> +branches are not cloned at all. For security reasone the config sections
> +and triggers are not cloned either.

Thanks.

But the above will not lose any information content if "Although... clone,"
is dropped.  It in fact, dropping that would make it even clearer.  

Saying only "beware that neither X nor Y nor Z is done" leaves readers
wondering "why not".  Saying "you may assume W but that is not the case"
is the same.  How about expressing it a bit differently and in a more
positive way?  Documentation is not a place to express your frustration
you felt immediately after you found out that your initial assumption did
not match reality.

And there is no triggers in git.  If you are improving documentation,
please get your terminology straight.

I think the first three paragraphs of this manual page need major
overhaul.  There were not much difference between bare and non-bare clone
when historical layout was used, but exactly because a clone with a
working tree always use separate remotes layout, what they do is vastly
different these days.

Points to stress, and the order to present them, in the rewritten first
paragraphs would be:

 - There are two different kind of clones.  A bare one and non bare one.

 - A non-bare one is a way to prepare where you work in.  It is assumed
   that you will want to keep updating the resulting repository from the
   source of the cloning operation from time to time, so 'origin' is set
   up for you automatically to track its branches in remotes/origin.

 - A bare one is a way to prepare where you push into so that others can
   fetch from it.  IOW, it is a place people meet to exchange history, not
   a place where somebody actually works in to build history.  It is
   expected that people will push into the resulting repository from
   elsewhere to update it, rather than somebody will fetch into it further
   from any 'origin'.  No 'origin' is made, and branches are copied 1:1.

 - In either case, only the information from the originating repository
   that are designed to be shared are propagated.  That includes branches
   and tags, but not things that are specific for working in the
   originating repository such as config, stash, hooks and remote tracking
   branches.
