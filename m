Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7054C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646AF206DB
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MRIw0jYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBKXHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:07:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59392 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgBKXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 18:07:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B13CE4E533;
        Tue, 11 Feb 2020 18:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7/Uugq/8z+DArl5y8bDfS8PpNyM=; b=MRIw0j
        Ywujkwbze7RbTki4mavR75KQYuMarbK+oPWD0DhxSKqW1KnSJat7Xcw7BeMk/5vi
        Pe6Yio6GABVE2sJujS+CxVSa3A90UNgDuzph7Ql5RvWON4KmwFGgQ42Kl69XdwxL
        I7FXTArcQCkAxzDv3bVLlncbX0I46dAHBY+Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pXt7m4RhpL8DcTrDWaseZ6kJtVf4hhpX
        1Q+FeeT5aoBt6ZuABuI+S5s1csVe/ykfGOb2c9noqBpZ17qoZvl+Y9Qz4+URd9I8
        jA8xZG/mT7UiH8nHOrUe8i8ZTIfbIeas3C8IVuNzqe0Fnvf/mbNF941qhJuPWg9C
        s+wJvnw+UsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A31744E532;
        Tue, 11 Feb 2020 18:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9FC24E530;
        Tue, 11 Feb 2020 18:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] color.c: refactor color_output arguments
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
        <20200211193625.231492-1-gitster@pobox.com>
        <20200211193625.231492-2-gitster@pobox.com>
        <20200211194640.GA2127797@coredump.intra.peff.net>
        <CANsz78Jv6VZPx+XeFTnRTFofrVj-jrmx2-rFtXJpbfM3XMTS+w@mail.gmail.com>
Date:   Tue, 11 Feb 2020 15:06:59 -0800
In-Reply-To: <CANsz78Jv6VZPx+XeFTnRTFofrVj-jrmx2-rFtXJpbfM3XMTS+w@mail.gmail.com>
        (Eyal Soha's message of "Tue, 11 Feb 2020 18:01:19 -0500")
Message-ID: <xmqqo8u4vi3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35AADD18-4D23-11EA-9A13-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> Had I gotten any of those constants wrong, unit tests would fail.

To be fair, the tests only look for hardcoded numeric constants like
91 and 104, so it won't be able to catch a mistake like "oh, we
thought bright red was 91 but actually it was 111" ;-)

> None of those values are likely to ever change.  I think that the most
> important feature of the constants is that they are descriptive.

Yup.  Thanks for bringing up and working on the topic.
