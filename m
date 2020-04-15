Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E192C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E0420784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f+vbxNwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411093AbgDOR3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:29:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411089AbgDOR3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 13:29:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90C90627F7;
        Wed, 15 Apr 2020 13:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aEGLaID1/5UN0VXmCEerWcEEy7Y=; b=f+vbxN
        woFuYv36olxp5QT9iU/RgHKfXKr922Pc8qgl7OvmKHJbR5Dacig0q/q6oX0wOsd3
        vucMoM2s3k0QCSA7XcSq1bQqzW5RKrOV5MF5PtYoeRcu2++bZJUZ96ycUMxKx8Yw
        7qkDQJYd0S700ZNfhff4ZCEhua0f6imPuNQCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V0GIakGCpv7ZFmZz1xDjXGYfuVClS93e
        IoNpkrw2L0K0T0zUOMuOv2+n41MABa/x5pHb/a4OKY1eEsObVgEGgtdu8Y+b8ZJ7
        3HQJfAtaxO7WNijRGkkVStSyAeczAN2TKETWisMRffCgdQYYrXkTeOo1LBDlml0+
        2MENk2Uc4EE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86F81627F6;
        Wed, 15 Apr 2020 13:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A331627F5;
        Wed, 15 Apr 2020 13:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] log: add log.excludeDecoration config option
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
        <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <xmqqftd47jce.fsf@gitster.c.googlers.com>
Date:   Wed, 15 Apr 2020 10:29:05 -0700
In-Reply-To: <xmqqftd47jce.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Apr 2020 10:24:33 -0700")
Message-ID: <xmqqblns7j4u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B6E15AA-7F3E-11EA-A324-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  Do we still need "found" here?  If there are include patterns
> given explicitly from the command line, a ref MUST match one of them
> in order to be included, and a ref that matches one of them will be
> included no matter that exclude config says.
>
> So shouldn't the updated logic for the include patterns part be more
> like ...

I still think that the two clean-ups I mentioned are both worth
doing, but without them, but with the simplification of the code 
I suggested, the resulting helper becomes like this, which I think
is quite easy to understand.  It seems to pass t4202, which you
updated, too.



int ref_filter_match(const char *refname,
		     const struct string_list *include_patterns,
		     const struct string_list *exclude_patterns,
		     const struct string_list *exclude_patterns_config)
{
	struct string_list_item *item;

	if (exclude_patterns && exclude_patterns->nr) {
		for_each_string_list_item(item, exclude_patterns) {
			if (match_ref_pattern(refname, item))
				return 0;
		}
	}

	if (include_patterns && include_patterns->nr) {
		for_each_string_list_item(item, include_patterns) {
			if (match_ref_pattern(refname, item)) {
				return 1;
			}
		}
		return 0;
	}

	if (exclude_patterns_config && exclude_patterns_config->nr) {
		for_each_string_list_item(item, exclude_patterns_config) {
			if (match_ref_pattern(refname, item))
				return 0;
		}
	}

	return 1;
}
