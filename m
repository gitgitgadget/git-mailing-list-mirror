From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Thu, 10 Jul 2014 10:36:09 -0700
Message-ID: <xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	<xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 19:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5IGc-0001hn-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 19:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbaGJRgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 13:36:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53516 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaGJRgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 13:36:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF0C726C4A;
	Thu, 10 Jul 2014 13:36:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xb35NCWYHQU0pvEmA1CosN8VrvU=; b=itTRuN
	Xr9cOr0rvEFjo/B1Ge5x0Aiby1IdKKY/zrrFJ45lbNKfXPK1P8QwEkXWvsx7I5Qc
	Mc8qyVRTc8ZlCmw7S/aQXTjRZLawT0xqhB/kHumkMFB8Av7M0covCHsJ9F5l2JHw
	8/oM1ThqVB2jeIx1MnzH7+rv2pS/NuRZZzqXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J07x6kPk8VFH25mNR4LmaL/rOkOG2fXj
	XeayhMdFSouB9yWLmsXMvB3i5ciSJq7ox/h8Mr0aLzq3ZJ5vv9k6RLU1ZWxFMf74
	ZArI58C1yTHI8ccx/HEV9zLDcxEaUtHVErlE7+SSAQUWN9p+KxDSoRMLrQlkEhQF
	wbxl0cvK2xU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A815526C48;
	Thu, 10 Jul 2014 13:36:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4AA626C42;
	Thu, 10 Jul 2014 13:35:55 -0400 (EDT)
In-Reply-To: <xmqqr41t88dz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Jul 2014 09:51:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A5C8611C-0858-11E4-A0F7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253195>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>>> Is this really an error?  It may be a warning-worthy situation for a
>>> user or a script to end up doing a no-op graft, e.g.
>>>
>>>         git replace --graft HEAD HEAD^
>>>
>>> but I wonder if it is more convenient to signal an error (like this
>>> patch does) or just ignore the request and return without adding the
>>> replace ref.
>>
>> As the user might expect that a new replace ref was created on success
>> (0 exit code), and as we should at least warn if we would create a
>> commit that is the same as an existing one,...
>
> Why is it an event that needs a warning?  I do not buy that "as we
> should at least" at all.

Ehh, it came a bit differently from what I meant.  Perhaps s/do not
buy/do not understand/ is closer to what I think---that is, it is
not like I with a strong conviction think you are wrong.  It is more
like I do not understand why you think it needs a warning, meaing
you would need to explain it better.

> If you say "make sure A's parent is B" and then you asked the same
> thing again when there already is a replacement in place, that
> should be a no-op.  "Making sure A's parent is B" would be an
> idempotent operation, no?  Why not just make sure A's parent is
> already B and report "Your wish has been granted" to the user?
>
> Why would it be simpler for the user to get an error, inspect the
> situation and realize that his wish has been granted after all?
