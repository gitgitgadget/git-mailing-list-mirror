Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ECC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiBJTOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:14:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiBJTOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:14:17 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FAD2607
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:14:17 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F18D311971E;
        Thu, 10 Feb 2022 14:14:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BCWWPotp/5g0OocWClW3FcorrT39fcWnk1fubT
        +tick=; b=uBIw9szuVmyyStgrp8Ldpy99WzRV4dEkQ4QqeA9xCDNo70y9riXjzG
        ebv9hUKtKo5HX+Yg7m4p2GQfIR+l9XyRowg4CGsD31rCVzhyg79Zra8V9Xs3GS9D
        G+zhU+EFAV2sIR7dtLDxhSq4LhvagBVS5PuRyrIPCjJOG5nU7c5ug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E909311971D;
        Thu, 10 Feb 2022 14:14:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5267511971C;
        Thu, 10 Feb 2022 14:14:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        <xmqqiltmwufw.fsf@gitster.g>
        <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
        <xmqqh796tw34.fsf@gitster.g>
        <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
Date:   Thu, 10 Feb 2022 11:14:15 -0800
In-Reply-To: <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 10 Feb 2022 19:36:49 +0100")
Message-ID: <xmqqczjuttyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3C658CE-8AA5-11EC-B6FE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> on a tangent: I posted a patch to write MERGE_AUTOSTASH,
> rebase-merge/autostash, etc. as refs.
> Is that the right direction? They are read like refs, but they are
> together in a directory with other bits of stateful data (similar to
> what is appended to FETCH_HEAD). Perhaps I should rather change the
> read path, so they're always read as files rather than refs?

I think that would be a lot more preferrable.  If a file is written
to record pieces of info, among which an object name happens to be
included, it does not have to be recorded as a ref.  Especially if
it is an ephemeral file like MERGE_AUTOSTASH and FETCH_HEAD.
