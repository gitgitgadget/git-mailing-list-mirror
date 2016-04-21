From: Junio C Hamano <gitster@pobox.com>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 15:16:45 -0700
Message-ID: <xmqq37qesj3m.fsf@gitster.mtv.corp.google.com>
References: <20160421113004.GA3140@aepfle.de> <87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
	<20160421170815.GA10783@sigill.intra.peff.net>
	<CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
	<CAGZ79kY9cpT7FN673P1u78XUwmqd0S4trAe5mauC1bdjrEsq9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:16:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atMu6-00029C-Md
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbcDUWQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:16:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751604AbcDUWQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:16:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 356BD15AF5;
	Thu, 21 Apr 2016 18:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d5FBMcdfesF9W4uHK3cj+14wUBs=; b=F9r7t1
	Tgm7f/LlZRmaTF6KVHdPJenS0Ke1CXRfMJNgN7Clzm/S18vmvvd/cuBq8Q9MAkIe
	HyV9llf2EVC0SvJmV1v7CXYpAwS5qF4FCCU5IMl5thmF5D9NYEeNH39Gu7jJIubX
	A65OocF9V/YSPBiJXLy+ZXiWOGQvAYQKtAhC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/jBtSC/w0FBOO1zjOZsl5cd5ff0LI/R
	07Js/jslzOE9dxHYmUGMzhownpQZbCm+Q3c/NRrcY8LB4PsOZS3TlHuxXVcTrP44
	UU0KfbiWhJTP82Jb9Au+1HXrDCgYVwriHOY2IeygD5kNeWUQsOCzuzDL7ew3rjxJ
	C6gXDV/isYo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 261EE15AF4;
	Thu, 21 Apr 2016 18:16:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87A9215AF3;
	Thu, 21 Apr 2016 18:16:46 -0400 (EDT)
In-Reply-To: <CAGZ79kY9cpT7FN673P1u78XUwmqd0S4trAe5mauC1bdjrEsq9Q@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Apr 2016 10:44:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC74AA30-080E-11E6-8449-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292155>

Stefan Beller <sbeller@google.com> writes:

> Combining Junios and Linus idea:
>
> * We want to have the minimal history, i.e. that tag with the fewest
> cummulative parent commits. (i.e. v3.13-rc7 is better than v3.13
> because `git log --oneline v3.13-rc7 |wc -l` (414317) is smaller tha
> `git log --oneline v3.13 |wc -l` (414530).
> The difference is 213.
>
> tags/v3.13-rc7~9^2~14^2~42 has 9 + 14 + 42 additional steps (65)
>
> tags/v3.13~5^2~4^2~2^2~1^2~42 has 5 + 4 + 2 + 1 +42 steps (54)
>
> tags/v3.13~5^2~4^2~2^2~1^2~42 has 9 less steps, but its base tag
> has a higher weight by 213.
>
> v4.6-rc1 has even more weight (588477).
>
> So I guess what I propose is to take the weight of a tag into account
> via `git log --oneline <tag> |wc -l` as that gives the tag which encloses
> least history?
>
> We also do not want to have "a lot of side traversals", so we could
> punish each additional addendum by a heuristic.

These are essentially shooting for what Linus meant "something
optimal", contrasting his "improved heuristics" version, and it is
good that you are thinking about these issues.

It may be a bit tricky to think the "optimum description" in terms
of "how many commits are behind these tags", though.  One thing that
commonly happens is:

 (1) A fix X is developed on an ancient codebase, e.g. on top of
     v1.0.0 release.

 (2) X is first merged to the current 'master' and becomes part of
     the next release v2.0.0.

 (3) X is later merged to the maintenance track and included in
     v1.0.1.

There are a few questions you would want to ask "describe --contains
X" and depending on the reason why you are asking the question, the
desired answer may be different:

 - In which release did the fix X first appear?  (answer: v2.0.0)
 - What is the oldest release with the fix X?    (answer: v1.0.1)

I happen to be a maintainer who prefers to have a tidy containment
relationships among his releases, and after the above three steps,
there will be this:

 (4) Later v1.0.1 is merged back to 'master' branch and a tag v2.0.1
     on the maintenance track for v2.0.x series would contain it.

But not all projects are run that way.  Often older maintenance
tracks will never merge back to the current development track
(i.e. fixes are only ported-back).

If the v1.0.x codebase had an unrelated problem in the code that no
longer exists in v2.0.x codebase, the maintenance track may have
quite a many commits that exist only there and not in 'master', and
when (3) happens, the "weight", i.e. the commits behind the tag, of
v1.0.1 may be greater than the weight of v2.0.0 in such a project.

In other words, an algorithm that uses "how many commits are behind
the tag" as one of the deciding factor to name X would choose
between v1.0.1 and v2.0.0 depending on what other things that have
nothing to do with X happend on these parallel development tracks,
which may not be desirable.
