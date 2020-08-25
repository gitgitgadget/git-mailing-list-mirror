Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601AC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB41206EB
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="phhniGAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYU7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:59:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50345 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYU7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 16:59:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3DD6E47D6;
        Tue, 25 Aug 2020 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VGPizuQwRqXuAtwGoQbsG/QhDiY=; b=phhniG
        AEnc/CnhYguS0/2VdPtG7JFjdGkQcbJA92lqUhwdYn6FnQrPIl7jLUFI5cMvfwkx
        LDnDbRALQe2xXRXK7LM3LkJBxzt4bm62nzi0xI+v23oChxDRZLeOzRtOJ6VbWE84
        Gu3cofkrUpSyZ5/TqdIvuNIGz31u+Wj7VRYOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CRpTpM+r6kiI/qesVR8uSIM3E70HYdIP
        haCEYXlTyag7Z8IbAhjqaz0NTHP4FpdvUIH+jKUWN1XHWPaNfmTegI081AsmUPJZ
        J6vihwTwZ3EMjEk0jmY1XfUaPw9yM6pEzIhTwq+S4Bn0AgUnqwX4FHLRN7itvb9G
        UdAS/m276Vo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC20DE47D5;
        Tue, 25 Aug 2020 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E035E47D3;
        Tue, 25 Aug 2020 16:59:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/8] Maintenance II: prefetch, loose-objects, incremental-repack tasks
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 13:59:03 -0700
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 25 Aug 2020 18:36:31
        +0000")
Message-ID: <xmqqpn7ezbl4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFC9C828-E715-11EA-9DE1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is based on v3 of part I (ds/maintenance-part-1) [2].
>
> This patch series contains 9 patches that were going to be part of v4 of
> ds/maintenance [1], but the discussion has gotten really long. To help, I'm
> splitting out the portions that create and test the 'maintenance' builtin
> from the additional tasks (prefetch, loose-objects, incremental-repack) that
> can be brought in later.

I gave it a quick look but the changes mostly are fallout from
renaming the options structure to maitenance_RUN_opts and loss of
midx verify while a task rewrites midx; iow, no significant change
that are likely to become controversial.
