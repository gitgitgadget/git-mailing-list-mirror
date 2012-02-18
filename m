From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Does pack v4 do anything to commits?
Date: Sat, 18 Feb 2012 10:34:43 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1202181013350.24536@xanadu.home>
References: <CACsJy8CZPG3b3LBF-EFO_kOv6i157jy5414+bHcqiwOKyC+8VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 16:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RymJL-0007CX-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 16:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab2BRPeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 10:34:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29718 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab2BRPeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 10:34:44 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LZL0019BHXVUP80@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 18 Feb 2012 10:34:43 -0500 (EST)
In-reply-to: <CACsJy8CZPG3b3LBF-EFO_kOv6i157jy5414+bHcqiwOKyC+8VA@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191009>

On Sat, 18 Feb 2012, Nguyen Thai Ngoc Duy wrote:

> Hi Nico,
> 
> I had an experiment on speeding up "rev-list --all". If I cache sha-1
> of tree and parent, and committer date of single-parent commits, in
> binary form, rev-list can be sped up significantly. On linux-2.6.git,
> it goes from 14s to 4s (2s to 0.8 for git.git). Profiling shows that
> commit parsing (get_sha1_hex, parse_commit_date) dominates rev-list
> time.
> 
> >From what I remember, pack v4 is mainly about changing tree
> representation so that we can traverse object DAG as fast as possible.
> Do you do anything to commit representation too? Maybe it's worth
> storing the above info along with the compressed commit objects in
> pack to shave some more seconds.

Both the tree and commit object representations are completely changed 
to evacuate SHA1 parsing and searching entirely.  The SHA1 references 
are uncompressed, and replaced by indices into the pack for direct 
lookup without any binary search.  And the commit dates are stored in 
binary form. All path names as well as author/committer names are 
factored out into a table as well. This should make history traversal 
operations almost as fast as walking a linked list in memory, while 
making the actual pack size smaller at the same time.

> By the way, is latest packv4 code available somewhere to fetch?

Well, not yet.  Incidentally, I'm going in the Caribbeans for a week in 
a week, with no kids and only my wife who is going to be busy with scuba 
diving activities.  Like I did last year, I'm going to take some time to 
pursue my work on Pack v4 during that time.  And I intend to publish it 
when I come back, whatever state it is in, so someone else can complete 
the work eventually (I have too much to do to spend significant time on 
Git these days).


Nicolas
