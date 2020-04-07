Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC37C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F9320719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 23:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q93roYOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGXoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:44:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51782 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGXoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 19:44:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75EC1CA8AB;
        Tue,  7 Apr 2020 19:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VuxpLkii3zJun5V9iEuOa+heN6M=; b=q93roY
        OoN9dY2HWWV/Z74LJlVsO9PAhtzRkvUP1RVmLmeOMp28J4qADdrQreT6aZCL70o0
        CavkcbzBQ8HWKcH9DEKCu4RRYpCunVbpU+1BNvxdr0+FCej5dJahFw0qCrZRl1Fl
        4BQsbWOH/BSlUOQ+/HqOvf+UjcByIs0cM/G9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q4G0n9oNPD6QQZHD0JPNY14Sid2DozOr
        gBgp7dJ6FmMHw43tVe8gsrzbw48YKzJaJC6U4OEC3cSqDuutD/3EIJCzvyMwAlo/
        1wAhtLF0ONSfYf1mc87hoR2wm535ZV6WoUQfl/INGBTMOKejFyzXQk3rSvdRJamG
        SrEhuhJ6dM8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E61BCA8AA;
        Tue,  7 Apr 2020 19:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B91D6CA8A9;
        Tue,  7 Apr 2020 19:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, garimasigit@gmail.com
Subject: Re: [PATCH v3 2/4] diff: make diff_populate_filespec_options struct
References: <20200331020418.55640-1-jonathantanmy@google.com>
        <cover.1586296510.git.jonathantanmy@google.com>
        <c1973fd6308109b0cc99544500d8932222b66726.1586296510.git.jonathantanmy@google.com>
Date:   Tue, 07 Apr 2020 16:44:18 -0700
In-Reply-To: <c1973fd6308109b0cc99544500d8932222b66726.1586296510.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 7 Apr 2020 15:11:41 -0700")
Message-ID: <xmqqpncirhd9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3585F38-7929-11EA-87CD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The behavior of diff_populate_filespec() currently can be customized
> through a bitflag, but a subsequent patch requires it to support a
> non-boolean option. Replace the bitflag with an options struct.

Hmph, clever :-).

> +	struct diff_populate_filespec_options dpf_options = {
> +		.check_size_only = 1,
> +	};

I would have called this instance of d-p-f-o "check_size_only",
which would make the site that uses it ...

>  	if (!DIFF_FILE_VALID(one))
>  		return 0;
> -	diff_populate_filespec(r, one, CHECK_SIZE_ONLY);
> +	diff_populate_filespec(r, one, &dpf_options);

... easier to understand, especially if we can made it constant, but
that would probably contradict the plan to add more fields to the
structure, so let's see how it goes.

> @@ -3339,13 +3346,17 @@ static void emit_binary_diff(struct diff_options *o,
>  int diff_filespec_is_binary(struct repository *r,
>  			    struct diff_filespec *one)
>  {
> +	struct diff_populate_filespec_options dpf_options = {
> +		.check_binary = 1,
> +	};
> +

The same comment applies to here, too.

