Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECCC11D20
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0E5206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zjf/5prn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgBTUfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:35:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62120 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTUfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:35:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4924F4704A;
        Thu, 20 Feb 2020 15:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8c3qFhNrAqU6qLrw7NLHVy+NU0A=; b=Zjf/5p
        rnw50UgWs7OYaYG53OH8F48UOFkWzW7tctRqPwcZOXf/sg9YbfOoOLtvQzxloltJ
        ZEwQawp8C/KOne6J13K6SDX+zlO4zJBw7fXwnE0BlgsBJ6YN2KrwwQHovXbtOQTT
        Svm+KBNPRDH9Yw3L4OzPVzO/4y3Qw7az/l3pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B06AKqJqFBG+VjBwRla6oI/4b3H7m6yu
        uaX9W4GM060hYH4yQgWMkrvkJMCNN85j69EY1k8zCp8iiDNH4zBCrRxWN/mNbTWh
        6ERsU9aSjzhUZ1prFLSiojSKY0zKEpNOdMa1agsCgTwfiUyKnwilSIzsbDXVf/r+
        ZB2OX2XK4o8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FACB47049;
        Thu, 20 Feb 2020 15:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F8BE47048;
        Thu, 20 Feb 2020 15:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-8-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:35:37 -0800
In-Reply-To: <20200220015858.181086-8-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:50 -0800")
Message-ID: <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DFCCA72-5420-11EA-A8CC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void get_git_remote_https_version_info(struct strbuf *version_info)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "remote-https");
> +	argv_array_push(&cp.args, "--build-info");
> +	if (capture_command(&cp, version_info, 0))
> +	    strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");
> +}
>  
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -29,6 +41,10 @@ static void get_system_info(struct strbuf *sys_info)
>  	strbuf_addstr(sys_info, "compiler info: ");
>  	get_compiler_info(sys_info);
>  	strbuf_complete_line(sys_info);
> +
> +	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
> +	get_git_remote_https_version_info(sys_info);
> +	strbuf_complete_line(sys_info);
>  }
>  
>  static const char * const bugreport_usage[] = {
> diff --git a/remote-curl.c b/remote-curl.c
> index 8eb96152f5..73e52175c0 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -17,6 +17,7 @@
>  #include "protocol.h"
>  #include "quote.h"
>  #include "transport.h"
> +#include "version.h"
>  
>  static struct remote *remote;
>  /* always ends with a trailing slash */
> @@ -1375,6 +1376,13 @@ int cmd_main(int argc, const char **argv)
>  	string_list_init(&options.deepen_not, 1);
>  	string_list_init(&options.push_options, 1);
>  
> +	if (!strcmp("--build-info", argv[1])) {
> +		printf("git-http-fetch version: %s\n", git_version_string);

We are letting bugreport grab this information from remote-curl, and
they are different binaries, so git_version_string we see here is
that of the remote-curl.  Good.

> +		printf("built from commit: %s\n", git_built_from_commit_string);
> +		printf("curl version: %s\n", curl_version());
> +		return 0;
> +	}
> +
>  	/*
>  	 * Just report "remote-curl" here (folding all the various aliases
>  	 * ("git-remote-http", "git-remote-https", and etc.) here since they

Makes sense, except that it is not clear what our overall stance on
i18n/l10n of the bugreport output.

I think there are two schools of thought.  

 - You can stick to C local, with an expectation that developers can
   read reports in C locale.  This will allow developers to avoid
   having to read reports written in a language they do not
   understand, and also makes it easier to mechanically process
   reports.

 - You can make sure what matters in the report is localized to the
   end-users' locale.  This will avoid forcing end-users to send out
   a report that they may not even able to read (which is what
   happens if we did not do i18n/l10n).

I am not sure which way you are aiming at.  The boilerplate text
we saw in a very early part of the series were marked N_() but some
of the messages in later parts of the series are not.
