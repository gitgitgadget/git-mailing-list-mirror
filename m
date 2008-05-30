From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test cases for git-am
Date: Fri, 30 May 2008 15:12:41 -0700
Message-ID: <7vy75rh25i.fsf@gitster.siamese.dyndns.org>
References: <20080530140447.GB10514@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 31 00:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Cr9-0001XV-AL
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbYE3WMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYE3WMw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:12:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYE3WMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:12:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5856A3898;
	Fri, 30 May 2008 18:12:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2C4CB3896; Fri, 30 May 2008 18:12:43 -0400 (EDT)
In-Reply-To: <20080530140447.GB10514@leksak.fem-net> (Stephan Beyer's message
 of "Fri, 30 May 2008 16:04:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8ABAFE3C-2E95-11DD-95EE-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83350>

Stephan Beyer <s-beyer@gmx.net> writes:

> the reason I added this test is because I'm working on git-sequencer (for
> GSoC'08), which functions as a common backend for git-am, git-rebase, ...
> And I think this test will make my life easier ;-)

Absolutely.  Starting by writing a verifiable specification of what you
will be building (aka "tests") is a very good way.

> As this is my first test, I hope to get some constructive feedback.

    Date: Fri, 30 May 2008 16:04:47 +0200
    From: Stephan Beyer <s-beyer@gmx.net>
    To: git@vger.kernel.org
    Cc: gitster@pobox.com
    Subject: [PATCH] Add test cases for git-am
    Message-ID: <20080530140447.GB10514@leksak.fem-net>
    Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com

Please don't do this "Mail-Followup-To:"; it is rude to others, and it is
rude to me.

 * It is rude to others.  When they want to give feedback to _you_
   privately and say "Reply", it will put me (and the list) on "To:"
   header.  They have to be careful and edit their "To:" header.  You
   stole time from them, which otherwise would have been spent on much
   better things, such as actually giving constructive feedbacks.

 * It is rude to me (or whoever you place on your M-F-T).  I filter and
   sort my incoming mails to give precedence to ones that have me on "To:"
   over the ones that have me on "Cc:".  When people want to give feedback
   to _you_ publicly and say "Reply All", it will again put me (and
   perhaps the list) on "To:" header, and I may not be interested in
   suggestions they are giving to _you_.  You stole time from me, which
   otherwise would have been spent on something better, like sitting back
   and sipping my Caipirinha ;-).

> Perhaps it is also useful to swap t4150 and t4151 or to merge them.

Pehaps.  A single test t4150-am.sh might be enough.

> diff --git a/t/t4151-am.sh b/t/t4151-am.sh
> new file mode 100755
> index 0000000..df4fb5a
> --- /dev/null
> +++ b/t/t4151-am.sh
> @@ -0,0 +1,223 @@
> +#!/bin/sh
> +
> +test_description='git am running'
> +
> +. ./test-lib.sh
> +
> +cat >msg <<EOF
> +second
> +
> +Lorem ipsum dolor sit amet, consectetuer sadipscing elitr, sed diam nonumy
> +...
> +feugait nulla facilisi.
> +EOF
> ...
> +test_expect_success setup '
> +	echo hello >file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m first &&
> +	git tag first &&
> +	echo world >>file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -s -F msg &&
> +	git tag second &&
> +	git format-patch --stdout first >patch1 &&
> +	tail -n +3 msg >file &&

"tail -n 3" you mean?  Same for "head -n <n>" in other places.

> ...
> +test_expect_success 'am changes committer and keeps author' '
> +	test_tick &&
> +	git checkout first &&
> +	git am patch2 &&
> +	! test -d .dotest &&
> +	test "$(git rev-parse master)" != "$(git rev-parse HEAD)" &&
> +	test "$(git rev-parse master^)" != "$(git rev-parse HEAD^)" &&
> +	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
> +	test -z "$(git diff master..HEAD)" &&
> +	test -z "$(git diff master^..HEAD^)" &&
> +	compare author master HEAD &&
> +	compare author master^ HEAD^ &&
> +	! compare committer master HEAD &&
> +	! compare committer master^ HEAD^
> +'

Hmmm.  Checking for inequality does not feel so robust.  You will allow
"am" to record garbage and will not be able to detect a breakage.

> +test_expect_success 'am --signoff adds Signed-off-by: line' '
> +	git checkout -b master2 first &&
> +	git am --signoff <patch2 &&
> +	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1 &&
> +	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2
> +'

Again, don't you want to check not just "It added something", but "It
added what we expected it to add"?

> ...
> +test_expect_success 'am --keep really keeps the subject' '
> +	git checkout HEAD^ &&
> +	git am --keep patch4 &&
> +	! test -d .dotest &&
> +	git-cat-file commit HEAD |
> +		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
> +'

... in other words, like this one that checks "It left what we expected it
to in the result".

Other than that, I did not think anything obviously wrong with the patch. 
