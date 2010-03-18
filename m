From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH 0/9] Multiple remotes without conflicts
Date: Thu, 18 Mar 2010 20:42:49 +0100
Organization: SUSE Labs
Message-ID: <201003182042.49935.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de> <20100318190712.GD10981@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLcS-0007Qa-NA
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab0CRTmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:42:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:42019 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab0CRTmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:42:51 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3B9B293F46;
	Thu, 18 Mar 2010 20:42:51 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20100318190712.GD10981@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142505>

On Thursday 18 March 2010 20:07:12 Shawn O. Pearce wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > I'm still trying to find a simple and painless way of sharing the object
> > store among multiple repositories: the idea is to have a "parent"
> > repository which contains the actual object store, and a number of
> > "child" repositories which link to that object store.  The obvious
> > problem is garbage collection: we can only garbage collect the parent
> > once it has all refs of all its children.
> >
> > One way of ensuring that is to make each child a "remote" of the parent,
> > and to fetch all remotes first.  This works for branches, but not for
> > tags or for the reflog.
> 
> This just feels like the wrong solution.
> 
> Why can't we have a "$GIT_DIR/children" subdirectory with a symlink
> or file-containing-path to each child repository.  Modify the fsck
> and gc paths to include these additional reference and reflog spaces,
> and that's that.
> 
> Child registration is then just a matter of installing the symlink
> in the parent, or removing it, and gc/fsck never needs to worry
> about a fetch up front in order for it to be accurate.

Another way would be to add some kind of "child" flag to remotes, and to teach 
gc to fetch such children before doing its work (or check that they are up-to-
date).  I think it's much nicer to construct the "parent" repository in such a 
way that it includes all relevant refs locally: it will just look and behave 
like a "normal" repository.

Thanks,
Andreas
