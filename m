Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E17C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDCE2082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XnFvWUoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAaSkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:40:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSkH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:40:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80417ABE1A;
        Fri, 31 Jan 2020 13:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lYvsooNyR3nIH22LkpH6y+10sLM=; b=XnFvWU
        oI8ExtFAMt7k+iYy62Cdup89BBXmuDQVNSP3msyNU2JdEOHiOm1P9DSaC5YcUmXc
        fmr8vBmPu5zp+t5MJy8KmNRrlgDrpIJfUjXxbtI4FdEVqEINsyAIcYS6/Wl9+Nx2
        Tq6lMMZ/N4amAmtM6ibnfWXaQwqmmH4DioJnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fs1vO09MzOpkCcAudOtSojf4VvmmMbVm
        1QhWi0zt2bwvT/udyw+nRXUawKp7rHVZB+XfwTpjZjZA6guNV/hZfj3GN7s4FMXZ
        iHjIeqSAQCRULszerGKmRdZuGZGQ1uCBGUalX7GpdoHBVfFv+nxeKklae9EgT05s
        TbK+0FsI3B4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77FFBABE19;
        Fri, 31 Jan 2020 13:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C39EABE16;
        Fri, 31 Jan 2020 13:40:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 08/11] bisect: libify `check_merge_bases` and its dependents
References: <20200128144026.53128-1-mirucam@gmail.com>
        <20200128144026.53128-9-mirucam@gmail.com>
Date:   Fri, 31 Jan 2020 10:40:00 -0800
In-Reply-To: <20200128144026.53128-9-mirucam@gmail.com> (Miriam Rubio's
        message of "Tue, 28 Jan 2020 15:40:23 +0100")
Message-ID: <xmqqwo97a2rj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1789C772-4459-11EA-8D76-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> + * - If a merge base must be tested, on success return -11 a special condition

Is this eleven something the original (scripted version) used, or
what this series invented?  If the latter, what was the reason the
value was chosen, and what were the constraints when choosing the
value (e.g. it cannot be used an exit code by something)?

In any case, these values (if there other special codes defined)
should be given symbolic names (either #define or enum).
