From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 01:52:03 -0400
Message-ID: <20060805055203.GC18679@spearce.org>
References: <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org> <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com> <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com> <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com> <20060805052135.GA18679@spearce.org> <9e4733910608042240u581dd23q3859ebcfe4268ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 07:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9F54-0000MO-L2
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbWHEFwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbWHEFwK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:52:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26062 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161473AbWHEFwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:52:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9F4v-0007Px-EO; Sat, 05 Aug 2006 01:52:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9312520FB77; Sat,  5 Aug 2006 01:52:03 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608042240u581dd23q3859ebcfe4268ce2@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24889>

Jon Smirl <jonsmirl@gmail.com> wrote:
> How about adding a flag to repack that simply says delete the objects
> when done with them? I'd still create all of the objects on disk.
> Repack would assume that they have at least been sorted by filename.
> So repack could read in object names until it sees a change in the
> file name, sort them by size, deltafy, write out the pack and then
> delete the objects from that batch. Then repeat this process for the
> next file name on stdin.
> 
> I'm making two assumptions, first that blocks from a deleted file
> don't get written to disk. And that by deleting the file the file
> system will use the same blocks over and over. If those assumptions
> are close to being true then the cache shouldn't thrash. They don't
> have to be totally true, close is good enough.
> 
> Of course eliminating the files all together will be even faster.

See the email I just sent you.  The only file being written is the
pack file that's being generated.  No temporary files, no temporary
inodes, no temporary blocks.  Only two passes over the data: one to
write it out and a second to generate the SHA1.  I do two passes
vs. keep it all in memory to prevent the program from blowing out
on extremely large inputs.

It may be possible to tweak git-pack-objects to get what you propose
above, but to be honest I think the git-fast-import I just sent
was easier, especially as it avoids the temporary loose object stage.

-- 
Shawn.
