From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces unexpected result
Date: Fri, 15 Jan 2016 10:52:42 -0800
Message-ID: <xmqqfuxyisjp.fsf@gitster.mtv.corp.google.com>
References: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
	<CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
	<xmqqy4cf9ugm.fsf@gitster.mtv.corp.google.com>
	<20160102234923.GA14424@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Harper <timcharper@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jack Nagel <jacknagel@gmail.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:52:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK9UP-0005Yb-9B
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcAOSwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:52:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbcAOSwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:52:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA9C53A721;
	Fri, 15 Jan 2016 13:52:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FuvCJPa7cwCFNzzD7DfHXULzsEY=; b=G1MjCR
	lkXcL6EjNlI/8NL0Ae0Slr4E1WBuJrpR9KmmLQGMQlDeIquxRG+hkdZRDtRmkhWr
	ENVyKXwe4Kz+NrVD6UxY6e1Mf27S1ufe4eywgZBCQcPaaNTY22qEMNvsq42NuqdU
	M811A+hmyND+E+6FN3064wgOmi95QY7yZKtHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eXgEatGEoVBCVW4feDQUJoCEmvUpjcYb
	PYvSfCcP2q3rD9ogNG06ex53YRQIGoaUb/TrC8dEL6rESX3aijvuIbdQtyBpBJwT
	Wbut3Lg/1hQk1Pos9LildeAtvDjbheH9bw9Zk5/Uq7gxGjcOW/4pIWTk/j1iU/cV
	tbjIWHDVBYQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D111C3A720;
	Fri, 15 Jan 2016 13:52:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 481883A71F;
	Fri, 15 Jan 2016 13:52:43 -0500 (EST)
In-Reply-To: <20160102234923.GA14424@gmail.com> (David Aguilar's message of
	"Sat, 2 Jan 2016 15:49:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28D586C4-BBB9-11E5-BB69-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284198>

David Aguilar <davvid@gmail.com> writes:

> I think the best long-term solution would be to abandon the
> CommonCrypto backend, if possible.  There's not a strong reason
> for its existence.  It always seemed kinda hacky, and bolted-on.
> ...
>> A few questions we should be asking Apple users are:
>> 
>>  - Is there a strong-enough reason why those who do not want to use
>>    SSL should be able to choose the SHA-1 implementation available
>>    from CommonCrypto over block-sha1?
>
> IMO, no.
>
>>  - Is CommonCrypto SHA-1 a better implementation than block-sha1?
>
> I do not believe this to be true.
>
> My gut feeling is that we cannot rely on the long-term stability
> and availability of Apple's APIs.  Block-sha1 works fine on
> the current Apple hardware and I suspect that it (or openssl)
> will continue to work fine in the future.
> ...
>> If people do not care, we can leave things as they are.  It would
>> seem mysterious to use block-sha1 when we are not using CommonCrypto
>> for SSL (i.e. NO_OPENSSL), and otherwise CommonCrypto SHA-1, and
>> would invite a puzzlement we saw in this thread, though.
>
> I'm curious to see what others think about dropping CommonCrypto.
> It seems like a good choice from a maintenance POV.

Judging by a week-long silence, it seems nobody seems to have much
to say on this issue.  Let me summon the git_osx_installer
maintainer to hear from somebody who know a lot better than me about
things around OS X.

Thanks.
