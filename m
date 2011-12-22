From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Wed, 21 Dec 2011 23:00:43 -0800
Message-ID: <7vehvxdrac.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <4EF2D436.3080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 08:00:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdce2-0004tV-Si
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 08:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab1LVHAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 02:00:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab1LVHAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 02:00:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7F53ACF;
	Thu, 22 Dec 2011 02:00:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YbgiNcVE0G9N6bEcVVrQqS4BZLE=; b=jzq7a5
	V7C/uZfjV//luILVfIyzZTQ5Wq66/i8k378MleoNMTRf4ZijaDCrS9+GbJJIjzKG
	u+kDaj98i5BLfMYk4LQx5Iyf7I6QhLG86DwSU8Dxl8dS9+dRcpntlVVzGPa8tcqO
	YaaNmMVoYRT2NTsCMMzh0YL/Ix2Luw5CeBu1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+BYON8XQT0JOhoJONp4wSlh8RsSA9XW
	zoz4qDsCoI0mel8lLHotqg8XU3MPZi7S3x4hax1ah0rviBPss/w6iREUR+8I9fjz
	TblvUlZQt8H/NOtFebA8TPt0nl8vGyVnT9/ATr5N10GxKiULaaoL4j0DXFDzGMDq
	Be4u77UCQBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5290F3ACE;
	Thu, 22 Dec 2011 02:00:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D189B3ACD; Thu, 22 Dec 2011
 02:00:44 -0500 (EST)
In-Reply-To: <4EF2D436.3080303@viscovery.net> (Johannes Sixt's message of
 "Thu, 22 Dec 2011 07:54:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB3A1AA4-2C6A-11E1-8DF0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187600>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/22/2011 0:55, schrieb Junio C Hamano:
>>  void advise(const char *advice, ...)
>>  {
>> +	struct strbuf buf = STRBUF_INIT;
>>  	va_list params;
>> +	const char *cp, *np;
>>  
>>  	va_start(params, advice);
>> -	vreportf("hint: ", advice, params);
>> +	strbuf_addf(&buf, advice, params);
>>  	va_end(params);
>> +
>> +	for (cp = buf.buf; *cp; cp = np) {
>> +		np = strchrnul(cp, '\n');
>> +		fprintf(stderr, "%s%.*s\n", _("hint: "), (int)(np - cp), cp);
>> +		if (*np)
>> +			np++;
>> +	}
>> +	strbuf_release(&buf);
>>  }
>
> IMHO, this logic should be moved into vreportf(), and we get proper
> prefixing of multi-line warning(), error(), and die() messages for free.

Very very good point.
