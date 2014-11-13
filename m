From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 13:10:17 -0800
Message-ID: <xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
	<20141113133615.GA28346@lanh> <20141113200640.GB3869@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1f3-0001Yr-GV
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934044AbaKMVKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:10:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933636AbaKMVKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:10:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 114411D4BD;
	Thu, 13 Nov 2014 16:10:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yDT3gT/J327FEvhEiKXVfDxfH6A=; b=FoQl4k
	YzRWz+bCIWKVoFRdc/nfSuN9Jmnb1zMGcKeESdmm71LoU0AJsJuI6Yh9TiEfkZzJ
	8b4dECn0pZ8Ad1nJqpM06GpCynMxLISZJiRCqTjp8IEqXcoV2an7SPVYNPcenzaT
	ms55MO/x4lsEw7sjPKxiNTGvVnYidlHy8TiR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkgdfC56OyLmFNa76t22ITRjTI0CzFuo
	R+J9y1242tfsHQaGwG6b5uO0rFOMfXrsm+vit7vaB/OUUhwGeP6e6O7sALPhg3MK
	BMnPh2uYSLSjOFf0V7/owuvSSm83ti1dr6gA7qo/KVUSPY2xKaY6SoiZNssIdqEn
	DlMiOSSWN9k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06D7F1D4BC;
	Thu, 13 Nov 2014 16:10:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B59191D4B0;
	Thu, 13 Nov 2014 16:10:18 -0500 (EST)
In-Reply-To: <20141113200640.GB3869@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 15:06:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78A9624C-6B79-11E4-9293-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 08:36:16PM +0700, Duy Nguyen wrote:
>
>> On Thu, Nov 13, 2014 at 12:32:40PM +0000, Graeme Geldenhuys wrote:
>> > [alias]
>> >     deploy = !sh -c 'git archive --prefix=$1/ -o deploy_$1.zip HEAD 
>> > $(git diff --name-only -D $2)' -
>> > 
>> > This works very well. The only problem we have so far is that if we 
>> > have files with spaces in the name (eg: SQL update scripts), then the 
>> > command breaks.
>> > 
>> > Does anybody have an idea on how this can be resolved?  Any help would 
>> > be much appreciated.
>> 
>> I wonder if it's overkill to do something like this patch ("git
>> archive" may need some more updates for it to work though). With it
>> you can do:
>> 
>>   git diff --name-only ... | git archive ... HEAD -- ":(file)-"
>> 
>> The good thing is it works for other commands as well. But is it
>> really a good thing..
>
> I like the idea of taking paths from stdin (and especially if there is a
> "-z" option). But using a pathspec that reads from stdin seems like it
> creates a lot of corner cases. What would:
>
>   git rev-list --stdin -- ":(file)-"
>
> do? It is kind of neat that you could read from multiple files (besides
> stdin), but I'm not sure it is all that useful in practice (you can
> always cat them to its stdin).
>
> How about just adding --stdin, which matches other git commands?

How about doing nothing and use the correct $IFS instead?
