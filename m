From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 11:06:44 -0700
Message-ID: <7v63nw9xor.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081012183855.GA5255@spearce.org>
 <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vhc7g9z7s.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131950140.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRqQ-000354-1x
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 20:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbYJMSHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 14:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbYJMSHX
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 14:07:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbYJMSHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 14:07:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AE8838867D;
	Mon, 13 Oct 2008 14:07:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CFFA988675; Mon, 13 Oct 2008 14:06:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810131950140.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 13 Oct 2008 19:54:02 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C759F3E4-9951-11DD-A434-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98136>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 13 Oct 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > - all the editors that this guy tested keep the hard links, so it was 
>> >   kinda hard to understand why Git insists on behaving differently,
>> >
>> > - if the user asked for hard links, it is not Git's place to question 
>> >   that decision,
>> 
>> These are non-arguments,
>
> Actually, they are arguments.
>
> The thing is: these editors do what they do for a reason.  Which is 
> exactly the second reason.
>
> When a user makes hard links, it is not just for fun and bullocks.  It is 
> not for copy-on-write either, that's not what hard links are supposed to 
> do.  It is for cases when you need the _same_ information in two places.
>
> I am not that big a user of hard links myself, but when I do, I know 
> exactly what I am doing.  And with my patch and that config variable set 
> to true, Git will not interfer with that.

Ok, such a possible benefit should be described and defended better then.
I only thought of the scenario Shawn has brought up, which is a downside
of using this option without any conceivable upside, when I read your
patch and your rationale you repeated in a few messages that followed.

You could have said something like "The users may want to have a checkout,
and keep the same contents always appear elsewhere i.e. 'installing by
hardlinking'.  In such a setup, editing the source with an editor
configured not to break hardlinks would still work fine, but git-checkout
will unconditionally break such links, which is undesirable.  Such a setup
would want a configuration variable like this."

"It is not for fun and bullocks" is not a description any clearer than
what you kept repeating, but if you stated it like the above, then I would
not have had trouble understanding what you wanted to say.

The documentation update needs to warn about the Shawn's scenario.  I also
do not know what this should do when you have two tracked paths with
identical contents hardlinked to each other.  Because we do not track
hardlinks, I _think_ breaking links would be the right thing to do for
such paths regardless of this configuration variable.

It also raises another question.  Don't you want this to be an attribute
for paths, not all-or-nothing configuration per repository?
