Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B995C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4A52082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pd8nMzmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLQS6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:58:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53060 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:58:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F3BD9F1C7;
        Tue, 17 Dec 2019 13:58:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dQN1bsb8YDI401y8lQHog0uxrIA=; b=pd8nMz
        mmTa+g/6ilPF2vsVShfvW1la/SWAtgQ5Zbzc4ZHKYMZDz93URT7CnTF4XGEHSqpo
        /tPi/zartEGstmrAvG/JGwHBJqSS8WUb53dU7HSBkHwVBB4d2OXmPvayY6JAK9ZW
        MOFc2o4FtxDLjObVogAPeXbAAHOB91ARuxT5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qU5DYXhlDNv6ag1kSg4M3QgS6LX++wLo
        KtaLoptcVsFGkbruoWlOK1SG04EIAGQW3e2dGyzpz5hphuLoBXSgwJDmkI42CQ3E
        +6YDE4VTVfVl/TNmBW1WLTRn3Flj95jx8MoSdS73hFd0UhTZNDcndlCRYURDtgLZ
        6ywd/Ys/ud0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 978999F1C6;
        Tue, 17 Dec 2019 13:58:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDA299F1C3;
        Tue, 17 Dec 2019 13:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 12/15] t1409: let sed open its own files
References: <cover.1576583819.git.liu.denton@gmail.com>
        <0b7d19a7e1498238f3d6d4d9bb07b3345cbb345f.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 10:57:59 -0800
In-Reply-To: <0b7d19a7e1498238f3d6d4d9bb07b3345cbb345f.1576583819.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Dec 2019 04:01:37 -0800")
Message-ID: <xmqqfthihj9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 263D9CF8-20FF-11EA-97C6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Subject: Re: [PATCH 12/15] t1409: let sed open its own files

s/files/input file/;

This is borderline Meh to me, but since the patch has already been
written, let's use it ;-)

> In one case, we were using a redirection operator to feed input into
> sed. However, since sed is capable of opening its own files, make sed
> open its own files instead of redirecting input into it.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t1409-avoid-packing-refs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
> index c46848eb8e..f74d890e82 100755
> --- a/t/t1409-avoid-packing-refs.sh
> +++ b/t/t1409-avoid-packing-refs.sh
> @@ -8,7 +8,7 @@ test_description='avoid rewriting packed-refs unnecessarily'
>  # shouldn't upset readers, and it should be omitted if the file is
>  # ever rewritten.
>  mark_packed_refs () {
> -	sed -e "s/^\(#.*\)/\1 t1409 /" <.git/packed-refs >.git/packed-refs.new &&
> +	sed -e "s/^\(#.*\)/\1 t1409 /" .git/packed-refs >.git/packed-refs.new &&
>  	mv .git/packed-refs.new .git/packed-refs
>  }
