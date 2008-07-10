From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] apply: fix copy/rename breakage
Date: Thu, 10 Jul 2008 10:01:54 -0400
Message-ID: <20080710140154.GN26957@redhat.com>
References: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 16:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGwuk-0004Gb-17
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbYGJONc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbYGJONc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:13:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbYGJONb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:13:31 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m6AE1utX028549;
	Thu, 10 Jul 2008 10:01:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m6AE1tUf016898;
	Thu, 10 Jul 2008 10:01:55 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m6AE1tRg005231;
	Thu, 10 Jul 2008 10:01:55 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m6AE1taF019303;
	Thu, 10 Jul 2008 10:01:55 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m6AE1s8A019302;
	Thu, 10 Jul 2008 10:01:54 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vy74aqvr1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87973>

On Wed, Jul 09, 2008 at 08:10:58PM -0700, Junio C Hamano wrote:
> Recently, 7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught
> "git-apply" to grok a (non-git) patch that is a concatenation of separate
> patches that touch the same file number of files, by recording the
> postimage of patch application of previous round and using it as the
> preimage for later rounds.
> 
> However, this "incremental" mode of patch application contradicts with the
> way git rename/copy patches are fundamentally designed.  When a git patch
> talks about a file A getting modified, and a new file B created out of B,
> like this:
> 
> 	diff --git a/A b/A
> 	--- a/A
> 	+++ b/A
> 	... change text here ...
> 	diff --git a/A b/B
> 	copy from A
> 	copy to B
> 	--- a/A
> 	+++ b/B
> 	... change text here ...
> 
> the second change to produce B does not depend on what is done to A with
> the first change (this is explicitly done so for reviewability of
> individual patches).
> 
> With this patch, we disable the postimage record 'fn_table' when applying
> a patch to produce new files out of existing file by copying to fix this
> issue.

Odd.  I guess the way I read this workflow is

apply change X to A, copy A' to B, apply change Y to B => B' now has changes X+Y

But instead you are saying B' only has change Y because A is copied to B
not A'.

Regardless, it doesn't affect my workflow.

ACK.

Cheers,
Don
