From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pretty: Pass graph width to pretty formatting for use in '%>|(N)'
Date: Tue, 22 Dec 2015 14:54:45 -0800
Message-ID: <xmqqbn9iccwa.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
	<1442013913-2970-1-git-send-email-josef@kufner.cz>
	<xmqqa8sfa7di.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C8DCi_pZDd=m1hE70t7Z+MX3j6WcMe-Hp-u0y5VvwKqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josef Kufner <josef@kufner.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elliott Cable <me@ell.io>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 23:54:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBVpU-0004b8-Es
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 23:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbbLVWys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 17:54:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753794AbbLVWyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 17:54:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B05E37E72;
	Tue, 22 Dec 2015 17:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gI01u0JJYkuHIDZZmMEyCIuiJyM=; b=r/8ScH
	iyXmZvDvTDPdX1i+gd0vM6yUUNaEpfGJsRgrjNBzACiKq4m7/sHcercYgTMQaz/+
	SlBdn1DlKBOA7+NlEL8h3nRVmEmWeVm0mcqIdyCyXms0Ambtw0uxxud/kzNmaHLv
	qsLqqClzeB4LprNQhvm7rnke2I4pJu9w37n/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rI5wwlFcshq2dwk1nwiBh824oSC0ttGr
	Uggo3ClOgifmM0cnONwlvNJcn3fwwiMA+jYemalPT4VI1ELfnsjk6tV+etSEh1Ue
	dSdq0OahfCK3UdfOOF67REHedFxSTbr+1wB6eQzPWk/v7mnSa1N889iWc7gha9ap
	CGjooA7XeN8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2308737E71;
	Tue, 22 Dec 2015 17:54:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9836637E70;
	Tue, 22 Dec 2015 17:54:46 -0500 (EST)
In-Reply-To: <CACsJy8C8DCi_pZDd=m1hE70t7Z+MX3j6WcMe-Hp-u0y5VvwKqg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 23 Dec 2015 00:03:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF89849A-A8FE-11E5-BB54-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282914>

Duy Nguyen <pclouds@gmail.com> writes:

> (I'm joining the newer thread [1] back to this one, thanks for
> reminding me about this)
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/282771
>
> On Tue, Sep 22, 2015 at 2:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Josef Kufner <josef@kufner.cz> writes:
>>
>>> Pass graph width to pretty formatting, so N in '%>|(N)' includes columns
>>> consumed by graph rendered when --graph option is in use.
>>>
>>> Example:
>>>   git log --all --graph --pretty='format: [%>|(20)%h] %ar%d'
>>>
>>>   All commit hashes should be aligned at 20th column from edge of the
>>>   terminal, not from the edge of the graph.
>>>
>>> Signed-off-by: Josef Kufner <josef@kufner.cz>
>>> ---
>>
>> [CC'ed Duy for ideas, as the "%>|(ALIGN)" thing is his invention]
>> ...
>>
>> I have a suspicion that 50% of the users would appreciate this
>> change, and the remainder of the users see this break their
>> expectation.  To avoid such a regression, we may be better off if we
>> introduced a new alignment operator that is different from '%>|(N)'
>> so that this new behaviour is available to those who want to use it,
>> without negatively affecting existing uses.
>
> I tend to agree with Josef. >|(N) is about columns relative to the
> left edge of the screen. You can already use >(N) to be relative to
> the left edge of the space given to the commit.

OK.  I didn't check if >(N) with that old patch still behaves that
way, but if that is sensible, then it is not breaking anything, so
it may be a good idea to salvage it.  I dunno.
