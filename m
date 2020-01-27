Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE44C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BCC24679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xr1uJWoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0XJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:09:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0XJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:09:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80BD0B80A8;
        Mon, 27 Jan 2020 18:09:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0zrt6mv9DMXI9+ir22vTgi4S+E=; b=xr1uJW
        oNhGSZiaVwp282t7CZf/TSdXO4cRnupdZhOVuGL+EggdOT97WS9vZ5haWQSuWjnr
        6mKqKTD1Pjd+mRovZD1svSpRF1Ywv63rq/UcepvwJ35nFXdbXtXeRT/f7vNlKWmM
        SkvHmojmMqkF0eEw5I49UBz57nsZP+8ZYNQRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cHlAUbzPxOPk+2uMaamijyK9e9rwU7Wy
        wpM3Z/u7eRbu8NF16jGzS4DUoQDDQmv/U1GbhWk2Spb/5U7PUmQ0HLKUUWXTA7Xn
        FiYyNwHokkuKRGtkC3TrqY1ZIZNp6Agk43UCcwknZ2TOPum1VyfGpw7Cnzr7Swgs
        7/X8Q9pPmSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78F56B80A7;
        Mon, 27 Jan 2020 18:09:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8858B80A5;
        Mon, 27 Jan 2020 18:09:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v5 4/6] config: split repo scope to local and worktree
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <9f160e281a984ea7578f8fbe244adc77c6585e44.1579912764.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 15:09:41 -0800
In-Reply-To: <9f160e281a984ea7578f8fbe244adc77c6585e44.1579912764.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Sat, 25 Jan 2020
        00:39:22 +0000")
Message-ID: <xmqqblqoa43u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A953B60-415A-11EA-B357-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..6695e463eb 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
>  		return "system";
>  	case CONFIG_SCOPE_GLOBAL:
>  		return "global";
> -	case CONFIG_SCOPE_REPO:
> +	case CONFIG_SCOPE_LOCAL:
>  		return "repo";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";

It used to be only "repo"; now we give either "repo" or "worktree".

>  	case CONFIG_SCOPE_CMDLINE:
>  		return "cmdline";
>  	default:
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 7b4e1a63eb..90196e2862 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -259,7 +259,7 @@ test_expect_success 'iteration shows correct origins' '
>  	value=from-repo
>  	origin=file
>  	name=.git/config
> -	scope=repo
> +	scope=local

But the test expects "local".

This patch cannot be correct.  I recall fixing this manually when I
queued the previous round to 'pu'.  Please double check.
