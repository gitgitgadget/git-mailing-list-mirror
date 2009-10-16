From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] strbuf_nested_expand(): allow expansion to interrupt
 in the middle
Date: Fri, 16 Oct 2009 10:22:45 -0700
Message-ID: <7vr5t3uuca.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <1255681702-5215-3-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0910161329270.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqYi-0002SZ-2s
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbZJPRWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZJPRWy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:22:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbZJPRWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 13:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B26C7AE6A;
	Fri, 16 Oct 2009 13:22:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=r/XcCvFHzNakqq618WBY8d1bE9I=; b=iwRIvvAkWxzAaOwrUeUUtnK
	eZiNY47mXzVRGrfFipd5en7td4M82i0KbpPHCS+GH0sy2HP+3bHjrvL9g+UbwLfR
	rh9SAnmab+p/U9NH2WIr1rcvsGwArYQ4cdBps7dRV1UZ0ksT8LAQ+ncUSGQqEr2J
	nZDx3YtA9qSpSkhoCjNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=EokLhorX9csN3pgXhgrVMfnXI2kA1Nh8tViiIQetWqTOiUNcA
	KcJPXkrcsTfeBtpmBbFExXo5QAHZPETX9IK38eWbVeUAWodMhTOM6P7Y2AT3/92t
	2qPcOEHYQ18CG8sCyKnWUa7xR3nAytBKaUN9pPp2P1FnQaFAGUfCZGwCik=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A97E7AE69;
	Fri, 16 Oct 2009 13:22:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F6077AE68; Fri, 16 Oct 2009
 13:22:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 895FF518-BA78-11DE-A49F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130511>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 16 Oct 2009, Junio C Hamano wrote:
>
>>  		consumed = fn(sb, format, context);
>> -		if (consumed)
>> +		if ((ssize_t) consumed < 0)
>> +			break;
>
> Would it not be much better to fix the signature of fn in a separate 
> commit before this one?

Yes, I considered it and it is a reasonable thing to do if this were to
become a real series for includion, but I thought it would add unnecessary
noise to the patch when the main purpose of posting the series is still to
be a proof-of-concept for discussing the design and future directions
(including "it should not have any future---it is useless code churn for
supporting only one example user 'rewrap'").

Please remind and yell at me if (1) this turns out to be going in the
right direction and (2) I forget to fix it when I redo the series after
discussion to apply them for real.

Thanks.
