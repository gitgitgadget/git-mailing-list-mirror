Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB2C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhLHXqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:46:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62108 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbhLHXqs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:46:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20C97F428E;
        Wed,  8 Dec 2021 18:43:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=Cl7WcJr994sxG+LhK3G2TxSpqwmFoVoeEYK6aTeMoTA=; b=q5Gb
        EglLENI1viniqXND+bEoNBWqtE6kvxfb17L2W3Ai8rQ6bm99eQxck+Qmzbt24pwL
        c26VyWv6DsbTCI0XUYe8gh5GiqTdWlkMRd2ogw5L5g09KHpPbq+JWkkfBrjk7DJ6
        E5EEi3CUp6cBNhMgmW4VjKl9YLLMEn51tL4K5Rg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18B9CF428D;
        Wed,  8 Dec 2021 18:43:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AF69F428C;
        Wed,  8 Dec 2021 18:43:14 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v5.1 0/8] redo ssh-signing-key-lifetime topic
Date:   Wed,  8 Dec 2021 15:43:05 -0800
Message-Id: <20211208234313.3052303-1-gitster@pobox.com>
X-Mailer: git-send-email 2.34.1-365-gae484d3562
MIME-Version: 1.0
X-Pobox-Relay-ID: 9C6E501A-5880-11EC-96B7-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, here is a quick attempt to move the fixes to the existing tests
to the front as a preliminary clean-up as [1/8], and stop step [7/8]
(used to be [6/8]) from copying the mistake we already cleaned in
[1/8] from the beginning.

No other changes intended, although I think I fixed a typo in the
proposed log message in [1/8] (the early half of the old [8/8]).

Fabian Stelzer (8):
  t/fmt-merge-msg: make gpg/ssh tests more specific
  ssh signing: use sigc struct to pass payload
  ssh signing: add key lifetime test prereqs
  ssh signing: make verify-commit consider key lifetime
  ssh signing: make git log verify key lifetime
  ssh signing: make verify-tag consider key lifetime
  ssh signing: make fmt-merge-msg consider key lifetime
  ssh signing: verify ssh-keygen in test prereq

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  6 ++-
 commit.c                         |  6 ++-
 fmt-merge-msg.c                  |  5 +-
 gpg-interface.c                  | 90 +++++++++++++++++++++++++-------
 gpg-interface.h                  | 15 ++++--
 log-tree.c                       | 10 ++--
 t/lib-gpg.sh                     | 62 ++++++++++++++++++----
 t/t4202-log.sh                   | 43 +++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 67 ++++++++++++++++++++++--
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 350 insertions(+), 48 deletions(-)

--=20
2.34.1-365-gae484d3562

