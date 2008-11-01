From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 17:19:26 -0700
Message-ID: <20081101001926.GF14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101000213.GB29036@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:21:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4EK-0005gF-Sk
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYKAAT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYKAAT2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:19:28 -0400
Received: from george.spearce.org ([209.20.77.23]:35403 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYKAAT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:19:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A779A3835F; Sat,  1 Nov 2008 00:19:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081101000213.GB29036@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99691>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Fri, Oct 31, 2008 at 11:49:11PM +0000, Junio C Hamano wrote:
> > 
> > I understand that the apidocs/ is a very early work-in-progress, but
> > still, it bothers me that it is unclear to me what lifetime rules are in
> > effect on the in-core objects.  For example, in C-git, commit objects are
> > not just parsed but are modified in place as history is traversed
> > (e.g. their flags smudged and their parents simplified).  You have "flags"
> > field in commit, which implies to me that the design shares this same
> > "modified by processing in-place" assumption.
> 
> I don't think it's impossible to have something efficient without this
> kind of hacks. You just need to dissociate the objects from their
> annotations, though use some kind of allocator that allow numbering of
> the objects, and use that number as a lookup in an array of annotations.
> It will require pool allocators for the annotations, but that should
> work fine and efficientely.

Interesting approach.  I don't know why I didn't think of that one.

You'll still need to be able to toss parts of the git graph though.
If you just pin everything in memory under a single global object
table you'll run server processes out of memory as they chug through
large numbers of repositories.

> > By the way, I hate git_result_t.  That should be "int", the most natural
> > integral type on the platform.
> 
> I concur.

int it is then.

-- 
Shawn.
