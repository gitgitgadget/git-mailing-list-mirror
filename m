From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Sun, 15 Mar 2015 00:30:06 -0700
Message-ID: <xmqq3856vhtt.fsf@gitster.dls.corp.google.com>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqa8zevhya.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 08:30:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX309-0000qp-Fs
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 08:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbbCOHaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 03:30:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751180AbbCOHaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 03:30:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 130C938A8B;
	Sun, 15 Mar 2015 03:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVGhO+8kFj/L2tKFPilbXb8+vwc=; b=fn7m4h
	Clkv4R9gTYLvuyHsEqxFKqj3jTTdqZN2QO3PtbCC9LgMpT3IA4OnbpXOMrLWh6an
	slFDX4pwr+B9zASpJ3cTLYzqtUfN+ETbAKzmLRIoCM280Lr9UMJPcfAdmoj/cs59
	0YXkZcBStYXWR/FY20sttSml+jplPiDvxIuvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jviztWT2h3A9XzQiC3b0X7JMQ41JvT5K
	Ii8E0hRRQwYkx9BSW14FaqZbjvN6upfZqZDSDky1J9sPPMiZOub2zBR9tlv7N0DM
	dunCk2xm4T+eIPo/dqmxdSB6RW9FAQZ/X5Hi3IBQTp5V6mqGUeFxAurFWjttoyGl
	zz4ojpm/d20=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C9C738A8A;
	Sun, 15 Mar 2015 03:30:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94EFD38A89;
	Sun, 15 Mar 2015 03:30:07 -0400 (EDT)
In-Reply-To: <xmqqa8zevhya.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 15 Mar 2015 00:27:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AF01490-CAE5-11E4-B2C2-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265485>

Junio C Hamano <gitster@pobox.com> writes:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> Hi guys,
>>
>> So I was looking at fetch-pack.c (from master @ 52cae643, but I think  
>> it's the same everywhere):
>>
> ...
>> -		hashcpy(ref->new_sha1, local);
>> +		hashcpy(ref->new_sha1, o->sha1);
>>  		if (!args->verbose)
>>  			continue;
>>  		fprintf(stderr,
>>  			"already have %s (%s)\n", sha1_to_hex(remote),
>>  			ref->name);
>>  	}
>>  	return retval;
>> ---

One thing I wonder is if this hashcpy() is doing anything useful,
though.  Is ref->new_sha1 used after we are done in this codepath,
or is the reason nobody noticed it is because it does not matter
whatever garbage is in that field nobody looks at it?
