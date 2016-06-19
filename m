Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B344320189
	for <e@80x24.org>; Sun, 19 Jun 2016 23:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbcFSXvv (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 19:51:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbcFSXvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 19:51:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC71226754;
	Sun, 19 Jun 2016 19:51:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SQGlwWkLsIctqk0+oIkuYvizTRg=; b=HviYWJ
	nPZGNwbLU8F4gzriBH97mOXgTHdfnJrG7EykooskQ2/UXMiNd79CAI40bVaRHmhE
	bB7jgkQUPBngBnP6JdH8UxUfH+XKXUPlPJT1NDFwOO75ATqSNARqeo49GxbWKydT
	goRmxGXF6KP1HdFkZFuXb0imdYM6+oD/yUiCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fkt5BFZBAQ2z4qlmBVaV8jE0vMjmFzdT
	FFZNbyJg2v2MyYs6cYa1xxWjDcROdBLJyjhyA/akUDynmrdxfBET42LhVkKUF02B
	YQ3PEzI88qyDvZlvR3je8NGmE3/f+IKIz7xd3WE1Naw7DT0caS6O9E3XgY0Nb2G/
	c643qvk2ie8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D4C4326753;
	Sun, 19 Jun 2016 19:51:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CC7C26752;
	Sun, 19 Jun 2016 19:51:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
	<576650E7.70107@alum.mit.edu>
	<xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 19 Jun 2016 16:51:43 -0700
In-Reply-To: <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 19 Jun 2016 11:09:34 -0700")
Message-ID: <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C796F10A-3678-11E6-B79C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> According to [1], something in that test seems to have been trying to run
>>
>>     git update-ref -d git-p4-tmp/6
>>
>> Similarly in the other failed test.
>
> Ah, OK, that would try mucking with .git/git-p4-tmp/6 but that is
> not a place to have a ref.  It will not participate in reachability
> analysis and will end up losing the referents.
>
> Perhaps placing it under refs/git-p4-tmp would fix it (both in
> git-p4 and in tests)?

Oh, another thing.  If these refs are meant to be transient, they
are likely to be per worktree, if "git worktree" managed multiple
worktrees that share the same set of branches and tags are in use.

I recall we carved out one hierarchy under refs/ as "not shared
across worktrees" (was that refs/worktree/ hierarchy?  I didn't
check but please do so when the patch actually is written), and
that hierarchy is the appropriate thing to use for this, I think.

Thanks.
