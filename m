From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Mon, 04 May 2015 15:29:32 -0700
Message-ID: <xmqq8ud4ou2b.fsf@gitster.dls.corp.google.com>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
	<CAPig+cSuCouNCuKa99mct4UMPykuMVy3+7sqB6y+v+UtP2oeTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpOrs-0005JJ-7q
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbbEDW3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:29:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbbEDW3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:29:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B796D4EFBA;
	Mon,  4 May 2015 18:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hEb/3rHZ22M+SiuwN5MYo/1Udvk=; b=Re2grR
	CBjRNujB80sNqsAeN3Z6gRF0fqXtmCsprXGW3o/Fn4EXPRVLx9WLnV3FsVz0GU7Q
	YpyaqWTc/vv5/m0DMAP2Tet/dsnD7wmCt/iAtd4vxa46un3lM6usegyTH5yJx4VK
	M8hBk11YW11NjFxarehFJLasY1ZhFtq/TIrs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vn+MMnbr3l7z+/ZVlgLjwCCnw32GM8p5
	I4Yx7/dbV3PcPM7ATdz6lrIl4/P1wbrnPGwgArrzapkN0xzXUFvWWQJgZ8KnTNyN
	CABddVAHng3ZZVOHrDQM7OEmXAJBNcztGDrhga1R9ijA9o251cv0bko8WEIKxseo
	aG167+Y6Nx4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF71B4EFA9;
	Mon,  4 May 2015 18:29:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E7BF4EFA6;
	Mon,  4 May 2015 18:29:33 -0400 (EDT)
In-Reply-To: <CAPig+cSuCouNCuKa99mct4UMPykuMVy3+7sqB6y+v+UtP2oeTw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 May 2015 16:19:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09961C86-F2AD-11E4-8389-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268366>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 4, 2015 at 3:11 PM, Stefan Beller <sbeller@google.com> wrote:
>> prefix_path(): Unconditionally free result of prefix_path
>
> Slightly redundant mention of "prefix_path". Also, prevailing custom
> is to drop capitalization.
>
>> prefix_path() always returns a newly allocated string since
>> d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
>> 2008-01-28)
>
> I'd probably turn this sentence fragment into a proper sentence:
>
>     As of d089eba (...), prefix_path() always returns a newly
>     allocated string, so free its result unconditionally.
>
>> Additionally the const is dropped from the pointers, so the call to
>> free doesn't need a cast.
>
> Imperative mood:
>
>     Additionally, drop the const from variables to which the
>     prefix_path() result is assigned so they can be free()'d
>     without having to cast-away constness.
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     Thanks for all the suggestions!
>>     They are incorporated into this version of the patch.
>
> Thanks, this version looks much better.
>
> FWIW, with or without addressing the very minor nits above:
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks, both.

To save a round-trip, I'll munge the log message myself stealing
Eric's suggestions.
