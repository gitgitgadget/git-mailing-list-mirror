Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D2C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3440661100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhIIRIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:08:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58486 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhIIRIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:08:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D3F4EEA5B;
        Thu,  9 Sep 2021 13:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=i4LuPox6p4N08JdePF2D8oLmGVughFPK/7AAfKUDndU=; b=cQDG
        AI22IrZX2YzsD/BH5+HfUIiA9mSvLRHDUOGOrhhYC9Y31gWv+b3eX2iRrEyExBX3
        VYgT4MeNw9lowMUU1hEg20Vqb+q47thhI65wbsuh11NpZAi5PUAg9Gj4nuQ9eL9b
        4Y8w1Wgu1Nv7BXjOY1hN7OJBbeXPYKiaxNd/bZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE6F6EEA59;
        Thu,  9 Sep 2021 13:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76ADCEEA55;
        Thu,  9 Sep 2021 13:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru>
        <cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org>
Date:   Thu, 09 Sep 2021 10:07:05 -0700
Message-ID: <xmqqilz91xvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C6AC354-1190-11EC-82F1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Gitk does not want to look at a commit and then decide which incarnation
> of the command it wants to use (--cc vs. -p) depending on whether it is
> a merge commit or not. This decision is delegated to command that is
> invoked. Therefore, silent fall-back from --cc to -p in case of
> non-merge commits or non-conflicted index is absolutely necessary.

Well explained.

"-p" in general is an instruction to show some form of textual
patch, and "--cc" and "-c" are the variants (i.e. compare with each
parent and combine the comparison results) of it that naturally
degenerates to the normal patch output when there is only one
parent.

"--cc" also flips the "m" bit, which controls if there is any tree
comparison should be made for merge commits, which matters for "log"
family of commands, so in that sense "--cc" was made to imply "-m",
but "--cc" inherently means "-p" for non-merge commits without any
need to say X implies Y.

Thanks.

