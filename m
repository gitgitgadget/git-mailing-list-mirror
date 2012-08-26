From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/17] Clean up how fetch_pack() handles the heads
 list
Date: Sun, 26 Aug 2012 10:20:21 -0700
Message-ID: <7v7gslwox6.fsf@alter.siamese.dyndns.org>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Aug 26 19:21:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5gWN-0004Rd-0z
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 19:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab2HZRU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 13:20:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab2HZRUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 13:20:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F311820A;
	Sun, 26 Aug 2012 13:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97xNf4EylWvJopnhhV2e+5Df9SM=; b=UVDCkR
	Xa59narvZCV55XhIhdKfL4jYsQHXJoccP2ihmg7AgY8llZxxCe3JHJxqgQGZA3CW
	Gjesf7KIbk24ftnkFMGbGUhydKWMMCDQNsR5Bwc2q0eA8XE5MgGdPFC6fbGkDEQN
	FOfqbVksgrq4Jv/nxNy1aQLy4R8NY/MjrmrCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKTNRJV6F/KtNZSpVQfOxS9AfGKipSPD
	9EYuLvwu4Z9BVLljmT3JEh/bBiduD0wf0hfge655L1Uv4Cb4PuMvQPDCsnuOznWL
	GroqIF6f5W9BDtWo1qeEFGGnIZevFGgp7je9DaoAzBl6qwsuf1QdrRO4v0sOHQwO
	WShChxdVL84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ADA28209;
	Sun, 26 Aug 2012 13:20:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA6B68208; Sun, 26 Aug 2012
 13:20:23 -0400 (EDT)
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Sat, 25 Aug 2012 08:44:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 520668B0-EFA2-11E1-9097-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204299>

mhagger@alum.mit.edu writes:

> Re-roll, incorporating Jeff's suggestions.  Some commit messages have
> also been improved, but the only interdiff is that match_pos is
> renamed to head_pos in filter_refs().
>
> This patch series applies to the merge between master and
> jc/maint-push-refs-all, though the dependency on the latter is only
> textual.

I've read this twice and saw nothing questionable in the series
(other than that the titles of a few weren't clear enough when
placed in a short-log like below).  Very nicely done.

Thanks.  Will queue.

> Michael Haggerty (17):
>   t5500: add tests of error output for missing refs
>   Rename static function fetch_pack() to http_fetch_pack()
>   Fix formatting.
>   Name local variables more consistently
>   Do not check the same head_pos twice
>   Let fetch_pack() inform caller about number of unique heads
>   Pass nr_heads to do_pack_ref() by reference
>   Pass nr_heads to everything_local() by reference
>   Pass nr_heads to filter_refs() by reference
>   Remove ineffective optimization
>   filter_refs(): do not leave gaps in return_refs
>   filter_refs(): compress unmatched refs in heads array
>   cmd_fetch_pack: return early if finish_connect() returns an error
>   Report missing refs even if no existing refs were received
>   cmd_fetch_pack(): simplify computation of return value
>   fetch_pack(): free matching heads
>   filter_refs(): simplify logic
>
>  builtin/fetch-pack.c  | 128 ++++++++++++++++++++------------------------------
>  fetch-pack.h          |  19 +++++---
>  http-walker.c         |   4 +-
>  t/t5500-fetch-pack.sh |  32 ++++++++++++-
>  transport.c           |   8 ++--
>  5 files changed, 101 insertions(+), 90 deletions(-)
