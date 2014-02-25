From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Tue, 25 Feb 2014 13:44:46 -0800
Message-ID: <xmqqob1u6f5d.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
	<xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
	<CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 22:45:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIPo7-0005bm-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 22:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaBYVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 16:44:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbaBYVou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 16:44:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79416FFC3;
	Tue, 25 Feb 2014 16:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cHIdY+WQagWMq8GzsNvjl0EFNVw=; b=uTYpbz
	voIhk7FIsRaw4r3Qi5mnWAe29WU+5rW1iPoEae9Xs1h9XcsEPS3jm6k64aA8UfgQ
	9dWvlYAUzGiUYPmnG0xWd+nAVEMllbo+Dc8o1rkO3fALNGgG2bzDqsnGjUzqn2TD
	ZOuWQCYLI/Hu+Bru43JVLGXwjpRggL5rmNago=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5zIKOPLG5AOlACQfR8zBfXik1UMYcL/
	cW+Kwt0LKGLAXddWxDiAHUUVlszeeAGB11oC8huHl1kbbRm611zCrB6jqTNA+UnJ
	ARwLylZj2Od6s9zzJqsdd4BYwOntmSqTAnvqXnof9TUPauzAf+e8ZKv8sgyivefA
	XyxMcaqiNBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B647D6FFC2;
	Tue, 25 Feb 2014 16:44:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD3796FFBE;
	Tue, 25 Feb 2014 16:44:48 -0500 (EST)
In-Reply-To: <CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 29 Jan 2014 16:40:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0CC2831E-9E66-11E3-8AD5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242685>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Thinking some more about the tag_name issue, I realize that the other
> patch ("Make request-pull able to take a refspec of form
> local:remote") broke another thing.
>
> The first patch pretty-printed the local branch-name, removing "refs/"
> and possibly "heads/" from the local refname. So for a branch, it
> would ask people to just pull from the branch-name, and for a tag it
> would ask people to pull from "tags/name", which is good policy. So if
> you had a tag called "for-linus", it would say so (using
> "tags/for-linus").
>
> But the local:remote syntax thing ends up breaking that nice feature.
> The old find_matching_refs would actually cause us to show the "tags"
> part if it existed on the remote, but that had become pointless and
> counter-productive with the first patch. But with the second patch,
> maybe we should reinstate that logic..

Sorry for back-burnering this topic so long.

I think the following does what you suggested in the message I am
responding to.

Now, hopefully the only thing we need is a documentation update and
the series should be ready to go.

-- >8 --
Subject: request-pull: resurrect "pretty refname" feature

When asking to fetch/pull a branch whose name is B or a tag whose
name is T, we used to show the command to run as:

	git pull $URL B
        git pull $URL tags/T
	
even when B and T were spelled in a more qualified way in order to
disambiguate, e.g. heads/B or refs/tags/T, but the recent update
lost this feature.  Resurrect it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh     | 4 +++-
 t/t5150-request-pull.sh | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 93b4135..b67513a 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -53,6 +53,8 @@ fi
 local=${3%:*}
 local=${local:-HEAD}
 remote=${3#*:}
+pretty_remote=${remote#refs/}
+pretty_remote=${pretty_remote#heads/}
 head=$(git symbolic-ref -q "$local")
 head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
 head=${head:-$(git rev-parse --quiet --verify "$local")}
@@ -124,7 +126,7 @@ git show -s --format='The following changes since commit %H:
 
 are available in the git repository at:
 ' $merge_base &&
-echo "  $url $remote" &&
+echo "  $url $pretty_remote" &&
 git show -s --format='
 for you to fetch changes up to %H:
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 2622057..75d6b38 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -216,8 +216,14 @@ test_expect_success 'pull request format' '
 		git request-pull initial "$downstream_url" tags/full >../request
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
-	test_i18ncmp expect request.fuzzy
+	test_i18ncmp expect request.fuzzy &&
 
+	(
+		cd local &&
+		git request-pull initial "$downstream_url" tags/full:refs/tags/full
+	) >request &&
+	sed -nf fuzz.sed <request >request.fuzzy &&
+	test_i18ncmp expect request.fuzzy
 '
 
 test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
