Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B97C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA9A2166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSnoEq2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBDUup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:50:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52117 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBDUuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:50:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE91E3C8B8;
        Tue,  4 Feb 2020 15:50:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p5/Qjzyg+QE3u0g4p3c7aSWSYVo=; b=rSnoEq
        2hO3s3ck7Vqv+eMov+hYBEJ8dF8fsv5+/yoHUf0ISCv6FgGyA4s6BBwiDD59782d
        OoBlJadY2UEHsAEnPRFus8OhnwvGTk2VcGybtq2OPsOnf9epgW6lDR9Bl5kx/IHk
        Wvsxw3/hUhUbEXUNYPnLb1pDFyDW3u6Mk1ASs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y2Pra/NpIVlzInLMY1cBy1xLACLWHUo5
        V//U/yZUhT/RBC2LksnQbz4QbHw7rPXsbDEeLqmYTQHX0S1vAQDG+oplTfDqlk2F
        sKD4btyhPioR76j84CpgYRmwcnXHxbDo2h7q4MGUVj2Nd2o2Y/gIWejxORlt50pH
        urmUE4DB6nc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C783C8B5;
        Tue,  4 Feb 2020 15:50:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 170323C8B4;
        Tue,  4 Feb 2020 15:50:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 4/4] git-p4: add p4 submit hooks
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
        <3d34dd042e47fce7bc49a63f676378172e15775e.1580507895.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 12:50:39 -0800
In-Reply-To: <3d34dd042e47fce7bc49a63f676378172e15775e.1580507895.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Fri, 31 Jan 2020 21:58:15
        +0000")
Message-ID: <xmqqmu9y6pr4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 015071F6-4790-11EA-B050-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> The git command "commit" supports a number of hooks that support
> changing the behavior of the commit command.  The git-p4.py program only
> has one existing hook, "p4-p4-pre-submit".  This command occurs early
> in the process.  There are no hooks in the process flow for modifying
> the P4 changelist text programmatically.

OK.  It is unclear to me how the line between 3/4 and 4/4 was
decided.  It makes sense that 2/4 was done as adding the mechanism
to run hooks.  

A natural progression after your 1/4 and 2/4 would have been to add
the "--[no-]verify" mechanism to disable any verification hook in
3/n, possibly rewrite the implementation of existing hooks using the
mechanism you added with 2/4 and 3/n in 4/n, and then either (1) add
and document all new hooks in 5/n, or (2) add and document one new
hook per one step in 5/n, 6/n, 7/n and 8/n (you are adding one in
your 3/4 and then three in your 4/4 here).  As a reviewer I do not
have strong preference either way (i.e. 4 final steps to add 4
hooks, or 1 final step to add 4 hooks), but 3/4 and 4/4 you have
here look harder to reason than necessary, at least to me.

Thanks.
