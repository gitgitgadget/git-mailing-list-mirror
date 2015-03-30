From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Renaming "git rebase --onto"
Date: Mon, 30 Mar 2015 14:12:08 -0700
Message-ID: <xmqqk2xyw5p3.fsf@gitster.dls.corp.google.com>
References: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 23:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycgyv-0000M5-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbbC3VMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 17:12:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752400AbbC3VMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 17:12:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF54145B3C;
	Mon, 30 Mar 2015 17:12:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OZaM9hMAp1yofHNCNHiVm/aDWEI=; b=JthtEi
	R+ulbgdIb0U2jk8ww/rPBCQjI6fPXABrE+bRP0UWP4kg8qICUOPv2Eb5g3l14L75
	13lsuxUTOvgxpDto4/dhka88/Xs67t943HjFkoR0CSQODAxqx12YqZJ/ihDS/0HC
	nmb5UHyd+0kM+uebGgmY+qfoMw2v/UBTmrSoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WupbNVyBLxNdsjbS3dHSL433dRfj6Ih1
	2icQB9Weut7THBUBOka5E4Mye4vwNuJfJJ/bpcbi23SkAzTsRd7nfTbgJ4pLJN7u
	KbLCI8BD63IgodSKpGXev2eUa9wn6OINKz0mU1kkdedkcvUuRhPBPXoz59W2pRT4
	tI5Gm0syxAg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7E4145B3A;
	Mon, 30 Mar 2015 17:12:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D21F245B31;
	Mon, 30 Mar 2015 17:12:09 -0400 (EDT)
In-Reply-To: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com> (Jonathon
	Mah's message of "Mon, 30 Mar 2015 13:49:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D7CE600-D721-11E4-8DAF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266477>

Jonathon Mah <me@JonathonMah.com> writes:

> During a few years of discussing git operations with colleagues, I’ve
> found the “git rebase --onto” operation particularly ambiguous. The
> reason is that I always describe a rebase operation as “onto”
> something else (because of the English phrase “A is based on
> B”). For example:
>
> $ git rebase new-base  # “Rebase HEAD onto new-base (from merge-base of HEAD and new-base)"
> $ git rebase new-base my-branch # “Rebase my-branch onto new-base
> (from merge-base of my-branch and new-base)”
>
> Personally, I understand “git-rebase --onto new-base old-base” as
> meaning “rebase from old-base to new-base”. Some prepositions that
> might make this clearer:
>
> $ git rebase --from old-base new-base  # “Rebase HEAD onto new-base, from old-base"
> $ git rebase --after old-base new-base # “Rebase commits on HEAD
> after old-base HEAD onto new-base"
> $ git rebase --excluding old-base new-base # “Rebase HEAD onto
> new-base, excluding commit old-base (and its parents)"
>
> In all cases this would change the order of the arguments compared to
> --onto, making it more consistent with the no-option rebase.

The bog-standard rebase is

    git rebase U

which rebases the current history that has diverged from the history
leading to U on to U.

Or

    git rebase U BRANCH

which rebases BRANCH that has diverged from the history leading to U
on to U.  In both of these invocations, these arguments define which
part of the local history is replayed.

Now,

    git rebase [--onto O] $other_args

is just a way to say $other_args still define which part of the
local history is replayed, but you are replaying on something that
is different from the usual default case (which is U).

Which feels very consistent between the cases with and without the
extra --onto parameter, at least to me.  Hence, if you change order
in any way, I would think you would break the existing consistency.

I suspect that this thread is a symptom of something unrelated,
though.  There might be something wrong in your workflow if you find
yourself using --onto too often, for example, and that may be the
issue we should be focusing on, not on how "rebase --onto" is
spelled.

> What do others think? Is my view of “onto” common or unusual?

"common or unusual" is a question we cannot answer, I would say.
People who are used to "rebase" may be so used to it that it might
feel natural to them but cannot tell if that is only because they
already know how "rebase" spells its arguments, or they would still
find it natural if they did not know anything about "rebase".
