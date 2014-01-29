From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Wed, 29 Jan 2014 15:34:32 -0800
Message-ID: <xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 00:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8eeW-00025Z-A7
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 00:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbaA2Xeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 18:34:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbaA2Xef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 18:34:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2FE86806C;
	Wed, 29 Jan 2014 18:34:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7/aQ9jnG40zjWl4ckdSLs726hQ=; b=NGHXR8
	iAQPcftGHtZQg5UsYm0JUt7lOhzJtbW1pEDfDRWcdHoO4q1I9V2EN7JQEyRYu7iz
	edZBYK7bcYXbAL9B8xDFM8cZRV6ZmCTl50/QxjnBtQG4OTaxxHnCSoXTSwvQODj7
	jDX2pqd+1mQN0AIqYTWbX+YQTn0SJgk6VpEeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FU6bsIVNR5G/jT9yMujrOI6zobxB0a74
	TWe6VGQ6IsQ0M3L2BQefDpkOhIsb3UuX6BglElHZ+ePtXBf7TPNo3PrBZs6NbcHa
	DudvPvnlrnbktZm6c9tVps7OZuit24t6gC5uSmWzC1HBAqbTcMr6wYOe1q+Du1pK
	SYlfV3wMaTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A262F6806B;
	Wed, 29 Jan 2014 18:34:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6F866806A;
	Wed, 29 Jan 2014 18:34:33 -0500 (EST)
In-Reply-To: <xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 24 Jan 2014 12:16:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E89847FE-893D-11E3-BDA7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241232>

Junio C Hamano <gitster@pobox.com> writes:

> So there are two remaining items, I think.
>
>  - After creating a tags/for-linus signed tag and pushing it to
>    tags/for-linus, asking request-pull to request that tag to be
>    pulled seems to lose the tag message from the output.
>
>  - Docs.
>
> [Footnote]
>
> *1* Not that it is always acceptable to break the existing users as
>     long as they are clueful ones and they are given an escape hatch.
>     But this time I know I won't be in the middle of firestorm like
>     the one we had immediately after 1.6.0, as long as I keep the
>     URL of the message I am responding to in the list archive ;-)

I am not yet doing the docs, but here is a minimal (and I think is
the most sensible) fix to the "If I asked a tag to be pulled, I used
to get the message from the tag in the output---the updated code no
longer does so" problem.

With this fix, the updates to t5150 I queued on top of the two
patches can lose a "test_expect_failure".

I would not be surprised if there are other regressions, though
[*1*].  I am worried about regressions when the user explicitly asks
a ref to be pulled---e.g the command refuses to produce output and
instead fails (perhaps because the ambiguity check is overly
stricter than it should be), or the command produces output that is
different from what we used to produce (this patch is a fix to the
problem in that latter category, but there may be other differences
the existing tests are not covering).

[Footnote]

*1* No, I do not count "I used to be able to ask 'master' (or
implicitly 'HEAD' that I happen to be sitting on) to be pulled and
rely on that the command figures out that I have that commit on
'for-linus' in my publish repository, but that feature was removed"
as a regression.  Removing that cleverness is the point of this
series.

-- >8 --
Subject: [PATCH] request-pull: pick up tag message as before

The previous two steps were meant to stop promoting the explicit
refname the user gave to the command to a different ref that points
at it.  Most notably, we no longer substitute a branch name the user
used with a name of the tqag that points at the commit at the tip of
the branch.

However, they also lost the code that included the message in a
tag when the user _did_ ask the tag to be pulled.  Resurrect it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index c8ab0e9..93b4135 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -132,6 +132,14 @@ for you to fetch changes up to %H:
 
 ----------------------------------------------------------------' $headrev &&
 
+if test $(git cat-file -t "$head") = tag
+then
+	git cat-file tag "$head" |
+	sed -n -e '1,/^$/d' -e '/^-----BEGIN PGP /q' -e p
+	echo
+	echo "----------------------------------------------------------------"
+fi &&
+
 if test -n "$branch_name"
 then
 	echo "(from the branch description for $branch_name local branch)"
-- 
1.9-rc1-183-g614c158
