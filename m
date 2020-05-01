Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB5C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1843820787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RrYR8XeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEAG0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:26:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53255 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgEAG0p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:26:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A59BBE8CA;
        Fri,  1 May 2020 02:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVR3X20oMyHNOweKwvjAUeP3THA=; b=RrYR8X
        eWB6yZ76WkwgSCdqUcvalc31ADSSqoL2u792eBFj2rrFRIBtLc6G05Mc1hUhnGEn
        1OYyneHT8n54eRJoadJ5OZ0vIOlHpV/Zu4VpumYRDNHwKJtITVlixwAXIkPPbuJi
        BLEKiDzD95+cTuvmJtTKPVQ3BWDqiu6hZyMsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yfnGvl1aOsXXJVSaAIkxpCu0j/RVd8kc
        64oxskV7+j8Fw8IoRwb++WMPd2e8GLAFwZMCBpypM3BOOkXikexk7eVDgPfvYT+n
        zBHlkyaN5d1YMDcaselmh0CMFIUv5ACZKE7ViLR08Ave6u8glLzldYZ3Imojlca4
        2pbZR4g1bqM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 016C3BE8C9;
        Fri,  1 May 2020 02:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5105DBE8C8;
        Fri,  1 May 2020 02:26:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitcredentials(7): make shell-snippet example more realistic
References: <20200501061917.GC23665@coredump.intra.peff.net>
        <20200501062316.GB25603@coredump.intra.peff.net>
Date:   Thu, 30 Apr 2020 23:26:39 -0700
In-Reply-To: <20200501062316.GB25603@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 May 2020 02:23:16 -0400")
Message-ID: <xmqqy2qcnpb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8581A7A-8B74-11EA-BCB6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's an example of using your own bit of shell to act as a credential
> helper, but it's not very realistic:
>
>  - It's stupid to hand out your secret password to _every_ host. In the
>    real world you'd use the config-matcher to limit it to a particular
>    host.
>
>  - We never provided a username. We can easily do that in another config
>    option (you can do it in the helper, too, but this is much more
>    readable).
>
>  - We were sending the secret even for store/erase operations. This
>    is OK because Git would just ignore it, but a real system would
>    probably be unlocking a password store, which you wouldn't want to do
>    more than necessary.

All of them make sense, but I do not think we want to encourage that
loose style of passing unquoted argument to echo to lose embedded
$IFS spaces that is not a SP.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is in fact very close to what's in my own ~/.gitconfig, except that
> I swap out "cat" for the "pass" tool.
>
>  Documentation/gitcredentials.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index 8a20343dd7..63b20fc6a5 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -233,8 +233,9 @@ helper = "foo --bar='whitespace arg'"
>  helper = "/path/to/my/helper --with-arguments"
>  
>  # or you can specify your own shell snippet
> -[credential]
> -helper = "!f() { echo password=$(cat $HOME/.secret); }; f"
> +[credential "https://example.com"]
> +username = your_user
> +helper = "!f() { test $1 = get && echo password=$(cat $HOME/.secret); }; f"
>  ----------------------------------------------------
>  
>  Generally speaking, rule (3) above is the simplest for users to specify.
