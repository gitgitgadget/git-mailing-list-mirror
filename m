Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25880C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4972082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s1LJyB+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgA3Sj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:39:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62721 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgA3Sj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:39:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F9D8AA1B6;
        Thu, 30 Jan 2020 13:39:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XkPG0NlnY7zq
        h0wH+jBV5AjBzs0=; b=s1LJyB+oqM9lkixwCkoAqhxP+CoMRDFZwGBJALq+RQUw
        yeYYdquKRVujYm9gQ1cVaQfEVaCQyKCg7ubww0scIhGejo2dPj6KxoCH/PnHsOaQ
        BcpmUjWZzbgA7wKuwtm+wPXSILOqzJ7XEX4fpAaEFXojLZXok4XYzdCv3rLIPrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kV5PUF
        gDAWNf9T6CR/E4NFsWOG/fOfqkngmoxHog3hOxluE1zhvKsmXWaLnPSMb2aN/XOa
        9QVk9WjMaM+kc1B0Jr+n6+s8y+GWA+E6k9g7OVe4LTq5HdOyQxv7j34fYYRB/Y+o
        ho/WXl8u8GZdWE/1cD81pHZOPHQN4WfdcFLZ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ABA5AA1B5;
        Thu, 30 Jan 2020 13:39:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 754B4AA1B4;
        Thu, 30 Jan 2020 13:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Andrey Mazo <ahippo@yandex.com>,
        Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
        <CAE5ih79a4SeiAnC_c+XHXAiibeNBg-h1ZjMsv2pHMNtHGmqX1w@mail.gmail.com>
        <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com>
        <xmqqeevhenbh.fsf@gitster-ct.c.googlers.com>
        <1dfe9fba-ec25-cd44-981a-25f7bcba31cc@gmail.com>
Date:   Thu, 30 Jan 2020 10:39:48 -0800
In-Reply-To: <1dfe9fba-ec25-cd44-981a-25f7bcba31cc@gmail.com> (Ben Keene's
        message of "Thu, 30 Jan 2020 09:20:42 -0500")
Message-ID: <xmqqmua4dc0b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5EA5F66-438F-11EA-BB71-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

> ... the name of the hook from "p4-pre-edit-changelist" to follow the
> git standard hooks:
>
> * "p4-prepare-changelist" - This will replace the proposed hook but sti=
ll
> =C2=A0 take only the filename. This hook will be called, even if the
> =C2=A0 prepare-p4-only option is selected.

With "to follow", I presume that this corresponds to the
"prepare-commit-msg" hook?  Does "changelist" in P4 lingo roughly
correspond to "commit", or to "commit message"?

> * "p4-changelist" - this is a new hook that will be added after the
> =C2=A0 user edit of the changelist text, but prior to the actual submis=
sion.
> =C2=A0 This hook will also take the temporary file as it's only paramet=
er
> =C2=A0 and a failed response will fail the submission.

And I presume that this corresponds to "commit-msg" hook?

>>   * Given that "git commit" has a pair of hooks for log message, is
>>     adding one new hook a reasonable thing?  If so, the log mesasge
>>     should explain why (e.g. perhaps the other one already is there,
>>     or perhaps the other one is not applicable in the context of
>>     interacting with P4 with such and such reasons).)
>
> I agree with your suggestion.

OK.  Let's find them in the updated patch ;-)

>>   * Is it reasonable not to have a mechanism to disable/skip the
>>     hook, like "git commit" does?  If not, the log message should
>>     explain why such an escape hatch, which is needed for "git
>>     commit", is not needed.
> The existing hook, p4-pre-submit, does not have an escape hatch,
> so I did not add one to this method, but I can certainly add one.

It is probably a good idea in the longer term, but we can certainly
punt and then revisit to cover them with --no-verify later (as long
as we do document our intention to do so in the log message).

>>   * githooks(5) manual page is supposed to list all hooks, so a patch
>>     that adds a new one should add a description for it in there.
>
> I'll add text for these files (githooks and the git-p4 pages).
>
> I'll make a new submission soon.

Thanks.
