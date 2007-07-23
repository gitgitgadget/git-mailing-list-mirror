From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 23:05:03 +0100
Message-ID: <87hcnun5dc.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID62J-0008MW-82
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbXGWWFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXGWWFN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:05:13 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:47913 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbXGWWFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:05:09 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6NM54gq022603;
	Mon, 23 Jul 2007 23:05:04 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6NM53ps031093;
	Mon, 23 Jul 2007 23:05:03 +0100
Emacs: no job too big... no job.
In-Reply-To: <87lkd6n62i.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "Mon, 23 Jul 2007 22:49:57 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-WEiAPG-Metrics: hades 1072; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 23 Jul 2007, nix@esperi.org.uk outgrape:
> (I'd recommend storing the names of user/group file owners as well as
> the uids, so you can --- given suitable permissions --- chown to the
> right username in preference to uid if that user exists at checkout
> time.)

Suddenly this gets more complex. git-merge-file(1) has to understand the
contents of this file, so as not to consider merges conflicting unless
two files actually have different permissions (i.e. doing a line by line
diff, and combining the two such that at most one file with a given name
exists in the result), and so as not to consider lines with differing
ownerships conflicting unless we're running under a uid in which we can
change ownerships at all. (I'd like to track ownership but it's looking
like a bit of a nest of snakes.)

And the problem is that while git has a lot of strategies for merging
*trees*, its file merge system is totally unpluggable: it just falls
back to xdiff's merging system. I guess I'll have to add that feature :)

(How does this cope with binary files, I wonder? I seem to recall
something about that flying past back before the volume of the git list
overwhelmed me...)
