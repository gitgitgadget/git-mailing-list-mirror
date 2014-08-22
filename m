From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Fri, 22 Aug 2014 08:57:50 -0700
Message-ID: <xmqqmwawpldt.fsf@gitster.dls.corp.google.com>
References: <1408637110-15669-1-git-send-email-prohaska@zib.de>
	<1408637110-15669-3-git-send-email-prohaska@zib.de>
	<xmqq1ts9qy24.fsf@gitster.dls.corp.google.com>
	<0342479D-7C9F-42E6-9B79-745AEDE57EB5@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrEB-00014e-Sf
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbaHVP6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:58:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61922 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266AbaHVP6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:58:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD94232481;
	Fri, 22 Aug 2014 11:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/bcks7FilTjHcbpU+NaSeVdvEow=; b=NCLaCv
	V60NqkTK2H2AK0Zrc3tvuTQl8vknJeCJ2Dposvzl0A1JJ7/TkVqDzBFftwI8t4DS
	XH4rD13eV3aiX9wjA2439nf/4ns+q2Muwt7YpTFHj267LrMN4ECfIEnudOVP7TJ1
	qHOUAde2NGTYKOTt6iLkYeysmMjgsRzeucNRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qN0A/tv5C8HqLhgde1TFh/VyvSa7tFgx
	WggukOoiV3pHex2iyOVNIhF7ibLVBvsV0rlZnmWRDUV9iV8cQjR1fb2QueSzxUWT
	uh03XWcfajb3q5Jofhf5nfhayzM5LIFBhApmfjpiL0e9AJxxSKp2ykCD0h+R2xCW
	Qse7W2S3a6c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD49F3247F;
	Fri, 22 Aug 2014 11:58:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B18CE3246B;
	Fri, 22 Aug 2014 11:57:51 -0400 (EDT)
In-Reply-To: <0342479D-7C9F-42E6-9B79-745AEDE57EB5@zib.de> (Steffen Prohaska's
	message of "Fri, 22 Aug 2014 15:46:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 124946A2-2A15-11E4-A170-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255681>

Steffen Prohaska <prohaska@zib.de> writes:

>>> +	if (limit == -1) {
>>> +		const char *env = getenv("GIT_MMAP_LIMIT");
>>> +		limit = env ? atoi(env) * 1024 : 0;
>
> ... this should then be changed to atol(env), and ... 

In the real codepath (not debugging aid like this) we try to avoid
atoi/atol so that we can catch errors like feeding "123Q" and
parsing it as 123.
