Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A51DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbiBJWyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBJWyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:54:51 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD955A4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:54:51 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A03C8161490;
        Thu, 10 Feb 2022 17:54:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=995M2+yo0FEGauL6K1wZQkEkZ5ukyGLwOvJXq3
        IHZgs=; b=KLEJBT25IoWVRYPwRTQblSndjW2L4a4aRCSyy57EuqYkJx+9Yh6ND5
        FXo4fv3pxqVC8G+jjBvqdjiZt3S8PLFIoVl0Pvs3OUJnxLUItdLwFLVnI95FxEMf
        t+0hz10BLinRygxRSLmeQdeEgjKPJhdyNsK5AQHq/pl/01zZ3tOnI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 991E716148F;
        Thu, 10 Feb 2022 17:54:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A6D816148E;
        Thu, 10 Feb 2022 17:54:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
References: <20220210044152.78352-1-chooglen@google.com>
        <20220210044152.78352-9-chooglen@google.com>
Date:   Thu, 10 Feb 2022 14:54:47 -0800
In-Reply-To: <20220210044152.78352-9-chooglen@google.com> (Glen Choo's message
        of "Thu, 10 Feb 2022 12:41:52 +0800")
Message-ID: <xmqqpmnue3ig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73146F4E-8AC4-11EC-8448-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> add_submodule_odb() is a hack - it adds a submodule's odb as an
> alternate, allowing the submodule's objects to be read via
> the_repository. Its last caller is submodule_has_commits(), which calls
> add_submodule_odb() to prepare for check_has_commit(). This used to be
> necessary because check_has_commit() used the_repository's odb, but this
> is longer true as of 13a2f620b2 (submodule: pass repo to
> check_has_commit(), 2021-10-08).

Yes!  I wonder if we can do this much earlier in the series (or even
an independent clean-up that the rest of the series depends on) and
have it graduate earlier?
