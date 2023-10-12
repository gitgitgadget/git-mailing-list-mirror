Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26024CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379547AbjJLQ06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379537AbjJLQ06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:26:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D28C6
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:26:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D45C7232F0;
        Thu, 12 Oct 2023 12:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/BFBr/B0Vlj7NxeOAMfMJz61nJnMY4JHljlgWf
        SfRwo=; b=t52yg/egfy2AyRn+smvZnQFR00Iyie5G9/P2tL3K5PI+SBRSUHkefr
        i5NaaFMCQ+KyuWUGEkk4th4Y4JvV1OzCC0D1suJetfjlMdc0x3f6ZpB60KenGJ3q
        /MUq5+UToEIYZt8ajZcv3et1eMjA5afO3QYwUo4iaMlRaaC1zA8uk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD49E232EF;
        Thu, 12 Oct 2023 12:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56320232EE;
        Thu, 12 Oct 2023 12:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
        (Karthik Nayak's message of "Thu, 12 Oct 2023 12:44:27 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
        <ZSTs3BUVtaI9QIoA@tanuki> <xmqqil7etndo.fsf@gitster.g>
        <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
        <xmqqbkd5nlq0.fsf@gitster.g>
        <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
Date:   Thu, 12 Oct 2023 09:26:50 -0700
Message-ID: <xmqqa5snhkmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26A91AFA-691C-11EE-A947-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> ... To ensure that the feature should
> work with corrupt repositories with stale commit-graph, I'm thinking of
> disabling the commit-graph whenever the `--missing` option is used.

Just to avoid giving anybody a wrong guideline, for most of the
other features, we should assume that the commit-graph accurately
represents the reality in the object database and take advantage of
it, leaving it to "git fsck" to ensure that the commit-graph is
healthy.

But "rev-list --missing", especially when used with actions other
than allow-promisor or allow-any, is a feature that is only useful
when one wants to really notice objects that are available in the
object store, and it would be a bug for it to pretend as if objects
the commit-graph has heard of exists without checking.

