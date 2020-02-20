Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F9C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE5208CD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="el1T+tzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgBTUNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:13:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65212 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgBTUNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:13:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2183150BBD;
        Thu, 20 Feb 2020 15:13:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjOjlvDZAhkJxqT7/F5nn0x3T6s=; b=el1T+t
        zSfFswJIKgk8kbuaU8m7oEsmcUWL1RGwpDvtRy8U8k9VyKEPA4pd6Db7Xv9nNcqY
        /aQBLLr94Ep5vkFKwXEBzv3RoR6OCCcLACtRwV4p6eJu8TSmliqY6luociDizW9M
        2mpXoHaiKf9qnZGqygEOfElcS2fN0D+N0r8Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QI7ihCk1GwLzZo/KawG64yABEFuqN+5h
        IwE85CssI4KpppsB1A+tFOEhuEh8eojiwaOp9kH7zyxoKFFD3v+77eNmJw0VyLct
        vFKsVBscDPMpbmdOfXkXiwnQz7fx4uMPYdl9IQO0XhIVjmkdcErTHzMjWSCov+pG
        9Qsq+jNit74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0239850BBC;
        Thu, 20 Feb 2020 15:13:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AAD050BB8;
        Thu, 20 Feb 2020 15:12:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 05/15] bugreport: add uname info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-6-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:12:58 -0800
In-Reply-To: <20200220015858.181086-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:48 -0800")
Message-ID: <xmqqzhdd9fw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63D46B18-541D-11EA-B40C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	/* system call for other version info */
> +	strbuf_addstr(sys_info, "uname -a: ");

Is that "-a" portable across systems?  That is, when given "-a",
would "uname" on all platforms show sysname, release, version and
machine in that order and nothing else?

If we are merely saying "in this section, we are showing a selected
subset from what we learned about the system with uname(2)", perhaps
just stop at saying "uname: "?

> +	if (uname(&uname_info))
> +		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);

i18n/l10n?  Don't we want to use strerror() here?

> +	else
> +		strbuf_addf(sys_info, "%s %s %s %s\n",
> +			    uname_info.sysname,
> +			    uname_info.release,
> +			    uname_info.version,
> +			    uname_info.machine);
>  }
>  
>  static const char * const bugreport_usage[] = {
