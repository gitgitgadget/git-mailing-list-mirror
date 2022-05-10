Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683DC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 16:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiEJQvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbiEJQvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 12:51:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807C244F2A
        for <git@vger.kernel.org>; Tue, 10 May 2022 09:47:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21C97114D0E;
        Tue, 10 May 2022 12:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w6jPWZGXlDxK+VdKlDQz2BfZnX8+Ns9nfVJA0v
        hdmNE=; b=gJqxJdpXOxZgA8WD74iWKa4cMNrOtBUl5gfRvmKNRE9/PxNfW3JJFD
        zDsNIKQwtH3xOnSFZCxj5GfqI8AnwGWpR7r3CB4MpfwKaYnO+34TdEzFZDiPQTzf
        vP4XP6zddufPDCLgreYhk1VmudmUoAjVFXMYBmw+Kj1A9xn0OXlNA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18650114D0D;
        Tue, 10 May 2022 12:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E0BF114D0C;
        Tue, 10 May 2022 12:47:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Timo Funke <timoses@msn.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Weird behaviour of git diff-index in container
References: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
        <YnnRIq3kudurSq4c@google.com>
Date:   Tue, 10 May 2022 09:47:41 -0700
In-Reply-To: <YnnRIq3kudurSq4c@google.com> (Jonathan Nieder's message of "Mon,
        9 May 2022 19:42:42 -0700")
Message-ID: <xmqq8rr98hci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8F96E7E-D080-11EC-9CD1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I love this example.  Thanks for writing.

I guess our mails crossed ;-)

> Some places I expected to find an explanation of this:
>
> - documentation for the "git diff-index" command ("git help
>   diff-index").  It does not mention this behavior.

Yes, diff-index and diff-files should at least have a pointer to
"update-index --refresh".  Ideally they should share a write-up
based on what both of us covered in these responses.

> - documentation for the "git diff" command ("git help diff").  It also
>   doesn't mention this.  That's particularly surprising because it
>   would be a great place to document the diff.autoRefreshIndex setting
>   that affects this behavior of the "git diff" command (described in
>   Documentation/config/diff.txt).

And the autorefreshindex documentation is a tad stale (it is on by
default these days) and does not say why you would want it.  I do
not mind config/diff.txt having it, but that should eventually refer
to the same page that is designed to help the readers of the
diff-index and diff-files documentation.

I do not think anywhere else the missing info belongs to, but
stepping back a bit, it may help to have a write up on scripting
using the plumbing commands in general, not limited to "diff-*"
family of commands.  I actually am torn a bit, as we have long
neglected to give matching improvement to plumbing commands when we
add shiny new toys to commands at the Porcelain level, so Git may
have grown much more hostile to scripters over the years X-<.

