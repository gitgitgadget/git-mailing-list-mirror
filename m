From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Fri, 29 Feb 2008 23:52:04 -0800
Message-ID: <7vejau6fvf.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
 <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
 <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
 <7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
 <18374.39253.408961.634788@cargo.ozlabs.ibm.com>
 <7vprugdxpj.fsf@gitster.siamese.dyndns.org>
 <18375.58359.687664.855599@cargo.ozlabs.ibm.com>
 <7vfxvbd0nu.fsf@gitster.siamese.dyndns.org>
 <18377.2084.30531.202087@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMWr-0007Is-8m
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYCAHwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbYCAHwR
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:52:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYCAHwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:52:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 883CF2A9C;
	Sat,  1 Mar 2008 02:52:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A1D2A2A9B; Sat,  1 Mar 2008 02:52:09 -0500 (EST)
In-Reply-To: <18377.2084.30531.202087@cargo.ozlabs.ibm.com> (Paul Mackerras's
 message of "Sat, 1 Mar 2008 18:39:16 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75637>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> Try it on user inputs like "master..next", "next...master".  You
>> wanted to grab only the positive ones, no?
>
> No... gitk passes the IDs it gets from git rev-parse (both positive
> and negative) to git log, rather than the original arguments.

I am not sure if I was answering the right question, then.

I thought the issue you were addressing was this.

 (1) the user says "gitk master...next" to start you.

 (2) you run "git log master...next" (or whatever the equivalent of what
     the user gave you) and draw.

 (3) the user does things outside your control to modify refs, and says
     "Update".

 (4) you could re-run "git log master...next" again, but that would show
     mostly what you already know.

     If you saved all the positive ones you used in (2), you could instead
     run "git log master...next --not <positives in 2>" to ask only the
     incremental changes (as long as the branches do not rewind, but you
     do not discard nodes from the already drawn graph anyway).

     <positives in 2> in this example sequence would be the object names
     for master and next when (2) was run.

I think your "gitk passes the IDs" part is about the master...next part in
the above example.  I do not think it really matters if they are converted
to object names or kept symbolic when given to "git log".  I was talking
about the part you add after --not in the second round, and that was why
my answer was only about positive ones.

Come to think of it, when you are told to "Update", you already know the
positive tips you can use to optimize (4), don't you?  They are the
commits you drew in (3) that do not have children.
