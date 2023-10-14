Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751B182A0
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CUyTatUY"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094CB7
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:10:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D03A1B1358;
	Sat, 14 Oct 2023 12:10:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fe1QxpxS+oq2PHuI7ys8iZVOdj/iDc8TdM7567
	xDtwQ=; b=CUyTatUYPPzw8/6MYd0w2LO5xxwDs2sjdk5vpKW1gQ1rtXU6tO9yX0
	b9ce5qozFM/WKfx3mv1uM4/LLqdFJey4ruRhlzd78iWra8E5dERqsD8TQBPO6QfJ
	CrV/32dW7jx+CJzWBHa+VI37iH1xoBcbD6/WeP8jPNZdBeF9GWdeQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5491F1B1357;
	Sat, 14 Oct 2023 12:10:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6C281B1355;
	Sat, 14 Oct 2023 12:10:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>,  git@vger.kernel.org,
  Josh Triplett <josh@joshtriplett.org>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <0deee2bc-1775-4459-906d-1d44b3103499@gmail.com> (Phillip Wood's
	message of "Fri, 13 Oct 2023 11:06:55 +0100")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
	<xmqqttqytnqb.fsf@gitster.g>
	<0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
	<xmqqttqvg4lw.fsf@gitster.g>
	<0deee2bc-1775-4459-906d-1d44b3103499@gmail.com>
Date: Sat, 14 Oct 2023 09:10:42 -0700
Message-ID: <xmqq5y39xjzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A27BD0C-6AAC-11EE-9EBB-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Phillip Wood <phillip.wood123@gmail.com> writes:

> One thought I had was that we could abuse the comment syntax to
> annotate paths something like
>
> #(keep)
> /my-precious-file
>
> would prevent /my-precious-file from being deleted by git clean (and
> hopefully unpack-trees()[1]). It means that older versions of git
> would treat the file as ignored. If we ever want more than one
> annotation per path we could separate them with commas
>
> #(keep,something-else)
> /my-file
>
> Strictly speaking it is a backward incompatible change but I doubt
> there are many people using comments like that.

;-)

If "#(" feels a bit too generic, that part can be bikeshed.

I might find some example use cases why we shouldn't later, but
offhand, the idea of (ab)using the comment is a very good idea.
