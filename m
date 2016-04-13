From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 14:58:40 -0700
Message-ID: <xmqq4mb5jhm7.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSoB-0003Tx-MK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbcDMV6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:58:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752959AbcDMV6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:58:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E8812327;
	Wed, 13 Apr 2016 17:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gi/oVosqysxSGj4hLIvVs/OxxHY=; b=GdKmYM
	xKSYBXbCJeNr+0FT+t0b3Mg2RbTZzE13j10P1R2nkKBRyPtsYdjtkl/lBCo4HZ1r
	u+CIxqaugfUT4gwRWuzFMktV9qbK1iV9OBjUwcRb5u/u6L/hTdxxHDd9/n3A2ACH
	ZIE4QiL1LRl20rGcI+nob7gypj6+wZzlFR/Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E5rcUuVRIwq8z6xAaZL0j6CRLmK0l68H
	slLTXR15cXF5PN/Yd6xU9pedZulc9q9H+an0raSO5meNzaBoBs18F3LWo4mSfWOl
	5Muh8vWi3RmA87w41Y6gYOC0UTEPUP3QjYQM5N9L8PgBU08ZFEIkstUkanieLWcH
	CN+0vuIy+Ww=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDFCA12326;
	Wed, 13 Apr 2016 17:58:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A2B112325;
	Wed, 13 Apr 2016 17:58:41 -0400 (EDT)
In-Reply-To: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 14:37:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E253FE9C-01C2-11E6-8654-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291494>

Stefan Beller <sbeller@google.com> writes:

> $ cd t/
> $ git merge ...
> ...
> Auto-merging builtin/submodule--helper.c
> Auto-merging builtin/fetch.c
> CONFLICT (content): Merge conflict in builtin/fetch.c
> Auto-merging builtin/clone.c
> Auto-merging README.md
> ...
>
> It should say ../builtin/fetch.c IMHO.
> Any reason to keep the old behavior?

I actually prefer to see the "relative to root" behaviour when it
comes to things like this, that lets you view the things that happen
in the whole-tree context.

I would have to go insane before I start a whole-tree operation like
"git merge" from deep in my tree, but if I happened to do that, e.g.

	cd perl/blib/lib/Git/SVN/Memoize
        git merge other-branch

I'd rather see that the conflicted path, e.g. builtin/fetch.c,
reported by showing it like the above output, not happening in
../../../../../../builtin/fetch.c which I have to count the
up-dots to know which file it is talking about.
