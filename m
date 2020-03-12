Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77AC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DC1206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOSNoTHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLTMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:12:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64138 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTMF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:12:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E615950647;
        Thu, 12 Mar 2020 15:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KJ/qGn6yqBUCdQ3+jG5cT4QynL4=; b=HOSNoT
        HBo2qv2gUn8mMr2GMmbc2tphVXBlNS2B1VquPJcOV2+Me0I+hqcZ11O+6GbXiK9B
        hCcnChBsajPOY9CMaFcERt924479UhN43Y940cmgnVfpq95MsW7xXxI1oHRbO2bZ
        EFLw60Xe+ZBW8+75q2Ce60FrBJgca4r/yw7zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jpXB9w72FtNM46H4yYMjoaN/YRdXGRh+
        WluqODUg04F36xXHRPQdmsKkK782xMSMCzcJvsCHzZVWEELsuoV1E/5/3fPwTiWq
        YppK28flBKpFjp+D97UNTnyRxh6Ge6Btxg0cnTlKRUZJtqH09jF0AjjMoATQHt9y
        FrRDnLygYqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBAD150646;
        Thu, 12 Mar 2020 15:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5474550645;
        Thu, 12 Mar 2020 15:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
        <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
        <20200312151318.GM212281@google.com>
        <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
Date:   Thu, 12 Mar 2020 12:12:01 -0700
In-Reply-To: <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 Mar 2020 09:33:02 -0700")
Message-ID: <xmqqftedfkvy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AC21556-6495-11EA-8530-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Mar 12, 2020 at 8:13 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>> ...
>> This broke quite a few upstream users for us today...

One more thing I've been wondering was if we should really have said
"ok, the two known gotchas have been dealt with, so let's ship it".
It is quite likely that users may be hit by remaining differences
between the merge and apply backends that we assume to be merely
subtle and easy-to-work-around ones, and it may be prudent to use
the "let's not change the default just yet, but ask people to test
it in their workflow by advertising the configuration" patch.
