Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD8C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D579F613D6
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhDEWXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:23:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59208 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhDEWXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:23:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DF61AA306;
        Mon,  5 Apr 2021 18:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Ak9/HGJWdqxhWL2f+T2G2/Ofzg=; b=s3C7I0
        m2bXA1zyaSbL1ooJw9KCxSVweZZh02ctHqHB/KSWaAHqm+XAY4UBL/yk5Aa4YsLq
        Yb3LDv+7PJzQDPHDwEj7gWCAvq0dIkbnmeJ34ZcOKYReT+IxAZshv1WsgakYDvh8
        HbaiuzADBkYMguZuVK1nBS7H70HyYCI4RJfX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w1IQYKzf5lCs9mW+bxcjM1igEQBGqoAu
        pes2dPJJUdt7A4kmlEur7xt1YE6gqhHoo9h6Cp3v+9ZXxJqZrthHOuE4c6Zh0+lA
        l9s3HQBdZ018mw4BLmgFoECMTJi5NcSn/ooDI4JQkbEgWZHaqIKQvE1OFZdw/f7g
        uTfjA2XyDhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42EA7AA305;
        Mon,  5 Apr 2021 18:23:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0F54AA304;
        Mon,  5 Apr 2021 18:23:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-1-jerry@skydio.com>
        <20210403013410.32064-2-jerry@skydio.com>
        <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
        <xmqqy2e00zaf.fsf@gitster.g> <xmqq1rbq276g.fsf@gitster.g>
        <CAMKO5CtCk_sJsFFiKKFR1wCSyY226CbxPtN6=p6JRzocSuv8jQ@mail.gmail.com>
Date:   Mon, 05 Apr 2021 15:23:36 -0700
In-Reply-To: <CAMKO5CtCk_sJsFFiKKFR1wCSyY226CbxPtN6=p6JRzocSuv8jQ@mail.gmail.com>
        (Jerry Zhang's message of "Mon, 5 Apr 2021 15:12:43 -0700")
Message-ID: <xmqqy2dw4bh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91389CFE-965D-11EB-8DC9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> I can see what you mean about the user safety issue. However,
> my specific use case (see cover letter) involves an index that does not
> match HEAD, and wouldn't be possible at all if we forced the index to
> match HEAD. Furthermore git-apply --cached even without --3way
> doesn't force the index to match HEAD either, so why force it now?

Primarily because we tend to be extra careful before mergy operation
than any other operation.  Especially without --3way, apply (with or
without --cached/--index) is extra careful to make itself all-or-none
operation to be safe, so that there is no mixed mess that requires
manual intervention (which would further increase the risk of mistakes).

It is OK to introduce a new option to allow a dirty index, and your
tool can pass that option when it calls "apply --cached --3way", but
it would be safe to require a clean index (it does not matter how
dirty the working tree is ;-) by default.

