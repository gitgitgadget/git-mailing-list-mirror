From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 09:41:32 -0700
Message-ID: <xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
References: <20160421161043.GK7907@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:41:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHfh-0003FY-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcDUQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:41:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751654AbcDUQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:41:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7A5C13C09;
	Thu, 21 Apr 2016 12:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TDdmi1Qaaj/pjVJISChpL+xQo8I=; b=fbMq1/
	yGC1k5lAHEMvtIvEsmyda830qIuYVp+ZndKVuEotXFrma/ocd1Ky81uNpXNxowVG
	obYqs8zBfcPQgTnGpdlCHvCCqh9GbXebJUHJS9wSDaibmqVI3787jDWG1HSx++Kh
	ipuZEoW7UrOlDyw/IS84epvykHsyYAFn56lGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PmolWVp+09hjAtEab/vKGYcb68QlKwdk
	2drXwJSAubHmFVy85KcRLXMW2+jCt44RJ1pY8x9h/9lV6UXqpzPgNL6BI3bjTN7I
	jtwr3UkzFHnhSVQ+G5qtxX6Rn39JjTt3qIxulYbWyYDeb/rQ5Pfy6aLVR3EQlMsN
	g50kBzPGGhA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A024813C08;
	Thu, 21 Apr 2016 12:41:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC91013C06;
	Thu, 21 Apr 2016 12:41:33 -0400 (EDT)
In-Reply-To: <20160421161043.GK7907@onerussian.com> (Yaroslav Halchenko's
	message of "Thu, 21 Apr 2016 12:10:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E874E0B6-07DF-11E6-8063-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292123>

Yaroslav Halchenko <yoh@onerussian.com> writes:

> I have decided to try 2.8.1.369.geae769a available from debian
> experimental and through our (datalad) tests failing I became
> aware of the 
>
>     https://github.com/git/git/pull/158/commits/e379fdf34fee96cd205be83ff4e71699bdc32b18
>     merge: refuse to create too cool a merge by default
>
> which is planned for the next release.

See http://thread.gmane.org/gmane.linux.kernel.gpio/15365/focus=15401
for the backstory.

As this is to allow maintainers at higher levels of hierarchy not to
have to worry about stupid mistakes happen at maintainers at lower
levels, I'm afraid that turning this into an opt-in safety would
defeat the point of the change in a major way.

> ... BUT not sure if it is so
> important as to cause a change in behavior on which some projects using
> git through the cmdline interface might have been relying upon for
> years!

It is not very productive to make such an emotional statement
without substantiating _why_ a merge that adds a new root, which was
declared in the thread above as "crap" (in the context of the kernel
project), is necessary and is a good idea in "some projects".  Maybe
there is a valid use case that those from the kernel land didn't
think about.

> Given that git is quite 'self-healing', i.e. if someone has managed to
> make a merge he didn't intend to, there is always a way back (e.g., as
> simple as git reset --hard HEAD^),

That is only true if people notice.  A mere warning would not be an
effective prevention measure for a user who has to perform dozens of
merges a day.

I am personally on the fence, but right now I am on the side of
keeping the behaviour as implemented and documented, simply because
I haven't heard anything concrete to convince me why some people
need to regularly do a "crap" merge (in other words, in what context
these are not "crap" merges but ability to create them is a valuable
part of everyday workflow).
