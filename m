Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF4C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DBC20774
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTIDS181"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHJPXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:23:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51471 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgHJPXF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 11:23:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4D5CEB0E5;
        Mon, 10 Aug 2020 11:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=forFSQEETY8aK4sX/CLWXGY7tXM=; b=WTIDS1
        81YGhrW3/B8QQQrqd11DuT6SubJyG+xQE+fJC6KHXRmT79RhHr9xE8gWRduCe0qD
        bkfdfdO5ZiLi3fKzYovOPKIsENs2dO8+RPieM+PdMPdBd5hSWdwUDkIOURPXgP1u
        iBGNTSlSFYqhxkmngjvqKq0sgH9rdi26QLqnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LudMIJAeJHtCXkluNjGP/OEh/L9IJxGL
        xb2+x4WY7SB9roI8V9n4bdlWxwzR0U0QkcLdxjww6n9CUxk4865WaTX8SyD4SR7w
        OEBReZrzE6ZOZjaXGotBiu7R0KzTbAtobooTFCu/EAS9SMwRkO/50Vfr10SvfUgp
        lITTfxP9u/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD86FEB0E4;
        Mon, 10 Aug 2020 11:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDAF2EB0E2;
        Mon, 10 Aug 2020 11:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
References: <20200809060810.31370-1-sunshine@sunshineco.com>
        <20200809174209.15466-1-sunshine@sunshineco.com>
        <xmqq7du7eiqi.fsf@gitster.c.googlers.com>
        <CAPig+cTA_BVz-bGcGY++g2RV-Zd3Gv_yTGjv=VeMeqhP4eZZrw@mail.gmail.com>
Date:   Mon, 10 Aug 2020 08:22:59 -0700
In-Reply-To: <CAPig+cTA_BVz-bGcGY++g2RV-Zd3Gv_yTGjv=VeMeqhP4eZZrw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 9 Aug 2020 15:34:57 -0400")
Message-ID: <xmqqtuxacyp8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60A02BD0-DB1D-11EA-84FF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I had the same concern that it didn't necessarily make sense to allow
> "-" for $2, but eventually thought of a case such as:
>
>     sed '...' actual | test_cmp expect - &&
>
> which massages 'actual' before test_cmp() sees it. True, we don't
> actually have such callers, but it theoretically is legitimate.

Yup, that looks a bit too stretching [*] to me, but that was what I
had in mind when I said "I'll let it pass".

    Side note.  Presumably that 'actual' was written by Git, to
    avoid losing its exit code, e.g.

	git frotz >actual &&
	sed '...' actual | test_cmp expect -

    but then it becomes more natural to write the second one like
    so:

	git frotz >raw &&
	sed '...' raw >actual &&
	test_cmp expect actual

