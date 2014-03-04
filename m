From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Tue, 04 Mar 2014 00:29:52 -0800
Message-ID: <xmqqvbvul62n.fsf@gitster.dls.corp.google.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
	<xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
	<531514D9.4000101@gmail.com>
	<xmqq4n3en7un.fsf@gitster.dls.corp.google.com>
	<53157B72.3000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobir@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:30:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKkji-0004N8-1L
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 09:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbaCDI35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 03:29:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441AbaCDI3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 03:29:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB1568362;
	Tue,  4 Mar 2014 03:29:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CsNC8ySKoddXgpUs6UZzSnQtTkE=; b=HGe2SA
	s70L4JEo2ZG+4Ds1fQvj51SxUePDWquVw6Q1jbPuc0KRaFXLPp+ZPlf5NwVZon3N
	+Zk5C81vlik3tFWUCCaklj8cws371BKfmxHT9PjhMxRq4DgveQ+1W8f4TtXrjol7
	/qlJoFK2Ip5cIDyu+sP+Eji4lAGlE2crjeMR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RsQjusOVUhn9r1XLHxwp5QuDqFjf1GrT
	s1maVvH4tj1x7D5OZql/ZyTX91ssv2N6JqZBEuykYu7XT38+DKinZQ8YX7X5hcC1
	31ws4E5y8ZkqSO9gz8V+xQSWCndN4arIY817R70Amj0DQWvrnGeheywTamV9qqmV
	zSM4iujwgl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D1068360;
	Tue,  4 Mar 2014 03:29:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3D4D6835C;
	Tue,  4 Mar 2014 03:29:53 -0500 (EST)
In-Reply-To: <53157B72.3000205@gmail.com> (Ilya Bobyr's message of "Mon, 03
	Mar 2014 23:06:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2949164A-A377-11E3-B6E3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243327>

Ilya Bobyr <ilya.bobir@gmail.com> writes:

> While it could be done, it looks less obvious than this:
>
>     GIT_TEST_ONLY='1 4' ./t0001-init.sh

If you are thinking about affecting only one test, then you
shouldn't be mucking with environment variables in the first place,
primarily because running:

    $ GIT_TEST_ONLY='1 4' make test

to run test .1 and .4 of all the test scripts would not make any
sense.  I think your "simplicity" argument is a total red-herring.
Of course if you do not have to say the test script name, your
specification would be shorter, but that is only because your
specification is not specific enough to be useful.

Giving that as a command line argument to the specific script, e.g.

    $ sh ./t0001-init.sh --only='1 4'

might make some sense, but the above GIT_TEST_ONLY does not make any
sense from the UI point of view.

There are many reasons that makes me unenthused about this line of
change in the first place:

 * Both at the philosophical level and at the practical level, I've
   found that it always makes sense to run most of the tests, i.e.
   skipping ought to be an exception not the norm. Over the course
   of this project, I often saw an alleged fix to one part of the
   system introduces breakages that are caught by tests that checks
   parts of the system that does not have any superficial link to it
   (e.g. update the refs code and find a rebase test break).

 * Even though GIT_SKIP_TESTS mechanism still allows you to skip
   individual test pieces, it has never been a serious "feature" in
   the first place. Many of the tests unfortunately do rely on state
   previous sequences of tests left behind, so it is not realistic
   to expect that you can skip test pieces randomly and exercise
   later test pieces reliably.

 * The numbering of individual test pieces can easily change by new
   tests inserted in the middle; again, many tests do take advantge
   of the states earlier tests leave behind, so "do not add new
   tests in the middle" is not a realistic rule to enforce, unless
   you are willing to clean up existing test scripts so that each
   test piece is independent from all the previous ones.

The latter two makes the ability to skip individual test pieces a
"theoretically it could be made useful but practically not so much"
misfeature.  I am very hesitant to see the test framework code
churned only to enhance its "usefulness" when there isn't any in the
first place, without first making changes that fundamentally
improves its usefulness (e.g. to solve "test numbering is not
stable" problem, you could identify the tests with test names
instead of numbers to make it more stable, but that is not what your
patch is even attempting to do).

I view such a change as merely a code churn, damaging the codebase
that is already less nice than ideal and turning it more difficult
to fix properly to make it truly nicer later.

My suggestion to cram everything into GIT_SKIP_TESTS is primarily
because it is one way I can easily see how it allows us to limit the
"damage" to the codebase--the suggested change could be contained
within a single shell function "match_pattern_list" and no other
code has to change to support it.  I am not saying it is the only
way, but glancing at your patch, adding an extra environment
variable would need to also modify its callers, so the extent of the
damage to the codebase seemed somewhat larger.

So, I dunno.  I am not yet enthused.
