Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47847494
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006415; cv=none; b=kJM6gluciPMQ4Z29t0OCDBjPqyZDdLs+Px9+YJ8CdtNqeRVRHOzZx4zM2qaafo1yTdWnqaXNuFyzWm0K612YJMrIysPrQQUfpO0AjbnVpRjhsNyQUAz/Tmg7g6y30Zjjosbvxi/HGTfBdL5sJTDj72bretBC0NL1GIRGfna7eHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006415; c=relaxed/simple;
	bh=08zXqErAzs2Xx/C+lPaYpETY4l5H11/EWXRedA5eqUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tauCZr9ub087tVTEdglu/bjQu19c/z6hDWcd4egiuQ3BtjSQKmudCRRmF2F5lsg6STuMxgC2A+ZBf+IGkDeNnFJYYr9YSh0gBuuB7Qi6/uBp7OTJHtbIQXptM/JL0D8EvKHyfBss/qIbVsJwQWc3qTtl8ZcQfsAbgiE0TZOSsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pn3ANgdo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pn3ANgdo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EBB82FCA4;
	Fri, 26 Jul 2024 11:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=08zXqErAzs2Xx/C+lPaYpETY4l5H11/EWXRedA
	5eqUM=; b=Pn3ANgdo/fnotwdju3RAY6L3ricRkmPK2oQvSdyUZJHgdLAjUO6BKT
	qBnlyyAvyKGeVnzKQnUuAjxGYxfVag2FnQ47VTE4bwPVMdBrwz/K4Za1S18VrXPq
	3lo5RN1kC+mGXIcjqCluya1aPb6RlCgOx7T0q+I0p9tQRnB4NVBN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8351A2FCA3;
	Fri, 26 Jul 2024 11:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3EA32FCA2;
	Fri, 26 Jul 2024 11:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Haritha
 <harithamma.d@ibm.com>
Subject: Re: [PATCH v3] Fix to avoid high memory footprint
In-Reply-To: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Fri, 26 Jul 2024 06:27:14
	+0000")
References: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
	<pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 08:06:50 -0700
Message-ID: <xmqqed7gyyyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B05BEDC8-4B60-11EF-AAE3-34EEED2EC81B-77302942!pb-smtp1.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: D Harithamma <harithamma.d@ibm.com>
> ...
> Signed-off-by: Harithamma D <harithamma.d@ibm.com>

I am assuming that you and the person who did d254e650 (build:
support z/OS (OS/390)., 2024-03-06) are the same person?  That
commit was signed off like so:

    commit d254e65092daba8667d6b4d5b4f59c099c1edd1f
    Author: Haritha D <harithamma.d@ibm.com>
    Date:   Wed Mar 6 05:44:17 2024 +0000

        build: support z/OS (OS/390).

        Introduced z/OS (OS/390) as a platform in config.mak.uname

        Signed-off-by: Haritha D <harithamma.d@ibm.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

It is OK if you really want to use a longer name this time, but then
please be consistent within a single commit.  The author name of the
proposed commit is "D Harithamma" and a different name "Harithamma D"
is used to sign off the commit, which is not what we want to see.

Thanks.
