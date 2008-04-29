From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 15:05:40 +0200
Message-ID: <48171D24.9000104@gnu.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>	 <4816CC80.9080705@op5.se> <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com> <48171442.4050707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, Russ Dill <russ.dill@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 15:08:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqpY1-0002lH-CO
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 15:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbYD2NFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 09:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757030AbYD2NFu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 09:05:50 -0400
Received: from main.gmane.org ([80.91.229.2]:40327 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755692AbYD2NFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 09:05:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JqpWl-0005pK-F5
	for git@vger.kernel.org; Tue, 29 Apr 2008 13:05:47 +0000
Received: from 195.176.178.209 ([195.176.178.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:05:47 +0000
Received: from bonzini by 195.176.178.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:05:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 195.176.178.209
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <48171442.4050707@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.1 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  0.1 FORGED_RCVD_HELO Received: contains a forged HELO
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  3.0 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?195.176.178.209>]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80682>


> I can think of one way to make git a lot more resilient to hash
> collisions, regardless of which hash is used, namely: Add the length
> of the hashed object to the hash.

Not really, because most attacks are about collisions, not second 
preimages.  They produce two 64-byte blocks (hence, same length) with 
the same hash value.

As such, they allow to change a blob that *the attacker* injected in the 
repository.  The way the more "spectacular" attacks are devised requires 
a "language" with conditional expressions -- for documents, for example, 
Postscript is used.  If you prepare a postscript file whose code is

    if (AAAA == BBBB)
      typeset document 1
    else
      typeset document 2

where AAAA and BBBB are collisions, and you change it to "if (BBBB == 
BBBB) the hash will be the same, but the outcome will be document 1 
instead of document 2.

The fact that this requires having the two "behaviors" in the blob is 
not a big deal for source code, going in the wrong branch of an "if" can 
be an attack.  On the other hand, it makes adding the length useless for 
collision attacks.  True, it wouldn't be useless for second preimage 
attacks, but SHA-1 is still secure with respect to those.

Paolo
