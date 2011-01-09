From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date
 incorrectly
Date: Sat, 08 Jan 2011 22:58:22 -0800
Message-ID: <7vaaja8sxd.fsf@alter.siamese.dyndns.org>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org>
 <7v62u043ba.fsf@alter.siamese.dyndns.org>
 <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org>
 <7vk4ig7y0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Jan 09 07:58:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbpEk-0002o1-9u
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 07:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab1AIG6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 01:58:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1AIG6b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 01:58:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F3B9456C;
	Sun,  9 Jan 2011 01:59:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CqHaumXMhFTuslN/CfT3f9tB8BE=; b=VwP0c0
	43RPUQwt2q5B5HuW3kaytPEVwRz5COwMm8B3jgavNGYBSutLgmchQxnTt+wkx1Bs
	FrDyqGBNZxglaYDKuC5248V9hkdxht5NZrJjV4MrgUgj+6EIUWi1FMDR+6boUhWR
	Dyh/gFWKcYb7O9YDoUTzwzyQnGEJ62z5yRLSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b3qiT9QtAFoI/+UJUJjQTtKlpsq2567U
	EOw2lrVA7b+xFhE/MkdEI962yAwK25OhhGHhYzuP5Sn23jy+1r7s/FTXqA5S/7va
	JD2VSliluQe1+osrTCjWYTee+gJn7wrIbOzUv+WlmTHAuhYXGBhM2pW4E/kP3/ip
	owfaZQzaWwA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CC46456B;
	Sun,  9 Jan 2011 01:59:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91C22456A; Sun,  9 Jan 2011
 01:59:03 -0500 (EST)
In-Reply-To: <7vk4ig7y0t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 07 Jan 2011 21\:41\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3327888-1BBD-11E0-BA48-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164844>

Junio C Hamano <gitster@pobox.com> writes:

> "git rev-list --no-walk ^HEAD~3 HEAD"?  Isn't it a nonsense?  If it is "no
> walk", then why do you even list a negative one?

The above was my thinko.

When you explicitly give range to no-walk, you override that no-walk with
"please walk".  This is primarily to help Linus who wanted to do "git show
HEAD~3..HEAD"---see how his thinking changed over time by comparing
aa27e461 and f222abde.

The right fix then would be to first always add in the order things were
given, and sort by date at the end after adding everything to queue and we
still have no_walk set, or something like that.
