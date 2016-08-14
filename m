Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 1346 invoked by uid 111); 24 Jun 2008 08:45:53 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 04:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYFXIpj (ORCPT <rfc822;peff@peff.net>);
	Tue, 24 Jun 2008 04:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYFXIpi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:45:38 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60072 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751426AbYFXIph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:45:37 -0400
Received: (qmail 10641 invoked by uid 90); 24 Jun 2008 08:45:14 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Jeff King <peff@peff.net>
Cc:	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 08:30:41 -0000
Message-ID: <willow-jeske-01l5lTEoFEDjCVta>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 08:30:41 -0000
References: <20080624081601.GA2692@sigill.intra.peff.net>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5kv6TFEDjCj8S>
In-Reply-To: <20080624081601.GA2692@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is mostly moot since I've understood that it's easy to set git to never
GC. I guess I'm curious about why those GC fields would ever be set to anything
other than never?

-- Jeff King wrote:
> No. Git keeps the reachable DAG. So if the DAG is part of development
> that is merged into one of your long running branches, or if you keep
> around the branch that points to it, it will never go away.

Right, that's what I thought.

I'm not primarily concerned with what developers can do to their local git
repositories. I'm concerned with what the default sync operations can let them
do to the crown-jewels in the 'central organization repositories' which
everyone is periodically pushing to.

I like that deleting a branch in your repo does not cause it to be deleted in
other repos. Presumably in an  organization we could prevent the central repo
from ever accepting branch deletes from developers. (without some kind of
authorization)

Does it have the same protection for all operations that can cause DAGs to be
dangling? For example, if they branch -f" and push the branch?

---

Again it's simple enough for me to just set the GC times to "never" on the
server, and I find git pretty pleasing because I'm a
short-attention-span-comitter. On a perforce or cvs repository, I frequently
tar up subtrees between commits, so i don't lose my work -- git is light-years
ahead of this.

Quite a bit of my fear of losing data came from some issues in the git-gui. I'm
trying out git on a windows project, and windows-shells just don't work right,
so I'm using the "Git Gui". It turns out right-clicking on a history entry in
the gui has no checkout option, and the only option it does have which will let
you move the tree to that place is "reset --hard".. since this was the easiest
thing to find in the GUI, I assumed it was the right way to do it, and then all
my more recent changes disappeared. It doesn't seem to have reflog
functionality, so I couldn't find any way to get back all my changes. I ended
up having an old history window that I did another reset --head in back to the
latest change, but I got scared about what git was doing underneath. The docs
clearly explained that it will garbage collect dangling refs, and frankly the
information about how often this happens is buried so deep I had no idea what
the frequency was.
