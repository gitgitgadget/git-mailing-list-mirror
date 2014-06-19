From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising 'git-describe --all --match' behavior.
Date: Thu, 19 Jun 2014 14:50:38 -0700
Message-ID: <xmqq7g4cfu1d.fsf@gitster.dls.corp.google.com>
References: <87ionxxbz8.fsf@osv.gnss.ru>
	<xmqqr42khl3l.fsf@gitster.dls.corp.google.com>
	<87d2e4d8w7.fsf@osv.gnss.ru>
	<xmqq38f0hg0h.fsf@gitster.dls.corp.google.com>
	<8761jwd5gk.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxkEM-0005T5-92
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965735AbaFSVuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:50:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50548 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964833AbaFSVup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:50:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5CD1620AAA;
	Thu, 19 Jun 2014 17:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dc2TlOdlUi4BFCRBllDcvbO/Ris=; b=SHxCGC
	jz4wiQ/o2TC3ZD1jx1OjOj6pvO+/S/7ctMIiM8fJ5kNJMsia0K1J9D8ZV7n7SR5S
	/pF8TtqHWcx8he72x6XNYdVvo8ZmvWIIiljDzOjolFxQm5t+iEQbfLEr3bZ9mwn7
	COHelY1wg7L3PdrZVZdA1FmMZidzvQpx7pBTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rXkkEV1WjmTGQc+6Kq4en3vqp039+Lch
	MTXEzewQ3sVAKzORN4OQi1lfh290NLpEGbhh6D48yexUjvMcuPwWpSFYV8psv3EC
	d4yIoISoGlsYxuYjORGIecPiWCQ+G15sORADnej5NDSaaF1H+DtLCXgyV6upEiNl
	aIjNWm6SQoE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5214920AA9;
	Thu, 19 Jun 2014 17:50:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF1B920AA6;
	Thu, 19 Jun 2014 17:50:35 -0400 (EDT)
In-Reply-To: <8761jwd5gk.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	20 Jun 2014 00:12:11 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BEA4C2C4-F7FB-11E3-AF96-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252195>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergei Organov <osv@javad.com> writes:
>>
>>> Will something break if it won't helpfully prepend refs/tags/ once
>>> --all is given?
>>
>> "describe --all --match 'v*'" will no longer match a tag v1.2.3, and
>> forces the users to say "describe --match 'refs/tags/v*'",
>
> No,
>
> descirbe --match 'v*'
>
> or
>
> describe --tags --match 'v*'
>
> depending on what they actually meant. Notice my "once --all is given"
> above.  ...
> Those who used --all meant to match against all the refs, no?

I noticed it when I responded and ignored it as unworkable, because
it would make the interface inconsistent by making the meaning of
one option (i.e. --match) change depending on an unrelated option
(i.e. --all or --tags).

You can argue both ways: Those who read the doc and used --match
did mean to limit to tags.

The thing is, you cannot change it without risking to break existing
usage.  That does not necessarily mean you can never change
anything.  You only need to craft a careful transition plan to
minimize the pain for those who will be broken, and the end result
will be good if the pain is small enough and the benefit is large
enough ;)
