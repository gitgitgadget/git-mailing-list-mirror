Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F02C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FDA20727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FPSJC1Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEORVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:21:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56876 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEORVX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:21:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 367DDCD537;
        Fri, 15 May 2020 13:21:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Dznmc5pasq8k1wLPBwjP5ruJl
        0Y=; b=FPSJC1CpYLtXE7W9eKBuJDPXIGVvtcQCmxn6wQNjvLdutsl6lhfpex2Pt
        EogcJY1Wo/D4xjmkRopPpjMa5h+JFhYfxys8Lx6+lKZ8jLGgLluyjrDgRciEVbi9
        9kJMjDaGV/aUNkBtD8w3X+SF9mGnk7+pLfhIImFjBPvo16SqTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=WgXQcKN+N6p8jdYrstF
        u5QxTbktT5zIACZKE/KE6a78OO0pRNOZEg5oc7WnvsUEbIK311N6NkZ0UJjx07fY
        4wDxZXhGnLlhk0BGNspNZzLA8HAQ8Iij9bYrbN4Cr1QgzRzvgED1Qv41X6E3kPdH
        IImgD5F60DcS3xveM2BwcBrg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2ED85CD536;
        Fri, 15 May 2020 13:21:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A88FCD535;
        Fri, 15 May 2020 13:21:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Unbreak TAP output under bash
Date:   Fri, 15 May 2020 10:21:15 -0700
Message-Id: <20200515172117.155238-1-gitster@pobox.com>
X-Mailer: git-send-email 2.27.0-rc0
In-Reply-To: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
References: <xmqqlfltm9b5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 7D9FE55E-96D0-11EA-BD59-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban reported and Carlo diagnosed that a recent change breaks TAP
output under bash.  We know we can work it around but I'd rather not
having to worry about the breakage this late in the cycle.  Let's
revert and re-attempt the enhancement it wanted to do in a way that
does not break TAP in the next cycle.

As the same change broke the test under some shells that are not
bash, fix for that change is also reverted.

Junio C Hamano (2):
  Revert "t/test_lib: avoid naked bash arrays in file_lineno"
  Revert "tests: when run in Bash, annotate test failures with file
    name/line number"

 t/test-lib.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

--=20
2.27.0-rc0

