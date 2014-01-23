From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Thu, 23 Jan 2014 14:58:31 -0800
Message-ID: <xmqqsises3u0.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 23:59:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6TEk-00075o-43
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbaAWW65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:58:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbaAWW65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:58:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A82767000;
	Thu, 23 Jan 2014 17:58:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JBJke1aRVC8uD06QTU9wMQFW7c=; b=fLpQuP
	xsOUkcB8BBfTT3V+qX1ZErJAbfm5u4Zmz3THvsOLigBP9/0RoogfR0uyG/u9PxQ9
	LS6V4VTuXTFGnJ82yBNbWTazV1iC6Hy3/FEFjQ8Z4CWpPigpjHyNTz851n4rsOXL
	6XlUXIcVb6ULXW+MEtjv5uuzjxxT7i2IH38gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0fO9DL8564DJe389aI7fKmt0VbqhDxa
	lmflA1a4JfWcpEGhIGvQ9NH3q2eO0q44csW+h5tkyEWNxYxZ24gVxR+JjXzgKVe8
	Xp7KA/901oPdersyvxVfwzcW4Y2CZn37kPfW9BM7J7MXuIVF44scTgIANIBtj0i4
	GST3MwzEPZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D39F566FFE;
	Thu, 23 Jan 2014 17:58:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAAD966FF7;
	Thu, 23 Jan 2014 17:58:51 -0500 (EST)
In-Reply-To: <CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 23 Jan 2014 11:57:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED64D9E8-8481-11E3-9C07-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240970>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Yes, so you'll get a warning (or, if you get a partial match, maybe
> not even that), but the important part about all these changes is that
> it DOESN'T MATTER.
>
> Why? Because it no longer re-writes the target branch name based on
> that match or non-match. So the pull request will be fine.

Will be fine, provided if they always use local:remote syntax, I'd
agree.

> In other words, the really fundamental change here i that the "oops, I
> couldn't find things on the remote" no longer affects the output. It
> only affects the warning. And I think that's important.
>
> It used to be that the remote matching actually changed the output of
> the request-pull, and *THAT* was the fundamental problem.

The fingers of users can be retrained to use the local:remote syntax
after we apologize for this change in the Release Notes, I see only
one issue (we seem to lose the message from the annotated/signed tag
when asking to pull it) remaining, after looking at what updates are
needed for t5150.

Thanks.

-- >8 --
Subject: [PATCH] pull-request: test updates

This illustrates behaviour changes that result from the recent
change by Linus.  Most shows good changes, but there may be
usability regressions:

 - The command continues to fail when the user forgot to push out
   before running the command, but the wording of the message has
   been slightly changed.

 - The command no longer guesses when asked to request the commit at
   the HEAD be pulled after pushing it to a branch 'for-upstream',
   even when that branch points at the correct commit.  The user
   must ask the command with the new "master:for-upstream" syntax.

 - The command no longer favours a tag that peels to the requested
   commit over a branch that points at the same commit.  This needs
   to be asked explicitly by specifying the tag object, not the
   commit.  But somehow this does not see to work (yet); somewhere
   the "tag-ness" of the requested ref seems to be lost.

The new behaviour needs to be documented in any case, but we need to
agree what the new behaviour should be before doing so, so...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5150-request-pull.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 1afa0d5..412ee4f 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -86,7 +86,7 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
 	s/        [^ ].*/        SUBJECT/g
 	s/  [^ ].* (DATE)/  SUBJECT (DATE)/g
-	s/for-upstream/BRANCH/g
+	s|tags/full|BRANCH|g
 	s/mnemonic.txt/FILENAME/g
 	s/^version [0-9]/VERSION/
 	/^ FILENAME | *[0-9]* [-+]*\$/ b diffstat
@@ -127,7 +127,7 @@ test_expect_success 'pull request when forgot to push' '
 		test_must_fail git request-pull initial "$downstream_url" \
 			2>../err
 	) &&
-	grep "No branch of.*is at:\$" err &&
+	grep "No match for commit .*" err &&
 	grep "Are you sure you pushed" err
 
 '
@@ -141,7 +141,7 @@ test_expect_success 'pull request after push' '
 		git checkout initial &&
 		git merge --ff-only master &&
 		git push origin master:for-upstream &&
-		git request-pull initial origin >../request
+		git request-pull initial origin master:for-upstream >../request
 	) &&
 	sed -nf read-request.sed <request >digest &&
 	cat digest &&
@@ -160,7 +160,7 @@ test_expect_success 'pull request after push' '
 
 '
 
-test_expect_success 'request names an appropriate branch' '
+test_expect_success 'request asks HEAD to be pulled' '
 
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
@@ -179,11 +179,11 @@ test_expect_success 'request names an appropriate branch' '
 		read repository &&
 		read branch
 	} <digest &&
-	test "$branch" = tags/full
+	test -z "$branch"
 
 '
 
-test_expect_success 'pull request format' '
+test_expect_failure 'pull request format' '
 
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
@@ -212,8 +212,8 @@ test_expect_success 'pull request format' '
 		cd local &&
 		git checkout initial &&
 		git merge --ff-only master &&
-		git push origin master:for-upstream &&
-		git request-pull initial "$downstream_url" >../request
+		git push origin tags/full &&
+		git request-pull initial "$downstream_url" tags/full >../request
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
 	test_i18ncmp expect request.fuzzy
@@ -229,7 +229,7 @@ test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
 		git checkout initial &&
 		git merge --ff-only master &&
 		git push origin master:for-upstream &&
-		git request-pull -- initial "$downstream_url" >../request
+		git request-pull -- initial "$downstream_url" master:for-upstream >../request
 	)
 
 '
-- 
1.9-rc0-250-ge2d8c96
