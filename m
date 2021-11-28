Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A4C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbhK1XZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 18:25:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359474AbhK1XX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 18:23:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9577AE8173;
        Sun, 28 Nov 2021 18:20:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=emh0zBzJVPRceJTj6bFd3Z695zAHxkqlsMOBjL
        HTN00=; b=d6Mptin+tAm9YmfyBEuiDxSSE7mrm9L4Qmzf08gc5Ss7/2/Y6L1NFp
        spZsWTdMKFbWw1dE0ckIE/6JN8iaaxZ6CGC/0qBDsK7JSiSJx3XOU0jmG7fadC2B
        CfzjO2HuD+Y8H4zbC6Icd7GrO1EiP4Y0VE7sG6FgQBm/e3PdTGizM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DFE5E8170;
        Sun, 28 Nov 2021 18:20:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9635E816F;
        Sun, 28 Nov 2021 18:20:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: Git SSH/GPG signing flags and config
References: <20211128125704.4twinfd3wriwdntz@fs>
Date:   Sun, 28 Nov 2021 15:20:37 -0800
In-Reply-To: <20211128125704.4twinfd3wriwdntz@fs> (Fabian Stelzer's message of
        "Sun, 28 Nov 2021 13:57:04 +0100")
Message-ID: <xmqqzgpn50l6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC54D452-50A1-11EC-B33A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Hi everyone,
> the `signing git objects with ssh` series was released with 2.34 and
> i'd like to thank everyone for your support and the good reviews!
> I think it would be beneficial now to adjust some of the wording in
> flags and the config. Currently everything is configured via gpg.* and
> all the `please sign this` flags are named --(no-?)gpg-sign.
> I would be in favor of a more generic flag independent of the signing
> mechanism. Adding something like `--ssh-sign` would suggest that you'd
> be able to switch signing format with it which i think would not be
> terribly useful. If you need to use multiple signing mechanism those
> would usually be configured per repository and can easily be done with
> an `includeif gitdir:` in your config.
> Therefore i would suggest just adding a generic `--(no-?)sign` to all
> the commands that support gpg-sign right now. The only problem i see
> is a conflict with `--signoff` so i'm open to other naming ideas. The
> same goes for the config. `sign.` as an alias to `gpg.` would work
> well with the current settings.
> Let me know what you think and i could prepare a first patch for one
> command to see what the alias / config / docs change could look like.

I do share your worry about --sign to be confused with the sign-off
procedure, and that was why the original used --gpg-sign.  We are
extending "gpg" part because "gpg" is not the only cryptographic
signing protocol we support, so perhaps --crypto-sign would still be
in the orginal spirit of "This is different from the sign-off, but
is a cryptographic signature, but it is a mouthful.

