X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 15:29:31 -0500
Message-ID: <20061207202931.GB12502@spearce.org>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com> <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net> <20061207192632.GC12143@spearce.org> <7vhcw7scln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 20:29:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcw7scln.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33632>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPsB-0007H8-G7 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 21:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163284AbWLGU3g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163294AbWLGU3g
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 15:29:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38205 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163284AbWLGU3e (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 15:29:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsPrx-0001e8-PI; Thu, 07 Dec 2006 15:29:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 ADCFF20FB6E; Thu,  7 Dec 2006 15:29:31 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> I am not sure what you are trying.  Do you mean stat() is slow
> >> on your filesystem?
> >> 
> >> Maybe you want "assume unchanged"?
> >
> > Yes, basically.
> 
> Then maybe "git grep assume.unchanged" would help?

Hmm.  OK, maybe I should have answered "No"" to your first question.
I keep looking at the assume unchanaged feature of update-index,
but refuse to use it because I'm a lazy guy who will forget to tell
the index a file has been modified.  Consequently I'm going to miss
a change during a commit.

What may help (and without using assume unchanged) is:

 * skip the `update-index --refresh` part of git-status/git-commit
 * skip the status template in COMMIT_MSG when using the editor

As Git will still at least make sure a `commit -a` includes
everything that is dirty.

Files whose modification dates may have been messed with (but
whose content are unchanged) will just go through expensive SHA1
computation to arrive at the same value, which is fine.

Users skipping the first part are doing so under the assumption that
their modification dates are usually always correct, and that then
they aren't the SHA1 computation of a handful of files is cheap
compared to stat'ing the entire set of files.

Users skipping the second part are doing so under the assumption
that knowing the names of the files they are committing doesn't
really improve their odds of writing a good commit message.

-- 
