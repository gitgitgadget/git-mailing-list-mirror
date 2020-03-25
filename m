Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81203C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE3B20719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HB37hd3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCYFTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:19:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:19:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26E56512A4;
        Wed, 25 Mar 2020 01:19:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zR4cSyxvQiyDDKLPo3c4oR4ap8Q=; b=HB37hd
        3yOksk6XmowwSwuLenRmwWmdVG2MCBDDq4Hs5KxbxMJHu5xGzxiVUZHjp5pT506X
        Vwvtl+jMjfknkMYH47FhacPErIMhYClKZ4wb3Vz++ChJDUbhVDQlWdLMcEu1vG5K
        ln7x8dmnb2aiGMkCbRcgd8d5kHl0VwY+q0RNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UCK1RVzsjgl9z+UNhHpPROtWGsRZE7w4
        Z8M6zasB+T6Pv0oaAhTFRXhb+WEu/FTnR8jo6U+BQpktw32Hb9sL7l6AGUsKEimQ
        JshzJePg2G+BCzGhQtgswp3lM5xXQ4+y6xAmwYcS8UqJNNlx6wDSJq+dST42dgFP
        XdPuxW+CFNU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E11D512A3;
        Wed, 25 Mar 2020 01:19:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A01DD512A2;
        Wed, 25 Mar 2020 01:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] New proc-receive hook for centralized workflow
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
        <20200322131815.11872-1-worldhello.net@gmail.com>
Date:   Tue, 24 Mar 2020 22:19:29 -0700
In-Reply-To: <20200322131815.11872-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 22 Mar 2020 09:18:10 -0400")
Message-ID: <xmqqftdxypsu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3496F6B8-6E58-11EA-B413-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Changes since v2 and v3:
>
> * Implement a on-the-wire protocol, and add new test helper to test
>   the on-the-wire protocol. See patch 2/5.
>
> * Refactor report() on both server and client side for reporting of
>   proc-receive. See patch 5/5.
>
>
> Jiang Xin (5):
>   transport: not report a non-head push as a branch
>   receive-pack: add new proc-receive hook
>   refs.c: refactor to reuse ref_is_hidden()
>   receive-pack: new config receive.procReceiveRefs
>   receive-pack: refactor report for proc-receive

t5516 detects breakage of these patches that are queued directly on
top of 2.26.

The tip of 'pu' tonight includes this, and fails.

E.g. https://travis-ci.org/github/git/git/builds/666579791

Thanks.
