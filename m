From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: respect add.updateroot config option
Date: Wed, 13 Mar 2013 08:51:08 -0700
Message-ID: <7vmwu747tf.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <vpqr4jjd5wp.fsf@grenoble-inp.fr>
 <20130313092754.GA12658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 13 16:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFnxq-0006Lw-Ro
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 16:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188Ab3CMPvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 11:51:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656Ab3CMPvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 11:51:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97716A3D4;
	Wed, 13 Mar 2013 11:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WGzGzJ9/OLlkkY/1nhEskxWp9Z4=; b=wAbQiz
	X/cdQyQNdfjT9EhtTZeywZIqQsVRJHl2V4rrEQOvz9E2UMK2AT4hAvBIJ9BuMjLN
	x8TbWHdqatqC+s6udjQBn99thJPLorMRkCXlt9N+n4xCNfGlfLqbL3DWy82rPFgL
	tU7cOQwHw8q+0pZUrJnQuhiekIKJgWI3IGphs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KnzOPVIHqo2ceKVQ7YOhVKWJbaYt56O/
	OmlRb5QjoCcXve0tFy7LtRhQfQNiuHCqq6BZ3vk/Dq2LIitZAhrkgyR0epvxn2+a
	psjChl/ehdVzXbUwJyvSYGiAdNesaq8cQSXDTPvTBrh5I4DNpriIa+w1YA+WP+Ft
	aF10CnNhyjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA33A3D3;
	Wed, 13 Mar 2013 11:51:10 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E53BAA3CF; Wed, 13 Mar 2013
 11:51:09 -0400 (EDT)
In-Reply-To: <20130313092754.GA12658@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 13 Mar 2013 05:27:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D31A67C2-8BF5-11E2-93FA-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218060>

Jeff King <peff@peff.net> writes:

>> Your patch doesn't advertise the option in the warning message, which I
>> think is good. You may mention it the commit message that this is a
>> deliberate choice.
>
> Yes, it was deliberate. I can add a note.
>
>> > +add.updateroot::
>> 
>> Detail: option names are normally camelCased => updateRoot.
>
> Good point, thanks.
>
>> I think the option name needs a bit more thinking. Without reading the
>> doc,
>> 
>> [add]
>> 	updateRoot = false
>> 
>> would be a very tempting thing to try. Perhaps explicitly warning when
>> add.updateroot is set to false would avoid possible confusion.

This is essentially the same as Matthieu's add.use2dot0Behavior but
with that "it is an error to explicitly set it to false" twist, it
alleviates one of the worries. It still has the same "the user saw
it mentioned on stackoverflow and sets it without understanding that
the behaviour is getting changed" effect.

Also it won't give chance for scripts to get fixed, even though I
suspect that instances of "add -u/-A" without pathspec end users
write in their custom scripts almost always would want to be
tree-wide and it is a bug that they do not pass ":/" to them.

The "future.*" (I'd rather call that "migration.*") approach with
the "never set it to false" twist is probably OK from the "complaint
avoidance" perspective.  The user cannot later complain "I tried to
squelch the advice but at the same time I ended up adding updated
contents outside my diretory", without getting told "That is the
documented behaviour, isn't it?"  But I still think it is much less
nice from "avoid hurting the users" perspective.  If the way to
squelch the user learns were to say "git add -u .", where the user
explicitly says "take the updated contents from this directory and
below", there is no room for confusion.  We won't hear complaints
either way, but with the "future.*" the reason why we won't hear
complaints is because the users do not have excuse to complain.
With the "require explicit .", it is because the users won't get
hurt in the first place.

> I dunno. I am not all that excited about this patch, due to all of the
> caveats that we need to communicate to the user. The current warning has
> annoyed me a few times, but perhaps it is still too soon, and my fingers
> and brain just need retraining. I think a config option could help some
> people, but maybe it will end up hurting more.  I'm inclined at this
> point to table the patch for now and see how I feel in a few weeks.
>
> I do think patch 1/2 makes sense regardless.

These two concluding paragraphs match my current thinking.

Thanks.
