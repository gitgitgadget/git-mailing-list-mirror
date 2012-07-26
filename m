From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 12:25:16 -0700
Message-ID: <7v8ve672ar.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
 <20120726171256.GC13942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTge-0001WC-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab2GZTZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:25:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237Ab2GZTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:25:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F929514;
	Thu, 26 Jul 2012 15:25:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BR8d4sG5LN+4TKCwMdzeQPm9KJs=; b=kOg4Mz
	YlBSsaXPa7XxYugxEpgZebCBqUD081li6PzjlFjrqn5V783K3MIW9uf9+wuhCPq0
	1QK9TzEwqIZtADEtJGPd4px0UAaJWttqYhUtCc0I6LSwVOwQ4kdppNTpiyRRlIHE
	dBJCWyzWOqfQUjT7sXvF5jho8VFYbIikUnBhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jETihF2afD7tDX72F2rjfMqmuF7lA/wC
	6hj9ELnUbN17FND3U/o6EoSLk/2OKbo8ZLuhb2ZxbEZKdG2ZitptVMw+teGyZ9sO
	FbG2Bl/nrJjwlMXC+T0sYga2IlEQ8x5wy6QywZBSvCN2XQGXMIGU7leKsRLQ4yOm
	aj6XPgDg04k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80D899513;
	Thu, 26 Jul 2012 15:25:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6FFD9511; Thu, 26 Jul 2012
 15:25:17 -0400 (EDT)
In-Reply-To: <20120726171256.GC13942@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jul 2012 13:12:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A20F9218-D757-11E1-B3FF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202295>

Jeff King <peff@peff.net> writes:

> Right. You can check this only when "git var GIT_COMMITTER_IDENT" works,
> and you can check the f20f387 behavior only when it does _not_ work. So
> we could do something like:
>
>   (sane_unset GIT_COMMITTER_NAME &&
>    sane_unset GIT_COMMITTER_EMAIL &&
>    git var GIT_COMMITTER_IDENT >/dev/null) &&
>   test_set_prereq AUTOIDENT ||
>   test_set_prereq NOAUTOIDENT
>
>   test_expect_success AUTOIDENT \
>     'mention auto ident in commit template'
>     '...'
>
>   test_expect_success NOAUTOIDENT \
>     'git rejects bogus ident before starting editor'
>     '...'
>
> But it is somewhat unsatisfying to only get random test coverage
> depending on how your system happens to be configured. I guess we
> somewhat have that already with the case-insensitivity tests.
>
> Do we want to go that route, or just drop this test completely?

There are three cases with respect to ident:

 - There is a user-configured one;

 - We derive one from the system and that is syntactically correct,
   but we know from the past experience the system is often
   misconfigured.

 - We derive one from the system and that is empty.

Before your tightening commit, the latter two cases were treated the
same way and gave the reminder to the user.  After the tightening,
these were separated into two and give different results.

Perhaps the tightening was not such a good idea in the first place?
The user would have seen a bad committer ident in the log editing
session without the new code anyway, so perhaps we should have added
a messasge e.g. "Abort the editor session and do not edit further;
fix your ident first--this commit will fail anyway" there, or
something?

The second case can lead to commits that the user may have to redo
with filter-branch, as the command does not even error out.  And we
do want to make sure that the user is given a chance to verify that
the commit will carry a name that the user is happy with with this
test.  I think that is far more important than a user on a system
with broken GECOS field has to run the editor twice.
