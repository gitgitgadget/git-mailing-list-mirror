Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46ED1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934913AbcHJS1M (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:27:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933331AbcHJS1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:27:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 641CE35216;
	Wed, 10 Aug 2016 14:27:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0YOa5VbM/Ge7V8Q6PxTvmB6hlrA=; b=YEL+W7
	r3BVF5yhUppn3cJJ/bbpKnPxW31Gi4A5AhPTNWu9BYCgJAPDWsxtDv0bQsEPwsmy
	jXgyRAVFW2Ce5PH7CPrB65LCF52LHsWYq1zIL/GkLeYTsotGAGJQdmEe8sgXGeck
	Gh1ACZEhhvRtErdvO9CjHujG3RFByEyCX6EeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/rfrDWlVJHdMrCQSnwwRQ/tm+36PvmM
	SUOL3VM5Jtn//C/Sl9ASUListWBk0ZVdNYmep/lEM6aZdTqVGDZqkH/djeJ81n3u
	QMhD2qKTgG/vqM9TNIl+jORzD/AL8884OXJooBcDQViHB0pQXtoD+CpfuPNI20ak
	rgIYLoqFBpY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ABA835215;
	Wed, 10 Aug 2016 14:27:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C975735214;
	Wed, 10 Aug 2016 14:27:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH] t7406: fix breakage on OSX
References: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
	<20160810175607.30826-1-sbeller@google.com>
Date:	Wed, 10 Aug 2016 11:27:05 -0700
In-Reply-To: <20160810175607.30826-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 10 Aug 2016 10:56:07 -0700")
Message-ID: <xmqq1t1w5vk6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B8AA4BA-5F28-11E6-9E5D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On OSX `wc` prefixes the output of numbers with whitespace, such that
> the `commit_count` would be "SP <NUMBER>". When using that in
>
>     git submodule update --init --depth=$commit_count
>
> the depth would be empty and the number is interpreted as the pathspec.
> Fix this by not using `wc` and rather instruct rev-list to count.
>
> Another way to fix this is to remove the `=` sign after the `--depth`
> argument as then we are allowed to have more than just one whitespace
> between `--depth` and the actual number. Prefer the solution of rev-list
> counting as that is expected to be slightly faster and more self-sustained
> within Git.

You meant self-contained, I would guess.

There are a couple of "log --oneline | wc -l" remaining that are
currently safe but they may be a time-bomb waiting to go off.

Thanks.
