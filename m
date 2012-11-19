From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-describe fails with "--dirty is incompatible with
 committishes" if passing HEAD as argument
Date: Mon, 19 Nov 2012 11:36:33 -0800
Message-ID: <7vfw45xu4e.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBjw0W4kLCKMj6HhdjAXOJYpDW2Rgncb+06ahjiYOWtZ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 20:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaX9G-0003io-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 20:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab2KSTgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 14:36:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311Ab2KSTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 14:36:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75087A710;
	Mon, 19 Nov 2012 14:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yb+E/UTa+Y9Iib3WrmG6My0UybI=; b=tLpdOw
	TIVVDmUUyOZA/LFmPuzDrHrCE7f5CemPiQ2qa3wJCZUxumPMQq7XTyi8P50nDhLe
	VlhlmugqG+1ycZtDYLiaPW42e2ZH57GNA15rM7A1A3Ld+rM6Ki7JYc5O+ekb1kvo
	KxIYlPKSJ7AY3ROjEBdqjymPSM9iP7xVQI2v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCnIyRNkC6+yYheXLkaT2Y8UaO4eQPW2
	viyYpvelQe3OLlyeFdJftgt5gZ7eHbzcOcXDz3ZoCbKgBUTWEvRIhs9mWN4ZeKm4
	RJsC+ySGhyBWo5C+MvMJdtUyN1EhxPbY2B6lR/jw+78H1vK9ADXyzLx6WmtXOUFI
	RcoNeJV9elM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61DE1A70D;
	Mon, 19 Nov 2012 14:36:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C60D2A70B; Mon, 19 Nov 2012
 14:36:34 -0500 (EST)
In-Reply-To: <CAC9WiBjw0W4kLCKMj6HhdjAXOJYpDW2Rgncb+06ahjiYOWtZ8Q@mail.gmail.com> (Francis
 Moreau's message of "Mon, 19 Nov 2012 16:47:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D75FEF0-3280-11E2-BE11-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210050>

Francis Moreau <francis.moro@gmail.com> writes:

> Inside the kernel repository, I tried this:
>
> $ git describe --dirty --match 'v[0-9]*' --abbrev=4 HEAD
> fatal: --dirty is incompatible with committishes
>
> If 'HEAD' is removed then git-describe works as expected.
>
> Is that expected ?

I would say so, at least in modern codebase.

"git describe" without any commit object name used to mean "describe
the HEAD commit using the better known points" before the --dirty
option was introduced.

But "--dirty" makes it describe the current checkout.  For example,
output from "git describe --dirty" v1.8.0-211-gd8b4531-dirty means
"your working tree contains work-in-progress based on d8b4531, which
is 211 commits ahead of the v1.8.0 tag".  So conceptually, it should
not take any commit, even if it were spelled HEAD.

"git describe --dirty HEAD^^" would be an utter nonsense for the
same reason.
