Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiB1WCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiB1WCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:02:35 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BCB0D33
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:01:49 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98CA0105FF7;
        Mon, 28 Feb 2022 17:01:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNJOUCCOYSe0mkL6p5gKP+SZF5BxIZurXAbuwL
        mTbxA=; b=kXIjBef9nUhIu3myeORh23gpKYOGEfZb9Go3lxuqBQMnfUs8MvcgiD
        1snwLwqnrGwPMYT4Jh5n5iFZvczvJf5Cqs5D/O8Ts17cdzghqN2BthFBQ/pY77+Q
        sIJpsH/z7VMNOohCUNRFQOSDeMQlkAD3KcoPXStZAUMVqraHrIxBs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84CFD105FF6;
        Mon, 28 Feb 2022 17:01:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCDF3105FF4;
        Mon, 28 Feb 2022 17:01:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
        <b5fb21f5-4aa6-fa36-a8f6-abf82b543c1d@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 14:01:46 -0800
In-Reply-To: <b5fb21f5-4aa6-fa36-a8f6-abf82b543c1d@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 28 Feb 2022 10:27:08 -0500")
Message-ID: <xmqqa6eazm45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0655DFF6-98E2-11EC-A0A7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> +	HANDLE osfilehandle;
>
> I'd be more comfortable initializing this variable to
> INVALID_HANDLE_VALUE.

Both directories/files branches assign, so it is not needed.

>> +	if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
>> +		fh = 0;
>
> and here initializing fh = -1.

This does make it safer.

> And then this becomes:
>
> 	if (fh != -1)
> 		close(fh)
> 	else if (osfilehandle != INVALID_HANDLE_VALUE)
> 		Closehandle(osfilehandle);

Exactly.
