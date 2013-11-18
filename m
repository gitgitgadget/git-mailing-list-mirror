From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Mon, 18 Nov 2013 08:24:34 -0800
Message-ID: <xmqq4n79d6f1.fsf@gitster.dls.corp.google.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
	<1384335406-16332-4-git-send-email-artagnon@gmail.com>
	<xmqqbo1odqb4.fsf@gitster.dls.corp.google.com>
	<xmqq38n0dpgy.fsf@gitster.dls.corp.google.com>
	<CALkWK0k4MudojZt4PkLjnq0uZe322n30WP-=N0ckLw2QcnbzMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViRdC-00070n-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab3KRQYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 11:24:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab3KRQYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 11:24:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F12452D30;
	Mon, 18 Nov 2013 11:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nDBNWKbrMKcfNJdmNh9oeDjZx7U=; b=jcGFbg
	AySJBRJGu+3eAhO9P5KQ54mM91TptkEv5vqbP+nVpiWbiI3LZ73TzlpatStXFyFx
	ABiUGNDI8dmGHyCZl4afn41ACqkvKJI0gNhQG7RAHC6C88IwhWlN95sF7PePS13w
	krsYb+SkGimLrYBLFBNLW+HqDzyzkEPsH/6Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0UpdRyGD6ItLuieB213juLLE7J6m16B
	3DRZ4MHPp5083sxwJ6RaEbmbmcItpayHPGuwMijXP5fEixS5hrFqruwlwh/KCxYe
	i7WXK/x4ROv0FitzUbwkn2fqCwxuqGYtbRFylKaiKK21oexB/tGujWxSkwChBm91
	17x4DJGsRfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FF2C52D2F;
	Mon, 18 Nov 2013 11:24:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EA0152D2D;
	Mon, 18 Nov 2013 11:24:36 -0500 (EST)
In-Reply-To: <CALkWK0k4MudojZt4PkLjnq0uZe322n30WP-=N0ckLw2QcnbzMA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 14 Nov 2013 12:33:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA4F4C86-506D-11E3-B55C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237988>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Perhaps like this (obviously not tested as these three patches did
>> not add any tests ;-)
>
> Sorry about that. I didn't notice t6300-for-each-ref.sh. Will fix in
> the next round.
>
>> I also think that there should be a mechanism to do "color:reset"
>> after each record is issued automatically, and also have the color
>> output honor --color=auto from the command line, i.e.
>>
>>         git for-each-ref --color=auto --format='%(color:blue)%(subject)' | cat
>>
>> should turn the coloring off.
>
> We can add --color=auto later, but I'm wondering about auto-reset
> color after each token. What happens if I do:
>
>   $ git for-each-ref --format='%(subject)%(color:blue)'
>
> No color, right? So, it should be auto-reset color after each token
> _and_ at end of format-string.

If you are saying, by after each token, that

	--format='%(color:blue)%(A)literal string%(B)'

should result in

	<color blue> <value for A> <color reset> "literal string" <value for B>

then I would disagree.  I was suggesting it to instead produce

	<color blue> <value for A> "literal string" <value for B> <color reset>

where the <color reset> always comes when some color is used and we
hit the end of the format string. A bonus point if we can make it so
that we emit the final reset only when the last "%(color:some)" is
not "%(color:reset)", but unconditional "reset if we ever used
color" is fine.

Thanks.
