From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 12:06:51 -0800
Message-ID: <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GRz-0004n7-1l
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbaAFUG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:06:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbaAFUG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:06:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD9E5FD4F;
	Mon,  6 Jan 2014 15:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6W6rF1BH7CawXiCS3qodx5m5Ec=; b=H2hWlv
	bxMYASBuDh+Hvn54aH9fZnY5r6nNXvRYcmWYVlSRz+hqHwCOsOVDlHU0SJa6RaxE
	HwHYtL1AGTCvHOfd83IPm3WXqVcEGkCWIPgz6HNj4FQPOyuT2kbPmRCyhGyXDL1U
	1tVc9wcxg1KEE3OQFJf3FUBp4zmpPLcWV96FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F46JUfH6eCljYg18KvSM6ThftqmbpRFn
	moNNur6TFCtVlD4epBSnsQ4GIHjajDJStnBy4+jTJFMxQHmm1r6ekJeC5GvfougT
	ftuIaoTYm/mLjoYIKlizBaKiEC5EXjc+OaeKFxA2/O6qQcp5IRU2KpPvE8WRPdUT
	qWe873FuSy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2EDC5FD4E;
	Mon,  6 Jan 2014 15:06:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 146905FD47;
	Mon,  6 Jan 2014 15:06:55 -0500 (EST)
In-Reply-To: <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 7 Jan 2014 00:19:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 170876E6-770E-11E3-AF57-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240055>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>  - why is a single branch name sufficient?
>
> It does accept a <revision>, so any form is allowed; but why would
> anyone want that in a format.defaultTo? I'm not sure we want to impose
> an artificial restriction on the configuration variable though.

I meant "a single branch" as opposed to "depending on what branch
you are sending out, you may have to use a different upstream
starting point", and a single "format.defaultTo" that does not read
what your HEAD currently points at may not be enough.

Unless you set @{u} to this new configuration, in which case the
choice becomes dynamic depending on the current branch, but

 - if that is the only sane choice based on the current branch, why
   not use that as the default without having to set the
   configuration?

 - Or if that is still insufficient, don't we need branch.*.forkedFrom
   that is different from branch.*.merge, so that different branches
   you want to show "format-patch" output can have different
   reference points?

After all, "format-patch" to send things out to upstream is like
asking the other side to do a "rebase" you would do in your
repository, so whatever "git rebase" that were too lazy to specify
what the fork point was when applying may be a reasonable type-saver
default.  Yes, sometimes people need to rebase onto somewhere they
did not fork from, but that is why they can give explicit $upstream
and $onto to the command---I do not think it is any different for
"format-patch".
