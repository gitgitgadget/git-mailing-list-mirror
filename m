Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16570C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F3021D20
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A6/ZR7XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISAdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 20:33:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59818 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAdi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 20:33:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCD467533E;
        Fri, 18 Sep 2020 20:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pIAcho51dO1ZBqXbfwV8MljeL8I=; b=A6/ZR7
        XKQO6fr1wgS0L15NJKRQFaeowsKXFsNkxKs3EUO4RQN3ItiK3+n7P/uWW6f7ismU
        FLJgil1SS3ngZwj2DUvAgcjEpqBlcdkF05FbebbZiIfSsH+VG5yDoTqVrfE0RKYT
        FWqbxobgCnPEki7yionYWBaUQkgoIN1N/m4xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dW2kuEuCIgd9zu5Sb5UQFF8AKgbrxgqe
        8N7+oS9W/YWZI8jbSX/BmzdhDdTf7rW+N8UBfeAngc1LjzPeIQEoQAkbOtBzlYd2
        nqU/uDzVKqhK5HeeTPJD60IXcoG2zv3mtJfe29ncqps1srDcBYMJKGQyTdw1OTkE
        m2XfyY/cgzs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D41667533D;
        Fri, 18 Sep 2020 20:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62DC47533A;
        Fri, 18 Sep 2020 20:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] diff-lib: define diff_get_merge_base()
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <6aac57ca022963fb41d93905e41dff36dccd5969.1600328335.git.liu.denton@gmail.com>
        <xmqqd02ks4qk.fsf@gitster.c.googlers.com>
        <20200918103400.GA1874074@generichostname>
Date:   Fri, 18 Sep 2020 17:33:34 -0700
In-Reply-To: <20200918103400.GA1874074@generichostname> (Denton Liu's message
        of "Fri, 18 Sep 2020 03:34:00 -0700")
Message-ID: <xmqq5z8ali5d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0CAD9F4-FA0F-11EA-A171-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> became something like
>
> 	if (diff_get_merge_base(revs, &oid))
> 		exit(128);
>
> so I do agree with the spirit of the change but in reality, it just
> creates more busywork for the callers.

OK, then lets keep them as die()s.

> I think that it should be die-worthy because it's a logic error for a
> user to do this. I can't think of any situation where it wouldn't be
> more desirable error early to correct a user's thinking. Plus, we're
> trying to move away from the `...` notation anyway ;)

I do not think so.  We are *NOT* trying to move away from A...B;
what is mistake is A..B and that is what we want to move away from.
Luckily, there is no need to introduce a new option there, because
the user can just stop typing .. and instead type SP.

The primary value of the new option you are adding is that it allows
us to compare the index and the working tree with the merge base.
The current A...B notation can only be used to compare two trees.
