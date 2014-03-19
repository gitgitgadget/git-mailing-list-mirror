From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 12:41:31 -0700
Message-ID: <xmqqk3bq2cyc.fsf@gitster.dls.corp.google.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
	<1395226935-53044-1-git-send-email-modocache@gmail.com>
	<xmqqob123wjm.fsf@gitster.dls.corp.google.com>
	<20140319180213.GB11018@serenity.lan>
	<xmqqsiqe2es6.fsf@gitster.dls.corp.google.com>
	<20140319191217.GC11018@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Tim Chase <git@tim.thechases.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQMN8-0002HR-EC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbaCSTlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:41:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaCSTle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:41:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C43B2747A2;
	Wed, 19 Mar 2014 15:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7PVZlECy/YIxXNmToARYcnKugKo=; b=N5bYrW
	NZQChruvDa+gVMTHtPjZpIClmMmEjZKKuwketxKbl30URJjSi/tfsHF41ach5j8v
	n7+mqu8dGopwpGq0L85Ww0utuyaY/AD+X8ukq+n3OC1QqPCzw5vKdM8+uyRBWd/B
	zoixiudovA+yHOPrzi+YBibx3AMV2RV4qw2lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQqLAb0azcvo54T6FFkbh6Tcb2Vz+GIu
	FMGrJd/Hyv6cSn/88Z2qG/4wQhndsanPYmSByyRl6jdD2HwgEPuNRup+6Ya45PCH
	sXG1vzWOb+pxlVIXdy+zz+Z9gT8d8EOYDrsSoomsQxGvWl1WWv2FGaAXzOeRIKXG
	0av4dhuBGqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD750747A0;
	Wed, 19 Mar 2014 15:41:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B88927479A;
	Wed, 19 Mar 2014 15:41:32 -0400 (EDT)
In-Reply-To: <20140319191217.GC11018@serenity.lan> (John Keeping's message of
	"Wed, 19 Mar 2014 19:12:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7965B024-AF9E-11E3-81F5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244483>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Mar 19, 2014 at 12:02:01PM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > On Wed, Mar 19, 2014 at 10:53:01AM -0700, Junio C Hamano wrote:
>> >>    "rebase -" with your change still says something like this:
>> >> 
>> >>         First, rewinding head to replay your work on top of it...
>> >>         Fast-forwarded HEAD to @{-1}.
>> >> 
>> >>    instead of "Fast-forwarded HEAD to -".  Somebody may later want
>> >>    to "fix" this, making these two eye-candy output to be different
>> >>    from each other, and what your test expects will no longer hold
>> >>    (not that I think it is better to say "-" instead of @{-1}
>> >>    there).
>> >
>> > I don't think either of these is correct.  When using "-" with the
>> > commands that already support it, I have occasionally found that "-"
>> > isn't what I thought it was.
>> >
>> > Can we use `git name-rev` to put the actual name here, so that people
>> > who have not done what they intended can hopefully notice sooner?
>> 
>> That sounds like a right thing to do.  It however is totally
>> orthogonal to the change we are discussing, and should be done as a
>> separate patch.
>
> Is it not part of adding support for "-"?

I thought your suggestion was:

    'rebase @{-1}' says 'Fast-fowarded HEAD to @{-1}'. It should say
    'Fast-forwarded HEAD to 4f407407 (rebase: allow "-" short-hand
    for the previous branch, 2014-03-19)' instead.

Or it could be:

    'rebase @{-1}' says 'Fast-fowarded HEAD to @{-1}'. It should say
    'Fast-forwarded HEAD to master' instead.

In either case, it does not look like such a change is about
teaching "-" as a synonym to "@{-1}".
