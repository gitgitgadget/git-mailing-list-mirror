Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D64C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B64520767
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kc8+CJ2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgDWUBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:01:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52342 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:01:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35F83CCF6D;
        Thu, 23 Apr 2020 16:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZdJgHCJAYXT0MOyWVPadd06zBag=; b=Kc8+CJ
        2Fb4WjQhpogVP6MfUQGhX0iHx7ca0AsRM2y2+A5xjZrUJyUliQEPOaelnhQSYhgP
        TyWLa9c10lKWiKb2OY23WqYmlaK8oMJ7Rsy62XyCYOn7Xp0wVuWD7jPVFeTqJEJi
        zEMRnLs+eNxgD5O02ok8JK+gpUashdCbD/CV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qIs0i6SviEux9Zi35GWsSJGRIL9Pdqk3
        PBd6hVuFdVF9b0S0fBRRqS2i3meWPJkpoH/3KkrF47UHHjyETH02DixZSzeKGvpw
        d965Hk7mrzIuZnZolAdUbfbe7+WSmQ0sqzSs0fz15paPYeebZLM1CCt7+ErtezCQ
        Yc+iy98F9f4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FA08CCF6C;
        Thu, 23 Apr 2020 16:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7336ECCF6B;
        Thu, 23 Apr 2020 16:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Finish converting git bisect to C part 2
References: <20200423070704.39872-1-mirucam@gmail.com>
Date:   Thu, 23 Apr 2020 13:01:35 -0700
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 23 Apr 2020 09:06:52 +0200")
Message-ID: <xmqqa732gee8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D690428-859D-11EA-A5F5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> --- Changes since v2 Finish converting git bisect to C part 2 patch series ---
>
> General changes
> ---------------
>
> * Rebase on master branch: efe3874640 (Sync with v2.26.1, 2020-04-13)

Was there a particular reason why you needed to do this rebase?  It
seems that the patches apply cleanly on the same base as v2 has been
queued?  Does the result cause hard-to-resolve conflicts when merged
to the 'master', 'next' or 'pu' branches unless you do that rebase?

> Specific changes
> ----------------
>
> [1/12] bisect--helper: fix `cmd_*()` function switch default return
>
> * Use `BUG()` instead of `return error()` in default switch.

This rings a bell.  range-diff looks good.

> [2/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return
>
> * New patch: use '-res' instead of 'abs(res)'.

Alright.

> [3/12] bisect--helper: introduce new `write_in_file()` function
>
> * Rename input parameter `filepath` to `path`.
> * Change `error_errno()` to `error()` in mode checking.
> * Change error message when file cannot be opened.
> * Add `fclose()` before error return.

OK.  I am not sure if the error behaviour when fclose() fails is
ideal, but I do not think it is worth further polishing.

> [4/12] bisect--helper: reimplement `bisect_autostart` shell function in C
>
> * Reorder patch before `reimplement `bisect_next` and `bisect_auto_next`
> shell functions in C` to use `bisect_autostart()` function in 
> `bisect_append_log_quoted()`.

OK.

Will take a look at individual patches later.

Thanks.
