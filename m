Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE6C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692322518
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLVAQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:16:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7CC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:16:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lt17so15930041ejb.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=ilcqou8UDdtiuoOLGwmodaYdSMvMJBkRaGqjGkTk1zw=;
        b=VA7dL1+qpLYj5sX9lmt7feOKqwSAybWi3sf1Tp3N6/iy5BoFn3umKJGAFdbOo8vAHS
         AR0PsouegxwURaZORPVXhja9q+7ndihzSofZ1MRlPC+0FB6xw94xCLggCpxjTd4oxYBY
         xrMmP/0aVqD891Ei4jIRE6QwWwlVZD9YsYpoHk7xnKMWONX1r7p6gN2pmQs1VobA7pBi
         UZMXNEmZWJTIrPVZSDgJSOeLI2GE9gIziSY24N0N8VPCr14c6TiimBtSBTCjV6nfpRNk
         IvsqAp6ZIQ/Ym6I5GH+T9ydYCb5RCFTlgrG7cHUuk0aHVmDQ60Hhj8dNOK0KmjSvgEdW
         yYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=ilcqou8UDdtiuoOLGwmodaYdSMvMJBkRaGqjGkTk1zw=;
        b=LQP8SdYg85loZnQnhJkVdpEvgeB09U9Uvj4Ry9dYxK/coJGEqXAIXWXjcDujMTbIBG
         jA0cFmVmLnpH42b3c1E8Otqk8g4dVVco/6n12mAuCsHgDLeQ7atdRxV2LhW1ElZcFmen
         PItYedMHpYlM0iAYk5CeR6P7tgV04P7NFZ4KFEMp3aqByoGb0/JHLMtl6XCLdpgcYPM8
         wupKXtPtstHAFBNuf77moo8OkHF00CNJGRyk9WfkqfYzOlGXYPe4zH22P2bCn/fDB791
         dtunXnd72MS2oijXHxjzsucvwHwpYaM6x/iLXDxiO++z8gyemjZOUUL7J+Ry+L9YIXP3
         gY9g==
X-Gm-Message-State: AOAM532Li4NsxLamPbb/1wmHPCdaKOD1aW0oa7u0CpxZIRY/Yfmtq9v1
        WMoyJvod8WG75iA3eavWcKg=
X-Google-Smtp-Source: ABdhPJyThsBQxcnIpTHCeX76tWuzOgIb88GlPjHDEeJcJnuXRLtsMldxBMUUnxvG6P/1zMeELYbkqA==
X-Received: by 2002:a17:906:4a4f:: with SMTP id a15mr17945223ejv.541.1608596169935;
        Mon, 21 Dec 2020 16:16:09 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.123.225])
        by smtp.gmail.com with ESMTPSA id y16sm2228898edd.50.2020.12.21.16.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:16:09 -0800 (PST)
References: <20201221162743.96056-1-mirucam@gmail.com>
 <20201221162743.96056-3-mirucam@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
Message-ID: <gohp6ky2hqzovu.fsf@cpm12071.fritz.box>
In-reply-to: <20201221162743.96056-3-mirucam@gmail.com>
Date:   Tue, 22 Dec 2020 01:15:51 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Miriam Rubio writes:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Reimplement the `bisect_replay` shell function in C and also add
> `--bisect-replay` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
>
> Using `--bisect-replay` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 127 ++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            |  34 +----------
>  2 files changed, 127 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1854377fa6..92c783237d 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-auto-next"),
>  	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
>  	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> +	N_("git bisect--helper --bisect-replay <filename>"),
>  	NULL
>  };
>  
> @@ -916,6 +917,121 @@ static enum bisect_error bisect_log(void)
>  	return status ? BISECT_FAILED : BISECT_OK;
>  }
>  
> +static int get_next_word(const char *line, int pos, struct strbuf *word)
> +{
> +	int i, len = strlen(line), begin = 0;
> +
> +	strbuf_reset(word);
> +	for (i = pos; i < len; i++) {
> +		if (line[i] == ' ' && begin)
> +			return i + 1;
> +
> +		if (!begin)
> +			begin = 1;
> +		strbuf_addch(word, line[i]);
> +	}
> +
> +	return i;
> +}
> +

I would like to suggest a slight different approach to handling the "is
the begin of the loop?" logic. If I understood correctly, the `begin`
variable is to check whether is the beginning of the word processing
and is changed to 1 (aka: to true) on the first loop interaction after
the loop is executed for the first time.

However, I believe we can check this information in different way that
will simplify the logic by removing the "begin" and the
"if (!begin)..." altogether. The for-loop is initialize with "i" set to
"pos" which means that on the first execution the expression "i == pos"
is going to be true, and "false" for the next interactions. Thus, checking
if "i" is different, or better checking if "i" is greater should bring
the same result.

that said, the implementation might look like this:

  	strbuf_reset(word);
	for (i = pos; i < len; i++) {
		if (line[i] == ' ' && i > pos)
			return i + 1;

		strbuf_addch(word, line[i]);
	}

With additionally, removing the "begin" from the beginning of the function.

The above was copied into the email without major tests, although
I have this implementation locally just to ensure its compiles
successfully.

Please take this suggestion as you wish, I do not have any strong
opinion on the current implementation. Also, I'm a recent contributor to
the project and should not be much trusted when proposing changes as when
proposal comes from project maintainer and/or Senior contributors ;).

> +static int process_line(struct bisect_terms *terms, struct strbuf *line, struct strbuf *word)
> +{
> +	int res = 0;
> +	int pos = 0;
> +
> +	while (pos < line->len) {
> +		pos = get_next_word(line->buf, pos, word);
> +
> +		if (!strcmp(word->buf, "git"))
> +			continue;
> +		else if (!strcmp(word->buf, "git-bisect"))
> +			continue;
> +		else if (!strcmp(word->buf, "bisect"))
> +			continue;
> +		else if (starts_with(word->buf, "#"))
> +			break;
> +
> +		get_terms(terms);
> +		if (check_and_set_terms(terms, word->buf))
> +			return -1;
> +
> +		if (!strcmp(word->buf, "start")) {
> +			struct strvec argv = STRVEC_INIT;
> +			int res;

I believe this variable is already defined and initialize on the
beginning of the function, right? If that is the case then the
declaration seems duplicated here and can be avoided.

> +			sq_dequote_to_strvec(line->buf+pos, &argv);
> +			res = bisect_start(terms, argv.v, argv.nr);
> +			strvec_clear(&argv);
> +			if (res)
> +				return -1;

Also, (see bellow)

> +			break;
> +		}
> +
> +		if (one_of(word->buf, terms->term_good,
> +			   terms->term_bad, "skip", NULL)) {
> +			if (bisect_write(word->buf, line->buf+pos, terms, 0))
> +				return -1;
> +			break;
> +		}
> +
> +		if (!strcmp(word->buf, "terms")) {
> +			struct strvec argv = STRVEC_INIT;
> +			int res;

In case this supposed to be the same from the beginning of the function,
the declaration seems duplicated here as well. 

> +			sq_dequote_to_strvec(line->buf+pos, &argv);
> +			res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
> +			strvec_clear(&argv);
> +			if (res)
> +				return -1;
> +			break;
> +		}

Another suggestion, again take as you wish, you can place the "if"
directly on the call of the "bisect_start()" and set the "res = -1"
as the value of "res" will be used for the function return anyways.
Again with the intent of simplify the implementation.

The code will look something like the similar:

        if (bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL))
                res = -1;
        strvec_clear(&argv);
        break;

I did not test the above code thoroughly though.


> +		error(_("Replay file contains rubbish (\"%s\")"),
> +		      word->buf);

I think this will be nicer on the same line ;). Not worth a re-roll

> +		res = -1;
> +	}
> +	return res;
> +}
> +
> +static int process_replay_file(FILE *fp, struct bisect_terms *terms)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	struct strbuf word = STRBUF_INIT;
> +	int res = 0;
> +
> +	while (strbuf_getline(&line, fp) != EOF) {
> +		res = process_line(terms, &line, &word);
> +		if (res)
> +			break;
> +	}
> +
> +	strbuf_release(&line);
> +	strbuf_release(&word);
> +	return res;
> +}
> +


-- 
Thanks
Rafael
