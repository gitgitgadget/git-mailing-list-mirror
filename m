From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Splitting a project into branches afterwards
Date: Wed, 04 May 2016 01:38:32 -0700
Message-ID: <xmqqk2jai5fb.fsf@gitster.mtv.corp.google.com>
References: <loom.20160503T090745-628@post.gmane.org>
	<xmqqoa8mi64h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yohann =?utf-8?B?QsOpbsOpZGlj?= <yohann.benedic@orange.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsKR-0006e8-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757713AbcEDIii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 04:38:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757618AbcEDIig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 04:38:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA5111AAC;
	Wed,  4 May 2016 04:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fGB/f6ObEO+7
	djxzTsCrzfJDSbw=; b=TRiPcy9B+iwtndAyts3I3n95ewfvq0X6Dxem1D/o/wij
	gUx9JvsFWKIMFer/Ru398l3VOijvp6bF2OYs0ehT7pqwXmQ3NMjjWrBBduYselou
	XQbus+f8VuzcvUgybqAZyrJgflgf6V7wQrHYFKOlEoaAFhXmqTWaq7JFZCu79uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=naauz/
	vVtiCX/YO/WBJdR3A5Ggf9PLM50UPtYL3g7xfUq4bN9ZQvIxlQpR7stg+5YDNqXO
	+bFmJpVS5e1qvORfm3W6b6LY823ORxyLsg+d/8pwcZNWwAbl2E8G3p75+79yBbyy
	yWUHGpY+L2N2KYXMnKQ49mK8+r++bfasMhhgI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1508E11AA9;
	Wed,  4 May 2016 04:38:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A62211AA8;
	Wed,  4 May 2016 04:38:34 -0400 (EDT)
In-Reply-To: <xmqqoa8mi64h.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 01:23:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96ADEACC-11D3-11E6-BA98-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293520>

Junio C Hamano <gitster@pobox.com> writes:

> Yohann B=C3=A9n=C3=A9dic <yohann.benedic@orange.com> writes:
>
>> branch. If the framework branch moves forward, I want my product_A b=
ranch to=20
>> be able follow along : that's a merge of the framework from product_=
A. In=20
>> product_A, I might fix something from the framework and need to patc=
h the=20
>> latter. That's a merge in the other direction.
>
> Instead of doing a mixed ball of wax on product specific branch,
> can't you do the latter by (1) fix something that belongs to the
> framework part of the system on the framework branch, (2) merge that
> to product A branch, and then (3) use that fixed framework code to
> update the product A?  That way you would never have to merge
> product specific part to the framework, which is meant to be product
> agnistic (which is the whole point of your "initial removal" done on
> the framework branch, if I am reading you correctly).

In addition, I would imagine that you have this:

      F+B
     /
 ---X---F
     \
      F+A

where F stands for "framework part", A stands for "product A" and X
is F+A+B (i.e. everything).  The first thing I would do if that is
what you have is to abandon the product specific branches directly
forked from the "everything" and instead form a history of this
shape:

          F+B
         /
 ---X---F
         \
          F+A

That is, make the commit marked F in the updated history, whose tree
has only the framework part, the new "birth" of your company's
source code, where other product specific branches all fork off of.

Then touch the common framework only on its own branch, occasionally
merging that down to (all) product specific branches, change product
specific parts only on their own product specific branch, and merge
only in one direction (i.e. framework to product), never in reverse.

          F+B
         /
 ---X---F-----F'-----F''   ... framework evolves this way
         \            \   =20
          F+A---F+A'---F''+A'  ... product A evolves this way
