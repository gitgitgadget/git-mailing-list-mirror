From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/11] Untracked cache improvements
Date: Tue, 19 Jan 2016 09:47:24 -0800
Message-ID: <xmqqoachbgwj.fsf@gitster.mtv.corp.google.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	<569A5A66.3090907@web.de>
	<CAP8UFD27rFvCrPPs7q+bve9VoyXcg2bBjkz96VfaUm8TDh4c9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLaNP-0000Rb-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 18:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbcASRr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 12:47:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755254AbcASRr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 12:47:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08A2A3B80C;
	Tue, 19 Jan 2016 12:47:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8+YaTbsUb/tC
	uVN+6fPxskWM23w=; b=G9nOB1QN9TnvbIHI6zyOuWJmaKuvG6ZNmKKmHx/FOgMd
	mkY7vvkzZF+YXkyZq+EN8qFBqsCGdByp3bniRxO0+WyX2kTY8tkavAtkW1OWtt6W
	7zSIyraaZJZUBLsbs7rLGXbY/1RecBLn9rhbAryORxsEUQotv+evhXjD3rY18W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CVm272
	YeQZ+1BNYKjDd5X+8BO2g1qwgWZSNcAFooJSnEVrqwX7jBRp1oZS6tiq7qf7UDkz
	dEsQkWtxa+jqtP186E01Eyw3epoYTUiBwDhfI16bOo99NN6EvksW6TOj5UZcZCiq
	Jn/V2bj7ewdNQXdS0nv95FwPTiFg/c5auPF4s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE5853B80B;
	Tue, 19 Jan 2016 12:47:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 522513B809;
	Tue, 19 Jan 2016 12:47:25 -0500 (EST)
In-Reply-To: <CAP8UFD27rFvCrPPs7q+bve9VoyXcg2bBjkz96VfaUm8TDh4c9w@mail.gmail.com>
	(Christian Couder's message of "Tue, 19 Jan 2016 15:43:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B33E8A5E-BED4-11E5-B34A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284362>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Jan 16, 2016 at 3:57 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> General question after testing UC on a slow network share:
>>
>> time ./git status
>> On branch uc-notifs63
>> Your branch is up-to-date with 'cc/uc-notifs63'.
>>
>> It took 6.27 seconds to enumerate untracked files. 'status -uno'
>> may speed it up, but you have to be careful not to forget to add
>> new files yourself (see 'git help status').
>> nothing to commit, working directory clean
>>
>> real    0m19.159s
>> user    0m0.085s
>> sys     0m0.293s
>> ----------------------
>> Does it makes sense  to hint the user about the untracked cache ?
>
> I don't think it makes sense to hint about it for now.
> When more people will have used it for a significant time perhaps.

Chicken or Egg?

I tend to think updating this message is outside of the scope of
your series, but you would not get wider adoption (hence more guinea
pigs that 'have used it for a significant time') unless you
advertise it, and I agree with Torsten that this is the message that
matters most--it is shown when we know we spent a lot of time on
what UC is meant to speed up and no other time.
