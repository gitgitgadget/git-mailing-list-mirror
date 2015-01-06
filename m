From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 06 Jan 2015 02:20:33 -0800
Message-ID: <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RFp-0006wA-1v
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbbAFKUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:20:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754011AbbAFKUg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:20:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC1EB24D04;
	Tue,  6 Jan 2015 05:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfP39fRCeaOTba2Qb7QqXdGnT3E=; b=bDqmOT
	Vfn8F24UsOcpYyok6qN5ykGGWO0Abu8sTLJpnb44izKcki/4Tn8nHIx4f2Md/tQs
	bFkucPjdYQQmPlnZZ7LPFLuxSYN8QW2YgZbJa4qJuefEsGnW+JE9xuGymuhAYamI
	XeEXQ7jAm/zAtnSPXaTeuZp9+YfhKdUUaHvHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ojaORiSvw9NeppAfClJRPFTCeL1leWri
	pQFMYI7SaIPIXjK3rDvoX/jyfP5tT6PrQKzTVHKBVHI5e0kaEfUXqHo9UfjIrk9X
	4FqxAVxnC6GuoQ6GAaP0Ww79Vwr3WF6zllpEwVBVv7ouTtgOSVxMD5tyE+gynRf1
	7vELAA1bKlk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB41224D01;
	Tue,  6 Jan 2015 05:20:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3134824CFC;
	Tue,  6 Jan 2015 05:20:34 -0500 (EST)
In-Reply-To: <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Mon, 5 Jan 2015 22:03:53 -1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A668DDAA-958D-11E4-8931-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262050>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Now, however, since refs/heads/master exists and the new,
> more relaxed notes refs rules leave it unchanged, the merge
> succeeds. ...
> ...
> diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
> index 24d82b49..f0feb64b 100755
> --- a/t/t3308-notes-merge.sh
> +++ b/t/t3308-notes-merge.sh
> @@ -90,7 +90,6 @@ test_expect_success 'fail to merge various non-note-trees' '
>  	test_must_fail git notes merge refs/notes/ &&
>  	test_must_fail git notes merge refs/notes/dir &&
>  	test_must_fail git notes merge refs/notes/dir/ &&
> -	test_must_fail git notes merge refs/heads/master &&
>  	test_must_fail git notes merge x: &&
>  	test_must_fail git notes merge x:foo &&
>  	test_must_fail git notes merge foo^{bar

The test title reads "fail to merge non-note trees", and I am
assuming that the tree-ish refs/heads/master (aka 'master' branch)
represents does not look anything like a typical note tree where
pathnames are 40-hex with fan-out.

The fact that "git notes merge refs/heads/master" fails is a very
good prevention of end-user mistakes, and this removal of test
demonstrates that we are dropping a valuable safety.

Arguably, not being able to save notes tree anywhere outside of
refs/notes/ hierarchy may be too high a price to pay in order to
prevent refs/heads/master from being considered (hence to avoid such
end-user mistakes), but at the same time, losing this safetly may
also be too high a price to pay in order to allow people to store
their notes in somewhere outside e.g. refs/remote-notes/origin/foo.
"Somewhere outside" does not mean "Including other hierarchies like
refs/heads and refs/tags that have long established meaning".

Although I am not fundamentally against allowing to store notes
outside refs/notes/, it is different from "anywhere is fine".
Can't we do this widening in a less damaging way?
