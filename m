Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD1C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1B206CD
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SKh2rbrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgGGG0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:26:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58997 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGGG0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:26:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18C7C73F7D;
        Tue,  7 Jul 2020 02:25:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KK0Y4MaTAlQWxAlJIPJUz/ts4io=; b=SKh2rb
        rRyCBXgwg0O8VrchOgsaKZXfZKREbGRrKOBAvu4Ph1iPw/qvXDrxdvkgwTyzsa1X
        xKenc4T0T7x4wvkdCwqNh2sj/mNgTv244zDfUl3iy/vEcqreKbO8AEwZxaRR4R4H
        Vps6EaNLAaCKmszyxSxR3HKtjqwTpAjo+xQMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l0b4ZcnaiTzOwuenQGSKp6simLS+c2QJ
        ZUoL3bGOGTp14qSEKR1jXjutu6VFEgWMYU6odgWhWN8gUfoeHVTc2mMuO8R2Yn53
        jNmrOD8PTJ2GymtPbuaNEvrpkxS862d0KyDDk8Vcq0rRGqT6rlhipaG/Rgd7U/Ys
        jpkLAo30ENg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF76D73F7B;
        Tue,  7 Jul 2020 02:25:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50C7173F7A;
        Tue,  7 Jul 2020 02:25:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v10] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
        <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 23:25:57 -0700
In-Reply-To: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Tue, 07 Jul 2020 06:17:59
        +0000")
Message-ID: <xmqqd0577sei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8644194-C01A-11EA-A85B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> +		case "$meld_use_auto_merge_option" in
> +		"")
> +			meld_use_auto_merge_option=false
> +			;;

I somehow thought that I already pointed out that this is wrong,
didn't I?  You cannot tell between a "[section] var" (which is
"true") and not having any "[section] var = val" (which I think you
are trying to treat as "not configured---do not use") from the
output of "git config section.var".

Perhaps our mails crossed?

> +		[Tt]ure|TRUE)
> +			meld_use_auto_merge_option=true
> +			;;
> +		[Ff]alse|FALSE)
> +			meld_use_auto_merge_option=false
> +			;;

These are probably premature optimizations.

> +		[Aa]uto|AUTO)

Sigh.  I somehow thought that I already said we shouldn't do this
"aCCEpt AnY CaSES" unless all other variables that take 'auto' take
it case insensitively.

> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*)
> +				meld_use_auto_merge_option=true
> +				;;
> +			*)
> +				meld_use_auto_merge_option=false
> +				;;
> +			esac
> +			;;
> +		*)
> +			# try detect boolean for 'on'||'yes'||numberic value
> +			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
> +			if test -n "$bool_value"
> +			then
> +				meld_use_auto_merge_option="$bool_value"
> +			else
> +				meld_use_auto_merge_option=false

I think this case (i.e. set to a non-bool value, and we do not
recognise because it is not 'auto') should be flagged as an error,
instead of treated as a silent "do not use", as it would leave the
user scratching his or her head without realizing that there is a
typo in the configuration file.

> +			fi
> +			;;
> +		esac
>  	fi
>  }
>
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
