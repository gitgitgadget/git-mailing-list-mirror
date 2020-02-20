Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2359C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95190206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 19:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xDOkKHqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgBTTED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:04:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54581 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 14:04:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15061504D1;
        Thu, 20 Feb 2020 14:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a/3JYlVGIEb+Guvos5BUv1vyyI0=; b=xDOkKH
        qmtsLmIQyEXxj1REgOiVAj4lo3Al0fri9BgAtB0iWoDmBm5RkeC4SR6UliHkYgQv
        R+j8KBTz1LsGrtHt9XCr7BiUPMpu2dUUWwL52P5ulbhswKIADrEjfgjnEyYQRj9T
        H6rCbJH9hueNj6X38DLz7E1rUkL7V90ja6Y3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aleQbpBWZv8tZ5tzIYtwPhcxcMc45oOo
        dzB6NWDFDsw/m3H0/62Ea00kbowoRh7V/FA3cG3OudtYHrgodFQGsBET3ovLsGRD
        oQDUvNH7ugGhPh/WkWF45gV34hV14P+B5F9uqfnUyVSOHvxclVoPu/EnPra37D5G
        uDlNPyLqEZ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BDE7504CF;
        Thu, 20 Feb 2020 14:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45124504CE;
        Thu, 20 Feb 2020 14:04:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 02/15] help: add shell-path to --build-options
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-3-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 11:03:59 -0800
In-Reply-To: <20200220015858.181086-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:45 -0800")
Message-ID: <xmqqeeupaxnk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1F2F214-5413-11EA-A8C9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It may be useful to know which shell Git was built to try to point to,
> in the event that shell-based Git commands are failing. $SHELL_PATH is
> set during the build and used to launch the manpage viewer, as well as
> by git-compat-util.h, and it's used during tests. 'git version
> --build-options' is encouraged for use in bug reports, so it makes sense
> to include this information there.

It probably makes sense to capture PERL_PATH, PYTHON_PATH,
TCLTK_PATH, and TCL_PATH, as they fall into exactly the same
category as this one.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  help.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/help.c b/help.c
> index a21487db77..190722fb0a 100644
> --- a/help.c
> +++ b/help.c
> @@ -654,6 +654,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  			printf("no commit associated with this build\n");
>  		printf("sizeof-long: %d\n", (int)sizeof(long));
>  		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
> +		printf("shell-path: %s\n", SHELL_PATH);
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>  	}
>  	return 0;
