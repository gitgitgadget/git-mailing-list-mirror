From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Sat, 12 Sep 2009 20:35:46 +0200
Message-ID: <200909122035.47051.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909121750.00733.johan@herland.net> <20090912181150.GN1033@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXRz-0001im-So
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZILSfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbZILSfr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:35:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39237 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754824AbZILSfr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 14:35:47 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003VCFNPZG40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 20:35:49 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003KRFNN3920@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 20:35:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.182116
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <20090912181150.GN1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128279>

On Saturday 12 September 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > Shawn, do you have any additional defence for the date-based fanout?
> 
> No.
> 
> The only defense I have for it is "it sounds like a nice theory
> given access patterns", and the note about memory usage you made,
> but which I clipped to keep this email shorter. :-)
> 
> It was only a theory I tossed out there in a back-seat-driver
> sort of way.  Your results show my hunch was correct, it may help.
> But they also say it may not help enough to justify the complexity,
> so I now agree with you that SHA-1 fan out may be good enough.

Ok, so I guess we can drop the flexible part of notes code. Junio: Feel free 
to drop the two last patches from the jh/notes series.

> > How does the plan for notes usage in your code-review thingy
> > compare to my test scenario?
> 
> I think your tests may still have been too low in volume, 115k notes
> isn't a lot.  Based on the distributions I was looking at before,
> I could be seeing a growth of >100k notes/year.  Ask me again in
> 5 years if 115k notes is a lot. :-)
> 
> But we all know that SHA-1 distributes data quite well, so the SHA-1
> fan-out may just need to change from 2_38 to 2_2_2_34 (or something)
> to handle that larger volume.

Yes, I expect that the optimal number of entries per tree level is ~256, so 
if we add an upper threshold at ~300 (where we start using another fanout 
level), and a lower threshold at ~200 (where we consolidate subtrees and put 
all into this level), the (still-to-be-written) writing part of the notes 
code should automatically adjust the notes tree to the optimal layout.

With those assumptions, and a growth of 100k notes/year, a 2/2/36 fanout 
should last you ~150 years, and a 2/2/2/34 fanout should be enough for the 
next ~40,000 years... ;)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
