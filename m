From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Add "skip_unmerged" option to unpack_trees.
Date: Tue, 05 Feb 2008 15:44:11 -0800
Message-ID: <7vve536kac.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041335530.13593@iabervon.org>
	<alpine.LSU.1.00.0802050129570.8543@racer.site>
	<alpine.LNX.1.00.0802042127210.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYFl-00019u-2N
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761050AbYBFAee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760959AbYBFAed
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:33 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59228 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759848AbYBFAe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:27 -0500
X-Greylist: delayed 3043 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2008 19:34:27 EST
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 7DE0347E88A
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:48:04 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3BA16193C27;
	Tue,  5 Feb 2008 18:46:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4ED02193C97;
	Tue,  5 Feb 2008 18:44:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72727>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
>
>> Hi,
>> 
>> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
>> 
>> 
>> >  		if (any_files) {
>> > -			if (o->merge) {
>> > +			if (skip_entry) {
>> > +				do
>> > +					o->pos++;
>> > +				while (o->pos < active_nr &&
>> > +				       !strcmp(active_cache[o->pos]->name,
>> > +					       src[0]->name));
>> > +			} else if (o->merge) {
>> 
>> Maybe it is just me, but I would have thought
>> 
>> 				while (++o->pos < active_nr)
>> 					if (strcmp(active_cache[o->pos]->name,
>> 							src[0]->name))
>> 						break;
>> 
>> more readable.  But that's maybe because I have trouble with do ... while 
>> constructs logically (I like to see the loop condition first, then the 
>> loop body).
>
> I find yours less readable, because the loop condition is an exceptional 
> case (this is the last entry, so we run out of active_cache before finding 
> anything else), and you've got the actual effect of the loop in the 
> condition instead of the body, and I find using the value of ++x or x++ a 
> bit confusing outside of regular idioms. I'd go for:
>
> 				o->pos++;
> 				while (o->pos < active_nr &&
> 				       !strcmp(active_cache[o->pos]->name,
> 					       src[0]->name))
> 					o->pos++;
>
> if you care, though; it's not bad to make it clear we're skipping the 
> first of these entries based on a different consideration from the rest 
> (the first is the entry we decided to skip, and the rest are ones that 
> match it in filename).

The last one is vastly more readable than your original, and
moderately easier to follow than Dscho's, at least to me.

Thanks.
