From: Junio C Hamano <gitster@pobox.com>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 12:27:58 -0700
Message-ID: <xmqqmvomsqwx.fsf@gitster.mtv.corp.google.com>
References: <20160421113004.GA3140@aepfle.de> <87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
	<xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:28:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKGm-0005u5-4b
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbcDUT2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:28:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751041AbcDUT2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:28:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCF78132CC;
	Thu, 21 Apr 2016 15:27:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAD+pG+QXGSqOiNwFfCcMltvK9k=; b=omk3Ya
	6hseezRdP+0maHCgoJB1QIUPSga066whT9d6AY3TtX4Bc3N+jcFNAmDMegYTymUx
	PznqVfLFA7SI8p8HlayivKHtYaAC1zaOqq0LmKTb5ZcgkGNykpQBlN+Xft47jB/O
	KuTjGUM8EJVYywJxCOaShT/bYLk503erT2llQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SXCAtCzjrJofN1UN3HhpDs3eNnOh4Gqe
	8Z/j2h6ulMviWgNyKMCwuqskNdYcGyg8ISVuMY2nxLEiZ4dWk3HvHYkmyyWsb18d
	nTVWAKuG5D04P06P2CwMOvSz9JX8QrHFU1Ej+1zav4CrkbZTHuYsKqJfx5W7LUw7
	BBmfPC60Rz4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2A5D132CB;
	Thu, 21 Apr 2016 15:27:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2425C132CA;
	Thu, 21 Apr 2016 15:27:59 -0400 (EDT)
In-Reply-To: <CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 21 Apr 2016 10:43:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 280CB30E-07F7-11E6-8F65-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292143>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But this patch is small and simple, and has some excuses for its
> behavior. What do people think?

I like it that you call it "excuse" not "rationale", as I couldn't
form a logical connection between your "4 (2) letters" and "10000
(100)" at all ;-)

Modulo the usual style issues (e.g. we frown upon patches in
attachement that makes it harder to quote and comment), I think this
is a strict improvement and is a good measure until somebody does a
full "topologically closest" solution.

>                  Linus
>
>  builtin/name-rev.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 092e03c3cc9b..0354c8d222e1 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -16,9 +16,6 @@ typedef struct rev_name {
>  
>  static long cutoff = LONG_MAX;
>  
> -/* How many generations are maximally preferred over _one_ merge traversal? */
> -#define MERGE_TRAVERSAL_WEIGHT 65535
> -
>  static void name_rev(struct commit *commit,
>  		const char *tip_name, int generation, int distance,
>  		int deref)
> @@ -55,19 +52,26 @@ copy_data:
>  			parents;
>  			parents = parents->next, parent_number++) {
>  		if (parent_number > 1) {
> +			int weight;
>  			size_t len;
>  			char *new_name;
>  
>  			strip_suffix(tip_name, "^0", &len);
> -			if (generation > 0)
> +
> +			// The extra merge traversal "weight" depends
> +			// on how complex the resulting name is.
> +			if (generation > 0) {
> +				weight = 10000;
>  				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
>  						   generation, parent_number);
> -			else
> +			} else {
> +				weight = 100;
>  				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
>  						   parent_number);
> +			}
>  
>  			name_rev(parents->item, new_name, 0,
> -				distance + MERGE_TRAVERSAL_WEIGHT, 0);
> +				distance + weight, 0);
>  		} else {
>  			name_rev(parents->item, tip_name, generation + 1,
>  				distance + 1, 0);
