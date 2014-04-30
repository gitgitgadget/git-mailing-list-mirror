From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] use approxidate for "git commit --date=xyz"?
Date: Wed, 30 Apr 2014 14:34:59 -0700
Message-ID: <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
References: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:35:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfc9v-0007L2-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945910AbaD3VfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:35:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759237AbaD3VfK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:35:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5710821F3;
	Wed, 30 Apr 2014 17:35:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NeiqeCXmKODLwS3EcMqhQ0zBTG0=; b=c2UD9Q
	DIPG5Cb3YsNkdsu5psYvnB6XUPXa4LC8dZBrIo2/9pLL/RO/Bh517Gjm+ewyUrrP
	3O039KaxBECn3IlrroIzUBOvy7l8qTCIa5zAPxjHJsEqepAnaC3CQiWxU4Rzj0lo
	R/qXO5xUpYd4/19/Evy+TofqXFFbTK+0CWFeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MI4kOm/cMuNQFw9wtMLgX1tb5Oaa0ck5
	BO+cq+58JlUxuVsyDAMbkIUcVCmd56DyZRtknjnJj6gpi5S51ChvlutevD1WMdb5
	YN7j/HBfNq2YTz+9lXX+QDV7IHhO+U8vMdmHwmWRpBWFKO3ZBdQeVg/aNDaH4uZa
	LooyuPIjOyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2FD821F2;
	Wed, 30 Apr 2014 17:35:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CD1B821ED;
	Wed, 30 Apr 2014 17:35:01 -0400 (EDT)
In-Reply-To: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 30 Apr 2014 14:09:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 490CA414-D0AF-11E3-A0AF-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247782>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I just got a comment saying that
>
>     git commit --amend --date=now
>
> doesn't work. I replied that you can use
>
>    --date="$(date)"

Offhand without double-checking the actual codepath I do not have
objection against approxidate-careful.

But why does the workflow need --date=now in the first place?
Wouldn't --reset-author do what you want better?  What is the
situation where you want to say that this patch has been changed
significantly enough from the original to label it with the current
timestamp without taking the authorship?

> but I do wonder if we should accept the approxidate format - we do in
> other equivalent places. Hmm?
>
> The code uses fmt_ident(), which uses parse_date(), which in turn uses
> parse_date_basic(). Maybe parse_date() could use
> "approxidate_careful()" instead of "parse_date_basic()"?
>
>             Linus
