Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1E16F0F4
	for <git@vger.kernel.org>; Tue,  7 May 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099537; cv=none; b=mb7qaRE+sLAwPtxpLmaMl2XbGGnVk5jI0xPnn72eI/WdDyXvpbY4Dd4PC7FSPrAHjp2YYz8Skj7fdqLRZQJRdekTBQEbd5Q3wW1eQMF0POK3cQlKbbz+v+Bj8cOiAsc0gLhcN4bjwxHfPrSOKARA2q79jZzUxNAUQuO9zPwDGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099537; c=relaxed/simple;
	bh=G8Ej81CVkfYyhO2zCOvGp7IBw+j4SGUWGXXqW2ejf8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIaIja/IyjNawHL1HrnkoO1CjrgHXxFFs/REtyVAYA+7YPtAgjuYLnYmzRqgDCwJpW10PBb3jJU1G4FhazSha/U7UxYeay3ErGUt67E7wFIB/zJug7qoRod86C9g1i/fY2oyNY6pniQEMRb4Mx14sFP4TMmH3yqWVw0MbZFQaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBm4A2Uo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBm4A2Uo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE80D2A3BF;
	Tue,  7 May 2024 12:32:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G8Ej81CVkfYyhO2zCOvGp7IBw+j4SGUWGXXqW2
	ejf8o=; b=TBm4A2Uowz06LpQXXhx13G/ggaAntXCHHh1oiLIiOO6suFCVZRoGcf
	fjxru+LcHLRITFIIZWfWv0T/4wCJooHbX/IDhwIro4nqjAugZL6wJ1arsZsXaoV/
	gshP0PMmijsjWOFxF97UIGSVaZD+FcSf0owbtpW5wpvK9LRL/U7Og=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A74AC2A3BE;
	Tue,  7 May 2024 12:32:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10D132A3BD;
	Tue,  7 May 2024 12:32:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/8] refs: add support for transactional symref updates
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Tue, 7 May 2024 14:58:51 +0200")
References: <20240507060035.28602-1-knayak@gitlab.com>
	<20240507125859.132116-1-knayak@gitlab.com>
Date: Tue, 07 May 2024 09:32:07 -0700
Message-ID: <xmqqy18lpoqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 595CA5EA-0C8F-11EF-AADC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes since v7:
> * I had rebased v7 on next. I've rebased v8 on master. That's the only difference
> between the two versions.

I've applied them to the same base as used to queue the previous
round, which I think is "436d4e5b14 The seventeenth batch".  It went
without conflicts, and tests fine in isolation.  I'll see if it plays
well with other topics in 'seen' later in the day but not now.

Thanks.

> Junio, this might cause conflicts when merging, I think you resolved them for
> v6 and hope its the same now. Let me know if I can help otherwise somehow. 

The easiest for both of us would be to do this:

 (1) Build on whatever base you want, and format-patch the series.
     If you are doing "rebase -i" in-place to update from the
     previous round, this will reuse the previous base so (2) and
     (3) may become trivial.

 (2) Find the base of where the last round was queued, something like

     $ mine='kn/ref-transaction-symref'
     $ git checkout "origin/seen^{/^Merge branch '$mine'}...master"

 (3) Apply your format-patch result.  There are three cases

     (3)-1. Things apply cleanly and tests fine.  Go to (4).

     (3)-2. Things apply cleanly but does not build or test fails,
	    or things do not apply cleanly.

     In the latter case, you have textual or semantic conflicts
     coming from the difference between the old base and the base
     you used to build in (1).  Identify what caused the breakages
     (e.g., a topic or two may have merged since the base used by
     (2) until the base used by (1)).

     Check out the latest 'origin/master' (which may be newer than
     the base used by (2)), "merge --no-ff" the topics you newly
     depend on in there, and use the result of the merge(s) as the
     base, rebuild the series and test again.  Run format-patch from
     the last such merges to the tip of your topic.  If you did

     $ git checkout origin/master
     $ git merge --no-ff --into kn/ref-transaction-symref fo/obar
     $ git merge --no-ff --into kn/ref-transaction-symref ba/zqux
     ... rebuild the topic ...

     Then you'd just format your topic above these "preparing the
     ground" merges, e.g.

     $ git format-patch "HEAD^{/^Merge branch 'ba/zqux'}"..HEAD

     Do not forget to write in the cover letter you did this,
     including the topics you have in your base on top of 'master'.
     Then go to (4).

 (4) Make a trial merge of your topic into 'next' and 'seen', e.g.

     $ git checkout --detach 'origin/seen' &&
       git revert -m 1 <the merge of the previous iteration into seen> &&
       git merge kn/ref-transaction-symref

     The "revert" is needed if the previous iteration of your topic
     is already in 'seen' (like in this case).  You could choose to
     rebuild master..origin/seen from scratch while excluding your
     previous iteration, which may emulate what happens on my end
     more closely.

     This trial merge may conflict.  It is primarily to see what
     conflicts _other_ topics may have with your topic.  In other
     words, you do not have to depend on to make your topic work on
     'master'.  It may become the job of the other topic owners to
     resolve conflicts if your topic goes to 'next' before theirs.

     Make a note on what conflict you saw in the cover letter.  You
     do not necessarily have to resolve them, but it would be a good
     opportunity to learn what others are doing in an related area.

     $ git checkout --detach 'origin/next' &&
       git merge kn/ref-transaction-symref

     This is to see what conflicts your topic has with other topics
     that are already cooking.  This should not conflict if (3)-2
     prepared a base on top of updated master plus dependent topics
     taken from 'next'.  Unless the context is severe (one way to
     tell is try the same trial merge with your old iteration, which
     may conflict in a similar way), expect that it will be handled
     on my end (if it gets unmanageable, I'll ask to rebase when I
     receive your patches).

Something like the above should be added to the SubmittingPatches
document (or its successor to cover more advanced topics, perhaps).

Thanks.
