Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F443C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657A32075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wgmzpAN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGSOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:14:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63844 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGSOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 14:14:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F11A16EDB5;
        Tue,  7 Jul 2020 14:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6gUmlFpFXnNxumpojwQHGEPh5e4=; b=wgmzpA
        N4LP4HfDD08g9xJNOLpeAmt9R/yPTidEWRkZZArtRr9AWrmtqS70NSiOSuV6aNmn
        MEBISPxm9vjPb2RYRL3AAvOM+njQisF183CnR30mCiPXrGQoP8fqWvMDHkkU88sL
        vpMg+g1Dwk6PSx/tcRFcsYW3mNXBRp2CFmGT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wt6ywt2j3kqiXyaMHJIV/vyfmtJvY8GB
        JafIWTSvTq1B9yL/jGOwg4EULpx/DTi+ESviO7L8D5XXSYrPHEAjV7yKip6ZnFSd
        VwwqQsP4svc/0MyIt//mFWLz3ROIEiDheN+QDkMN2ZC2+2nBeEO0uLGaOpJXzEyw
        7AQg2Bt5fjM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FFC6EDB4;
        Tue,  7 Jul 2020 14:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 703176EDB0;
        Tue,  7 Jul 2020 14:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
        <xmqqimf09ypc.fsf@gitster.c.googlers.com>
        <CAFQ2z_OPbcX9FGsFnmraAUpTu2eKuf2PZ+DO-CTWvaBZD6WQQQ@mail.gmail.com>
        <xmqqv9iz5p2v.fsf@gitster.c.googlers.com>
        <CAFQ2z_P37j32O71Z+NxNNU7-xLfYf-Rz-MvbYakcpaysiep9Zw@mail.gmail.com>
Date:   Tue, 07 Jul 2020 11:14:37 -0700
In-Reply-To: <CAFQ2z_P37j32O71Z+NxNNU7-xLfYf-Rz-MvbYakcpaysiep9Zw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 7 Jul 2020 19:15:32 +0200")
Message-ID: <xmqq5zaz5h0y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85CAF0C-C07D-11EA-A84C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I can fix this specific instance here (which is what I think you
> want), for this commit to practice what it preaches. At the same time
> there are probably about 100 or so other places where the tests check
> the file system directly for ref(log) existence, so it would never be
> totally consistent.
>
> The only way to systematically find the offending places is to
> introduce a new ref backend and then fix all the tests, and I think
> that goes outside the scope of this small series.

Good.  I think we are on the same page.  I suggested to make the
patch internally consistent, nothing more.  And fixing everything in
the world is outside the scope of these two patches.

Thanks.
