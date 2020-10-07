Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F63C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED3E2083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqbHrSGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgJGWYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 18:24:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60971 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgJGWYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 18:24:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37FCAF2DAB;
        Wed,  7 Oct 2020 18:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8tZLwus9kAAStuH0MFYbPQK61cc=; b=bqbHrS
        GLOkzeKdOpPsG0W0Zq5FufDDjTaNxnVAoLqNCSIjXeGVucX6/gmSRyPWt2lHKeu7
        wAJDBfeCB3OvgfCpZ/M0KQy6tKHimdyV/LesU61QRLsc9sfnxNLSQqSFO4pWDS1T
        T3k/jAk/vPZH7qK6noQTqmGxP+8skPN6nXVe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dL3uNIinpdcKRZ363Vx+CxfzF8p5IaaG
        tpMT4CdIc0cu8BpeCd27feEHwXj3PLyahpd7/CMsGR6JaFI/d/q+adP34L4hH9vm
        aMiIfPQcCAUIOQbiqOPB4fQuk84I1fmM8X/f8+RV/D/0k7fCwkNm4HHs+gnLYH3c
        D1FCoifCxNc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30661F2DAA;
        Wed,  7 Oct 2020 18:24:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77043F2DA9;
        Wed,  7 Oct 2020 18:24:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] help: do not expect built-in commands to be hardlinked
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
        <xmqqpn5u2bps.fsf@gitster.c.googlers.com>
        <xmqqh7r62ah2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010072349280.50@tvgsbejvaqbjf.bet>
Date:   Wed, 07 Oct 2020 15:24:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010072349280.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 7 Oct 2020 23:49:33 +0200 (CEST)")
Message-ID: <xmqqh7r5znbo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E740688E-08EB-11EB-A96B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, what I would have expected you to say when you found the `uniq()`
> function is: Johannes, why don't you call `QSORT(); uniq()` after the call
> to `load_builtin_commands()`? After all, `exec_path` and `env_path` might
> both be `NULL`...

Nah, you are expecting too much out of me.  I didn't ask because I
knew we didn't need to, and I didn't particularly care if you lucked
out or if you had the same understanding as I had how you arrived at
the right solution ;-)

