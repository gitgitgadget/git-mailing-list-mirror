From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/2] http: support sending custom HTTP headers
Date: Thu, 05 May 2016 12:40:58 -0700
Message-ID: <xmqq37pwb8dx.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<ff7edf51fe8baf57f6f4cab170602154e5b1e73e.1462342213.git.johannes.schindelin@gmx.de>
	<67F2E414-657C-4C6C-9746-9B3026737C66@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:41:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayP92-0008PA-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228AbcEETlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:41:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755496AbcEETlB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:41:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40A6F195F9;
	Thu,  5 May 2016 15:41:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=595rJ/2CeNPjBRp9z1F/sIW5PsE=; b=qjnp3b
	BKuujHaqIjxrWM16k58Ij3yS+p40wpLNnDdrjpesd5X+DsQv9kdk0aSFcTu+Nqo0
	2D7RVT0y6jaZEVJeNjQHe465DhM+naXApHRM0cYYnifZJZtlTRtmDWkAx6r0e1M3
	S3NTlP4LRtLg7SD1CrX/VL9carTeZiRYZy0pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H877MK4f2SgOr0VTC8CRN4LaSHzAJRNW
	hfvkUNQH9KFOppmjwXRdtIlCn56LIUwESdm+ycIj5pCaLbfo4QHg7piLLLzL39V0
	nyQVkqpOMMbobPWrmd2s6E9bRTr9nkHRCOQ6aKXnidgf6QF/afQQNwfmKBwgVRTC
	DKtBXmRRPR0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37D69195F8;
	Thu,  5 May 2016 15:41:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA5A4195F7;
	Thu,  5 May 2016 15:40:59 -0400 (EDT)
In-Reply-To: <67F2E414-657C-4C6C-9746-9B3026737C66@gmail.com> (Lars
	Schneider's message of "Thu, 5 May 2016 21:10:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B13DD16-12F9-11E6-B8E5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293669>

Lars Schneider <larsxschneider@gmail.com> writes:

[administrivia: next time please snip the 224 lines you are not
responding to when commenting on only five lines].

>> +<LocationMatch /smart_headers/>
>> +	<RequireAll>
>> +		Require expr %{HTTP:x-magic-one} == 'abra'
>> +		Require expr %{HTTP:x-magic-two} == 'cadabra'
>> +	</RequireAll>
>
> I think "<RequireAll>" depends on mod_authz_core which is only
> available in Apache HTTPD 2.3 or later [1].
>
> Right now the test only checks if Apache version greater 2
> is installed. Should we guard this test with a special version
> check? Or do you see a way to check the magic values without
> "<RequireAll>"?
>
> I only noticed this because I enabled these tests on Travis-CI
> and the Travis Linux box comes with Apache 2.2.22 installed...
>
> - Lars
>
> [1] https://httpd.apache.org/docs/trunk/mod/mod_authz_core.html


2.2 is 12 years old, but the last update is last summer, which is
still fairly recent.  It would be really nice if we can accomodate
2.2.x series.

It is only test, so it probably is OK to skip it in the worst case,
but on the other hand, the point of having CI is so that we can
catch bugs that would manifest only in tests that normal people
would not run regularly, so...

Thanks. Real-world value of having Travis canary is seen here.
