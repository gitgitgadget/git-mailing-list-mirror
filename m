From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 02 Dec 2009 09:55:24 -0800
Message-ID: <7vaay1gt0z.fsf@alter.siamese.dyndns.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202171117.GY31763@genesis.frugalware.org>
 <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtQV-00015z-TL
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZLBRza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbZLBRz3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:55:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZLBRz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:55:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7F9842B4;
	Wed,  2 Dec 2009 12:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=koUoB0eWv8t7bUs7eW4C654gL9E=; b=YlEv2A
	Ed3QdIB56t0KEpwVq76HONVnfTVYHRZkssF/d+cMb5HjzdneHU9Jl9vUTC5DWlZQ
	x2Rwpb4qssYHvIejKuVmUbO7iVnvFnJi5c2eUIviVnFSMAmeOTHjbD/5CQpT6crg
	hrsZ/ZHxpAotkvTnr+CiMRnYAm+QMHV2BUpaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWgW5tXI3ZKkGfX0A2ur8K8V0ehCTosP
	Ble2Oq4k9CVyaeYEoAJSqtujrHI9UVrxirpcDbchuW2XNH4MQM+ikjiHyU3lMfVN
	xep8AJvGowj4QNjszI3q81F1D3Z8thnI4h7Y6xoWLjpYmPI2ipPrWdIFlaNgLIg3
	/Mk3tdP4uNE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B09A842B3;
	Wed,  2 Dec 2009 12:55:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F27D2842A6; Wed,  2 Dec
 2009 12:55:25 -0500 (EST)
In-Reply-To: <7vpr6xgtxn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 02 Dec 2009 09\:35\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E20CD222-DF6B-11DE-BE82-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134363>

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> ...
>> Is there any documentation describing what does parse_date() accept?
>>
>> Based on t0006-date.sh and the comments in the source, I see 3 supported
>> formats:
>>
>> 1) <unix timestamp> <timezone>
>>
>> 2) A format like 2008-12-02 18:04:00
>>
>> 3) RFC 2822 (Thu, 21 Dec 2000 16:01:07 +0200)
>
> The above are all supported (you can label 2 as ISO even though the
> official ISO8601 wants "T" instead of " " between date and time).
>
> For more amusing ones, see
>
>     http://article.gmane.org/gmane.comp.version-control.git/12241
>
> and follow the discussion there ;-)

I should have mentioned ones with more importance in real-life before
referring you to the amusing ones: US and European dates.

date.c::match_multi_number() groks these:

    mm/dd/yy[yy] (US)
    dd.mm.yy[yy] (European)
