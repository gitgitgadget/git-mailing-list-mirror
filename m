Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB77C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346F82073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="coQfT0fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfLKQjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:39:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52580 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbfLKQjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 11:39:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D9F892E2D;
        Wed, 11 Dec 2019 11:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/H9Xfk8QCNwqXho10lSPKgSbSFc=; b=coQfT0
        fOCSlrobgQkac+vvpVnHOAwornHBGUY8ZF9fqk3vpbUvqGehYEAOtrmDEIGdu94d
        q1EFbzzrRiWMRyrNx7KW8vEXW3MoK2Y6IF812FnGF/j/jiNBoj7i986GhGm8/0gt
        iNcYk+XCdWDSfXQSBD/1t+fVmZxPr1WihsMS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yaoUd5K9+xwVWku5olTqrZxwwTAkZEFp
        mHQS1trAI1JDcxwgpOH0ftxkt+WVbmzUQpFv3RQpTODQ+574yNb4viucl4H5fNem
        hrG87IOgLTx2mDYFh+sXNsnSl//yRM75Spo0NAsSF676qxRIJfFx6CQLw662DvMt
        OUNuBnqskZE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0500A92E2C;
        Wed, 11 Dec 2019 11:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28D1C92E28;
        Wed, 11 Dec 2019 11:39:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v5 05/15] git-p4: promote encodeWithUTF8() to a global function
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
        <11d7703e411f1dced8a34defc68922ba44c614d5.1575740863.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Dec 2019 08:39:44 -0800
In-Reply-To: <11d7703e411f1dced8a34defc68922ba44c614d5.1575740863.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Sat, 07 Dec 2019 17:47:33
        +0000")
Message-ID: <xmqq1rtarf3j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7C0A120-1C34-11EA-A267-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> This changelist is an intermediate submission for migrating the P4
> support from Python 2 to Python 3. The code needs access to the
> encodeWithUTF8() for support of non-UTF8 filenames in the clone class as
> well as the sync class.
>
> Move the function encodeWithUTF8() from the P4Sync class to a
> stand-alone function.  This will allow other classes to use this
> function without instanciating the P4Sync class.

Makes quite a lot of sense, as I do not see a reason why this needs
to be attached to any specific instance of P4Sync.

