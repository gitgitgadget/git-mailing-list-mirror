From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t: branch: improve test rollback
Date: Wed, 04 Sep 2013 10:19:00 -0700
Message-ID: <xmqq61ugo67v.fsf@gitster.dls.corp.google.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
	<1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqmxr9a7.fsf@gitster.dls.corp.google.com>
	<CAMP44s2BU86zZ_KE78BPYpsjBZJ7Mj0MJqM4Lj28AKxYfeLVDQ@mail.gmail.com>
	<xmqqtxi1o6kf.fsf@gitster.dls.corp.google.com>
	<CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 19:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHGjm-0003fs-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 19:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763223Ab3IDRTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 13:19:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763208Ab3IDRTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 13:19:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 379543EBE5;
	Wed,  4 Sep 2013 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5Oe+17SeuIZAErL8kZbYEcUjGc=; b=fnRSit
	+NTM2D91FXPWFFcGxbe0Mks2F7DG+2wsn2PLNAvKdrwmTbPgKCFUNG9co68FU1OE
	JnUqYKOQNjHc8esnJ7L2GplJx5biD6T8chQlUWIB3aoEtqQtLZoyWf22zgSJpJqw
	ejP20/VHHe3D8BDdW9FdmejQTUM3ki5xUViS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X2C84xeJrtSFeQ55fmNzLmsKqgZ1pSlL
	uvmwr/TH0lgCvWLIlMO12WdSGQjQrVDmgMmOPQMKWZAjEMVsxYNf+JCNiX+ZJhxD
	zKNNyb0SGLeZ1G+Oz/+VEa8AgjJ3lxp31Biolbhna3dPMXNuN2cyRCX1br1CygwU
	I6E6NN9RcHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCA23EBE4;
	Wed,  4 Sep 2013 17:19:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 603D13EBD6;
	Wed,  4 Sep 2013 17:19:02 +0000 (UTC)
In-Reply-To: <CAMP44s1Q6YjVnVz3OnT=cE+ozUddBxFzM1r_WT5QoR7sP6-9Sg@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 3 Sep 2013 18:03:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18050F3A-1586-11E3-82EC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233851>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Sep 3, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Tue, Sep 3, 2013 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>>  test_expect_success 'refuse --edit-description on unborn branch for now' '
>>>>> +     test_when_finished "git checkout -" &&
>>>>
>>>> I am not sure if this is a good change.  Depending on the outcome of
>>>> the "git checkout" in the test (it may succeed and set @{-1} to the
>>>> branch we were on when we entered the test, or it may fail and leave
>>>> @{-1} to the branch before we were on when we entered the test),
>>>> this will take us to a different place, no?
>>>
>>> It is better than leaving Git in an unborn branch.
>>
>> True, but it falls short of "After every test the environment should
>> be as close as to how it was before as possible.", doesn't it?
>
> No it doesn't. Closer is closer.

Closer is not "as close as ... possible".

I think the fix is just to use the name of a concrete branch we want
the next test to start on, instead of "-", which could be far
quickly done than making excuses like that.
