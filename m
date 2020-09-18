Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D5DC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA18422208
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkR5o+oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRRWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:22:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65200 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRRWf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:22:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D56371DE4;
        Fri, 18 Sep 2020 13:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q3E09tpmpIXi/o1CzX3NIgsP5CQ=; b=CkR5o+
        oMQKy0UK1fNTEfJ0jC98IAH/lxxMJFqsA1MiZKqgFDMs5XWuMfTU9ZaJEhtcuJWi
        UfLsYoqiwH13/w/bJErtWN9LfPP+8sQHUhkiSA799/166v8I0LA6XiaSmtteS8iJ
        SB/6evBDF/8NY+9ZrfEeaqts28K99Y3BgiQnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uttnNXbiKYuROoDNjvMft75KqkiYB+ed
        tIJ6+QPmDF1aZmBaFES+VgLWoyGEOn/AC+tVgkCk7kq4RGdxYZEsdez9QbqkPkIn
        NdB4zPRbHhoXyaagljWvceNzrsHE1eCts7K0Pw1cHFYjNhGh3EdyvwQ8CyFLgFHu
        wLSKKn/m/6c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8416A71DE3;
        Fri, 18 Sep 2020 13:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06AA771DE2;
        Fri, 18 Sep 2020 13:22:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH 0/2] config: improve error message for boolean config
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
Date:   Fri, 18 Sep 2020 10:22:32 -0700
In-Reply-To: <pull.841.git.git.1600395427.gitgitgadget@gmail.com> (Andrew
        Klotz via GitGitGadget's message of "Fri, 18 Sep 2020 02:17:05 +0000")
Message-ID: <xmqqmu1nm23r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 899DACEA-F9D3-11EA-911B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently invalid boolean config values return messages about 'bad numeric',
> which I found misleading when the error was due to a boolean string value.
> This change makes the error message reflect the boolean value.
>
> The current approach relies on GIT_TEST_GETTEXT_POISON being a boolean
> value, moving its special case out fromdie_bad_number() and into 
> git_config_bool_or_int().

The approach does not make anything worse than what we currently
have, which is good.

I am undecided if we want to apply 2/2, or if we want to apply 1/2
alone without 2/2.  If we applied 2/2, those who are reading the
code in a year who forgot about this review thread would have to
wonder if all values assigned to the variable bad_numeric are
enclosed in _() and go up to find all assignments.

Omitting 2/2 would keep _() around the message string fed to die(),
so it may be easier to immediately see that the call to die is not
missing basic i18n, but there is a risk to forget marking with N_().

If we were to use 2/2 in addition to 1/2, then squashing them into
one commit will make the result easier to follow, because we no
longer need an untranslated string in bad_numeric after 1/2 is
applied.  We are losing "the reason why we use N_() is..." comment
in 1/2 anyway so doing what 2/2 does in the same commit would be
more sensible than splitting these into two patches.

I dunno.

Thanks.

