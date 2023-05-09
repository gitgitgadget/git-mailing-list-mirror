Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDDC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjEIUfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjEIUft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:35:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35C10FE
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:35:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso6894094b3a.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683664548; x=1686256548;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVyiF9xpT6HWVo30btL3VhX+fRmehfDm5gBeyK3W0i8=;
        b=kvQED+iSeHrH1H4pH6iGeRkdVkTuQ0zMzSCkSdrzDYj8sxn/XglNKgQZEOuTO9BjqX
         4IY0Rvnd7eQt45DxNhBvzitAlZGNMA/Zj7BQOfxOqWTi0HAoDqBb+0qvWjs0104aKnoP
         5gW5lmiy5ZO2sXUZ/v3P9IbYjbPFBIerVqKgSFIHEpVKq1A6L0RBp04oMb8C5SGvoyZC
         +8O+8Gz26gjlfFUVjKdWEr0d0IkCjdfQaaC5LV4SRJOO5R1mz10IKVmq/CS+0INTfkHi
         lJwEVN9rcvDoTUqZIYFgsD3CatUZ3TOAU+n5BALSf7BjvjAvd3rJu+ja/ZLc+7z/898q
         uJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664548; x=1686256548;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZVyiF9xpT6HWVo30btL3VhX+fRmehfDm5gBeyK3W0i8=;
        b=ElWQpI6cFlxtWWAjwxMBjSoFeEXzMKItGel58HfFzOV0Ljl09IjrqLu2q2zbcd8KYn
         UV+q/W8qVYPYUe8LXnk6Ujd/776uwmi70ucQ1WBF6hI5A5fJjyy0klZcwRLlFSozjs7e
         S77ZubhSxEIoj7HrFaZgLfRtOF1uJbuaz3WbYF841xijitJ2eVxd/Ms0ojsCBNAiVsTU
         GB76rCClYwyWcFyClS3sDJFi0VYsiLj/MvMq0Kb02VUpx9D0wCb651DcehZaj4j0eeAd
         o8UKlq/ELjzDITBan5e802Q8RltGTFEjyeimd0qQejzWMOXBpMWJxQe9Xn3gffU6aD30
         YG/g==
X-Gm-Message-State: AC+VfDwAJ801XSgGGOOR8LBEAz6HbtiOiq0crzReLIvIHt6jccpmWqP6
        f7Fl2tGpKmMo6yDe9X7PK94=
X-Google-Smtp-Source: ACHHUZ40BZ/tPqEwUOSF99vSlQ1NFosBWe3HjX54RFBRMDEh/b1Mu2zhpo34UsVrRx2lBQSK6jmjJQ==
X-Received: by 2002:a05:6a00:2311:b0:63a:ea82:b7b7 with SMTP id h17-20020a056a00231100b0063aea82b7b7mr22540999pfh.28.1683664548419;
        Tue, 09 May 2023 13:35:48 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b0063b8d21be5asm2211928pfh.147.2023.05.09.13.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:35:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 6/8] fetch: move display format parsing into main
 function
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 13:35:47 -0700
In-Reply-To: <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:24 +0200")
Message-ID: <xmqqo7mtw8d8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> We're about to introduce a output format though that is intended to be
> parseable by machines, for example inside of a script. In that case it
> becomes a bit awkward of an interface if you have to call git-fetch(1)
> with the `fetch.output` config key set. We're thus going to introduce a
> new `--output-format` switch for git-fetch(1) so that the output format
> can be configured more directly.

Good.  I was wondering about that code in the context of the
previous patch, especially the error message had a hard-coded
assumption that it comes from a configuration variable.

And the changes to display_state_init() to lift the responsibility
of finding and validating .format out of the function, and the
changes to intermediate functions to pass the .format through the
callchain, are all expected and there was nothing questionable.

> @@ -2157,6 +2149,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	const char *bundle_uri;
> +	enum display_format display_format = DISPLAY_FORMAT_UNKNOWN;
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  	struct remote *remote = NULL;
>  	int result = 0;
> @@ -2183,6 +2176,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>  
> +	if (display_format == DISPLAY_FORMAT_UNKNOWN) {
> +		const char *format = "full";
> +
> +		git_config_get_string_tmp("fetch.output", &format);
> +		if (!strcasecmp(format, "full"))
> +			display_format = DISPLAY_FORMAT_FULL;
> +		else if (!strcasecmp(format, "compact"))
> +			display_format = DISPLAY_FORMAT_COMPACT;
> +		else
> +			die(_("invalid value for '%s': '%s'"),
> +			    "fetch.output", format);
> +	}

OK, but isn't the usual way to do this to have configuration parser
before parse_options() and then let parse_options() override
whatever display_format set by it?

That way, we do not have to worry about DISPLAY_FORMAT_UNKNOWN at
all.  Just initialize the variable to whatever default format at the
beginning of this function, read "fetch.output" to override it if
the configuration exists, and then let parse_options() to handle
"--output-format" or "--porcelain" or whatever to further override
it.

Thanks.
