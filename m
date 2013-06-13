From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] rebase: prepare to write reflog message for checkout
Date: Thu, 13 Jun 2013 10:51:25 -0700
Message-ID: <7vbo79vqzm.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBgL-0003z1-4t
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab3FMRv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:51:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938Ab3FMRv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:51:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E906F27D71;
	Thu, 13 Jun 2013 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AKPPlWoQOUpkbsQuckOO1VA40lg=; b=dXQKVn
	HeOGg4lgMBwD4Suzj5hRidyQzCXhuuluncbKN+N+wlnJbXHx/55cK5Con2ncZVPs
	od3jVaFrO13QbtmmFbOyduJil4M5Mc7eolZ8ejFBKXNgTttQcHfAtcrf822/FKD3
	IzNyuboj1Q8UCPE0uLLI4Z2Fa59NCyAek5jfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ur/3qje+ksQPiuUN/13ijguTHJ6CVVap
	RQhiJNpE0WmeaAg5UwaQzNeZBvetuUjzUNP6jLPe+Q+B1Ep8VTzDVvfkBASdPwhr
	jNcAVOCyMmud+inC5Xzw6vY5N74gGO4wMLn/1QDk9a8z06AMZgSz8qQaWLmFqqNe
	lFxeDA9KL9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E13A127D70;
	Thu, 13 Jun 2013 17:51:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65E2D27D69;
	Thu, 13 Jun 2013 17:51:27 +0000 (UTC)
In-Reply-To: <1371130349-30651-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Thu, 13 Jun 2013 19:02:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF0EBEA8-D451-11E2-8218-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227756>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> rebase should never write "checkout: " messages to the reflog, since it
> is highly confusing to the end user, and breaks
> grab_nth_branch_checkout(), as demonstrated by failing tests
> in t/checkout-last.  

"breaks" because "the branch flipping rebase internally does is not
'checkout' as far as the end user is concerned", which essentially
is the tautology with the first part "should never write".

I would say

    The branch flipping rebase internally does is not 'checkout' as
    far as the end user is concerned; rebase should never write
    "checkout: " messages to the reflog.  Instead it should say
    "rebase: checkout master".

> Set a sensible GIT_REFLOG_ACTION: checkout does not
> respect GIT_REFLOG_ACTION yet, but this defect will be addressed in a
> future patch.

That is not a defect; it did not have to so far, until this patch.

I suspect doing 6/6 before this patch may make more sense.
