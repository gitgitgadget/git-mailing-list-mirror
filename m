From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 19 Dec 2012 12:07:36 -0800
Message-ID: <7vvcbx956f.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
 <7vehinibpc.fsf@alter.siamese.dyndns.org>
 <87ip7yp4mf.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:08:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlPvp-0006T5-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 21:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab2LSUHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 15:07:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2LSUHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 15:07:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B7EA60C;
	Wed, 19 Dec 2012 15:07:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLvjuZP3hJ7gJ6s3SE+D8oohP58=; b=NFZAek
	r9ps/kDygU8ifwJv8zm63sP4jAUhp3IQqy3j+ACqYfwu1PIVlenLCaLUOLw9TyjH
	LNJc5SAUX2ZcepXXxK9xipiGa2Eooaqp5MqfwwuVnXypTqAYtyUAg+lzAn0c0Qo+
	IcrO9utxcFeg56WdmShaLULEGSIs5Hpb4TPmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3OPUfhsDBxKt2a068+LEEyniwmgVeqA
	zIjPMewop/uon3bn182kSLdJUIHr6N7AmnNE90Xa5EzqX+DlF+JZ/C7o2hgJK1PT
	FxZU6b0ZI6HFf/pycItVHjIvpX21xGutmk+NHgIAF2qsNjCC+Be5F3kEOwMdjwpO
	bE5ZONrUKKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23115A60B;
	Wed, 19 Dec 2012 15:07:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97543A60A; Wed, 19 Dec 2012
 15:07:37 -0500 (EST)
In-Reply-To: <87ip7yp4mf.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 19 Dec 2012 14:12:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC31B3E6-4A17-11E2-B8D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211844>

Thomas Rast <trast@student.ethz.ch> writes:

> I still wouldn't recommend this approach in git-replace(1) for several
> reasons:
>
> * It does not generalize in any direction.  For each field you may want
>   to change, you have to know a _specific_ way of getting just the
>   commit you want.
>
> * More to the point of replacing the parent lists, while the above might
>   be expected of a slightly advanced git user, you get into deep magic
>   the second you want to fake a merge commit with an arbitrary
>   combination of parents.  (No, you don't need to tell me how.  I'm just
>   saying that fooling with either MERGE_HEAD or read-tree is not for
>   mere mortals.)

I do not buy either of the above.  When you are replacing one with
something else, you ought to know what that something else is and
how to create it.  Editing a text file with an editor to replace
40-hex object names with another is not a more intuitive way for end
users, either (in other words, you are seeing this from the point of
view of somebody who *knows* the internal representation of Git
objects too much).

> * The above potentially introduces clock skew into the repository, which
>   can trigger bugs (like rev-list accidentally missing out on some side
>   arm!) until we get around to implementing and using generation
>   numbers.

That is an irrelevant point when comparing the "go down to bare
metal replacing the object representation" vs "use the usual Git
tools the end users are already familiar with" approaches.  You will
encounter the issue you are raising if you make a newer commit a
parent of an existing child with an older commit timestamp, no
matter how you do the grafting.
