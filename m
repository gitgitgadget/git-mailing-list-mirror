Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C57C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7729B208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WaDrEb9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgBTW0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:26:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52866 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTW0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:26:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA84519DB;
        Thu, 20 Feb 2020 17:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sEzG2wKUb6dvMJsHfvPqvTTNwI8=; b=WaDrEb
        9Jr/idBg9p9EnDykOfT1xkQPpitb1wAS70WkKfsymRQLedj4FSglvHO7XqiNpF5d
        9EpW10+2/L22S90Wcj8SiYMMN/kFqNWqGpH1RcHgZoaHBgCnTnvz43o1a9yqCm4T
        HIZSpW6a05pT1H8FkHqUuN2/hV8ck8Wk0SNKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SCAloL2vPCIa8xPHjLJP0NJF6o5x+8Xj
        5IXgWR7C1pmKgJH2CyzKOpWaQPHta8P0dmwh4MrWoD2LZYU9SkyT2DKjYI6upb+U
        xeCcNe6reWiK22tiOnUqBs1prr25hbVYi1M1Eir1uQlObi48MkbaRs6PbNzVokmF
        9svlpUGtSi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D54CF519DA;
        Thu, 20 Feb 2020 17:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DB0D519D8;
        Thu, 20 Feb 2020 17:26:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: BUG: git clean -d cannot remove files from read-only directories
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
        <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
Date:   Thu, 20 Feb 2020 14:26:26 -0800
In-Reply-To: <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        (Adam Milazzo's message of "Thu, 20 Feb 2020 20:05:48 +0000")
Message-ID: <xmqqo8ts99pp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08E5FB32-5430-11EA-806A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Milazzo <Adam.Milazzo@microsoft.com> writes:

>> Also, another way to look at this; currently 'git clean -fd'
>> behaves the same on untracked directories as 'rm -rf' does and I
>> think that's a good model for how to behave.  Why should they be
>> different?
>
> I would ask "why should they be the same?"

Simply because that is how users would expect how the world works
(iow, model things after what they are already familiar with).
