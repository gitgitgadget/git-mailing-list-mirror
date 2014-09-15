From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Mon, 15 Sep 2014 11:25:42 -0700
Message-ID: <xmqqppew7nbt.fsf@gitster.dls.corp.google.com>
References: <1410683442-74523-1-git-send-email-davvid@gmail.com>
	<5415C069.9000702@gmail.com> <20140914185403.GA93515@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTayD-0008Kj-DO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbaIOSZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:25:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57160 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbaIOSZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:25:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E99F3934E;
	Mon, 15 Sep 2014 14:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04F1bSjcEdjFigXz19MlUYbJp+U=; b=eSJTrn
	fehTQPWYcOqABdFUHo8wfmKmJjdid3IHX78YQxlrFVAqa/0zLcm3wiT+1uzssA6I
	tNsPLUbN/4OFWN7DJtAWipsjbeKm9NizuWv/14/gTQIM+0hgDTiijRLPBMs7Mst7
	ao41jzM8ER7OafHMU6pbynBuks/3KOEed+Za4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhKOSqa5zFhyq3RHGnYRSYGGqCnXswtl
	jRqErR3RJeZO3E9kptI/rbi2Nkwz8bpvut3VNuUWQ3T87TBSDvUKavfDDgynqsXu
	HF3Zyot+IJJZPsbMg0X9yAomLUTdie+58XviGCWUJHzQf64gn9zu+eqbqRCbQ1om
	dsGJGvei4+0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 531383934D;
	Mon, 15 Sep 2014 14:25:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB9C23934A;
	Mon, 15 Sep 2014 14:25:43 -0400 (EDT)
In-Reply-To: <20140914185403.GA93515@gmail.com> (David Aguilar's message of
	"Sun, 14 Sep 2014 11:54:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4589FE4-3D05-11E4-9466-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257064>

David Aguilar <davvid@gmail.com> writes:

>> > +test_expect_success 'fails silently when using -q with deleted reflogs' '
>> > +	ref=$(git rev-parse HEAD) &&
>> > +	: >.git/logs/refs/test &&
>> > +	git update-ref -m test refs/test "$ref" &&
>> 
>> I'm just curious, why not simply
>> 
>>    git branch test
>> ?
>
> Maybe it's a bad reason, but I wanted to replicate the behavior
> that git stash expects -- it writes to a ref outside of
> refs/heads/.  I thought it'd be good to exercise that same
> machinery since it will involve different code paths.

I think that is a very sensible thing to do.  Another reason to
avoid using "branch" when you care about what "update-ref" does is
that "branch" does more than what "update-ref" does.
