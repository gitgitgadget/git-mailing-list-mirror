From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: disallow fast-forwarding tags without --force
Date: Fri, 27 Aug 2010 10:28:34 -0700
Message-ID: <7vfwy0hsn1.fsf@alter.siamese.dyndns.org>
References: <1282893284-17829-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:28:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2jO-0001AX-TS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab0H0R2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:28:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab0H0R2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:28:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F8EED0195;
	Fri, 27 Aug 2010 13:28:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7xaLIGwId76wi12zvp4jgV0v5/Y=; b=rgi66ascIjRfPh0hcufO8/f
	Qprznh03Xn/6RVGfnlXFaObmY/WAD24mDWCaErojlcilb4Z1MFw6UuehuMpzQnMo
	/ifQAkDAZ9hCi42xCJ4mVt9iJeG1N/XSmC2PdLmDoVLsF/9hUVlV78RbzD3HgF5m
	blmdHucFIVn56/k75UeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qLQEIlJMeAstMuoylU0roW86MqixX0DeRna1jcA0jz0/9hGpI
	nvS/UimF0Vt9a+pPvjHqdvXQWJ1ovr0sE1ydHCBYNqbwBNnH082H57+LOKkPN+oG
	yn4H11QxWPii7moptpxzrQ6GWY1S1x+sAI+eg56kSCyMCAjRWdFIkpZUYg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B75AD018E;
	Fri, 27 Aug 2010 13:28:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6182D0183; Fri, 27 Aug
 2010 13:28:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 874D480E-B200-11DF-B58D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154608>

Dave Olszewski <cxreg@pobox.com> writes:

> Generally, tags are considered a write-once ref (or object), and updates
> to them are the exception to the rule.  This is evident from the
> behavior of "git fetch", which will not update a tag it already has
> unless --tags is specified, and from the --force option to "git tag".

The title and what you describe later in your proposed log message do not
match.  This is about "push: disallow updating an existing tag by default"
isn't it?

This proposes a big change in the policy, and I do not like it starting
out as the new default to forbid people from doing something they have
been allowed to do for a long time.  I recall hearing some people auto
tagging the latest version their autobuilder/tester tested successfully
and updating the same tag nightly---your change will break their cron
script, no?

If you ship the feature disabled by default first, it will still allow
people to take advantage of it by simply flipping the feature on, instead
of having to install their own update hook.  In a later version, if and
when enough people agree that this should be on by default, we can do so
at a version bump.
