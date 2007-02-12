From: Theodore Tso <tytso@mit.edu>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 14:35:07 -0500
Message-ID: <20070212193507.GA18730@thunk.org>
References: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com> <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <7vd54gau3r.fsf@assigned-by-dhcp.cox.net> <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com> <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com> <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com> <20070212051108.GB699@spearce.org> <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com> <Pine.LNX.4.64.0702121013150.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 20:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGgxV-0008Or-Gr
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 20:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXBLTf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 14:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbXBLTf0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 14:35:26 -0500
Received: from thunk.org ([69.25.196.29]:49681 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965336AbXBLTfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 14:35:25 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGh2S-0006ef-9z; Mon, 12 Feb 2007 14:40:37 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGgx9-0007ut-Ub; Mon, 12 Feb 2007 14:35:07 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702121013150.1757@xanadu.home>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39426>

On Mon, Feb 12, 2007 at 10:20:31AM -0500, Nicolas Pitre wrote:
> Repacking on clone is not the solution at all.
> 
> This problem is going to largely be resolved when GIT 1.5.0 gets 
> installed on kernel.org.  With latest GIT, pushes are kept as packs on 
> the remote end (when they're big enough which is over 100 objects by 
> default).  Then repacking multiple packs into one is almost free as most 
> of the data is simply copied from one pack and sent over the wire as a 
> single pack.

Even before we get Git 1.5.0 installed on master.kernel.org (and we
should really ask hpa to do that), is there a reason we haven't done
something like this across all of the kernel repo's on
master.kernel.org?

for i in <list of kernel git repo's on master.kernel.org>
do
   pushd $i
   if [ ! -f objects/info/alternates ]; then
	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects \
	   > objects/info/alternates
	git repack -a -d -l
   fi
   popd
done


					- Ted
