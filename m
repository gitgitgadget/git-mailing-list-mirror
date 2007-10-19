From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:47:05 -0400
Message-ID: <20071019034704.GB11095@coredump.intra.peff.net>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiipS-0002Tl-9p
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654AbXJSDrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760471AbXJSDrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:47:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1951 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758448AbXJSDrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:47:07 -0400
Received: (qmail 8776 invoked by uid 111); 19 Oct 2007 03:47:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 23:47:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 23:47:05 -0400
Content-Disposition: inline
In-Reply-To: <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61639>

On Thu, Oct 18, 2007 at 11:40:47PM -0400, Michael Witten wrote:

> Anyway, succinctly:
>
>> What you want to happen is the following:
>> 	
>> 	git show HEAD:A.txt > path/B.txt
>> 	git add path/B.txt
>> 	mv A.txt B.txt
>> 	git rm A.txt
>
> Better:
>
>>  	mv A.txt path/B.txt
>> 	Point the index entry for A.txt to path/B.txt
>
> I hope that's right.

Hrm. So you _do_ want to do an index-only move of A to B, in which case
the suggestion of a "git-mv --cached" seems sensible. Though I'm curious
why you want that. The only workflow I can think of is:

  1. you modify a.c
  2. your boss comes in and tells you to make some unrelated change,
     which involves moving a.c to b.c
  3. You don't want to commit your changes, so you git-mv in the index
     only without involving your dirty working tree file.
  4. You commit the index (which doesn't have your changes from (1)

I think that is sort of a bogus workflow, though, since you will never
have actually compiled or tested the changes in (2). You are much better
to git-stash your current work, fulfill the boss's request, then
unstash.

-Peff
