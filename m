From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 09/14] git-clean: use a git-add-interactive compatible UI
Date: Thu, 16 May 2013 12:39:47 -0700
Message-ID: <7vtxm24su4.fsf@alter.siamese.dyndns.org>
References: <cover.1368696028.git.worldhello.net@gmail.com>
	<9d73d532fb2d8372b971d607b9ddaa1af2b84ffd.1368696028.git.worldhello.net@gmail.com>
	<7vy5be4tbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 21:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud41q-0005GL-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 21:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab3EPTju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 15:39:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab3EPTju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 15:39:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B7A71F96E;
	Thu, 16 May 2013 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hLEQBR53PHYlWpcmsEJYjRSEWno=; b=Fx0ZGB
	FktIfR3qRfYDvgkx73olX3ertnZSCOg0vfT4YR7u6fOzlMrM+3g66yj8m/QBZfvV
	0dqt4dxwt8IuRmAf2muF2LUg2q8A1sjJKgE21ajRFPlH7eueERcSTZlgi/rj1sue
	y5tkTnmictNwk/9/9TwwAhFJx0GpPKmmLbTrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dGhE5ZtWU/0aNKHPgJV25oHT9PXYY3MB
	N+LTA6jixQtstjQ5cGyBD6gCouWWRRlVgmJu6gUGNGt/2YUHWtVIUWa56GRhnwBa
	yt1BF6jhcUxTmnlx1H9hPFj/R9w5ZBWLTuwEKjx9sazVxLphz7Kca3eyX8BWfvxi
	aPIo+zw4Pxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 713A31F96C;
	Thu, 16 May 2013 19:39:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D66DF1F96A;
	Thu, 16 May 2013 19:39:48 +0000 (UTC)
In-Reply-To: <7vy5be4tbf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 May 2013 12:29:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EA9D6FA-BE60-11E2-B2FF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224614>

Junio C Hamano <gitster@pobox.com> writes:

> Also please fix this one:
>
>> +		for_each_string_list_item(item, (struct string_list *)stuff->stuff) {
>> +			if ((*chosen)[i] < 0)
>> +				(*chosen)[i] = 0;
>> +			strbuf_addf(&menu, "%s%2d: %s", (*chosen)[i] ? "*" : " ", ++i, item->string);
>
> Because the evaluation order of function arguments are not defined
> (not left to right; these are comma-expressions),

I cannot spell, sorry.  s/are not defined/is not defined/.  Also
s/these are c/these are not c/;

>
> 	(*chosen)[i] ? "*" : " "
>
> may use the original value of "i", or value after increment the
> evaluation of
>
> 	++i
>
> left in "i".
