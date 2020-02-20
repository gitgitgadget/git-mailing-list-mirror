Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A9C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621B020722
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8stbmnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBTUHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:07:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64454 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgBTUHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:07:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60388A96F7;
        Thu, 20 Feb 2020 15:07:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kY0dz2x3a1imCTGFxNgU3HzmpMs=; b=K8stbm
        nhyztpnAyVM06kZeu3eraH5caEq8dVpOzxD/07KYeJc6cAk/26cR+4319hvdDfNu
        pDvnyC/+140IrFv9h1O2KhMqhjcAdr5SQGIt8eSJ/hVPi+aSX7t99x1p0qama4KU
        hik4ngWCCtMJJ3yQkZmxkGcLxxTEsjKKernuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S+L2rTWRtNRPy85f9mGp62B2KSNKTKIY
        TgA96ww9J//7edLeJWW3gDuCe/bjyfh3ZcqP1EKT32pE66KhxtnIPl0c2Wv2w2vV
        4nv+WhogIFIIVLQQiJLoudMeeUXM+0EJOq/bl3RzhgDTzyRlMit8d+je5RDFZ1f0
        MjPkBRg2bb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5812EA96F6;
        Thu, 20 Feb 2020 15:07:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B0D02A96F5;
        Thu, 20 Feb 2020 15:07:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 04/15] bugreport: gather git version and build info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-5-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:07:46 -0800
In-Reply-To: <20200220015858.181086-5-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:47 -0800")
Message-ID: <xmqq4kvlaup9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAAB58D6-541C-11EA-AF81-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void get_system_info(struct strbuf *sys_info)
> +{
> +	/* get git version from native cmd */
> +	strbuf_addstr(sys_info, "git version:\n");
> +	get_version_info(sys_info, 1);
> +	strbuf_complete_line(sys_info);

It is a bit curious use of "don't do anything if sys_info ends with
a complete line, but complete it if it ends with an imcomplete
line".  That tells the readers that we do not know what
get_version_info() will do (now or in the future) to its output
buffer.

> +}
> ...
> diff --git a/help.c b/help.c
> index 190722fb0a..44cee69c11 100644
> --- a/help.c
> +++ b/help.c
> @@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
>  	exit(1);
>  }
>  
> +void get_version_info(struct strbuf *buf, int show_build_options)
> +{
> +	/*
> +	 * The format of this string should be kept stable for compatibility
> +	 * with external projects that rely on the output of "git version".
> +	 *
> +	 * Always show the version, even if other options are given.
> +	 */
> +	strbuf_addf(buf, "git version %s\n", git_version_string);

This ends the output with a complete line when !show_build_options ...

> +	if (show_build_options) {
> +		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
> +		if (git_built_from_commit_string[0])
> +			strbuf_addf(buf, "built from commit: %s\n",
> +			       git_built_from_commit_string);
> +		else
> +			strbuf_addstr(buf, "no commit associated with this build\n");
> +		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
> +		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
> +		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
> +		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */

... and the pattern indicates the output will end with a complete
line when !!show_build_options, too.

> +	}
> +}

So, was the strbuf_complete_line() merely defensive programming?  It
may deserve a comment if it will stay there.

>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  	int build_options = 0;
>  	const char * const usage[] = {
>  		N_("git version [<options>]"),
> @@ -637,26 +662,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  
> -	/*
> -	 * The format of this string should be kept stable for compatibility
> -	 * with external projects that rely on the output of "git version".
> -	 *
> -	 * Always show the version, even if other options are given.
> -	 */
> -	printf("git version %s\n", git_version_string);
> +	get_version_info(&buf, build_options);
> +	printf("%s", buf.buf);
> +
> +	strbuf_release(&buf);
>  
> -	if (build_options) {
> -		printf("cpu: %s\n", GIT_HOST_CPU);
> -		if (git_built_from_commit_string[0])
> -			printf("built from commit: %s\n",
> -			       git_built_from_commit_string);
> -		else
> -			printf("no commit associated with this build\n");
> -		printf("sizeof-long: %d\n", (int)sizeof(long));
> -		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
> -		printf("shell-path: %s\n", SHELL_PATH);
> -		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> -	}
>  	return 0;

Makes sense.
