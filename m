Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B189C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E1E610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbhKIXDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:03:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbhKIXDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:03:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 601F6F9099;
        Tue,  9 Nov 2021 18:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vPT5cwO1pk4eULNrjo9XgvSTCUkKucvq1AuY9H
        MHl08=; b=f4+WacmJ77CQIXa4g1lZDHZYQ4pgE2LKMIDX8YPZOoqeHaUpqKFM3B
        LXPEl50XUF1ZqAmdYZW4ylTEV+ZKs6LRYZ+sXFw2xppZIInzi2gjkvjRsc4p1LbT
        bGzNxv0EtZywZ019QlAr+o7xzyqrj6F4Cav4YgWW+Ko7H2EAYXKZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57564F9098;
        Tue,  9 Nov 2021 18:00:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7AA3F9097;
        Tue,  9 Nov 2021 18:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 1/4] fetch: Protect branches checked out in all
 worktrees
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
        <20211109030028.2196416-1-andersk@mit.edu>
        <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
        <316e8579-d720-b40e-66fb-3280e8de1922@mit.edu>
Date:   Tue, 09 Nov 2021 15:00:41 -0800
In-Reply-To: <316e8579-d720-b40e-66fb-3280e8de1922@mit.edu> (Anders Kaseorg's
        message of "Tue, 9 Nov 2021 14:52:36 -0800")
Message-ID: <xmqqa6id0w9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD7D65E6-41B0-11EC-B9FE-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

>>> +	git fetch -u . HEAD:wt
>> Maybe even `test_path_exists wt/apple.t`, to verify that the
>> worktree has
>> been updated?
>
> Not here; git fetch -u never updates working trees, not even the main
> working tree.

Correct.  The "--update-head-ok" option was invented to let the user
tell Git this: I know updating the ref may make the relationship
between HEAD, the index and the working tree inconsistent, and you
will normally prevent me from doing so to save me trouble. But in
this call, I will reconcile the inconsistencies myself, so do not
worry about the issue and just update the ref.

So there is nothing to fix here.  If the user wanted to update the
working tree, taking the material that was just fetched from the
other side into account, "git pull" would have been used instead.

Thanks.
