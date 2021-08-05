Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C15BC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB916101C
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbhHEUlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:41:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60064 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhHEUlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:41:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 803AEE7E03;
        Thu,  5 Aug 2021 16:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CimxpOnZ5K/VAb61XQfyaCFshlKIhtLw5Gcqc/
        xerl8=; b=ueJxIEw8PTnHMVRgx5nWBE6aZgMfPzaNVk6jQT9hgWenU9o7KEIP+n
        Jo6e25FYQtm6ELiG/bCtu31LF/VS/xAcHL5PbdoO9cZbeXNSho3Vb/tcHFhayltn
        FkgaFMvPgnFa5hCvyRX02Efx2WH/EGjilKro4vObyWegN0hpPthVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D55E7E02;
        Thu,  5 Aug 2021 16:40:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6CDDE7E01;
        Thu,  5 Aug 2021 16:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 5/9] submodule--helper: remove constness of
 sm_path
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-6-raykar.ath@gmail.com>
Date:   Thu, 05 Aug 2021 13:40:58 -0700
In-Reply-To: <20210805074054.29916-6-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 5 Aug 2021 13:10:50 +0530")
Message-ID: <xmqqeeb7k4kl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70B386EE-F62D-11EB-AE35-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This is needed so that it can be modified by normalize_path_copy() in
> the next patch.

This is a hard-to-judge change.  With this alone, we cannot tell if
somebody has already looked at the member (and possibly saved the
pointer elsewhere) before "the next patch" starts modifying the
member in the struct.  It probably should be done in a single patch
to demonstrate why it is needed and how existing users of the field
are OK with this change.

>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 9b676c12f8..99aabf1078 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2748,7 +2748,7 @@ struct add_data {
>  	const char *prefix;
>  	const char *branch;
>  	const char *reference_path;
> -	const char *sm_path;
> +	char *sm_path;
>  	const char *sm_name;
>  	const char *repo;
>  	const char *realrepo;
