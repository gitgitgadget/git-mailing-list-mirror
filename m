From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 19:03:39 -0800
Message-ID: <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 04:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxsdx-0006oc-PE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 04:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1CKDDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 22:03:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1CKDDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 22:03:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8448A4C6A;
	Thu, 10 Mar 2011 22:05:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xtwlOOWXEE/1qkUscDTprpG3BIs=; b=uvDiJH
	h5/vyxde+BLWkPb/ks43kyiKD6laIgPqBq//UlFqynySXEDUIv7MYHbP1W4aCrHX
	92HLzEF5h8XhId6UIW2H0qMivEsyTQwSmPYqYUpAAAd+Bup6NSrtgA/SGQZdaLrc
	nsdDbyv0/57NXUtfzb2LWJsQ5tGhqbpa0m4xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=czif/axcZ5x93SoqJDZRCu0Ry2oVCqR4
	YfWdTS7lGIexju4BwqTLupt0Wuq54+ddq1XekF83/gbPdoVuayiJGxMjK4XIk/Ip
	6KfuXqx3qHKLFgs22IxsygGU5ibS6qbYyQ1ChZgM1MRSTa76HJT5ruJVwB+oKIGi
	z0ct04CzS4g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 520304C69;
	Thu, 10 Mar 2011 22:05:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E74244C65; Thu, 10 Mar 2011
 22:05:10 -0500 (EST)
In-Reply-To: <7vmxl21lwr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 10 Mar 2011 17:33:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63C64CB6-4B8C-11E0-8783-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168879>

Junio C Hamano <gitster@pobox.com> writes:

> Hmph, why?
>
> That 979f79 one already have enough other objects with similar names, so
> compared to 83c3c that doesn't, it is natural that you would need more
> digits to protect its uniqueness, no?

Yuck, this is showing my total non-understanding of statistics and secure
hashing.  The example does not mean the next object we will create in
git.git project somehow magically is more likely to have 979 prefix than
83c prefix.  In other words, 979f7929 is much less likely to collide with
new objects than 83c3c, simply because it has 4 more digits in it (making
the likelyhood of collision with the next one by four orders of magnitude
in base-16), the likelyhood does not depend on what other objects happen
to share the same prefix right now, and adding one digits to each would
make it 1/16 less likely to have collision relative to the likelyhood with
their current length.

In any case, if we want to protect abbreviations we generate today from
future collisions, the only sane thing to do is to give sufficiently long
"len" that is computed globally by taking the total number of objects into
account.  We should consider the loop in find_unique_abbrev that makes
sure that prefix truncated to len is unique, and increments until the
result becomes unique, merely a last-ditch thing, not contributing to
futureproofing.  Even though adding 1 to make it minimally unique as we
have always did before the abbrevguard patch has the same "that 1 extra
has different effectiveness for protecting against future collisions,
depending on how long the base string is" issue, we cannot get away by
adding less than 1 character, and adding more doesn't make it better.

So let's scrap the abbrevguard thing.  I somehow thought that I already
took your "make DEFAULT_ABBREV tweakable" patch, but apparently I didn't.
That one is the real fix to the issue of futureproofing.
