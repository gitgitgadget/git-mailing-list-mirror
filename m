From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 6 Mar 2012 09:46:05 +0100
Message-ID: <878vje86cy.fsf@thomas.inf.ethz.ch>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
	<nngy5re29zn.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <greened@obbligato.org>, <git@vger.kernel.org>
To: "David A. Greene" <dag@cray.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:46:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4q2B-0006ex-4H
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab2CFIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:46:09 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:5254 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758301Ab2CFIqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:46:08 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:46:08 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:46:05 +0100
In-Reply-To: <nngy5re29zn.fsf@transit.us.cray.com> (David A. Greene's message
	of "Mon, 05 Mar 2012 12:11:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192314>

dag@cray.com (David A. Greene) writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> greened@obbligato.org writes:
>>
>>> +# GIT_VALGRIND_TOOLS is the location of tools like valgrind.sh.
>>> +if test -z "$GIT_VALGRIND_TOOLS"
>>> +then
>>> +	# We allow tests to override this, in case they want to run tests
>>> +	# outside of t/.
>>> + 
>>> +        # For in-tree test scripts, this is in TEST_DIRECTORY/valgrind
>>> +        # (t/valgrind), but a test script that lives outside t/ can
>>> +        # set this variable to point at the right place so that it can
>>> +        # find t/valgrind directory that house test helpers like
>>> +        # valgrind.sh.
>>> +       GIT_VALGRIND_TOOLS="$TEST_DIRECTORY"/valgrind
>>> +fi
>>
>> I'm a bit curious: why isn't it enough to spell that path
>> $GIT_BUILD_DIR/t/valgrind instead of making it fully configurable?
>
> For the same reason that TEST_DIRECTORY is different and unrelated from
> GIT_BUILD_DIR.  It's my understanding that GIT_BUILD_DIR could end up
> being somewhere compeltely unrelated to where TOP_SRC/t/valgrind is.
> At least that's why I introduced a new parameter.

I'm just worried that for such a fringe use-case, the maintainer of the
out-of-tree tests will never notice that he missed to customize *this*
particular parameter.  So I'd rather have it spelled in terms of the
existing two (?).

Don't we, right now, get stuff as follows:

  item                   path
  --------------------------------------------
  test-lib.sh            $TEST_DIRECTORY
  git                    $GIT_BUILD_DIR/bin-wrappers
  valgrind.sh            $TEST_DIRECTORY/valgrind
  git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin

You are saying this must change to an entirely new path

  valgrind.sh            $GIT_VALGRIND_TOOLS
  git (with --valgrind)  $GIT_VALGRIND_TOOLS/bin

but what's wrong with simply

  valgrind.sh            $GIT_BUILD_DIR/t/valgrind
  git (with --valgrind)  $TEST_DIRECTORY/valgrind/bin

In the common case of t/, these just map to what we had before.  In the
out-of-tree case, we'd create valgrind/bin in the test directory for the
*temporary* stuff, and still look for the wrapping valgrind.sh in the
git tree.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
