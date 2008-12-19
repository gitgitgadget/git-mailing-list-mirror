From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 11:18:17 -0600
Message-ID: <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
	 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
	 <alpine.DEB.1.00.0812170003540.14632@racer>
	 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com>
	 <alpine.DEB.1.00.0812170420560.14632@racer>
	 <20081217101110.GC18265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDj0l-0005F3-Fb
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 18:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYLSRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 12:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYLSRSV
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 12:18:21 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:22811 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYLSRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 12:18:20 -0500
Received: by rn-out-0910.google.com with SMTP id k40so807203rnd.17
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 09:18:17 -0800 (PST)
Received: by 10.150.205.20 with SMTP id c20mr966692ybg.191.1229707097388;
        Fri, 19 Dec 2008 09:18:17 -0800 (PST)
Received: by 10.151.135.7 with HTTP; Fri, 19 Dec 2008 09:18:17 -0800 (PST)
In-Reply-To: <20081217101110.GC18265@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103570>

On Wed, Dec 17, 2008 at 4:11 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 17, 2008 at 04:43:57AM +0100, Johannes Schindelin wrote:
>
>> > I agree, I haven't thought of any fix along these lines other than to
>> > make gc do the clean up.
>>
>> I have, and IIRC I briefly mentioned it back then.  Basically, you will
>> have to add a "git notes gc" or some such, which basically reads in the
>> whole notes, traverses all reachable commits, marking the corresponding
>> notes, and then writes out all marked notes (leaving the other notes
>> behind).
>
> I was thinking something similar, but I think it is even easier. Make
> the rule "if we still have the object, then we still have the note".
> That has three benefits:
>
>  - implementation is simple: for each note $n, delete it unless
>   has_sha1_file($n).
>
>  - it handles notes on non-commit objects
>
>  - it kills off notes when an object is _pruned_, not when it stops
>   being _reachable_. So if I delete a branch with a commit found
>   nowhere else, its notes will hang around until it is actually pruned.
>   If I pull it from lost+found, I still keep the notes.
>
> Note that all of this garbage collection of notes is really just
> removing them from the most current notes _tree_. If the notes structure
> is actually composed of commits, then old notes that are "deleted" will
> still be available historically.
>

This is my concern with keeping a history of the notes pseudo-branch. Let
us say that I do the following

1) on branch A commit a
2) add note a`
3) on branch B commit b
4) add note b`
5) on branch B commit c
6) add note c`
7) delete branch A
8) gc after a time such that a is pruned

Now either I will always have  anote a`
