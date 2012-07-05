From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: can I always ignore a file during a merge?
Date: Thu, 5 Jul 2012 20:49:04 +0100
Organization: OPDS
Message-ID: <1E3C4BE2EAA245A9BEF11CC496E28B9E@PhilipOakley>
References: <p06240817cc114629c20f@[192.168.1.122]> <20120703073847.GD16679@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Jeff King" <peff@peff.net>
To: "Stephen Bannasch" <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 21:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sms32-00047D-JH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 21:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2GETtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 15:49:02 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27540 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2GETtA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 15:49:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAOXu9U9Z8r5W/2dsb2JhbABFhV+FQKwQgQiCEwUBAQQBCAEBGRUeAQEhBQYCAwUCAQMRBAEBAQICBSECAhQBBBoGBw8IBhMIAgECAwGHdQmmd5J2gSCKGYUsMmADjU+Xa4Jg
X-IronPort-AV: E=Sophos;i="4.77,532,1336345200"; 
   d="scan'208";a="392154932"
Received: from host-89-242-190-86.as13285.net (HELO PhilipOakley) ([89.242.190.86])
  by out1.ip03ir2.opaltelecom.net with SMTP; 05 Jul 2012 20:48:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201061>

From: "Jeff King" <peff@peff.net>
To: "Stephen Bannasch" <stephen.bannasch@deanbrook.org>
Sent: Tuesday, July 03, 2012 8:38 AM
Subject: Re: can I always ignore a file during a merge?


> On Wed, Jun 27, 2012 at 07:39:03PM -0400, Stephen Bannasch wrote:
>
>> Is there a way to merge from branchA to branchB and from branchB to
>> branchA while completely ignoring changes to a file that is tracked
>> and exists in both branches?
>
> No. Fundamentally, a commit object in git consists of a content state
> (i.e., a pointer to a tree object) and a pointer to all previous 
> history
> (i.e., zero or more "parent" pointers to commit objects). The 
> semantics
> of a commit object can be thought of as "I have looked at all of the
> history in all of the parent commits, and the state contained in my 
> tree
> pointer supersedes them all".
>
> So you could make merge B into A, but keep A's copy of the file (e.g.,
> using the "ours" strategy). But that is saying that you considered the
> state of both A and B, and decided that A's version supersedes what
> happened in B. If you later wanted to merge from A to B, B's version 
> of
> the file would not even be considered as an outcome for the merge.
>
> There isn't really a clever way to work around this via a different
> merge strategy; it's a fundamental aspect of git's data structure for
> storing history.
Stephen,
One thought, following too much reading of the manual,  is to use the 
merge --squash option, which leaves you with the index ready for a 
commit, and then revert the undesired file using checkout -- <file>, 
followed with git add <file>, and if you want both merge parents set the 
MERGE_HEAD as required (see the man pages) before the final commit.

Philip

>
> -Peff
> --
