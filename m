From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
Date: Fri, 22 Aug 2014 09:31:29 -0700
Message-ID: <xmqqiolkpjtq.fsf@gitster.dls.corp.google.com>
References: <1408637110-15669-1-git-send-email-prohaska@zib.de>
	<1408637110-15669-3-git-send-email-prohaska@zib.de>
	<xmqq1ts9qy24.fsf@gitster.dls.corp.google.com>
	<0342479D-7C9F-42E6-9B79-745AEDE57EB5@zib.de>
	<xmqqmwawpldt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:31:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrkh-000412-03
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 18:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803AbaHVQbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 12:31:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62963 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932484AbaHVQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 12:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5619C32C9F;
	Fri, 22 Aug 2014 12:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R7baNfVSwa/AD6CjOnHvkbj2WZw=; b=nTKYci
	NSdG49LJuI25fTvIyvEn+fmHmRHzmsoN5GtpKWcmfCb0+0z2C3qlr9MEBZjmvDWT
	We29XhML0hv1WWuGuHU7DLMoJZmoMz/5jXffRPHPuJOUgHLyfTbk5/4KVPHCbXXo
	VVj+GQny3hu71bGvN72T1f3RyGP1C42VMOnnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dNrhPHZXBvF8DA25/eSrHpVYe3ZkvxDG
	55ZxLBTc3jALCrY3FRNbMAUftR5JJoXSOZcXQM6XskTdZVbR1hBCnt5N98odk3zT
	a8xQG+COzyAoF90ZqQiLDnZ42q984DC4atWHP4OOa9Rby4VR2N4eEZGsBJJBCJ2J
	xsSy216nnaI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47FC732C9E;
	Fri, 22 Aug 2014 12:31:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EAE4132C92;
	Fri, 22 Aug 2014 12:31:30 -0400 (EDT)
In-Reply-To: <xmqqmwawpldt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Aug 2014 08:57:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5D8560A-2A19-11E4-81B9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255685>

Junio C Hamano <gitster@pobox.com> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>>>> +	if (limit == -1) {
>>>> +		const char *env = getenv("GIT_MMAP_LIMIT");
>>>> +		limit = env ? atoi(env) * 1024 : 0;
>>
>> ... this should then be changed to atol(env), and ... 
>
> In the real codepath (not debugging aid like this) we try to avoid
> atoi/atol so that we can catch errors like feeding "123Q" and
> parsing it as 123.

Sorry for hitting <SEND> by mistake before finishing the paragraph,
which should have concluded with:

    But it is OK to be loose in an debugging aid.  If I were doing
    this code, I actually would call git_parse_ulong() and not
    define it in terms of kilobytes, though.
