From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 09:45:27 +0200
Message-ID: <86bqe3va08.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707221406.25541.jnareb@gmail.com> <857iosmto0.fsf@lola.goethe.zz> <200707222226.30788.jnareb@gmail.com> <85644cf3mf.fsf@lola.goethe.zz> <85ps2jeju9.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICsbx-00082c-Og
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbXGWHpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXGWHpm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:45:42 -0400
Received: from main.gmane.org ([80.91.229.2]:36612 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbXGWHpl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:45:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICsbp-000315-9L
	for git@vger.kernel.org; Mon, 23 Jul 2007 09:45:38 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 09:45:37 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 09:45:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:WVqII47sSIJ0IthvIPSAeO38Wt8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53404>

David Kastrup <dak@gnu.org> writes:

> Addition: I was thinking so much of my implementation and its
> semantics that I did not consider one possibility that you might mean
> here:
>
> When adding a/b, always also add a (and the whole hierarchy above it)
> automatically as sticky.  Namely disallow unsticky directories in the
> repository at all.  That would mean that
>
>   git-add a/b;git-commit -m x;git-rm a/b;git-commit -m x
>
> might not be a noop if a was not in the repository previously: it
> would cause a to stay around sticky until removed.  With all other
> schemes, however, it would cause a to be removed "on behalf of the
> user" even if the user intended it to stay around.
>
> Indeed, this scheme might by far be the easiest to understand.
> Having no autoremoval at all in levels higher than the deleted level
> is something that people might easily understand: delayed removal
> just does not happen anymore, and git never deletes a directory
> unless told to.

And of course, it would be a nuisance for people managing a
patch-based workflow.  But those can actually easily set the
repository preferences differently, and even
find -type d -empty -delete
is not too hard to do.  So it would even be feasible as default.

But I think that in practice, the "track only what has been added
recursively" approach is a good default.  And since patches without
dir information never add anything recursively, it would mostly keep
the directories clean.

-- 
David Kastrup
