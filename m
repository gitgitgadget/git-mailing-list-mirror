Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445AFC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 23:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AA7206F1
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yOwXq4HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKUXBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 18:01:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54916 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKUXBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 18:01:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CB5D94A09;
        Sat, 21 Nov 2020 18:01:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OdzXGtqDTiWvpDCLgSTl6S/naNI=; b=yOwXq4HDfqiGYmiVnyvT
        ybRY9ukUPgHP3gKslYIbDLnCkYa7IMweZ7E+82mkNakJuq+5GT8sJYo3Ly7NjAgH
        cjCzbw/6zJ1EuKAD8S1cWRwIUf+vKasTVsCs/9ZVxoQtp3ySa2dT1YcDA3wKhKOh
        4KzkgjIdR2mtyTqOgyvNgX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Cnshm5Z7+OXBdsAEBSpPF9hIlrqIXHTBsz3Sq7kOl4aLRI
        2Uf2gxs6zy4upBe9+eJsb/DUI+KQjBLe3oTdUuhvyslL00cJy8RvzDTKMf70eqxQ
        kgf7Cfl0T/ADiNZhduNfVA3Kp1zYRZL2W1esGMwgXrdIa90B4r6nUN9Ap6Zi0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9467894A08;
        Sat, 21 Nov 2020 18:01:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15B1B94A07;
        Sat, 21 Nov 2020 18:01:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
        <871rgpr497.fsf@osv.gnss.ru>
Date:   Sat, 21 Nov 2020 15:01:42 -0800
Message-ID: <xmqqpn46qppl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85A23D34-2C4D-11EB-B87D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> To me "not on a branch [tip]" is also confusing, as in fact you are, as
> is easily seen after you perform a few commits, and now HEAD points
> directly to the tip of the branch (that has no other references).

Aren't you confused about what "on a branch" means?

After either of these two operations, your HEAD may point at the
same commit, but the former is on a branch (the master branch), and
the latter is not.

    git checkout master
    git checkout master^0

The difference between these two states does *NOT* come from which
commit HEAD points at.

The difference comes from what happens when you make a new commit
starting from that state.  The former (i.e. you are on a branch)
grows the branch.  The latter (i.e. you are not on a branch) does
not grow any branch.

This is an unrelated trivia, but did anybody know that we were
pretty much on the detached HEAD all the time for more than a month
of early life of Git, until cad88fdf (git-init-db: set up the full
default environment, 2005-05-30)?
