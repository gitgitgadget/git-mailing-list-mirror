From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Wed, 17 Jul 2013 12:29:52 -0700
Message-ID: <7v38rd6l3j.fsf@alter.siamese.dyndns.org>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 17 21:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzXQI-00087A-OK
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 21:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab3GQT37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 15:29:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756904Ab3GQT36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 15:29:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D732131074;
	Wed, 17 Jul 2013 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAL448u9WxJ7RY4AjX16W//1FAw=; b=EnKUpy
	h0JDOD0VBTUN/NyMR6Lj5uRD4NSnNEfGPIYOCI1bjuQkkQwu6EIpA7M/1ktbqZda
	c09YaZ65HSdMf5muNyqfNzrLT29xmR0ThamLa/slOUQlhlRUT8CbcnRFYp1S1oGi
	7oAou2CKvtQzbxm682C7ME8TTFjTTx5TL1Xpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hLBFljRg/Lobe47KD0JSW4vBIHySNt8o
	ICfijkIdcVwLP/dMsyB6cO9xvgnPnN7han8e37fX9cdIsU4o/DaHGrzfQO6RELZE
	3HefxNyuNNWT5Tb8hcBk4dJ/rvffCiiNA4GYZZhJGdIrf/04ZsjNwYF/LOWlo00f
	ZMcjWNBvAYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD66331073;
	Wed, 17 Jul 2013 19:29:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3020D31070;
	Wed, 17 Jul 2013 19:29:54 +0000 (UTC)
In-Reply-To: <878v16kfqy.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 16 Jul 2013 11:37:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41D12398-EF17-11E2-9479-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230642>

Thomas Rast <trast@inf.ethz.ch> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> From: "Dale R. Worley" <worley@alum.mit.edu>
>>
>> open() returns -1 on failure, and indeed 0 is a possible success value
>> if the user closed stdin in our process.  Fix the test.
>>
>> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
>
> I see you have this in 'pu' without Dale's signoff.  I'm guessing
> (IANAL) that it's too small to be copyrighted and anyway there is only
> way to fix it, but maybe Dale can "sign off" just to be safe, anyway?

Yup, that is a good idea.  Thanks.

>
>>  wrapper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/wrapper.c b/wrapper.c
>> index dd7ecbb..6a015de 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>>  		template[5] = letters[v % num_letters]; v /= num_letters;
>>  
>>  		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>> -		if (fd > 0)
>> +		if (fd >= 0)
>>  			return fd;
>>  		/*
>>  		 * Fatal error (EPERM, ENOSPC etc).
