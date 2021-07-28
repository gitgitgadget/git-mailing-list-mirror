Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F1C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34AA6023B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhG1R0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:26:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhG1R0K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:26:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD2E4D8E5A;
        Wed, 28 Jul 2021 13:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ejL2HWs38PSSj6GMRKM4YT88m5qkSfbW165nDM
        Wosz4=; b=eap5eKZv0OETNp2/BkpGEejXEqdt3Z7e7AIVDiaB30eSD8lr8OatjT
        P/tsbC8ep8XXi2CgNqf33su+BZ864OTjC7j/lDxuA8Vfou9NhCFIxRYENMjRq2Wi
        0ulawizEVUeLAo4Ww/ka75v5IE1MK8hFTyhQKy2jKTp95AkpePXjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A43D9D8E59;
        Wed, 28 Jul 2021 13:26:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA5E2D8E58;
        Wed, 28 Jul 2021 13:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
        <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
        <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
        <xmqq1r7jebbf.fsf@gitster.g> <xmqqtukfcvzv.fsf@gitster.g>
        <CAOLTT8SR86q+q37traSpk7iWEzAaGTtZzAWrck+0LnqgSefKRA@mail.gmail.com>
Date:   Wed, 28 Jul 2021 10:26:06 -0700
In-Reply-To: <CAOLTT8SR86q+q37traSpk7iWEzAaGTtZzAWrck+0LnqgSefKRA@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 28 Jul 2021 19:34:25 +0800")
Message-ID: <xmqqmtq69wpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E46F0C04-EFC8-11EB-875D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Just use a PARSE_OPT_HIDDEN cannot prevent the user from using
> the option... Is there a better way?

If a command can be invoked from a script, you can invoke it
interactively the same way.  Not advertising on short help, not
completing in the completion and documenting it for internal use is
the standard arrangement for such "implementation detail only"
options.
