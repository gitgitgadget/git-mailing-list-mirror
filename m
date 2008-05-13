From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 12:22:37 +0300
Message-ID: <20080513092237.GA4413@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org> <20080513000925.GA29038@spearce.org> <48292243.3050307@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Tweed <david.tweed@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 13 11:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvqt9-000852-3K
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbYEMJct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYEMJct
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:32:49 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:56983 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbYEMJcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:32:48 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482324D800382656; Tue, 13 May 2008 12:22:45 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvqiT-0002F1-Mt; Tue, 13 May 2008 12:22:37 +0300
Content-Disposition: inline
In-Reply-To: <48292243.3050307@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82010>

Paolo Bonzini wrote (2008-05-13 07:08 +0200):

> I think separate cutoffs should be in place for file size and number
> of  objects.  Very tight packs probably require hours to repack as
> efficiently.
[...]
> Thinking about both use cases, the best would be to have options
> (common  to git-clone, git-remote add, git-gc at least; and available
> via config  keys too) like
>
>   --keep-packs[=THRES1,THRES2,...]

Some thoughts from user interface's point of view. Two assumptions:

  - gc is daily or weekly operation
  - gc --aggressive is more like weekly or monthly operation.

In big repositories gc can feel pretty slow if there are not any .keep
packs and user runs the command daily. So I think there's a point in
having a .keep pack in repositories the size of linux-2.6 for example.
But at the same time I think it would be nice to have an easy UI-way to
repack with better disk space optimization.

This started as a crazy idea but maybe it's not so crazy so I'll
rephrase my previous suggestion. At final stage the command gc
--aggressive would add new .keep file which contains an identifier like

  This .keep file was added by "gc --aggressive" and
  will be automatically deleted at next run.

(Or something like that, you get the idea.)

At first gc --aggressive looks for .keep files with such identifier and
deletes them if found. Then it proceeds normally and finally adds new
.keep file with the same identifier.

This way the "daily" gc would operate very fast (as it leaves .keep
packs alone), and with gc --aggressive user could easily decide when to
create new landmark .keep packs (and also prune possible dangling
objects inside previous .keep packs). Normal user don't need to know the
details. Just run gc occasionally and maybe gc --aggressive when better
optimization is needed.

How does this sound?
