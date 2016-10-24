Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDA820193
	for <e@80x24.org>; Mon, 24 Oct 2016 18:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936131AbcJXSXF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:23:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754461AbcJXSXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:23:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E88C74850A;
        Mon, 24 Oct 2016 14:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7dJoumsTCV4HvcBsbpdBz55aCHE=; b=DmOjkM
        fvWHqOpZLGaA7qrmmDF1AD9HXtGJwlUpRh+W37w+R2aduDX0fuKG08PNrw6yyu9g
        rspGBOYQmuAiPCkFDTOzPDig3Ur2Q+c0QTui45HDQwF2+r3g8ytl5LKKYAR8nZSv
        NWB84hg8FGO4rTqzMyUEJJ8GtHEPZAtYS7znM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiFV32yF75iccZDlsSITgb1/vNJCFSC3
        0eRbgwVsS4b4YmhsJccop3II6i9/9G+uzc0aDfaJLaj/9IogkF91zValH1Rk4m5H
        U4u5kTmCMdopUmPzoMPULvr211Np5r4tlOrPgooqY1nPiy9LcdF/IJZuLNIi4rvS
        8t6qQyln+IQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E03CE48509;
        Mon, 24 Oct 2016 14:23:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61E8648508;
        Mon, 24 Oct 2016 14:23:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, e@80x24.org,
        jnareb@gmail.com
Subject: Re: [PATCH v2 0/2] Use CLOEXEC to avoid fd leaks
References: <20161024180300.52359-1-larsxschneider@gmail.com>
Date:   Mon, 24 Oct 2016 11:23:00 -0700
In-Reply-To: <20161024180300.52359-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Mon, 24 Oct 2016 20:02:58
        +0200")
Message-ID: <xmqq4m417gjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E63E55E2-9A16-11E6-B7A3-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> ## Changes since v1
>  * add fallbacks in case O_CLOEXEC is not available

That is a good idea.

>  * rename 'git_open_noatime_cloexec' to 'git_open' (Eric, Dscho)

OK.  This is the old git_open_noatime() that is meant to be used
ONLY for the files Git uses for its internal implementation, and
never for end-user files.  I think it is a good idea to open them
with O_CLOEXEC.

And the separate patch to use O_CLOEXEC in ce_compare_data() that
opens a working tree file for reading does not use git_open(), which
is also correct.  I like it.

>  * rebased the topic on `next` to fix a merge conflict

I think this applies cleanly to 'master', so that is where I'd fork
my copy at.

Thanks.

