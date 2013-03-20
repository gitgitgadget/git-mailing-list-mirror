From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: fix "Applying" message when applypatch-hook was
 run
Date: Wed, 20 Mar 2013 16:52:43 -0700
Message-ID: <7v1ub9d3xw.fsf@alter.siamese.dyndns.org>
References: <b978a77f8a37c47b2d6c2201d1f7cfffa01f8443.1363820289.git.simon@ruderich.org>
 <vpqli9hmyov.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 21 00:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UISoj-0005Vt-UX
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 00:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3CTXwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 19:52:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3CTXwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 19:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57EEBA539;
	Wed, 20 Mar 2013 19:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vTsUV609Hn4vo36U4/UnvVOWaJI=; b=ALVBCY
	OhZK0QhWCjZ22aw4tTxp9EuOxYq4u8z5qCxzAJHWtasdok1hUYB8aQhKMmylprKs
	E9lH01ow58bGixCFWedqCX4AmIgQT1R8tDK98iRmD68Dk26Nf3GogJbQL/odIgE7
	IQh3TaIzJv23+jvJZTFtpnlTMwTNWGAD4BeDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=he0bqeYfd78aQdbxMbQey4LnpqBkikOE
	VJfqpTEpc3LLxXyEWTLD5Rl0LJwPBMMzf20ZzDuZzerIT/qm68VtiDZKwgpEhD7p
	qxU6D70u57uJoXge7BzcmXQS57DzPalam1fVzrgxPWeNuIAWTYUzlA0NBHkeP04y
	pmGJWb4tgT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BBA2A538;
	Wed, 20 Mar 2013 19:52:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9527A537; Wed, 20 Mar 2013
 19:52:44 -0400 (EDT)
In-Reply-To: <vpqli9hmyov.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 21 Mar 2013 00:36:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42A5BC90-91B9-11E2-A657-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218689>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Please, read SubmittingPatches in the Documentation directory of Git's
> source tree. Your text above should be a commit message (hence, no
> hello), and should not be below the --- line.
>
> Also, read about signed-off-by in the same document.
> ...
> This copy/paste a piece of code that is already a few lines above. Is
> there any reason not to _move_ the assignment to FIRSTLINE after the "if
> test -x "$GIT_DIR"/hooks/applypatch-msg", to avoid duplicating?

More importantly, is this change even desirable?

The original motivation behind the "Applying:" message was to help
the user identify which one of the 100+ patches being fed to the
command, and it was not about showing what we ended up committing.
When you are running the command interactively, we do grab the
edited result since f23272f3fd84 (git-am -i: report rewritten title,
2007-12-04), but I tend to feel that the automated munging done by
applypatch-msg falls into a different category.
