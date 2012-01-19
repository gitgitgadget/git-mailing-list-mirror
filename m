From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Thu, 19 Jan 2012 10:30:10 -0800
Message-ID: <7vhazrk0jx.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <7vfwfclf4v.fsf@alter.siamese.dyndns.org> <4F17C294.6010004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnwl2-0000hh-Il
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 19:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698Ab2ASSaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 13:30:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932594Ab2ASSaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 13:30:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC3A58D1;
	Thu, 19 Jan 2012 13:30:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4/SYRfG0/w3wJhax66uG1JWnCaE=; b=qbI+ru
	GfFVzUhUC1/YmCNvxUSpAUeiYS+9tOnKsNy/C1rd2QpOfIfaBm5PhqGbxDB6hZLa
	JGdBaQ8aJeW+jWEUh9VAE532AbvGYYVzYbp4GQPF4+jralGBdkSGeA7FcFIpil1m
	bLogqo+0RpcWkak+v5eJxhvheGtBm/0gcWYDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNYsUsoDr51mKETN1S1tl8VW/ahFj4l5
	CfS6AS0vMhmWPo3hT4Dq6WfjXx2sLpxH2K48QUhwhlcJj4JeW+2cSg/85/SfCxxx
	hv+DD5xwbc58toALVP6+9HmI7cI5W0BjVdPnuUbRnMVGadRFSCjCwn9E0r0VhudP
	sEI9FRWwluQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61DFE58D0;
	Thu, 19 Jan 2012 13:30:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E220058CE; Thu, 19 Jan 2012
 13:30:11 -0500 (EST)
In-Reply-To: <4F17C294.6010004@viscovery.net> (Johannes Sixt's message of
 "Thu, 19 Jan 2012 08:13:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F7D11CC-42CB-11E1-8F02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188823>

Johannes Sixt <j.sixt@viscovery.net> writes:

> ... We have, e.g., NO_MMAP, and I can set it to request
> that some alternative is used, even if I have a working mmap(). The option
> name "NO_GETTEXT" is in exactly the same spirit.
>
>> In the current approach we take for shell scripts, we cannot have "No i18n
>> whatsoever and messages are emit with printf and echo". We always have to
>> go through gettext/eval_gettext even though they may be an implementation
>> that does not do i18n at all.
>
> Just like we go through _() in C code, even though there may be an
> implementation that does not do i18n at all, right?

Yes, just like that. The small detail that _() can be #define'd out to
empty while gettext/eval_gettext cannot be made to be no-impact like that
does not really matter.

> In C, it is easy, in shell code it may be more involved.

Correct.
