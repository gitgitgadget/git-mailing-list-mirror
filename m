From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Wed, 21 Oct 2015 13:07:54 -0700
Message-ID: <xmqqlhawugrp.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
	<5627B496.7030102@ramsayjones.plus.com> <5627EFE4.1060106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozgU-0006BC-79
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbbJUUIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:08:19 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756345AbbJUUH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55E1423F98;
	Wed, 21 Oct 2015 16:07:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58eEV+qJjLpM40V9Khl7j8BQAk4=; b=ETWv5w
	CtjXfNJK0vvB1c3bnCbGoxpUTIBrueZqE1qacxp7XoEodawq6cIGGWg7NNp+OSQ+
	W1yfhBmFNmCL6HFTB7t/FzISuaumPanqJJ/zkdu3BmG3Yw1sT8KI0EA29ALs90ez
	ZS+wLDjt/Af3CPJ16QqnO4e2kL050Bl/bJInY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjiR4yxQAS8y/Dc9HJ4IJJyAF/vrnZRR
	eU2gMbfuYQIKt5suNTzASeUR0mnNte9Gtvl/avVdk51yzDIfEH8YS8WB7+yaFdRX
	1Om+cBSNx5SCN+9jP7WtXWc8YdLdjMBMtuw+TqGMAc+BzH4MOXC6cM+l8/TkU/dx
	KeuOOXoR6Fc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CE6923F97;
	Wed, 21 Oct 2015 16:07:56 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B160E23F96;
	Wed, 21 Oct 2015 16:07:55 -0400 (EDT)
In-Reply-To: <5627EFE4.1060106@kdbg.org> (Johannes Sixt's message of "Wed, 21
	Oct 2015 22:04:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AED5DD4-782F-11E5-8F39-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280010>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.10.2015 um 17:51 schrieb Ramsay Jones:
>> On 20/10/15 22:24, Junio C Hamano wrote:
>>>
>>>      time git am mbox >/dev/null
>>>
>>> are
>>>
>>>        (master)                 (with the series)
>>>      real    0m0.648s            real    0m0.537s
>>>      user    0m0.358s            user    0m0.338s
>>>      sys     0m0.172s            sys     0m0.154s
>>>
>>
>> The corresponding times for me were:
>>
>>      (master)           (with the series)
>>    real	0m9.760s      real	0m5.744s
>>    user	0m0.531s      user	0m0.656s
>>    sys	0m5.726s      sys	0m3.520s
>>
>> So, yes, a noticeable improvement! :)
>
> Same here, on Windows built with the old msysgit environment:
>
> (master)             (with the series)
> real    0m3.147s      real    0m1.947s
> user    0m0.016s      user    0m0.000s
> sys     0m0.015s      sys     0m0.031s
>
> Although I tested 'git am patches/*' where the patches/* are the
> result of 'git-format-patch v2.6.1..github/jc/mailinfo-lib'.

Thanks, both.
