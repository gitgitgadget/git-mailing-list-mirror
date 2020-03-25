Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B9C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEBC2074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="szpKi+cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCYGnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:43:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55037 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYGnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:43:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E26ED52171;
        Wed, 25 Mar 2020 02:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7yIEpJ+qJnKWtrJyotc+clx4Mas=; b=szpKi+
        cC2k1lMNNz3iXo6AST6xbknqO4sVyArl1XMitp8Vsq4miEL1q/qndHbuN+pUl7Ei
        t3Wz+nGu+qjgUYvKj13Ix7HciXaDUt7emhZHLpjkZpOAWT+LDSxHnj4pMPk0J12C
        kylUhaWakjREKpwKxJM/rGShROJeNc4COnrEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q+nNYPdCd+viJkeNX8yf8C4IkCGV7gS+
        6/r9RpPp32sxygSpa0hBY5EjhF+4hCyK9YWuoP2qZcav3gr4tAaflkwN6heRduAa
        eo5fXh1urYJ8vzZ+eqTaRrssYt8iYBakip+F2NBVuw7EEdgoGNWCH4N8FKxK9YQz
        zXtvQcL/KiI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2A8D5216F;
        Wed, 25 Mar 2020 02:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2595F5216B;
        Wed, 25 Mar 2020 02:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] t: replace incorrect test_must_fail usage (part 3)
References: <cover.1585115341.git.liu.denton@gmail.com>
Date:   Tue, 24 Mar 2020 23:43:17 -0700
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 25 Mar 2020 01:54:47 -0400")
Message-ID: <xmqqimitx7cq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E936AC0C-6E63-11EA-BE7A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The overall scope of these patches is to replace inappropriate uses of
> test_must_fail. IOW, we should only allow test_must_fail to run on `git`
> and `test-tool`. Ultimately, we will conclude by making test_must_fail
> error out on non-git commands. An advance view of the final series can
> be found here[1].
>
> This is the third part. It focuses on t5*.sh.
>
> The first part can be found here[2]. The second part can be found here[3].
>
> [1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
> [2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
> [3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/

I left comments on individual patches, but I think they were all
minor.  Mostly the series looks good.

Thanks.

The dl/test-must-fail-fixes-* topics are always fun to read ;-)
