From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 01:36:26 -0700
Message-ID: <7v4pig2j91.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1zt-00056m-Ii
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbXHaIgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbXHaIgb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:36:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbXHaIga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:36:30 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E195B129EB4;
	Fri, 31 Aug 2007 04:36:49 -0400 (EDT)
In-Reply-To: <20070831081517.GB17637@mellanox.co.il> (Michael S. Tsirkin's
	message of "Fri, 31 Aug 2007 11:15:17 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57135>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Junio C Hamano <gitster@pobox.com>:
>> Subject: Re: [PATCH] fix parallel make problem
>> 
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>> 
>> >> +.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
>> >> +
>> >>  test-%$X: test-%.o $(GITLIBS)
>> >>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>> >
>> > Add a comment here?
>> 
>> I did not see a particular need for that.  What would you say
>> there?
>
> That it's a work-around for make bug.

I would agree it is a make bug to barf like what we saw.  Even
though we allowed it to treat test-%.o files as intermediate
products and allowed them to be removed, it is not a good excuse
for make to forget rebuilding them.

But I also happen to think not marking test-%.o as precious was
a bug on our side.  We would want to keep the build by-product
to avoid recompilation, don't we?  And this additional line is
primarily about fixing that bug, which works the bug around as a
side effect.

> So how did this end up in your mail?

Because it is not a format-patch output.

I often run "git diff --stat -p HEAD" from inside MUA in order
to get the patch from my work tree, write a proposed commit
message, and then reset the change away without committing after
sending that message (yes I do not need "git stash" --- gmane
and vger are my stashes, Mwhhhaaaa).
