From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Wed, 23 Mar 2016 17:13:16 -0700
Message-ID: <xmqqlh58bun7.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-6-git-send-email-sbeller@google.com>
	<xmqq37rif870.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaEmDFDf+1BZV1C5ETswbXmAUYk_OMsZf_ka6tJ=pfwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 01:13:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aistx-0008Ar-40
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 01:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcCXANU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 20:13:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751830AbcCXANT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 20:13:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26CAA506B6;
	Wed, 23 Mar 2016 20:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I9472myvcIlthdQbvmeNjQuGG8k=; b=UDpxHt
	4si9IdF5cmltqp/QmONZeox7e4+UTF0lgd1JX2HiCJLHoOYzoK39Hav1M9Me2UtW
	9BkCaoNUrV7Ce8DXmsfIipVmmnT2wNBK3VFpC2+Du/wJrf4VnFsobDAYeegR/FHc
	ZRYD9oqwBRhP7MpJRnEMfgiii6aS5KQvEDmSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppxKD3Ct/I0rokXyg/265LqCxEMepvjy
	uqpcDE7Jxc5ZNs80uBgn9HzGFDcobNpl+tYDZGg0bMrEYRXRTx4vfZHT1+lbv3o7
	T0d0yI2j28i5h8SuQaeRJwUw642eV330IGp5fKTovuEzLBSyQDINmDdzhuvu0Ykp
	zLxF7y0EqdE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E69A506B5;
	Wed, 23 Mar 2016 20:13:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 900FA506B4;
	Wed, 23 Mar 2016 20:13:17 -0400 (EDT)
In-Reply-To: <CAGZ79kaEmDFDf+1BZV1C5ETswbXmAUYk_OMsZf_ka6tJ=pfwcQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 23 Mar 2016 16:21:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3574F410-F155-11E5-9E2A-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289702>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 22, 2016 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This change introduces the 'submodule.actionOnLabel' variable
>>> in a repository configuration. Generally speaking 'submodule.actionOnLabel'
>>> restricts the action of a command when no submodules are selected via the
>>> command line explicitely to those submodules, which are selected by
>>> 'submodule.actionOnLabel'. It can occur multiple times and can specify
>>> the path, the name or one of the labels of a submodule to select that
>>> submodule.
>>>
>>> The introduction of 'submodule.actionOnLabel' starts with
>>> 'git submodule update' in this patch and other commands will follow
>>> in later patches.
>>>
>>> 'submodule.actionOnLabel' implies '--init' in 'git submodule update'.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>>
>>> TODO: generic documentation for submodule.actionOnLabel
>>> TODO: documentation for submodule update
>>
>> TODO: a name that matches the concept better.
>
> This is one of the hardest parts of the series so far. The last reviews
> were mostly bike shedding about the name of the concept and I thought
> we were settled to actionOnLabel as that fits best to what we want to do.
>
> So let's revisit that. My current understanding of the design:

I am not questioning the name "label" to call the facility that
allows projects to group submodules together, and that serves as one
of the ways to choose what subset of submodules are worked on by
default.  There is no need to revisit that part.

What I am questioning is

	action On Label

because

 (1) it sounds as if that configuration were a way to choose what
     action is done to the chosen subset of submodules;

 (2) it sounds as if the only way to choose a subset of submodules
     to be operated on by default is via the "label" mechanism.

And from your writing (omitted), I think we agree that we definitely
want to avoid the misunderstanding that is (1).  This variable does
not specify what is done--this specifies what subset of submodules
are to be operated on.  Having "action" in the name of the variable
is wrong.

And from the proposed log message, it is clear that "label" is not
the only way to specify the subset of submodules to be worked on,
i.e. "... can specify the path, name or the labels".   Having
"label" in the variable name is wrong.

I am tempted to suggest submodule.defaultOperand and I am fairly
sure "default" part of that name gets the concept much better than
"actionOnLabel", but there probably are much better words than
Operand.
