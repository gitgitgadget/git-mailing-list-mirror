From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Storing refs in the odb
Date: Mon, 20 May 2013 10:21:10 -0700
Message-ID: <7vbo85wos9.fsf@alter.siamese.dyndns.org>
References: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 20 19:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeTm0-0001eM-4X
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab3ETRVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:21:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755455Ab3ETRVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:21:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 358951CE96;
	Mon, 20 May 2013 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PKbxWluFu/hzyG0LkOdR147zB8=; b=IeBQlf
	wi5Ac8bz4JMXkJO5jaEqnyFxB/GK7rS6jpWtsV8TuXxMCsu1h1oWSjPk79Nq+x+V
	4Mlg5e5ru7vuAiuVfzOjXY4Y5ERLDmIqcmJXRu38oxRq/sBDmpDzPQvou2ahZhge
	sUWqhZ/9z1uHboUkDSQMtokTsvp/Y/UNq5qyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fVjHgc8bKBIlwzsIg7wUfjc+r9DRyJGX
	RwpfajQMlwO19mR3HVe604DtMpuNncvxXRuEVmkhSNP6YRLfdoC5hlhFlh3lKFR+
	7DPjoNt6Nqpb7EEQdM7NWBJgnZ7IGwDW7UDClB6AQXJyejQcCq5or0OP7drviESP
	0+m8zmJoOIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D07B1CE93;
	Mon, 20 May 2013 17:21:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 657541CE90;
	Mon, 20 May 2013 17:21:12 +0000 (UTC)
In-Reply-To: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
	(Johan Herland's message of "Mon, 20 May 2013 15:48:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB51517C-C171-11E2-B671-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224966>

Johan Herland <johan@herland.net> writes:

>> Of course in either case we couldn't use a tree object directly, because
>> these new "reference tree" objects would refer not only to blobs and
>> other trees but also to commits and tags.
>
> Indeed. I don't know if the best solution would be to actually _allow_
> that (which would complicate the object parsing code somewhat; a tree
> entry pointing to a commit is usually interpreted as a submodule, but
> that is not what we'd want for the ref tree, and a tree entry pointing
> at a tag has AFAIK not yet been done), or whether it means we need to
> come up with a different kind of structure.

You can disallow that only by giving up on being able to express
Linus's kernel repository, which has an oddball v2.6.11-tree tag.

I do not think that that particular tag in the particular repository
is too big a show-stopper; if it is only Linus, we can ask him to
drop that tag (he has v2.6.11 tag object that points at the tree, so
the users do not lose anything) and be done with it.

But if there are other repositories that tag trees in a similar way,
that would be a real regression.  We cannot just go ask people to
change their workflow that depended on using refs that directly
point at trees overnight.
