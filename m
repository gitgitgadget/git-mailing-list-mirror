X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t6024: fix timing problem
Date: Wed, 13 Dec 2006 00:59:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612130053230.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 00:06:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:06:13 EST
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34170>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHdY-0001vQ-UO for gcvg-git@gmane.org; Wed, 13 Dec
 2006 01:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932576AbWLMAGO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 19:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWLMAGO
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 19:06:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:37182 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932577AbWLMAGN
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 19:06:13 -0500
Received: (qmail invoked by alias); 12 Dec 2006 23:59:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 13 Dec 2006 00:59:32 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

hI,

On Tue, 12 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This script tests a complicated merge, where _all_ files conflict. In
> > these circumstances, the ordering of the commits -- which is affected
> > not by the timestamps in the commit message -- becomes a deciding factor
> > of the merge result.
> 
> "not by the timestamps", or "by the timestamps"?  I am confused...

I deleted the "only", but not the "not" in front of it. Should have read 
my mail before sending... Sorry.

> Do you mean the commit timestamps affect which merge base commit becomes 
> ours and theirs during the computation of the virtual merge base commit?  
> That certainly explains the problem.

It affects in which order the merge bases are merged. I remember that I 
made a case for the oldest merge base to go first. If two of them (or all 
three!) have the same timestamp, I _think_ they are ordered by SHA1...

Now, the problem here is that two of the merge bases have a common merge 
base, but the third has a completely different root. So, depending on 
which merge base goes first, the add/add conflict can remove the file from 
the index early, in which case the next merge does not find a stage 1.

> > 	How about this: if there is an add/add conflict, we treat it as
> > 	if there _was_ an empty file, and we let the shiny new xdl_merge()
> > 	find the _true_ conflicts, _instead of_ removing the file from
> > 	the index, adding both files with different "~blabla" markers
> > 	appended to their file names to the working directory.
> 
> I was not thinking about this t6024 test failure problem but was
> wondering about doing exactly that in merge-recursive to match
> the "two file merge" magic we have in git-merge-one-file.sh ---
> I guess great minds do think alike ;-).

*beams* Gee, thanks!

Ciao,
Dscho
