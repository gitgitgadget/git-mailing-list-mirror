Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5035C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C07E23A9A
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbgLRKfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:35:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61286 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLRKfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 05:35:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D42509BF13;
        Fri, 18 Dec 2020 05:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=p7/CTTmWRF/aHCjLMqb3pXyBJAo=; b=BqzpNBJgiWuSGk8efE3b
        bWrMSoAgfO28i3Ef4fzxii5z3tLeROxJEjnYD8PIKpjilyYqNefBl/OkGeyRd7q2
        nNUeCrW7FsEohWXu1g+VshtcUstx7kFJmG5FDE7JohqEuNw9gXwAAX4gMOcFaKQ1
        /hgp6Lx0URleVC6xGyL2bPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xGeXGedJvE4noz3mGZnI2AUs0RplkNP4BZUUR0RWcPyfka
        Wf39iXCYDSb9+dkD9oW3DQOALxsrixxMC0fToM3EYLVTjytYy4/xsDIE+QuM0hvv
        z1OxOmZubKi8oLFvuDD0cwAVk+NFBuCkvtbbxJwkmjdJ3APbjuE9d3BRR6DRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC3A19BF12;
        Fri, 18 Dec 2020 05:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53BE59BF11;
        Fri, 18 Dec 2020 05:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v3] mergetool: add automerge configuration
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
        <xmqqk0tgx7ms.fsf@gitster.c.googlers.com>
        <5fdc16b8de8c1_f2faf208ad@natae.notmuch>
Date:   Fri, 18 Dec 2020 02:34:23 -0800
Message-ID: <xmqqwnxftnbk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98D073C4-411C-11EB-B6E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Right, althought the user can't configure otherwise, and the default 7,
> it can't hurt to add it.

Yes, that would make it certain that the code would survive the
change in the underlying xmerge part of the system.

I am still not sure what the right plan to deal with conflicts
recorded in the virtual ancestor.  Do we just close our eyes and
ignore it?

An easy way out may be to give an command line override so that
users can easily re-run mergetool with the feature disabled only for
a single invocation that went wrong, which would make it less likely
that users disable the feature permanently upon seeing just one case
of the new logic getting confused.
