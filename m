Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705BDC433E0
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E4064EE3
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbhCCGvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:51:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50551 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841884AbhCCGjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 01:39:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F57FB910E;
        Wed,  3 Mar 2021 01:38:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=64PTD1dHuMJQJGGUaKdoSUBl5gA=; b=MetYqB
        O98hIvSgI+74D2DI51EqAnn2smd6CMjdbda1y81KihjI33DRIM6BKlmD8OrHdlq2
        1CoahMflNQUHnDwroqtNJkSwH4sPa9ZsqoBge9qrc3rbp2my33sAS/4QJGk8Ja9m
        yfcYJLmM9oZ6sMMlVbAThJJ2VkxiWoML6xTCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yr6QcWXraQQ4XhOt9FeV3Cp+xX37nHcQ
        Of+0iozg2H/L8ec5y/5QpvQVjEf73Ts3+PpUYfAYLeo7lF6JVo3QshH3ukd9tRO6
        pLybtuizxznswCpPEJnQo4k6ufZ5f5gvjKUB/VdPS4Zy+QnJjCv9TFr49HbTlnDw
        engiU9A7Sz0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26C31B910D;
        Wed,  3 Mar 2021 01:38:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1155B910C;
        Wed,  3 Mar 2021 01:38:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     XonqNopp <xonqnoppp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: =?utf-8?Q?Proposal=C3=B6?= git push -F
References: <CAJU-ojOhSpGraS=Cwy=kMNxNgN=T=o7Eq-BxcAfSLHMzmtAm9Q@mail.gmail.com>
Date:   Tue, 02 Mar 2021 22:38:31 -0800
In-Reply-To: <CAJU-ojOhSpGraS=Cwy=kMNxNgN=T=o7Eq-BxcAfSLHMzmtAm9Q@mail.gmail.com>
        (XonqNopp's message of "Tue, 2 Mar 2021 13:35:53 +0100")
Message-ID: <xmqqim68lp20.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 122CC570-7BEB-11EB-956C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

XonqNopp <xonqnoppp@gmail.com> writes:

> I have discovered some months ago that it is more safe to force a push with
> git push --force-with-lease
>
> But since then I keep wondering: why is this not the default?

Because the form "--force-with-lease=<this-exact-commit>" is a
strict improvement over "--force", but the lazy "guess where the
other end should be" form, i.e. "--force-with-lease" alone, is worse
than "--force" in that it gives users false sense of security
without offering the safety the "lease" mechanism gives.


