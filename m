From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Files different for me
Date: Wed, 25 Feb 2009 14:23:29 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709E048CB@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain> <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcPNO-00087j-Ex
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 20:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbZBYTXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 14:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZBYTXd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 14:23:33 -0500
Received: from mail5.tradestation.com ([63.99.207.76]:2094 "EHLO
	mail5.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbZBYTXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 14:23:33 -0500
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Feb 2009 14:23:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Files different for me
thread-index: AcmXeg9bHmSvmN0NSuer3Uj3/0bV3AAAtzTQ
X-OriginalArrivalTime: 25 Feb 2009 19:23:31.0219 (UTC) FILETIME=[8B1A2630:01C9977E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111482>


=== re: ===

The handling of a case where a pull decides to go ahead (because it does
not have to touch the Makefile you have your codename updates in) but
does
not complete with real conflicts, is not as graceful as the other two
cases (merge refusing to run at all without touching anything, or merge
completes cleanly and makes a commit).

You will be left with:

 - Paths that have local changes (index matches HEAD but work tree does
   not match the index --- like your Makefile);

 - Paths cleanly merged (index and HEAD are different but work tree
   already matches the index);

 - Unmerged paths (index has higher stage entries with <<</===/>>> files
   in the work tree);

You, I and experienced users know what to do.  Deal *only* with the last
kind, mark them with "git add" after you are done with each of them, and
make sure you do not say "-a" when committing the result, to exclude the
first kind from the merge result.

I've been wondering if we can make this safer for others.

===end===

I've gone over that carefully and I understand (I think) what you are
saying.  The first two are things that were not committed, and should
stay that way (added or not) if they did not conflict.  But they can get
in the way if a merge (on other files) is needed.

In an effort to "wonder" out loud, can you explain how to handle that
with "mergetool"?  For a dumb user like me, it just fixes some files
itself (I guess kdiff is smarter than the normal merge logic) and
presents me with a GUI for things I need to specify.  This should
naturally only go through files with conflicts because of those
"<<</===/>>>" files present.

So, what should I know/do?  "Don't use -a"?  If the idea is to commit
the merged stuff but preserve the status of what I've added but don't
want to commit yet, I'm at a loss.  Using git GUI, it will be backwards:
my additions show, but the freshly merged files are noticed as changes
that could be staged.  I want to un-stage the original, stage the merged
files, commit, then re-stage the original stuff?!

Looking again and what you wrote, I think you are not doing that at all.
You would add the merged files to the index, carefully preserving the
first kind.  Is it possible/easy to do what I thought you meant at
first:  commit just the merged files, and leave the "unaffected" files
still in the index and not committed?

--John
