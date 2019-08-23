Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6EF1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfHWQEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:04:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62805 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732458AbfHWQEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:04:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 260CA7929D;
        Fri, 23 Aug 2019 12:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3p+tacjXW9ME8dlR1qYbS7bQ1O4=; b=KiH84w
        D9d3ZuyfzPJj9x2VuHA7Es4y96jTu6mg7PCA4TeeP1sVOh77ghy/kHb+U4hMV9Jh
        hjzBdAtlRPPKmzNXtAgLmRGRZKgcdJHzNnOiguZxfwlHyhI2VQeA2NIriAcxIGF/
        T6gj9odVoEKLhs7wAjse1H+LkLFemsfrhtGgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o4IPyWJU/BLkEnst6Oj/YBpTyOCn0jMa
        xnXDnjzRwnh0JpdS1XcUoYVA7XHfm0PmjRs96sNBT9u1BWfyFLgfEHZIW5E2FHB5
        ECAOBLxw8CarLJ8SYxpN3yl/IuEM7l1MJ/WPvwkRAv1+hwqLKFsBDh4DxshvJyvv
        j7GL4XuumZ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DB2A7929C;
        Fri, 23 Aug 2019 12:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D1B57929B;
        Fri, 23 Aug 2019 12:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
References: <20190819214110.26461-1-me@yadavpratyush.com>
        <20190822220107.4153-1-me@yadavpratyush.com>
        <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com>
        <20190822225143.3blolae3f65z6zqq@localhost.localdomain>
        <CAKPyHN27Pz8BtzdUCewZMd2wi5hx8LyJTfJqwkyTbbQLJk+=VA@mail.gmail.com>
Date:   Fri, 23 Aug 2019 09:04:17 -0700
In-Reply-To: <CAKPyHN27Pz8BtzdUCewZMd2wi5hx8LyJTfJqwkyTbbQLJk+=VA@mail.gmail.com>
        (Bert Wesarg's message of "Fri, 23 Aug 2019 08:04:14 +0200")
Message-ID: <xmqqo90fna0u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA749BCA-C5BF-11E9-BC04-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> The thing is, that the partial revert "just don't happen by accident".
> Here are the minimum user actions needed to get to this dialog:
>
> 1. whole-file revert
>
> - do a Ctrl+J, more or less anywhere in the GUI
>
> 2. hunk revert/revert one unselected line
>
> - right click anywhere in the diff pane (thats around 60% of the window area)
> - move the mouse pointer down 3/4 menu items
> - click this menu item
>
> 3. partially revert selected lines
>
> - select some content in the diff pane by starting by pressing and
> holding a left click
> - end the selection by releasing the left click
> - move the mouse pointer down 3/4 menu items
> - click this menu item
>
> Thats always at least 2 user actions more than the whole-file revert.
> Thus this cannot happen by accident quite easily in comparison to the
> whole-file revert. And thats the reason why this dialog exists, from
> my point of view.
>
> I can see the need to disable the dialog for the whole-file revert,
> and IIRC that was also requested a long time ago on this list. But I
> don't see a reason to have this dialog also for the partial reverts as
> a safety measure.

Thanks for walking us readers through your thought process.
