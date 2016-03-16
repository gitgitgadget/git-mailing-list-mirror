From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Can't git stash after using git add -N
Date: Tue, 15 Mar 2016 19:00:00 -0700
Message-ID: <20160316020000.GB12130@cloud>
References: <20160315230754.GA12058@cloud>
 <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 03:00:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag0ks-00064f-GO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 03:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbcCPCAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 22:00:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45919 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985AbcCPCAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 22:00:04 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4EB0317209D;
	Wed, 16 Mar 2016 03:00:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288942>

On Tue, Mar 15, 2016 at 04:46:48PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > After using "git add -N", "git stash" can no longer stash:
> 
> I think this is unfortunately one of the fundamental limitations
> that comes from the way how "stash" is implemented.  It uses three
> tree objects (i.e. HEAD's tree that represents where you started at,
> the tree that results by writing the index out as a tree, and
> another tree that would result if you added all the changes you made
> to the working tree to the index and then writing the resulting
> index out as a tree), but there are some states in the index that
> cannot be represented as a tree object.  "I know I would eventually
> want to add this new path, but I cannot decide with what contents
> just yet" aka "git add -N" is one of them (the other notable state
> that cannot be represented as a tree object is paths with unresolved
> conflicts in the index).

As far as I can tell, if I run "git add -N" on a file, and then commit
without adding the file contents, it gets committed as an empty file.
Could stash save it exactly as if I'd done "git add" of an empty file at
that path and then filled in the contents without adding them?

> "git rm --cached" the path and then running "stash save" would be a
> workaround, but then you'd probably need to use "--untracked" hack
> when you run "stash save" if you are stashing because you are going
> to do something to the same path in the cleaned-up working tree.

Right; I do specifically want to save the working-tree files.
