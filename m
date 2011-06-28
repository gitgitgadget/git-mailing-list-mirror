From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Tue, 28 Jun 2011 13:43:18 -0700
Message-ID: <7viprpu1p5.fsf@alter.siamese.dyndns.org>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
 <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
 <7v1uydvmh0.fsf@alter.siamese.dyndns.org>
 <20110628193034.GB3700@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 28 22:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbf83-0006KR-CS
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 22:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788Ab1F1UnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 16:43:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1F1UnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 16:43:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C28FB48E3;
	Tue, 28 Jun 2011 16:45:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IaM0JQNUcddyKlbUgvA6ugOjY1c=; b=kWH1mj
	0B8Z5jmp2VMPvUpWXdxRuhWqvWbLarnqvdSWepbXvBGM0D0LTbYGLCtuqKGNADm3
	CEbNhcq3vk7/RTA6qSuNIuVzV/dwVpIO6zjJwmoF9FmOwKrEUAY2NGgiGLpcjljb
	YAQ6KvXCsbnLVawE/W7+2Wqrn55QgW+1Sn7Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l4TPnCzxZFGuLa/F4TDMQWH8H5WhmUH5
	I3iMBVOLv6NHcR89wFYnIBYXC3xFwjZOSczS8xq39drAzfKZgTx5eZ2Zez+Tw6CE
	z5EBvKBs1j+GoT1T6P9wzGxLbj3G/7rs9FVCE4jRtgPIW6h/NVkireYznU5YkaEC
	MOsw5mSiNIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BADB548E2;
	Tue, 28 Jun 2011 16:45:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A59748E1; Tue, 28 Jun 2011
 16:45:33 -0400 (EDT)
In-Reply-To: <20110628193034.GB3700@book.hvoigt.net> (Heiko Voigt's message
 of "Tue, 28 Jun 2011 21:30:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9167ABBA-A1C7-11E0-9E77-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176418>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> What if
>> 
>>  (1) you are binding somebody else's project as your own submodule, you do
>>      not make any local changes (you won't be pushing them out anyway),
>>      and you do not have remote tracking branches in that submodule
>>      project?
>
> In this scenario the superproject can not be cloned that way that it
> would contain the submodule right? I would consider this a rather exotic
> way to work since pushing means to share your work somehow.

Sorry, I don't follow. Isn't this the classical example of an el-cheapo
router firmware project (i.e. superproject) binding unmodified Linux
kernel project as one of its submodules without you having any push
privilege to Linus's repository, which was one of the original examples
used in the very initial submodule discussion?

> How about not doing the is-pushed check when the submodule has no
> remotes? If we assume that only people having remote tracking branches
> want to share them via push this would allow your usecase.

Yes, that would reduce the false positive; same for (2).

> This check is solely meant as a convenience security measure. It should
> and can not enforce a tight check whether a superproject (including its
> submodules) can be cloned/checked out at all times. But it ensures that
> a developer has pushed his submodule commits "somewhere" which is enough
> in practice.

I am not entirely convinced but if this would catch more than 80% of
casual mistakes, it would be good enough.  I was hoping that somebody may
come up with an idea that would work even in case (3), though.
