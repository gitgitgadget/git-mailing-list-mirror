Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1634C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D1D207FD
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x0uARUQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfKZBev (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:34:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57977 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKZBev (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:34:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDAE23539A;
        Mon, 25 Nov 2019 20:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkTNUR8PDuv3eBgWd2YEThc/dSg=; b=x0uARU
        QJqIbGbf/cUlVXx/c/sfZQHHaG0Ck0XgM0jWSyTWOvmPKhDhd/60oQVDz+WM+0G4
        tXJiSBBphZsaAFFfbgRXF/iDYXuKPbIbUaCxuB9Etoiwp1M6SRArNtDP0qMlkH70
        wsz69ZoCZmRbvVoQMnLRo+CPxoPseuq2bX3Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d/f4Wkc+Q6okRY70Pb74Ox8Bx1XAWuF8
        Voex4neCpnU7KUcGNJjtYSqN7ifFzQqASynnWekYaGegTRox/JXhytHxQcbyysor
        NuYg4Ue34KMikKlPov1ipsy8pUjHfcuSCmXQN8nxLynLd5IHXJzMKFbvoxliB8pP
        +t/XaFKq1aM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B450B35399;
        Mon, 25 Nov 2019 20:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16E8735398;
        Mon, 25 Nov 2019 20:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 22/22] t7700: stop losing return codes of git commands
References: <cover.1574296987.git.liu.denton@gmail.com>
        <cover.1574449072.git.liu.denton@gmail.com>
        <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
        <xmqqftif2wg7.fsf@gitster-ct.c.googlers.com>
        <20191125235702.GA6250@generichostname>
        <CAPig+cQqK-HiDjmnBFo-qeE6cZ73EveWg6Ygb-4BX3X_iPSJZA@mail.gmail.com>
Date:   Tue, 26 Nov 2019 10:34:48 +0900
In-Reply-To: <CAPig+cQqK-HiDjmnBFo-qeE6cZ73EveWg6Ygb-4BX3X_iPSJZA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 25 Nov 2019 19:58:32 -0500")
Message-ID: <xmqqlfs3whc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFFAC756-0FEC-11EA-8B4A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> It may not be too much work for you to keep adding more (unrelated)
> changes to a series, but doing so increases the burden on reviewers
> unnecessarily, especially for a long patch series such as this one.
> Generally speaking, each iteration should help the series converge to
> the point at which it can finally land (be merged to "next"). Thus,
> ideally, each iteration should have fewer changes than the previous
> one.

Yup.  It is too easy to paint an ongoing series with a brush that is
broader than necessary and say "this is to clean up", and fall into
a never-ending run of scope expansion, as there always is yet
another thing to clean up.  The focus of the series has been to
ensure that we catch error exit from "git" and that script conforms
to the style guidelines, and does not include hash migration.  

Let's resist the urge to expand the scope.

Thanks.


