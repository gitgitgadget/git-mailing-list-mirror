Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C105C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E591A20730
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CYXr8Ugz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDIULf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:11:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63550 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgDIULf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 16:11:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EEE3C198B;
        Thu,  9 Apr 2020 16:11:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Gcw00aYZJuX68o6+gJs1HcgFd
        I8=; b=CYXr8Ugz/iC+czX+4QFrQM2JyNxtUeKXjSBtUlR4xJ3glhb81og/uiZYw
        6R3qUqSXnawZFF+OvI4xz4Wh6esiwDNAbDfi7jmjdrDQrYcfcFAbWGMtOMlNtsRs
        qbYBiHZqtvcWVcP4kPIFa81kSKayvPrQ6Uhv4xpXElCXthJbLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=Ha5WSNF8Uv02YUgRGlY
        t+KVhW4rChelTxMPOXohj/V3fBFypTlrA5n/mxT/4PpRZm+uoVCDwU6tDqIB3mij
        jEZPh9Ql4NdbxLblCifTmtq/4YIGqPB7A+6q9p5ha59YZEArbQ0+M0Tj6rOr9Ed5
        6zioB51KfyvKEnhyiTXK+/F4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5825EC198A;
        Thu,  9 Apr 2020 16:11:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49ED7C1986;
        Thu,  9 Apr 2020 16:11:31 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com
Subject: [PATCH 0/2] make "is_hidden" even more robust
Date:   Thu,  9 Apr 2020 13:11:27 -0700
Message-Id: <20200409201129.82608-1-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-106-g9fadedd637
In-Reply-To: <xmqqmu7locys.fsf@gitster.c.googlers.com>
References: <xmqqmu7locys.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 4D93D152-7A9E-11EA-9CE4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are two patches on top of "mingw: make is_hidden tests in
t0001/t5611 more robust" from yesterday to clean up the code by
consolidating two copies and make it harder to misuse.

Junio C Hamano (2):
  mingw: refactor test_path_is_hidden out to t/test-lib-functions.sh
  t: protect against use of test_path_is_hidden outside MINGW

 t/t0001-init.sh         | 13 +++----------
 t/t5611-clone-config.sh | 13 +++----------
 t/test-lib-functions.sh | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 20 deletions(-)

--=20
2.26.0-106-g9fadedd637

