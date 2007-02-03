From: Theodore Tso <tytso@mit.edu>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sat, 3 Feb 2007 08:20:59 -0500
Message-ID: <20070203132059.GB15419@thunk.org>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 14:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDKpO-0006P4-4g
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 14:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbXBCNVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 08:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXBCNVI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 08:21:08 -0500
Received: from thunk.org ([69.25.196.29]:33597 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbXBCNVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 08:21:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HDKuE-0001Gq-L1; Sat, 03 Feb 2007 08:26:15 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HDKp9-0001XA-7a; Sat, 03 Feb 2007 08:20:59 -0500
Content-Disposition: inline
In-Reply-To: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38564>

On Fri, Feb 02, 2007 at 10:40:49PM -0800, Junio C Hamano wrote:
> I do not think this is a good explanation.  For example, if we
> do this:
> 
> (1) I build a series and push it out.
> 
> 	---o---o---o---j
> 
> (2) Alice clones from me, and builds two commits on top of it.
> 
> 	---o---o---o---j---a---a
> 
> (3) I rewind one and build a few, and push them out.
> 
> 	---o---o---o...j
>                     \
>                      h---h---h---h
> 
> (4) Alice pulls from me again:
> 
> 	---o---o---o---j---a---a---*
>                     \             /
>                      h---h---h---h
> 
> Contrary to the description, git will happily have Alice merge
> between the two branches, and never gets confused.
> 
> Maybe I did not want to have 'j' because it was an incomplete
> solution to some problem....

Another scenario might be if 'j' was just a bad idea, and should have
never been committed in the first place.  Now if Alice builds upon it,
and at some later point Alice asks you to pull from her repository,
'j' will appear back in your repository.  So it's better to have a
changeset which simply undoes 'j' rathern than rewind, once you've
pushed out the repository.

The one exception to this is if 'j' contains something which might be
problematic from a copyright point of view, in which case you're
largely screwed if other people such as Alice has already pulled from
you and started basing changes on 'j'.

							- Ted
