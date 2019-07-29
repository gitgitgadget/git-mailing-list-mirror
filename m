Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDA01F462
	for <e@80x24.org>; Mon, 29 Jul 2019 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfG2S6G (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 14:58:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfG2S6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 14:58:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7989F15BDB0;
        Mon, 29 Jul 2019 14:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KsdLExe3TnhelxXE345LVclHFu0=; b=fIgIyl
        20Xre9fElLu0qCvtdPhbLKpSekzUt2binXJYNEZwYe0jXid1q9XiOjVbS15RK1+d
        pCOLLXoGIH4Ho5jqS25IH/bHjoCZA28hc/Fb8Q2M4elkhplZp0UNGFwtuhxBSGGg
        JwYn54kA8ao223NdxENZTwBL+KWcXztPEg+iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EYeSC85Wr5s3d12Sg3J2CiA9CemVN4ox
        7DKaNaNEw9kULP0fdtg0k14HWGVkYD1DNRRITnW48YRaaEDu+pdpohwBGYECjbsG
        RpKGYr24il96KeeeMsVfT8kJibcq4VEQhuMutwlcUKgcPSkrij+soMz1obDZTzAE
        Qz8oWid0XUI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7200715BDAF;
        Mon, 29 Jul 2019 14:58:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D967315BDAB;
        Mon, 29 Jul 2019 14:58:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralph Maalouf <ralph.maalouf@caretrx.com>
Cc:     "'git\@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: 'git show -c' omits hunk even though file was modified from all parents
References: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
Date:   Mon, 29 Jul 2019 11:58:02 -0700
In-Reply-To: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
        (Ralph Maalouf's message of "Mon, 29 Jul 2019 18:20:44 +0000")
Message-ID: <xmqqd0hsvfb9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB384172-B232-11E9-AEFC-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So in short, one side has 1/2/3//7/10/9 in fileA and the other side
has 1/4/3//7/10/9, and the result of the merge is recorded as
1/2/3//7/10/9.

> I realize that this is because fileA in the merge commit's tree is
> identical to what it was in branchA prior to the merge (so the
> output of 'git show -m' only outputs the diff for one parent). But
> I'm wondering if this is the intended behavior.

Yes, that is very much intended.  We do not show hunks that match
one of the parents, and if there is no hunk to show, the path itself
is not shown.
