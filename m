From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 06:55:04 -0700
Message-ID: <20090323135504.GA9732@spearce.org>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org> <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 14:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llkds-00023Z-IR
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 14:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbZCWNzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755989AbZCWNzH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 09:55:07 -0400
Received: from george.spearce.org ([209.20.77.23]:52476 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756957AbZCWNzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 09:55:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3960938211; Mon, 23 Mar 2009 13:55:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114302>

David Reitter <david.reitter@gmail.com> wrote:
>
> I'm just experimenting with "bzr fast-export", which converts to git,  
> and it seems to take about 4 minutes for 1000 revisions on our (modern) 
> server.  That would be around 7 hours for my emacs repository; I can't do 
> that daily.

No, you'd want to incrementally do that...

> I wonder if there's a way for (bzr) fast-export / (git) fast-import to  
> work incrementally, i.e. for selected or most recent revisions.

fast-import supports incremental use; git-p4 does it from Perforce.
The trick is the application writing the stream (bzr fast-export
in this case) needs to do something to pick up the prior revisions.
It might do that by using the same mark numbers, and requiring you
to use --import-marks and --export-marks on the git side to save the
mark database between runs.  I don't know, I haven't looked at it.

> Or, one could do something like  bzr diff -r $REV.. $BBRANCH |  (cd  
> $GBRANCH; patch -p0; git commit), plus preserving authors and log  
> messages.   Is this roughly what the fast-export format does anyways?

Eh, sort of.

The fast-import format works on whole files, not patches.  So we
have to get the entire file from bzr each time it is modified.
If the file is a small source file, you almost can't tell the
difference in performance.  If its a huge binary that changes often,
it hurts to keep dumping the entire thing over the stream.

But at the commit level, yes, it preserves authorship and log
messages, assuming the bzr fast-export program incldued that data.
And I'm rather certain it does.

-- 
Shawn.
