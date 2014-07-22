From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] refs.c: fix handling of badly named refs
Date: Tue, 22 Jul 2014 14:46:28 -0700
Message-ID: <xmqqzjg1dq2z.fsf@gitster.dls.corp.google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-13-git-send-email-sahlberg@google.com>
	<xmqqlhrlf7oe.fsf@gitster.dls.corp.google.com>
	<CAL=YDWnTNKGW3AAr7twZ44KUb1Pxu0kms5Lt_3-4LBYGQw2+PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9htQ-0004Ga-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbaGVVqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:46:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60554 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359AbaGVVqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:46:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A46AB2CC08;
	Tue, 22 Jul 2014 17:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rVkwvSJsn88efxaKNpP2A38EXPQ=; b=dW+iQ3
	U3dq0ZS+51vNHzGxn4bx/9a1AaMGdA/lj/ccG8CPY9ZYFczq07WaU4yKz8bZOY1E
	R8oJsN+EGtIEjPgu89+jsM6IUGuXEOZzBGE6irvdxmY4/Ujc0hHB2c86mm6zsFSa
	FZFnG1xDxCuvKx9+7uOblze09HkqeI0tqazAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5jkThXzzGyMrDcHhPPMEQN9+F9Q05uC
	Dz4wlSIMk66tneHRqM/XwP7+JUNDWIOlFV2F7KLHbmYezRpFXQAhgFaJrqYrapQU
	DkCSFhVUE1auL/sKRqtw7zLnbA/90Q4eYMt/xUF9kPp/Z3dS8KJQDoDb4heFM4Wb
	PqLpMN60hu4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98EA92CC07;
	Tue, 22 Jul 2014 17:46:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B845A2CC03;
	Tue, 22 Jul 2014 17:46:29 -0400 (EDT)
In-Reply-To: <CAL=YDWnTNKGW3AAr7twZ44KUb1Pxu0kms5Lt_3-4LBYGQw2+PQ@mail.gmail.com>
	(Ronnie Sahlberg's message of "Tue, 22 Jul 2014 14:30:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A397EF9E-11E9-11E4-AA9A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254047>

Ronnie Sahlberg <sahlberg@google.com> writes:

> I don't think we need to do that.
> That would imply that we would need to be able to also allow reading
> the content of a badly named ref.
> Currently a badly named ref can not be accessed by any function except
>  git branch -D <badlynamedref> which contains the special flag that
> allows locking it eventhough the ref has an illegal name.
>
> So no one else should be able to read or modify the ref at all.

OK.

> I think it is sufficient for this case to just have the semantics
> "just delete it, I don't care what it used to point to." for this
> special case  git branch -D <badrefname>
> so therefore since it is not the content of the ref but the name of
> the ref itself we have a problem with I don't think we need to read
> the old value or verify it.
