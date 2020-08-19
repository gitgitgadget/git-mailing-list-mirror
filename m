Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C188C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A032063A
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1CmAo+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgHSPw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:52:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58601 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHSPw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:52:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87341F2FA0;
        Wed, 19 Aug 2020 11:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68mVdxqQXyUJFhF0XW3IcMZgnNo=; b=X1CmAo
        +0YObpKVIh0v8JuPBrKvcxYKvq5gZOSq/ojuobzWuF31X3f6fNj3ZK2sx3uWDn+C
        gmJJOOKUB0yhYibOWbr4QjAFLOzTQWerJGZXOXJBWKkt66I4BsFJV3jqQ69ne4jg
        VzyK04UC4t77CuAKIvJR8ct5Z3ESxm18/aGHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NNixNrG95JLkHmYIKiXPqKw+e3R6W/ov
        UqSvPAg0seL2AQZbYh61cNPalPM/ef6fjNTGWwKiqOFyboYypMTTY3MFubB1IHdS
        rGTs7mwAV5LzxL70/KLXpGTjgmtpffkv1lmb6o0Y8A65WOLl9HUjbi+frxtyDXSj
        o+mF0XnAJLQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 808D4F2F9F;
        Wed, 19 Aug 2020 11:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7FEFF2F9E;
        Wed, 19 Aug 2020 11:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
        <xmqq1rklrhle.fsf@gitster.c.googlers.com>
        <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
        <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
        <CAFQ2z_No3QPJju7N9EqnT+knOioJpxxi61oFf9HyRGgf-fuwpA@mail.gmail.com>
Date:   Wed, 19 Aug 2020 08:52:51 -0700
In-Reply-To: <CAFQ2z_No3QPJju7N9EqnT+knOioJpxxi61oFf9HyRGgf-fuwpA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 19 Aug 2020 15:19:51 +0200")
Message-ID: <xmqqmu2qvdik.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A5E5B3E-E234-11EA-8E17-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> blame.c has an append_merge_parents() which reads multiple lines from
> MERGE_HEAD, and cmd_commit does so too. It's populated from
> write_merge_heads(). So the special casing should be extended to
> MERGE_HEAD.

Ahh.  That makes sense.
