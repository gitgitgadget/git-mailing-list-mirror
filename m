Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB341F461
	for <e@80x24.org>; Tue,  9 Jul 2019 14:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGIOnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 10:43:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60307 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 10:43:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C10B0705A0;
        Tue,  9 Jul 2019 10:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UByagNCJlB5BWATfC+/0ETFltWc=; b=aETYlC
        BbtMg2dVYBXIk6Ns98lOGOtCzev99Wj9Dlqa0TnLm69rWv1Prkp+lkDGoec69wUL
        drRzXw+M8c5m/HqJXXsNIkD/ag1+GFvbIS9q3AZ3CglsxR42Ccg/revcp1Ee7Gu9
        12KdIwxW5HKj/e2sSy9FO+N+4D+K2X9fNjzW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WjDEmyFx2T4qP0xlwgzygkNjRWxv0q+k
        Qr6UiMg/ZypsxLa2GfphLrfycoEKg0Axvu/MqtythNRijKdknpQVj+q4yy54Jjc2
        21p07RYi82p6jcDap9JBGSoFY1u+YGwqNxA047J+EMs22je4VbePKL29YROv+iaa
        8p9iEb6QjNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA1107059F;
        Tue,  9 Jul 2019 10:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4A447059E;
        Tue,  9 Jul 2019 10:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation on NTFS
References: <pull.216.git.gitgitgadget@gmail.com>
        <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com>
        <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet>
Date:   Tue, 09 Jul 2019 07:43:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 9 Jul 2019 15:27:11 +0200
        (CEST)")
Message-ID: <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC11E1A0-A257-11E9-9329-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Using `.lock` is actually an even more established pattern. (I used `.new`
> because the intention is not to lock files, but I would be prepared to
> change the patch to that end.)

When I said that the plus convention is established in this project
and not limited to the Documentation subdirectory, what I meant was
that your patch is insufficient if your goal is to depart from the
convention.

The pattern "*+" is known bythe top-level .gitignore file (not just
in Documentation/.gitignore) and that is because the build procedure
outside Documentation/ also follow the convention, e.g. the toplevel
Makefile.  Futzing with only one Makefile is not enough.

I think I saw "generate in .tmp, then move to final" pattern used in
projects by others.  The plus-sign is a lot shorter than anything
else and it is cute, but if some filesystems cannot deal with it,
changing it to something else may be a plausible workaround, as long
as it is done consistently and throughout the codebase.

> In addition, your `+` scheme will break on Windows once it uses `git.exe`
> or any other non-MSYS2 helper...

I am not sure what you mean here.  Is your git.exe disabled not to
be able to do this: "git.exe add hello+kitty.txt"?  I think that is
a more grave problem, and not limited to the Makefile in the
Documentation/ directory.
