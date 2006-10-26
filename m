X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 10:16:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610261012090.3962@g5.osdl.org>
References: <45354AD0.1020107@utoronto.ca><BAYC1-PASMTP07AB11A64250AAF683424
 DAE0E0@CEZ.ICE><vpq4ptz2uh8.fsf@ecrins.imag.fr> 
 <453DAC87.8050203@research.canon.com.au><Pine.LNX.4.64.0610232318200.3962@g
 5.osdl.org><Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu><Pin
 e.LNX.4.64.0610240812410.3962@g5.osdl.org><Pine.LNX.4.64N.0610241300450.811
 2@attu4.cs.washington.edu><20061025084810.GA26618@coredump.intra.peff.net><
 Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu><20061025094900.G
 A26989@coredump.intra.peff.net><Pine.LNX.4.64N.0610250954380.31053@attu2.cs
 .washington.edu><454098EC.8040406@op5.se><Pine.LNX.4.63.0610260929040.2424@
 qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0610261247420.12418@xanadu.home>
 <Pine.LNX.4.63.0610261003290.2424@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 17:17:57 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>,
	David Rientjes <rientjes@cs.washington.edu>,
	Jeff King <peff@peff.net>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610261003290.2424@qynat.qvtvafvgr.pbz>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30242>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8rM-0002EN-Ue for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423614AbWJZRRh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423623AbWJZRRh
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:17:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2980 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423614AbWJZRRg (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:17:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QHGcPo000402
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 10:16:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QHGapP021759; Thu, 26 Oct
 2006 10:16:36 -0700
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, David Lang wrote:
> 
> the offset within a pack for the starting location of an object cannot be
> larger then 4G.

Well, strictly speaking, even that isn't actually a limit on the _pack_ 
format itself.  It's really just the (totally separate) index that 
currently uses 32-bit offsets.

For example, you can actually use the pack-file to transfer more than 4GB 
of data over the network. You'd not need to change the format at all. Only 
the local _index_ of the result needs to change - but we never transfer 
that at all (it's always generated locally), so that's really a separate 
issue.

It's not even hard to fix. It's just that right now, the biggest 
repository that we know about (mozilla) is not even close to the limit. 
And it took them ten years to get there. So if the mozilla people switch 
to git, and keep going at the same rate, we have about 70 years left 
before we need to fix the indexing ;)

(Of course, other projects, like the kernel, seem to grow faster, so it 
might be "only" a decade or two - but since the index format is a local 
thing, even that won't be too painful, since we don't really need a global 
flag-day once we decide to start supporting larger offsets in the index)

