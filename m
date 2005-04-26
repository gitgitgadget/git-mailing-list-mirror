From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 13:19:38 -0400
Message-ID: <20050426171938.GA7632@delft.aura.cs.cmu.edu>
References: <20050425214326.512b006e.davem@davemloft.net> <20050426005725.6bfe6135.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 26 19:15:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTeA-0003PE-JJ
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVDZRT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDZRT6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:19:58 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:15560 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261696AbVDZRTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 13:19:42 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DQTik-000216-00
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 13:19:38 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426005725.6bfe6135.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Forgot to cc: git@vger when I sent this originally.

On Tue, Apr 26, 2005 at 12:57:25AM -0700, Andrew Morton wrote:
>  27 files changed, 46 insertions(+), 80 deletions(-)
> 
> And that's the bad patch.

Both Linus and DaveM merged the same patch from Al Viro, but they are
ofcourse different commits. So both branches have diverged and would
need to be merged, where someone decides if Linus's commit or Dave's
commit should be used.

> What did I do wrong?
> 
> Can someone suggest a better approach?

Well, I looked at the history, and if I skip the Viro patch in davem's
branch by hand I get,

$ git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:088dd3a45fdb8fb726cd50575856562c4f6f1c3e | diffstat 
 drivers/net/tg3.c                            |   73 ++++++++++++++-------------
 net/ipv4/ip_output.c                         |    2 
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    4 -
 net/ipv4/netfilter/ip_conntrack_standalone.c |    7 --
 net/ipv4/tcp_input.c                         |    1 
 net/sched/simple.c                           |   18 ------
 6 files changed, 46 insertions(+), 59 deletions(-)

So now, how to do this without picking through the logs. I figured the
patchutils stuff might have a solution for this. So I got the diffs on
Linus's branch wrt to the gca, and from Dave's branch wrt to the gca.

$ git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:b453257f057b834fdf9f4a6ad6133598b79bd982 > git-linus.patch
$ git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:5523662c4cd585b892811d7bb3e25d9a787e19b3 > git-net.patch
$ interdiff --no-revert-omitted -p1 git-linus.patch git-net.patch | diffstat
 drivers/net/tg3.c                            |   73 ++++++++++++++-------------
 net/ipv4/ip_output.c                         |    2
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    4 -
 net/ipv4/netfilter/ip_conntrack_standalone.c |    7 --
 net/ipv4/tcp_input.c                         |    1 
 net/sched/simple.c                           |   18 ------
 6 files changed, 46 insertions(+), 59 deletions(-)

That looks like it matched.

Jan
