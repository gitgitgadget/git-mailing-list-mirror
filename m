From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 05 Apr 2011 14:03:12 -0700
Message-ID: <7v8vvommwf.fsf@alter.siamese.dyndns.org>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
 <7v4o6cob4t.fsf@alter.siamese.dyndns.org>
 <B584DA91-1811-4976-A915-458672455DAD@sb.org>
 <7vk4f8mu4i.fsf@alter.siamese.dyndns.org>
 <BANLkTimqvu7c559_AQ6yLxPACOxD0ciNxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Notz <patnotz@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:04:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DQX-0005kG-Pm
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab1DEVDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:03:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1DEVDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:03:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2634146F2;
	Tue,  5 Apr 2011 17:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7lXk+z7009RokzuegtF+m0BgX84=; b=TqKByg
	Ejd6uoPGIZ+7YSNYoFfuw48OrorzpMMttWgEDcO+yVUNySgkuPSCEBmpv8wvvV1k
	C1qGRufn0hGI9qn8PG8Gqx00M2Mzvexkvd5hVvp4lFpUdQsiDrZ1RLkbwQAFdfyT
	do7k/kDz9crIC1aehLpf0AW1v09ymrPEcQ0N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aHXFecdC5yfNOv2h5Bf2nkYDEdvz4tPu
	Wg80NOsMTpkaQsCwOTpsNnEdgvlZNtr7Qx7UM/IDhd4hvevI87FZyY5luLmpygcb
	qxfPgC/75TFoeeVQxVMYo2MyVgRYmFH1jlNwBM4SNaWaxIaAlMEw7oDEi6BnU9uf
	iWSO64IrnUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C874A46F0;
	Tue,  5 Apr 2011 17:05:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4BDD46EB; Tue,  5 Apr 2011
 17:05:06 -0400 (EDT)
In-Reply-To: <BANLkTimqvu7c559_AQ6yLxPACOxD0ciNxQ@mail.gmail.com> (Kevin
 Ballard's message of "Tue, 5 Apr 2011 11:59:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6798D55C-5FC8-11E0-B7C4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170913>

Kevin Ballard <kevin@sb.org> writes:

> On Tue, Apr 5, 2011 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Kevin Ballard <kevin@sb.org> writes:
>>
>> > This seems unnecessary. `git commit --fixup HEAD` doesn't really make any
>> sense at all to run when you can say `git commit --amend` instead,
>>
>> What about this sequence?
>>
>>        git commit -m 'foo'
>>        git commit -m 'bar'
>>        git commit --fixup HEAD~1
>>        git commit -m 'baz'
>>        git commit --fixup HEAD~1
>>
>>
> You raise a good point. I personally think someone who types that deserves
> what he gets, but I have no objection to being intelligent about duplicate
> fixup! prefixes.

Of course an alternative solution is to fix this on the "rebase -i" side,
by building on top of your d3d7a42 (rebase: better rearranging of
fixup!/squash! lines with --autosquash, 2010-11-04).

Or perhaps we would want to do both.
