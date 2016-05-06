From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Fri, 06 May 2016 11:59:47 -0700
Message-ID: <xmqqy47n2esc.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
	<xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOXxqDEqVnf5K3QjXg5bfmKW2XkmPT-mqJ93+RF5N40g@mail.gmail.com>
	<CAGZ79ka37jWYDJrAWy5KLhaaJmrLRbmTzRC6A5DneuE63+XCeQ@mail.gmail.com>
	<xmqqy47o9s1h.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYGbjOKPQk8A-ag+JgvybW4Kf5=g8azVAOoMq79oXc5-Q@mail.gmail.com>
	<xmqqfutw9mfs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYKbef7DTkmE3Vf3C=PLfgB3xf0ikVKHFUfQ8+KkgGHPg@mail.gmail.com>
	<xmqqfutw85oz.fsf@gitster.mtv.corp.google.com>
	<xmqqa8k37m6i.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY5uDzG8PDLMh5e9afg+S3oTjEjq2aRo+s4ud86UCxZQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:59:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aykyh-0005dv-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbcEFS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:59:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758541AbcEFS7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:59:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E6DA17276;
	Fri,  6 May 2016 14:59:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/3tCH95DULqEd9jQRFxz1UOp6o=; b=qnTKIq
	XNG7XMWqQaYkT/EfG4qcm+kKDZirn4FSrv+4wDnKklLaCw1G92nJvR/OaLYKvMZ7
	koaUvxM9cYliF2m0YuUjNHyW3TBgM1XHxWvKJ4hZDumAimcHJgyuuRXsbMBJhIbj
	ahTiBzUkPodaoVLakEdeLhc64FCJohnl8QQw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdFhdgT/QG7JAP/YENs4CAWOjc8fSXe7
	t7yXxhXmmwej0jyF1Mpb2WHV6MOpLTfzRwH59zKgGOWSGHDfrBDtW/AI26L9o3ci
	gB4DQi+vlT31OsjBkkg6BuS6rhhBnbY+O4aiQdpwwD81l4+vIY0ZYyMd4WXUIaBb
	rOmrrTlT3Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1647E17274;
	Fri,  6 May 2016 14:59:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CC4317270;
	Fri,  6 May 2016 14:59:48 -0400 (EDT)
In-Reply-To: <CAGZ79kY5uDzG8PDLMh5e9afg+S3oTjEjq2aRo+s4ud86UCxZQA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 6 May 2016 11:23:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B497478C-13BC-11E6-A730-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293848>

Stefan Beller <sbeller@google.com> writes:

>> Further suppose that the user needs to view a submodule outside the
>> default group temporarily (imagine: for a day or two), while
>> carrying out some specific task.  Perhaps she is working on the
>> documentation submodule, which is her primary task hence her
>> configuration file specifies it as the default, but needs to see the
>> submodule that houses the implementation to describe the behaviour.
>>
>> So she does "init code-module/"; this has explicit pathspec, so
>> there is no difference between the two.  Now, while reading the code
>> module, she finds a typo in a comment, and wants to fix it.  We will
>> start to see differences.
>
> Another way (3) is to add code-module/ to the "set of interesting
> submodules, i.e. to the default group"

I do not want to force her to do more than "submodule deinit" when
she is done with that temporary task that required her to have
code-module/ checked out, which is what you are doing with such a
change.  So that is a non-starter to me.

>> The amount of "extra" in the first use case necessary for (1) is
>> greater than the amount of "extra" in the second use case necessary
>> for (2), though.  In addition, in the second use case, (1) makes it
>> easier for the user to miss important changes she made outside the
>> area of her usual attention, while (2) forces her to make a
>> conscious effort to exclude them.  These are the reasons why I have
>> a slight preference for (2) over (1).
>>
>
> That makes sense.
>
> So with (2)
>  * there is no need to modify status, diff, log for the default case and the
>     --recursive \*default" may come later, so the initial series can be smaller.
>  *

I sense a premature "Send" button here ;-)

In any case, I care much more about the "making it harder to miss
things outside the usual area of attention" benefit than "the user
may have to type less more often" benefit, even though both are
slightly in favor between (1) and (2).
