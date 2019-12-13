Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712A2C4D2C1
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434F24804
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7DHcahN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfLMT5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:57:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60201 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMT5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:57:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CC6923894;
        Fri, 13 Dec 2019 14:57:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZPfs0yWco8WHWDPcXTrRSuCWbwk=; b=i7DHca
        hNgsSx9zn5V/9/uf8M3ZPUFukdOstoGuCdrjh273t82P8fPrbhdJvOp3Jj149uLZ
        J+JXvmI3mATa3L5wEEihD/KCjsGt71MZD+XNlZ7EVi3cHzA28PuzY3QprF3TJxzc
        xrUWXLio7bkvwM/Y+en4sOwpPc2TfY8DzvY2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lZNrFsHYABIvlsgnUdYlgKrl7zhRlHaH
        uCcKOzK6R3ejqxv5V64+G/qwydsrWJad3hDfBKiRpn4Pw2e/PAgMW9BMfwuECmX/
        CnGAIoF+c2DUCRPXgYI4/eJtJoIWWDcBdNI6dQe2eDlMvWS60whXth/w389AvDC3
        G9yn9GT1jAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9255023893;
        Fri, 13 Dec 2019 14:57:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0432023892;
        Fri, 13 Dec 2019 14:57:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH] bisect--helper: convert `*_warning` char pointers to char arrays.
References: <20191213115225.13291-1-mirucam@gmail.com>
Date:   Fri, 13 Dec 2019 11:57:42 -0800
In-Reply-To: <20191213115225.13291-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Fri, 13 Dec 2019 12:52:25 +0100")
Message-ID: <xmqqblscj8w9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4543EB6-1DE2-11EA-B86C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> A char array creates a character array. Its size is the number
> of elements plus one (compiler automatically adds '\0').
> A char pointer creates a char array and a pointer to that char
> array that means four extra for bytes for the pointer variable.

This depends on the word size of your pointer and many people have
8-byte pointers these days.  Just say

	Instead of using a pointer that points at a constant string,
	just give name directly to the constant string; this way, we
	do not have to allocate a pointer variable in addition to
	the string we want to use.

or something.

> Let's convert `need_bad_and_good_revision_warning` and
> `need_bisect_start_warning` char pointers to char arrays.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
> This patch is a new version of:
> https://public-inbox.org/git/cadc46442d5c960caa58227092289fa2f44fb96f.1551003074.git.gitgitgadget@gmail.com/
> sent previously by Tanushree.
>
>  builtin/bisect--helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3055b2bb50..1718df7f09 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -282,11 +282,11 @@ static int mark_good(const char *refname, const struct object_id *oid,
>  	return 1;
>  }
>  
> -static const char *need_bad_and_good_revision_warning =
> +static const char need_bad_and_good_revision_warning[] =
>  	N_("You need to give me at least one %s and %s revision.\n"
>  	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
>  
> -static const char *need_bisect_start_warning =
> +static const char need_bisect_start_warning[] =
>  	N_("You need to start by \"git bisect start\".\n"
>  	   "You then need to give me at least one %s and %s revision.\n"
>  	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
