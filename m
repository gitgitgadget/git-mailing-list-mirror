From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] git-send-email: making --no-chain-reply-to the default
Date: Fri, 13 Feb 2009 16:29:11 -0800
Message-ID: <7veiy16eug.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lsorense@csclub.uwaterloo.ca (Lennart Sorensen),
	Ingo Oeser <ioe-lkml@rameria.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 01:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY8Ql-0003KP-LF
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 01:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbZBNA3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 19:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbZBNA3X
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 19:29:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZBNA3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 19:29:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8429E2B12A;
	Fri, 13 Feb 2009 19:29:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3DE812B144; Fri,
 13 Feb 2009 19:29:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 860A691C-FA2E-11DD-B62F-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109790>

There was a short complaint-fest on the kernel mailing list about the
default behaviour of send-email being "chain-reply-to".

As I am moving the discussion to where it should belong, here is a
summary of what was said so far.

When there are more than two patches in a series, we often see three
different styles (explanation taken from Lennart Sorensen's message):

  Split: (multiple seperate threads)
  foobar patch 1
  +-comment on patch 1
  foobar patch 2
  foobar patch 3
  +-comment on patch 3
  foobar patch 4
  foobar patch 5

  Shallow: (all patches as response to a cover letter)
  foobar patch 0 (usually a summary/overview)
  +-foobar patch 1
  | +-comment on patch 1
  +-foobar patch 2
  +-foobar patch 3
  | +-comment on patch 3
  +-foobar patch 4
  +-foobar patch 5

  Deep: (One long chain of messages)
  foobar patch 0
  +-foobar patch 1
    +-foobar patch 2
    | +-foobar patch 3
    |   +-foobar patch 4
    |   | +-foobar patch 5
    |   +-comment on patch 3
    +-comment on patch 1

Lennart reports that from early January to early Feburary on the Linux
kernel mailing list, there were 25 split sets, 56 shallow sets and 6 deep
sets.

I counted 30 shallow sets and 50 deep sets in a recent git mailing list
messages (I counted this by only looking at 3/N patch among 5200
messages).

The numbers themselves may show what the senders consider appropriate to
submit, but they do not talk about the reader preference, which matters
more.  The messages should be sent in a form that is easier to read.

Given that many patches on the Kernel list do not even originate from git,
as opposed to here a lot more are coming from git-send-email, I interpret
the differences of these numbers to mean that people prefer shallow style
when they have a choice, but many just use git-send-email with its default
configuration and end up producing Deep style threads.

I personally agree with a short list of people who expressed their opinion
there that it is a bad default as it produces the "Deep" kind illustrated
below that is hard to follow, and would like to propose to change the
default not to chain-reply-to in a future release (but not in 1.6.2, it is
too late for that).

But the people complained were only a tiny fraction of the Linux kernel
mailing list readership, and these days git is not a property of the
kernel community alone anymore.  People tend to speak out loud only when
they do not like the status quo, so I'd like to give people who do not
want the default to change a chance to voice their opinions.

Yes, I said "opinions" and that means I am not taking a poll of individual
preferences and "+1" and "mee too" are unwelcome noise.  Making convincing
arguments such as "Among $N major communities that use git as the primary
SCM, $M projects spell their patch submission policy to use Deep style,
which is a majority; please teach members of the minority projects to how
to configure git-send-email to match their style instead and do not change
the default." is good, if you can make one.

Unless we hear convincing arguments *why* the default should *not* change,
I'll announce that it will change in 1.6.3 in the release notes to 1.6.2.

Thanks.
