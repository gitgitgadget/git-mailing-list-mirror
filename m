From: David Kastrup <dak@gnu.org>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 23:30:31 +0200
Message-ID: <85wsvkfwnc.fsf@lola.goethe.zz>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
	<1187905879.5986.199.camel@beauty>
	<7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
	<85ir75h2zb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
	<86mywhfk17.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOgjl-0007pZ-Vx
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 23:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbXHXVae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbXHXVae
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 17:30:34 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45467 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbXHXVad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 17:30:33 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IOgje-0006GZ-H4; Fri, 24 Aug 2007 17:30:30 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C0D571C36605; Fri, 24 Aug 2007 23:30:31 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708241039250.25853@woody.linux-foundation.org> (Linus Torvalds's message of "Fri\, 24 Aug 2007 10\:51\:35 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56604>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 24 Aug 2007, David Kastrup wrote:
>
>> In your example, neither installed files nor ownership are tracked
>> in the filesystem.  Both are "tracked" in the Makefile.  Or rather
>> than being tracked, they are explicitly catered for by the user.
>
> And I seriously am saying that that is the only way to handle things
> sanely in a distributed content tracker like git.

Well, maybe _if_ you are using it as a distributed content tracker.
But git is excellent at tracking contents (and resolving conflicts and
merged) even if you _don't_ distribute.

Anyway, my beef with using something like .gitattributes or similar
for tracking permissions is twofold:

a) if I am tracking a directory, having to track additional files
clutters the directory.  So if one uses a separate file for tracking,
it should be able to use a file that is not actually in the work tree.
But it still needs to be versioned.  One could possibly fudge this by
creating an artificial work tree with the tracked directory being in a
subdirectory of it, but that's all pretty dorky.

b) merge resolution and movement tracking.  Delegating stuff to a file
and using the _file_ merging and tracking mechanisms is just not
really the same thing.  So it would be nice to at least have
"pluggable merge strategies" for particular files, or treat
gitattributes special with regard to merging, anyway.

Personally, I'm leaning towards a pluggable policy system containing
rules how permission information is represented textually in the
repository (that would allow acls and uid gid information), how the
index is updated from repo and workdir and vice versa.  The default
policy would just talk about 777 or 666 (or 775 and 644) as it does
now.

We already have a policy flag that optionally blocks the information
flow from/to the index regarding executable bits.  So it is not like
the concept is alien.

On the matter of taste: I feel fine about storing numerical uid/gid
data in the index, but I am already getting queasy with the idea of
storing them numerically in the repository: that's a place where I
find symbolic names more appropriate.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
