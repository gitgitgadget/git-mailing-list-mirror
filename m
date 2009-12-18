From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] branch: new option --will-track
Date: Thu, 17 Dec 2009 23:16:26 -0800
Message-ID: <7vd42c4ur9.fsf@alter.siamese.dyndns.org>
References: <1260956399-13802-1-git-send-email-cxreg@pobox.com>
 <7vaaxhdu1f.fsf@alter.siamese.dyndns.org>
 <20091218061851.GA10221@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 18 08:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLX4t-0004z5-V1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 08:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZLRHQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 02:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZLRHQj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 02:16:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRHQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 02:16:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 477C488C23;
	Fri, 18 Dec 2009 02:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=auMvLvQSgt9hJ+kMymu6hFSbEGM=; b=tfhLOp
	ZA4RdfiBKpOMfgFyfC/DGmXJijvxkD/SQNm3urvuZe4RCmreDQk6e3NOG2FzotXC
	5ZP8Goa0BYOOGuWsSLndrJZy/JajXEZ9tbct7I4K67gbTlRPvJuD7Lv65BCx/Gez
	kb4nRU4geHrsvX3utGSwl4hALRON4z5DvH/xY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kk8kBL5L6RX04dpGrZ1aDXdCXvylhQw3
	HIugbmPx+pv8//xlwdsVPMhSfnE0h0zmMKhpoD0VuMxuD5BTZxyGMrLUD4JnLQS9
	Emmk5y2eHsbZrNOtKMuWyqQSEqLgvfewJH/YbmfNKBUkqtPZZFlt/dU9dhFb7WPc
	rnaFxLTkYI0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1514A88C22;
	Fri, 18 Dec 2009 02:16:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46BCD88C1F; Fri, 18 Dec
 2009 02:16:28 -0500 (EST)
In-Reply-To: <20091218061851.GA10221@inner.home.ulmdo.de> (Andreas Krey's
 message of "Fri\, 18 Dec 2009 07\:18\:51 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4497194E-EBA5-11DE-9760-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135404>

Andreas Krey <a.krey@gmx.de> writes:

> On Thu, 17 Dec 2009 16:07:08 +0000, Junio C Hamano wrote:
> ...
>> Also "git pull --remember $there $this" might be a good way to tell the
>> configuration mechanism from the UI to remember that "I always want to
>> merge $this branch from $there while on the branch I am currently on", and
>> its implementation may probably use "git branch --reconfigure" internally.
>
> Actually my favorite would be 'git push --track $there', pushing
> the current local branch to $there and setting up tracking. That
> way the tracking decision need not be made before the remote
> branch actually exists.

Yeah, it may be useful, but that belongs to the same "in addition to the
most flexible form, we might want to _also_ do so" category, as the one
that makes "git pull" remember.

The advantage of remembering upon the first pull is that the request to
remember doesn't involve any "push is reverse of pull" indirection.
Instead, it is exactly what the user actually has done once: "I'm doing
this once, remember it for me".  Compared to it, I think it is less
obvious to make the first push remember its reverse [*1*].

Another issue that you need to think about is how you will allow users to
set up "integrate with merge or rebase" when making "push" remember.

An option with "pull" would make it much more obvious what is going on, as
the user would say "git pull --rebase --remember $there $this" if rebasing
is desired, and that is what is going to be remembered; again that is
thanks to the "I'm doing this once, remember it for me" semantics.


[Footnote]

*1* I am not saying "if you have 'pull --remember' you don't need 'push
--remember'" or vice versa.  As long as each (judged individually) makes
sense we could have both.
