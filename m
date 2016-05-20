From: Junio C Hamano <gitster@pobox.com>
Subject: Re: run-command: output owner picking strategy
Date: Fri, 20 May 2016 11:54:02 -0700
Message-ID: <xmqqwpmod0hh.fsf@gitster.mtv.corp.google.com>
References: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CAGZ79kZ1LTF4h_WVV9mMCAQCVtH667GU011LiRNtkTmi9ygUYw@mail.gmail.com>
	<390486239.5813961.1463768960439.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CAGZ79kbTa-E3QTgGhzEPKnEHiOMq_On6h6RC8jrrQaot1YE94g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:54:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3pYp-0002qM-S8
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbcETSyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:54:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750893AbcETSyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:54:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69A9B1ABF9;
	Fri, 20 May 2016 14:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TQAr/ULSBJKADoGA+u8DEidiQyQ=; b=PHSLYw
	Ws+rpYfkWhedmo3mv9b3RosDbdj/PG3DKVPkp1G19BhgR2bdtOdLH14QZ31IxeUg
	sTmlDq5/Jfpe8M4ZhXR1xotyIf8YDd2unkO/UZUOC41hCLyiQwwTpN2wZm5H8gXC
	fHQzJAWxaU7V+oWhylh8Dtgr9etoTW7tOU1/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yiAG+Dv5kcQ6k2z7wsrqdpGUj5qR/vqj
	CtYWyHvl43SJZdED/ih/YaqlGEfXZt305OTOFGuZGElQPum3feEcoVfSPAFthi+b
	FAZEgyYU/AttF3Z1nnatzRXxH57I9U+BKG0Efbzx9DtrKM83Y2daLoZ9cZpYQMGp
	/rOUUdpuecE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61FDD1ABF8;
	Fri, 20 May 2016 14:54:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA8D01ABF6;
	Fri, 20 May 2016 14:54:03 -0400 (EDT)
In-Reply-To: <CAGZ79kbTa-E3QTgGhzEPKnEHiOMq_On6h6RC8jrrQaot1YE94g@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 May 2016 11:39:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38EC22A0-1EBC-11E6-AAF4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295204>

Stefan Beller <sbeller@google.com> writes:

> I choose "as much live output" as an approximation of "least amount buffered
> over time, i.e. if you were to integrate the buffer size over time
> that should be
> minimized. (c.f. users waiting for output: http://imgur.com/gallery/lhjhbB9)
> I am not sure if that is ultimate thing to optimize for though.

It might be interesting to optimize to minimize the time the user
needs to stare an inactive screen, i.e. make sure there always is
something flowing.  That may involve throttling the output from a
buffer if that is the only buffer with any output, the foreground
thing hasn't made any output yet, and expected to stay silent for a
while, etc.
