Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7BCC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A04610D1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhIMTdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhIMTdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:33:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A4C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:31:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so23487095ejv.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6C3Pmi9VLRLCyGx9Po6bCPXItyTUkyyzwFo8V2nfUac=;
        b=FnX4A3bT4id74R23HT4OnyDawIcf3PzSx5qi4RcAxzuldi2Q075tc5/gPitOGigK4y
         c0Zz2AzfLNJeqwkg2xl0kLf+tWWYeje8sLSB2I18WTOuv5yFHfawb4CewE2dJ2tj11DD
         QRSSgeL2Ghhjp4ZFMB1xDCqs5sSDPp83kBeTjSVF0LPvd5BUU1vr7R3oSKsFbcVn/mjB
         tBxgk+BjUj1U1ByctOefJGYbWV8Q4q1ZmmokB+rdYu9Ym43dUs0cNj5YeBgl/k3+ygGl
         E/FfT8zSiBLfmazYTkjMyRlDbNQmbr41EH+vbC6bfbyApSAnmnknMyCWstDb01EHLiPU
         gU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6C3Pmi9VLRLCyGx9Po6bCPXItyTUkyyzwFo8V2nfUac=;
        b=pvjnbi+2yyFRFG0ngBKHFtv1ITG4bGhZCmiD+M1l1RKkRXF0MDR7Z4XPNZuawRVRVp
         yfVkn194bOJEh++bhP8erAuhTjOhnZ29fyNcMZYuQtCq+pyryfINWh/OWSTBQTiS2DX5
         wCHsIzuyQp5Sa2UwckrMYnx5u9rVGeTEFL7co81p0H/Qsqp27K+AcX96fnTJPnmWZl7t
         SjdEMRAnxPwg5FJx9IVE05jOkQyY8dWaa/R3JecGM9DrJ33KwO7LCO24Kq0EQmB5ZhCP
         PmGuvBRSEpQhj8u9ZKVSxq6jJkTOtvjyYpJIO0USjajjvHJRxVYwHIXZRhxrqjJ9Et8d
         XgCw==
X-Gm-Message-State: AOAM533wZ3RoO1uFRc/mtJNz4Y4hxKRdFXfLVufMI+OHqkN2g5Itkvzg
        PQ4wFawvCGE/a/9Jjv41MeMbqkS2lzSOEA==
X-Google-Smtp-Source: ABdhPJyqJP5VqU5m3PN6XN8V4/QKoeztK8viumA7vqutvuC3292Idkpr3KCmPQiPuhAvzbt9ZY3aqQ==
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr14344017ejd.425.1631561514176;
        Mon, 13 Sep 2021 12:31:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d9sm672462ede.31.2021.09.13.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:31:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v7 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
Date:   Mon, 13 Sep 2021 21:27:11 +0200
References: <20210913173905.44438-1-mirucam@gmail.com>
 <20210913173905.44438-6-mirucam@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210913173905.44438-6-mirucam@gmail.com>
Message-ID: <875yv446hj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 13 2021, Miriam Rubio wrote:

> +static int print_file_to_stdout(const char *path)
> +{
> +	int fd = open(path, O_RDONLY);
> +	int ret = 0;
> +
> +	if (fd < 0)
> +		return error_errno(_("cannot open file '%s' for reading"), path);
> +	if (copy_fd(fd, 1) < 0)
> +		ret = error_errno(_("failed to read '%s'"), path);
> +	close(fd);
> +	return ret;
> +}

Returns int, but that return value is ignored here, and we don't seem to
gain a caller in 6/6?

> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else {
> +		error(_("bisect run failed: no command provided."));
> +		return BISECT_FAILED;
> +	}

Not new in this series & I see this is v7 already, so ....

Just odd to see this BISECT_FAILED pattern (which is defined to -1),
instead of "return error(..." like elsewhere.

Then we take that enum and do a "return -res" from main(), i.e. it's not
even that we're somehow guarding everything with these BISECT_* codes in
this file (see 30276765c11 (bisect--helper: use '-res' in
'cmd_bisect__helper' return, 2020-08-28)).

Anyway, can be cleaned up some other time, but...

> +		if (temporary_stdout_fd < 0)
> +			return error_errno(_("cannot open file '%s' for writing"), git_path_bisect_run());

Here we're doing a "return error...(" directly.

> +	case BISECT_RUN:
> +		if (!argc)
> +			return error(_("bisect run failed: no command provided."));
> +		get_terms(&terms);
> +		res = bisect_run(&terms, argv, argc);
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}

Also not a new issue, but if we just covered the BISECT_AUTOSTART case
here, then we wouldn't need this default/BUG, the compiler would check
that we checked all existing enum arms.
