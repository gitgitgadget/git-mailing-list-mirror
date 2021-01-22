Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619AC43381
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D78A23B06
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbhAVVvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:51:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63285 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbhAVVv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:51:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAE5211258F;
        Fri, 22 Jan 2021 16:50:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AS9/sOt+dHWspAFn6s3+apjVyYg=; b=eV7D5K
        z7mmVU48ANtBS1TGLo59r1AQUvHLvA/3dINRDTbSFsCW/Uu71noA2PLGZYkwSV8Q
        tHFfVFTVcOw/Wv094bcVtI0Qy5vtU8WGoV834QyfA4vosjbwA2y7ACkgsJS5PdXG
        Hgqt1OUamkjX/CAShyt0ptO2/hcfhCINXUshg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PBpp31i9fzrmVAv1ykWWJ5aBYCMljtmu
        5mIXr7/ORdvDc+EfVvypuYsfUEVRyZELl6KG1uoUNd7pmD8u+s5hZ73VRbYjgNPn
        GH39wdxwx9GMYL5sppCa/lE74i6q3DLAePJ02h8vOqStETRshfsCXyKHXCfsfvIJ
        p3OGjKwYgsM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1F6D11258E;
        Fri, 22 Jan 2021 16:50:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 965B411258C;
        Fri, 22 Jan 2021 16:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] SKIP_DASHED_BUILT_INS: respect `config.mak`
References: <pull.840.git.1611234585889.gitgitgadget@gmail.com>
        <xmqqft2tc2w7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101221935230.52@tvgsbejvaqbjf.bet>
Date:   Fri, 22 Jan 2021 13:50:35 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101221935230.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 22 Jan 2021 22:16:52 +0100 (CET)")
Message-ID: <xmqqft2s7iac.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCD2E3C2-5CFB-11EB-8046-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> By the way, I wonder if we can (semi-)automate looking for such a
>> mistake in the future.  Does a simple rule like:
>>
>>     No variable that has "Define X if you want to distim the doshes"
>>     at the beginning of the Makefile must be referenced before we
>>     include config.mak
>>
>> work?
> ...
> The only thing that sticks out in this output is that we use SHELL_PATH a
> couple times before including config.mak.
> ...
> And I don't think that this hack of mine can be converted into a robust
> check that we'd want to run to verify that the Makefile does not use
> constants before they are potentially defined in config.mak,
> unfortunately.

Oh, I wasn't expecting all the work be done by you in your busy
schedule ;-) The primary thing I was looking for was to sanity check
the idea of the general rule.  Implementation of it can start as
something the reviewers would keep in their heads.  A script with
false positives that authors can use to be reminded may come next.

We do not have to jump to the perfection from day one, in other
words.
