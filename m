Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 32068 invoked by uid 111); 27 Jun 2008 06:57:48 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 02:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760391AbYF0G4z (ORCPT <rfc822;peff@peff.net>);
	Fri, 27 Jun 2008 02:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759561AbYF0G4z
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 02:56:55 -0400
Received: from w2.willowmail.com ([64.243.175.54]:32892 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753908AbYF0G4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 02:56:53 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jun 2008 02:56:53 EDT
Received: (qmail 22001 invoked by uid 90); 27 Jun 2008 06:50:01 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: is rebase the same as merging every commit?
X-Mailer: Willow v0.02
Date:	Fri, 27 Jun 2008 06:24:23 -0000
Message-ID: <willow-jeske-01l7GhRWFEDjChtB>
Received: from 67.160.239.249 at Fri, 27 Jun 2008 06:24:23 -0000
References: <7vvdzvn0ql.fsf@gitster.siamese.dyndns.org>
	<willow-jeske-01l79c1jFEDjCWw6-01l7@0yvFEDjCjEl>
In-Reply-To: <7vvdzvn0ql.fsf@gitster.siamese.dyndns.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks for the explanation.

However, when considering an SCM perspective, I don't understand why I have to
make a tradeoff between personal reproducibility (which I get from the original
changes), and upstream readability (which the community gets from my rebase).

I could get both of these if the rebase kept both the old and new.

Is there some reason that losing personal reproducability, and personal/local
tracking back to those changes of A-B-C is necessary as part of the process?

Further, the rebase machinery seems like it would be great for operations that
are even more 'dangerous', where I would really really want the history of the
transitions in case I realized a problem later.

Consider this set of commits on a personal branch

0 - feature a
1 - feature b
2 - bugfix a
3 - feature c / d
4 - bugfix b
5 - bugfix a2

>From all I've read about rebase, bisect, and the big tree management, it seems
like the three steps are Reorder, combine, rebase.  (In a more complicated
situation, i'd want to split a commit into pieces)

(1'')
0' - feature A
1' - bugfix a
2' - bugfix a2
(2'')
3' - feature b
4' - bugfix b
(3'')
5' - feature c (split)
(4'')
6' - feature d (split)

Frankly, I'm super impressed, because I can imagine how I might do this in git.
I'm guessing some of you are already doing this. But how do you do it? Can you
rebase a patch back into it's own history? (such as bugfix a from 2, to 1')

I want to mess around and try this stuff out, but I'm scared of doing bad
things to the tree and them being unrecoverable because rebase tosses the old
stuff. I don't understand why I have to lose my original work and/or the
connection to my original work, in order to reorder/combine/split for public
consumption. What is the argument for that? (other than the fact that the
current dag link propagation model would force others to get these changes if
they remained connected together. Something easily remidied by out of band
metadata, or different link types)
