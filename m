From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting
 GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri, 09 Oct 2009 14:33:46 -0700
Message-ID: <7vhbu8s151.fsf@alter.siamese.dyndns.org>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, drizzd@aon.at, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 09 23:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNIC-0004vf-2s
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934497AbZJIVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934493AbZJIVeo
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:34:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934490AbZJIVen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 17:34:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A451552B53;
	Fri,  9 Oct 2009 17:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1lhF7hmedEWV5FipYDZ6tyM+y8=; b=GLgz8S
	5ZgfJkkHiS3oRr95gH9L5F2YIrmZYdeFUidO4ExBEiwhYxQvkDTb529tTVbuANtM
	0kETlGMH+yqDL6He/gGA3avF1p/mT00U8w3hOODXpWoDPhZC7DY4n4iZrqAdj6M5
	GrVWh8cpzZp9Ef5HsRi/38J/lzPmcZm/7TeF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vnUbfwykzaMoyJ1mo+6dcxH0+deUDz+I
	W4/clLHfpJo+D3MuO58vjYpAKTiDCf1Lv66212sxUDLBJB5S6qH+JdIt88Bgf+fu
	4IIQgD6TzSMxEWH3Pq7j+aSjylDk4N3qLmZrxoLoFeDiAfdfcuqknmxKpUHxtG4S
	0yogBuJ+NhY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B48652B52;
	Fri,  9 Oct 2009 17:33:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A62A52B4C; Fri,  9 Oct
 2009 17:33:48 -0400 (EDT)
In-Reply-To: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\,  9 Oct 2009 13\:39\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71AAE7A0-B51B-11DE-A0F3-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129846>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Commit 6e7b5aaf introduced the concept of GIT_EXIT_OK as a way to indicate
> to die(), the exit handler, whether the exit was initiated by the test
> harness, or whether it was unexpected.  die() expects $? to contain the
> value passed to exit(), and when GIT_EXIT_OK is set, die() calls exit with
> the value in $?.  This works as expected when using the Bash shell.  For
> the Korn shell, $? has the value of the last executed statement _before_
> the call to exit.  If that statement completed successfully, then die()
> would incorrectly exit with a successful status when GIT_EXIT_OK is set.

That's somewhat unexpected, as I did not think this was an anomaly in
bash.  FWIW, dash seems to behave the same way.

    The environment in which the shell executes a trap on EXIT shall be
    identical to the environment immediately after the last command executed
    before the trap on EXIT was taken.

If the trap action was triggered because somebody called "exit 13", $? is
expected to contain that value, because that is the last command executed
before the trap on EXIT was taken, no?

> So, rather than relying on the behavior of Bash in order to get the exit
> code from $? inside die(), change GIT_EXIT_OK into GIT_EXIT_CODE, and set
> it to the code that we want to exit with.  This allows the test suite to
> be run with the Korn shell.

I wonder if the attached is a more clear and contained workaround for this
issue.

---
 t/test-lib.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..c47a295 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -185,7 +185,14 @@ die () {
 	code=$?
 	if test -n "$GIT_EXIT_OK"
 	then
-		exit $code
+		# Korn does not update $? when "exit 47" triggers
+		# the EXIT trap.
+		if test $code = 0
+		then
+			exit 1
+		else
+			exit $code
+		fi
 	else
 		echo >&5 "FATAL: Unexpected exit with code $code"
 		exit 1
