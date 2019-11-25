Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C6DC432C3
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA432207DD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bhd17FzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKYB66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:58:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65226 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKYB66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 20:58:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FF2DA7572;
        Sun, 24 Nov 2019 20:58:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yhkv3iOzxBLI+4enj7NAXUer26g=; b=bhd17F
        zHcMVqZgUUPxJyfZeB4zFELY7NCVZ4EVbSx2VH9MZXtHkytxeiJIL008YU4Hnv1v
        VhbDHnvgq4VahC0pZzH/huQedkWqT16u52ouubzQ/Bmx+7NOZYregsXmPNatovQc
        mE7xkCqBAPPcGOhJSXf0oxGhXF6KvIQWcG7xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yd45XyWNVgQunrA1RSPYfkKVcwfbzvx7
        ip+C0TfZgYxkcw1ygyDMFjZHJZWq9vLj4RSQcI2erYuEzt9Ho4zOqyXqZAVwbIwq
        tSz+Rqi3Hca+12uxDfXPkF4dvcBGK9+l4zIcKsBE9AjvrFsFcTQuB+EMefD1Zscw
        VA4afqFfIlc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88CF0A756F;
        Sun, 24 Nov 2019 20:58:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF0B3A756E;
        Sun, 24 Nov 2019 20:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nika Layzell <nika@thelayzells.com>
Cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] reset: parse rev as tree-ish in patch mode
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
        <338c2777f711ac21a30a7f890a8a11708e9a4fa6.1574538937.git.gitgitgadget@gmail.com>
        <xmqq4kyt250e.fsf@gitster-ct.c.googlers.com>
        <CACwGqKgPYMEHhfOnAEuCA3sNiuV0Wk_JQwU+c=vF7Wkhf=V9iQ@mail.gmail.com>
Date:   Mon, 25 Nov 2019 10:58:51 +0900
In-Reply-To: <CACwGqKgPYMEHhfOnAEuCA3sNiuV0Wk_JQwU+c=vF7Wkhf=V9iQ@mail.gmail.com>
        (Nika Layzell's message of "Sun, 24 Nov 2019 13:31:06 -0500")
Message-ID: <xmqqblt0zpgk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22089BCC-0F27-11EA-992C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nika Layzell <nika@thelayzells.com> writes:

>> Which means that perhaps a cleaner fix may be
>>
>> -       if (unborn) {
>> +       if (patch_mode) {
>> +               /* do not compute or check &oid we will not use */
>> +               ;
>> +       } else if (unborn) {
>>                 ...
>>
>> right?
>
> I tried to make this change, however it has unfortunate side-effects. The
> "git-add--interactive" script does produce an error if it is not of the
> expected type, but it exits with a successful "0" status.

Thanks for being diligent.  I love it when I see contributors do not
believe blindly what I suggest out of hunch and instead verify it
themselves.

> Given that the add--interactive script is undergoing a C rewrite, I am
> inclined to continue validating the argument in reset.c to avoid changes to
> the perl script.

Thanks.  That is a very reasonable decision.
