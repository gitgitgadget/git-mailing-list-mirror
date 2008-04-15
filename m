From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 15:56:00 -0700
Message-ID: <7vod8awwvz.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
 <7vej97x78v.fsf@gitster.siamese.dyndns.org>
 <20080415191930.GC31395@sigill.intra.peff.net>
 <20080415223716.GA1891@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Russ Dill <russ.dill@gmail.com>,
	Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:57:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlu5F-0003ir-Ix
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 00:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYDOW4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 18:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbYDOW4Q
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 18:56:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbYDOW4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 18:56:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDEAF2383;
	Tue, 15 Apr 2008 18:56:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AFC652381; Tue, 15 Apr 2008 18:56:07 -0400 (EDT)
In-Reply-To: <20080415223716.GA1891@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Apr 2008 18:37:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79639>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 15, 2008 at 03:19:30PM -0400, Jeff King wrote:
>
>> > Not complicated at all.  Put that description in-tree in a known location
>> > (say, "help-branch") in-tree and your propagation problem is solved.
>> >
>> > And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.
>> 
>> It is perhaps a little slow if you want to do things like adding the
>> help text to branch name decorations in log output. Maybe instead of a
>> flat file, you could parallel the ref name hierarchy in a tree? I.e.,
>
> It occurred to me that you actually meant "just stick it in a file in
> your actual work tree", not on a separate branch (for some reason,
> reading the name "help-branch" made me think you meant a ref).
>
> So that is obviously the very simple solution. But for fun, and because
> maybe somebody could learn something, here is a script implementing my
> approach. I dunno if it is worth including in contrib.

Another independent approach I was very tempted to suggest was to mimick
how "What's cooking" has been maintained over time (in other words, what I
describe here is a toolset that has proven to be viable and useful, backed
by the real world experience ;-).

All the tools I use for this are stored in my 'todo' branch, and I have a
checkout of the 'todo' branch in Meta/ subdirectory.

The core workhorse of this toolset is "Meta/topic.perl" script.  It lists
topic branches, and shows the list of commits on each branch that are
still not integrated in the final integration branch.  The script has a
built-in assumption of how the topic branches are named, and what
integration branches there are (namely, 'master', 'next' and 'pu'), but it
should not be too hard if somebody wants to generalize it to have more
than two "still cooking" stages and how they are named.

The' topic' script is called by "Meta/WC" script (obviously, that stands
for "What's Cooking") that applies a slight formatting of its output.
There isn't much to see in this intermediate script.

When I send out a new edition of "What's cooking", I feed the previous
edition of the message to "Meta/UWC" ("Update What's Cooking") script.

This script:

 - reads the old edition from its standard input, to remember the commits
   and explanatory text associated with each topic in the previous round;

 - reads from the "Meta/WC" output to learn the commits that currently
   reside in each topic;

 - compares the above two, insert new branches into "[New topics]"
   section, and mark the changed topics.

 - outputs the new edition to the standard output.

Then I can add descriptions for new topics, edit them for the ones whose
status have changed.

I do not personally keep any temporary or in-tree copies, because I happen
to do all the above in my MUA edit buffer.  But if I wanted to, I could
use one in-tree file dedicated for it and track it as part of the
contents.
