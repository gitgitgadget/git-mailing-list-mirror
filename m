From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 15:26:25 -0700
Message-ID: <7v7grw2qcu.fsf@alter.siamese.dyndns.org>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Mestnik\, Michael J - Eagan\, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCeLO-0004mR-TU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 00:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760129Ab2INW0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 18:26:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760125Ab2INW02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 18:26:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5485B996C;
	Fri, 14 Sep 2012 18:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zvws+mzHcoASHvWTc0QJMHW6UUw=; b=xM7QID
	y8uKLc4LB1M7h8es//MHwsEwVD2rA5ym9aEK5srP5P4sNuXsllNoqYCLLn3dy8ES
	zvGXDGkYT2hTKo1GGIPwlO1aMKWm2GG/V69W9dNE17dXZsiLFNlpIDhxCAaEsbZZ
	SCjABjJD2cgl8A6sl8nlxHjhwOMazH1tWGYUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ljhWLkFUkIvAI6MEk6CfhspUvXiz+dSl
	oxwcRZJCaM4CgOclasJ8LbAJOuboAKhxX8ZHoVT/6rOWZp1E5ezhu807oTttBMqv
	dAOtwaJGZYQuNkwfNSkMmEsfbxK+vgzo2wFaH6L4YK3oHnMx63HqxhGpb05OqOgX
	Uhd8P1jiOsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41663996B;
	Fri, 14 Sep 2012 18:26:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A6A2996A; Fri, 14 Sep 2012
 18:26:26 -0400 (EDT)
In-Reply-To: <7vfw6k2t8w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 14 Sep 2012 14:23:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38FF3AE0-FEBB-11E1-AB92-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205538>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> you need to "rm file && git checkout file"). If the user has to update
>> $Id$ to match the current sha1
>> (by remembering to do a more forceful checkout than checkout -f) then
>> one half of that feature is useless. 
>
> As if there is any value in "$Id$" _feature_.  It's a checkbox item,
> nothing more ;-).

Having said that, I think you could do something along this line (I
am thinking aloud, so there may be leaps in the logic below).

 * Introduce a new on-disk flag in the index.  Call it X.  After
   entry.c:write_entry() writes it out to the working tree, this
   flag is cleared.  And this codepath is the only place that clears
   this flag.

 * When applying a clean filter (from here on, everything that
   breaks byte-for-byte identity between the copy on the working
   tree and the contents that is hashed and stored in the object
   store are considered "clean filter", including CRLF->LF and
   ident), internally apply the corresponding smudge filter to the
   cleaned result and compare it with the original input we obtained
   from the working tree.  If they differ, flip the X bit on for the
   path in the index.

 * When "checkout" and any potential callers of write_entry() decide
   whether it is worth calling write_entry() [*1*], consider any
   path with the X bit on as "dirty" and call write_entry().

You have to be very careful when designing the third point, though.
There will now be two kinds of "the working tree file is different
from the version registerd in the index" once you do the above.
Different only because of "clean->smudge" roundtrip comparison, and
different because it does have a real local modification.  The
former must be considered "no local modification" for the purpose of
merges and branch switching (otherwise you will get "cannot merge,
you have local modifications" error).


[Footnote]

*1* This currently is done primarily with ie_match_stat(), that 
essentially is "Does the result of applying 'clean' to the working
tree contents match what is registered to the index?  Do not bother
doing this check over and over again once you checked this until
the file in the working tree is modified again".
