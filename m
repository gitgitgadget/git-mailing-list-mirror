From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: plug a memory leak
Date: Tue, 13 Aug 2013 14:50:06 -0700
Message-ID: <7v1u5xw99t.fsf@alter.siamese.dyndns.org>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
	<CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
	<CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com>
	<CAMP44s1CAMPWXDSAc7WHahmrKRrB8aG_H9fnXAMi2LFOGy5EdA@mail.gmail.com>
	<520A7AAE.6010309@web.de> <7va9klwb03.fsf@alter.siamese.dyndns.org>
	<520AA5FE.1090208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	=?iso-2022-jp?B?GyRCJy0nVidYJ1EnXydcJ1onXxsoQiAbJEInKidTJ1EnXxsoQg==?= 
	<abyss.7@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 13 23:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9MTt-0007aP-NE
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab3HMVuM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Aug 2013 17:50:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081Ab3HMVuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Aug 2013 17:50:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E73E38C51;
	Tue, 13 Aug 2013 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gzJ+65CR9QnQ
	DGPtttNfLQgq5HM=; b=pQ+ewmAdYOdBhW7Ijb46qNltqSKEmZFHXlyOn7mt3QME
	QtmSUB9jDFZtveueSt/HVt/7pdkKJiFEy4t6qWMwsGNjxh0g7vWzJ7n3QBgm2PET
	5rscYxaxL+336kJ+2b/9dm+9lx72YayGc/9hRjji+nDPpYCq+7z5Oh900HlaEFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i49l02
	AQTeKZ2RCva1/e12wnt5mgfkqB6VWqS51NnPNcCubnT0eNjwiICrjU1hRICnJVCO
	lU17WsxfvF9VeEiFAO2FXotLnr9PND5ow97HOozlppq3TtTTWKdmYCiktxyMOO/d
	FrnAnIR1H1az0cu6jnw8BSfnlwUYF6uIXS+00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21E3738C50;
	Tue, 13 Aug 2013 21:50:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C28B38C4E;
	Tue, 13 Aug 2013 21:50:08 +0000 (UTC)
In-Reply-To: <520AA5FE.1090208@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 13
	Aug 2013 23:32:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5240AEE6-0462-11E3-A55A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232252>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> It was lost in the follow-up discussion and I missed it.
>
> I had forgotten about it as well, until Felipe mentioned it again.
>
>> I assume that this is signed-off by you as a forwarder?  I'd prefer
>> to even mark it Reviewed-by: you.
>
> Right, I did review the patch and you can tag it as such.

OK, will queue and soon merge to and cook in 'next'.

Thanks, everybody.
