Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 03:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88B764DAF
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 03:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCJDon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:44:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56909 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhCJDoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 22:44:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7D8811D3FD;
        Tue,  9 Mar 2021 22:44:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ru1Uvsy6rBsRPb55wm9LpNTHC34=; b=q858HR
        P0qXYCUGZwX8hk8Tlu2uz6tWh+a0qH5MtcjLqqP32IsqEgeFhSBilt5HFPCxDBkW
        PB8ZuaFOv4sxdInr65NEXHNdzG9PTPKtXvXbjM+b/oQkHLTUh7+LMw32wrQiYz8G
        Ayjc3KyxpCQ5VGpXfppxDbcsqRNkzA7YruJH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FUQWBmh6/OEUs4iFEz8sU/1uqe7LApKI
        CC4EdwYEprFZUtdEga99zvkoJLOq6MxDXy975UIIYow6+fCozcorjhPd2kITCeNl
        K4smH2t8cLR4MjCm5kDf1S2T/TX+EtbX+IsSbr8bIT58u3hYLyfCRdiBYRlYCySQ
        mMsn9jVNL3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0B7111D3FC;
        Tue,  9 Mar 2021 22:44:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5703C11D3FB;
        Tue,  9 Mar 2021 22:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Seth House <seth@eseth.com>
Subject: Re: What's cooking in git.git (Mar 2021, #02; Mon, 8)
References: <xmqqft1542wu.fsf@gitster.c.googlers.com>
        <YEgg5bWZ7WRC7KBu@google.com>
Date:   Tue, 09 Mar 2021 19:44:10 -0800
In-Reply-To: <YEgg5bWZ7WRC7KBu@google.com> (Jonathan Nieder's message of "Tue,
        9 Mar 2021 17:29:09 -0800")
Message-ID: <xmqq8s6vvfjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E033A79C-8152-11EB-9C3D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> The second release candidate Git v2.31.0-rc2 will be tagged tomorrow.
>
> Is https://lore.kernel.org/git/YEbdj27CmjNKSWf4@google.com/ being
> considered for -rc3?  If not, I think we should revert
> sh/mergetool-hideresolved.  It's the kind of change that can undermine
> users' trust in "git mergetool", so it's important to me that we don't
> ship it enabled by default.

There is no plan for -rc3, so any such change will be final.

I can go either way.  "git revert -m1 78a26cb720" on top of
v2.31.0-rc2 may be a safer option, especially if it reverts
cleanly.

But if your "let's flip the default" can be sold in a convincing
way, I think that is also safe enough, as I recall I carefully
vetted the patch to make sure that the behaviour would be he same
when the feature is turned off.

Assuming that "let's flip the default" patch indeed correctly flips
the default, that is.  IIRC, there were two and half levels of
configuration involved in the code, and I did not validate that your
patch turned the right "true" into "false" back when I read it.

Thanks.

