From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 09:56:13 -0700
Message-ID: <20090603165613.GJ3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906031121.38616.jnareb@gmail.com> <20090603144837.GE3355@spearce.org> <200906031851.12160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBtlH-0001jp-Cm
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 18:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbZFCQ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 12:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbZFCQ4M
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 12:56:12 -0400
Received: from george.spearce.org ([209.20.77.23]:52883 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbZFCQ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 12:56:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 935A6381D1; Wed,  3 Jun 2009 16:56:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906031851.12160.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120621>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> > Oh, and send-pack/receive-pack protocol now has ".have" refs [...]
> 
> What are those ".have" refs? They are not described in current version
> of "Transfer Protocols" (sub)section in "The Community Book". I remember
> that they were discussed on git mailing list, but I don't remember what
> they were about...

If the remote receiving repository has alternates, the ".have" refs are
the refs of the alternate repositories.  This signals to the client that
the server has these objects reachable, but the client isn't permitted
to send commands to alter these refs.

Its good for a site like GitHub or repo.or.cz where cheap forks are
implemented by creating a repository that points to a common shared
base via alternates.  The ".have" refs say that the server already
has everything in that common shared base, so the client doesn't
have to re-upload the entire project if the fork started out empty,
or had all refs deleted from it.
 
> > In packed-refs, Junio had a hard time adding the "peeled-refs"
> > support, because the first version of the parser was so strict.
> > But again, somehow he managed to find a backdoor in the old parser,
> > and that backdoor is why that file looks the way it does today.
> 
> I don't remember what that was about... Nevertheless now we have
> kind of 'capabilities' section in .git/packed-refs

Sort of.  In a file format its worse than a network protocol,
because the file can't alter its contents based on what the
reader can understand.
 
> Interesting... even more so that this problem of designing without
> extendability in mind (magic number + version) is so persistent :-(

I know.  I think we maybe have learned the lesson.  I don't know.
 
-- 
Shawn.
