From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/38] refs: create a base class "ref_store" for files_ref_store
Date: Fri, 10 Jun 2016 08:53:00 -0700
Message-ID: <xmqqziqtf3c3.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<8ee7d7359f6763cba29dc788aba2f236204bb76e.1464983301.git.mhagger@alum.mit.edu>
	<xmqqbn3drkwd.fsf@gitster.mtv.corp.google.com>
	<575978DA.30608@alum.mit.edu>
	<xmqq60tijq4g.fsf@gitster.mtv.corp.google.com>
	<575A5BCF.20409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 17:53:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBOkB-0002Cp-8U
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 17:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbcFJPxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 11:53:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932114AbcFJPxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 11:53:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDFFB22E31;
	Fri, 10 Jun 2016 11:53:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zIobuKFnuz7vtibLT3SULdaoE6c=; b=SOuFO7
	w6kg8TulRZITC/4lKsCXFQPr7j8jv6Os6xMsGcF2cXP+tDfaqAv8/M2LDqx4AiOx
	tD5oY4DTwlA/1pdebkJktxwzNlwvbioq0DDxJFkAlyMKJUlQIiDvyOq3qzQmBZu5
	1gz1U/rNifYdQKlmQmIpAhvbc9/Qqb782oJno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHjs5SDkasLpig/Zo47Y8ZK7T0ZpYG9I
	DZ+BQteAX6VfRypw/dFwtj8H78nw5VYrpPB5KmTQvrnV9Ha7W0SYBtQxv0fYeOKf
	QR0jBFYPM9NCv0cJaHTYN41gkBcxe9Z2dLEsMLcn6EX9RZ7u2tKi+f0Olb4xDTpF
	89/s3b1XZN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E61CE22E2E;
	Fri, 10 Jun 2016 11:53:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C05B22E2B;
	Fri, 10 Jun 2016 11:53:02 -0400 (EDT)
In-Reply-To: <575A5BCF.20409@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 10 Jun 2016 08:18:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69B4D720-2F23-11E6-8020-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297008>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/09/2016 06:14 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>>>> +static struct ref_store *main_ref_store = NULL;
>>>>> +
>>>>> +static struct ref_store *submodule_ref_stores = NULL;
>>>>
>>>> Let's let BSS take care of these initialization.
>> [...]
>> Lack of "= ..." is a clear-enough clue that the code wants these
>> pointers initialized to NULL.
>> [...]
>
> OK. While I'm at it I'll add docstrings for these variables.

Yeah, if you explain what they are used for, it would become obvious
why their natural initial state is NULL.
