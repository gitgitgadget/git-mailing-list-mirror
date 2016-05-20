From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/9] connect: call get_host_and_port() earlier
Date: Fri, 20 May 2016 15:20:23 -0700
Message-ID: <xmqqwpmobcd4.fsf@gitster.mtv.corp.google.com>
References: <20160517013554.22578-1-mh@glandium.org>
	<20160517013554.22578-2-mh@glandium.org>
	<xmqqfutccuq5.fsf@gitster.mtv.corp.google.com>
	<20160520221430.GA28273@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 21 00:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3smW-0006aA-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbcETWU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:20:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751455AbcETWU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:20:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A51F61E534;
	Fri, 20 May 2016 18:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+V+khDP/VE6fsmcYi5BESvK+ss=; b=t+RQ+b
	hWdVyjLbcrl1cQGxaCQRzsXgSdnpk//Tc+rSuWg1o+mdRAUc8Lkfrf5rCRMDk+JP
	f31Zw9HAyTHJ/eikEX06sfU1d8zHl5yiH/Zygnp/7IAr8GTrHB6kWpDsIxcVMNcx
	UWECL3bDUgf5kausXPDte6kaL51gtrfln2MBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=to3eeHVGF1Ur9mwif9WFBm+kBFKHQ+e4
	PQpQ9XUsYefxvqWCGkmMzrWg2AknuPKLqy/Z0jpU5N91K/L6PBrIphZaAzi7OhUT
	mL8WOkccunlHTVYbEIKnscSvqibkNPwqvvoTrg7pYVx3p7XvjK0oG17acd/K37P3
	WjDGrt04juI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 722F81E532;
	Fri, 20 May 2016 18:20:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E57381E530;
	Fri, 20 May 2016 18:20:24 -0400 (EDT)
In-Reply-To: <20160520221430.GA28273@glandium.org> (Mike Hommey's message of
	"Sat, 21 May 2016 07:14:30 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C99D054-1ED9-11E6-8ADE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295216>

Mike Hommey <mh@glandium.org> writes:

>> Can never happen because?
>> 
>>   !*port means get_host_and_port() made the "port" pointer point at
>>   a NUL byte.  That does not happen because the only case port is
>>   moved by that function is to have it point at a byte after we
>>   found ':', and the "port" string is a decimal integer whose value
>>   is between 0 and 65535, so there is no way port points at an empty
>>   string.
>> 
>> OK.
>
> Do you want me to add this to the commit message in a possible v7?

No.

I was merely thinking aloud to see if "in a case that never can
happen" is sufficient decsription.  I think it is ;-)

>> This looks strange....
> v3 of this series did remove this get_port(), and broke the
> '[host:port]:path' syntax as a consequence. The reason this happens is
> that get_host_and_port, in that case, is called with [host:port], sees
> the square brackets, and searches the port *after* the closing bracket,
> because the usual case where square brackets appear is ipv6 addresses,
> which contain colons, and the brackets in that case are used to separate
> the host and the port.
>
> In that case, get_host_and_port returns "host:port" and null.

Doesn't that indicate that this codepath deserves some in-code
comment?
