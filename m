From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Tue, 03 Sep 2013 15:59:12 -0700
Message-ID: <xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
	<CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzZC-0000kC-8n
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab3ICW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:59:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760864Ab3ICW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:59:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 589443F5B8;
	Tue,  3 Sep 2013 22:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RxkxWabEZdlPP1XTUZSsRC+fOn8=; b=HDwsoE
	BXnLsbKtl4qF6/Rb+bfrYYO6Fwihi81StmsALIuDqx8R6tE0GsafAhJoL5PlAAoI
	AOO0LjIyJzwxL7UK5/MxcjRvxLES3wF9XIwrJBipYuyR0QS3ccv8893CNf/F94HN
	AZ+RWr5sxdC3eLKtITrRqbb8g2Tmszx/km4QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/V/CBey+/DYGssR3foLmh2HWLblVou4
	LA5nT/YGKU2miMNWzM/JKnpxi9IjDGhqXzaVX8kKR6I4oXLVZprZa+t7p2idrrUe
	Sx+/RzdwAITRRgEVkiwBXngPfDLMh27ro1dILkplKgI+9SuINpKIT42QiraDZUGR
	V1NA2ibvK1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2423F5B7;
	Tue,  3 Sep 2013 22:59:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B087B3F5AC;
	Tue,  3 Sep 2013 22:59:14 +0000 (UTC)
In-Reply-To: <CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 3 Sep 2013 17:10:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 748865C6-14EC-11E3-BF56-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233794>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Sep 3, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>  test_expect_success 'refuse --edit-description on unborn branch for now' '
>>> +     test_when_finished "git checkout -" &&
>>
>> I am not sure if this is a good change.  Depending on the outcome of
>> the "git checkout" in the test (it may succeed and set @{-1} to the
>> branch we were on when we entered the test, or it may fail and leave
>> @{-1} to the branch before we were on when we entered the test),
>> this will take us to a different place, no?
>
> It is better than leaving Git in an unborn branch.

True, but it falls short of "After every test the environment should
be as close as to how it was before as possible.", doesn't it?

I think the fix is just to use the name of a concrete branch,
instead of "-", which could be far quickly done than making excuses
like that.
