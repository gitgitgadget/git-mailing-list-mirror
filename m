Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0575C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7310964F78
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 03:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCLDBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 22:01:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56381 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhCLDBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 22:01:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 161E3124F56;
        Thu, 11 Mar 2021 22:01:12 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Z5v1WtdjVouf3AlRlGDGibWro
        dA=; b=rTmtn5fVjfOV032ufhy54iDw+26IxjFOIUC7XgWIqllTFehSSrEUsWwOg
        jo6RQBkYoyMd8tozVq3wcGBH0xNVMApMLf+/WTGEWpUZVxd29Ljo5iQYzbLoZy8x
        ClS9r64A6srZrcfm92XP//loNpCZ++SCsXVoJ86Ie2/1kRCF7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=f38dK6G7jyLhVA4CKnt
        hVa/kkjWFRyoyL7BKrW8iQI/bBXqLu7kBPcfaLfvjmWFOfODhgy8fbQu3J29S594
        egBo1DwJxbodYDI06YOWwXlMSqyiSNMg9SY6GZlt7SAsDWMn5uVcV4AGkFNdAsQt
        2tNyZyIEt+2LT9oFXHKW1xD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F06D124F55;
        Thu, 11 Mar 2021 22:01:12 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B007124F52;
        Thu, 11 Mar 2021 22:01:09 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] "rebase -x cmd" loses notes
Date:   Thu, 11 Mar 2021 19:01:05 -0800
Message-Id: <20210312030107.1849942-1-gitster@pobox.com>
X-Mailer: git-send-email 2.31.0-rc2-175-g3820f1c72e
In-Reply-To: <xmqq8s6tcuxc.fsf@gitster.g>
References: <xmqq8s6tcuxc.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 320B92F4-82DF-11EB-8CEF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here is a semi-failed attempt to fix the issue I encountered
earlier, cf. https://lore.kernel.org/git/xmqq8s6tcuxc.fsf@gitster.g/
where "git rebase" carries forward notes attached to the commits in
the original history to their equivalents in the rewritten history,
but "git rebase -x cmd" does not when cmd modifies the given HEAD
commit.


Junio C Hamano (2):
  sequencer.c: make commit_post_rewrite() take two object names
  [WIP] sequencer.c: carry forward notes on HEAD across "rebase -x"

 builtin/commit.c              |  6 +++---
 sequencer.c                   | 19 +++++++++++++------
 sequencer.h                   |  2 +-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 10 deletions(-)

--=20
2.31.0-rc2-175-g3820f1c72e

