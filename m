From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Speed up string search routines
Date: Sun, 14 Feb 2010 12:16:05 -0800
Message-ID: <7v3a13fu9m.fsf@alter.siamese.dyndns.org>
References: <20100213142014.GA9543@fredrik-laptop>
 <7vk4uhklxm.fsf@alter.siamese.dyndns.org>
 <4c8ef71002140847i19b64b21ocfa71658a49d97b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 21:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngkt9-0002AE-85
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 21:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0BNUQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 15:16:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0BNUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 15:16:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE329A3CA;
	Sun, 14 Feb 2010 15:16:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHxhFM01xkwVtlJU+Cefbpm5OPk=; b=KCw3K/
	8nAa5vaYOpOFCfAiTZXb6T0HL1w+S25+gAr/oPHp2Ju8n0HIuHp3VmUrvFaKQxX0
	uLbwRSB7Z6AkYzDxfppv7/+R3Bwhw7KsCyUCZLSwb1qlxp8I8y8RQ5sciS4My7zm
	0ljxTCx++HboJWZgGSIuUtdGB5i8zRv86Nhyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QC332Ohj1dQIWVG8nkZdGfm1Vrk4kOcY
	xa6Yby2hGxb1O2RdwcZsbvrlTdMcEgRR73kDjFmPP4qCs6ToUeZsv38kLCFwePrJ
	wYfhjzZ+9RkFqTP+7Yd892ZYDKOQiT7+9BEAR0ZCXJCKSdh5hMDb0BoOij0EW0Nr
	0tyhuHUNuHU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A62A39A3C9;
	Sun, 14 Feb 2010 15:16:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 179C09A3C8; Sun, 14 Feb
 2010 15:16:06 -0500 (EST)
In-Reply-To: <4c8ef71002140847i19b64b21ocfa71658a49d97b5@mail.gmail.com>
 (Fredrik Kuivinen's message of "Sun\, 14 Feb 2010 17\:47\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA2B04E8-19A5-11DF-9657-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139936>

Fredrik Kuivinen <frekui@gmail.com> writes:

> There is code in obstack.c to check if we are using gnu libc or not.
> If gnu libc is used, then ELIDE_CODE is defined and no code from
> obstack.c is compiled.

Thanks; that explains why there is no need to change Makefile to customize
where obstack is taken from.

But I am not a big fan of keeping borrowed code mixed together in the same
directory with our own code.  For something as large as xdiff, giving it
its own directory made sense, but for only two files, I thought compat/
would be a good place, hence my suggesiton.  kwset would probably want to
go together with them somewhere.
