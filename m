From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/8] add line number and file name info to `config_set`
Date: Thu, 07 Aug 2014 13:09:16 -0700
Message-ID: <xmqqwqakjc43.fsf@gitster.dls.corp.google.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
	<1407412759-13833-4-git-send-email-tanayabh@gmail.com>
	<53E3D494.1070606@ramsay1.demon.co.uk> <vpqlhr0m5tl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 07 22:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFU0E-0005oK-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 22:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbaHGUJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 16:09:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53387 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbaHGUJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 16:09:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 725A82DA22;
	Thu,  7 Aug 2014 16:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SjG1ZBQrwQVPvZomhAfmLzJQErM=; b=ptvv/B
	0o/Uyt6u8wS9gndDRLEBa7Bn801qGesk0IC4o/d7EG0HIYJGRqtl4E+um4yKNFG8
	lXxq/CG/LlJIy8EthFVUeEla+jR6XAE9tSsDoQhDhvE5rlHXUFqBk0PKtw20EZiu
	InwZszjmZsNjoGYMYDzeoznzvZSRfoFCAlw4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QIOhpKOunR+33M2dL7vLVZrUNVd7eT51
	1wmrvyHpEymbnxj6kA697ejbFbADfsVC4X1derZBHxJOhDV6dudy/dxwsHr18r33
	jxMZMSGEEdF+Bgp1LU1w4TTCbhLia6Vaik4M5/jATvl9BczWYW21/vVNNOSGhBe5
	qs1n3UTP0dU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68ACE2DA21;
	Thu,  7 Aug 2014 16:09:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D22C52DA19;
	Thu,  7 Aug 2014 16:09:17 -0400 (EDT)
In-Reply-To: <vpqlhr0m5tl.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 Aug 2014 21:56:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B61FFCB0-1E6E-11E4-B895-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254993>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> ...
>>> diff --git a/cache.h b/cache.h
>>> ...
>>> +struct key_value_info {
>>> +	const char *filename;
>>> +	int linenr;
>>> +};
>>> +
>>
>> I haven't checked, but does this series now include a user for
>> this struct outside of config.c? If not, then I think it would
>> be better to leave the declaration in config.c until it is needed.
>> (To make it easier to see if it is necessary in the context of the
>> patch which will make use of it).
>
> I disagree: this patch series is essentially about introducing a new
> API, and this struct declaration is part of the API.

Hmm, is it?  How would the customer of the API use it?  die_config
and friends may internally use the information recorded using the
structure, but I had an impression that it is an implementation
detail that does not need to be exposed to the customers of the API.
Am I mistaken?
