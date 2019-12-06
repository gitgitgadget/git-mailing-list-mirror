Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DEC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 11:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C6224658
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNeyBIyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFLeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:34:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54277 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFLeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 06:34:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so7454859wmj.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MZQaEG/8xOYb1yN7kS5kI7lytZ+NVHvw7zJst9OuX1g=;
        b=lNeyBIyhJJfBA6rPV4SUwbOBHipOjVlJMqEr6DKrpTmBR1yuWAPVXAsw9htF/tRg63
         CmdDgSNQ7fNlZcUGvq59lAv9ZAe504GPEV2y9IPiesXZe2rJ2z5JyIPmwESTlMjBN+hP
         EUXPM8g9g7a0HLMd65yFgm8L34tay5o0C4WlnBv8esQRag/QyHJbg8Eim+bQ2QOLTTKb
         FhQFvRAoo9KpekTRi3kN+12i9Czr5kIK5bNAuM/l63cuGnTbgKJMuLDkWyt07THUl4WS
         fI5DPaQYoSuD5l6ScDdiHoIbZEzRNA+sYpaWT06uzjB6AOKdd6MzcE8WZRRx7i9CoXGT
         2ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MZQaEG/8xOYb1yN7kS5kI7lytZ+NVHvw7zJst9OuX1g=;
        b=O2QShQtKRkXiw77E8pG9PoRQtqofJi0b9DdsL4IM4J3pDVGcoQQMVDNP1GbvGJMEGL
         0ESu5vhC75YX8USa/FWwauc746kUm1qYobWP7EB/N+c3KdHtjf+Hd6t+CzUK1evxxBbK
         ArkCVlaW2SekGZBKuLbSVZpAgUvZn2jpX8atWX0A8DWVVConTsVevG+4YpYcw2RX9qkf
         vBkw9Q1GKJGQ9DXI4hz+2pbE0I0sCXAkERdfxZk4NuNrO/zdb1XAIAwwiiTb2cdoCT2J
         yEZe6ZcvAHkj0xFqZMjOByG9emKSwipnVriAdFWE4x/EKozKz3Mk4Sf0nc53jxX0Ojjs
         CQiw==
X-Gm-Message-State: APjAAAXIbvW8z0SsSAgk+RuZMBrZDAtNP5s3DB8Mld9QHSN83ng2rP6O
        6JDmMjMiqllzsay1QL84VEk=
X-Google-Smtp-Source: APXvYqySap/fQrU8WFpf1m91XuA3DCwV8opi1otsDHQZNSjtXgZt0KwgcrFjdEJ8lKI26K8zqMRN2Q==
X-Received: by 2002:a7b:c113:: with SMTP id w19mr9867555wmi.144.1575632048873;
        Fri, 06 Dec 2019 03:34:08 -0800 (PST)
Received: from szeder.dev (x4d0c7a95.dyn.telefonica.de. [77.12.122.149])
        by smtp.gmail.com with ESMTPSA id s25sm3001851wmh.4.2019.12.06.03.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 03:34:08 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:34:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
Message-ID: <20191206113401.GA2746@szeder.dev>
References: <20191122011646.218346-1-emilyshaffer@google.com>
 <20191204203911.237056-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 04, 2019 at 12:39:11PM -0800, Emily Shaffer wrote:
> Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
> documentation accordingly.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50ce8d9461..54ba991c42 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c

> @@ -809,6 +813,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	int use_index = 1;
>  	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
>  	int allow_revs;
> +	char *pathspec_from_file;
> +	int pathspec_file_nul;

Uninitialized variables ...
>  
>  	struct option options[] = {
>  		OPT_BOOL(0, "cached", &cached,
> @@ -896,8 +902,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('W', "function-context", &opt.funcbody,
>  			N_("show the surrounding function")),
>  		OPT_GROUP(""),
> -		OPT_CALLBACK('f', NULL, &opt, N_("file"),
> +		OPT_CALLBACK('f', "patterns-from-file", &opt, N_("file"),
>  			N_("read patterns from file"), file_callback),
> +		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
> +		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
>  		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
>  			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
>  		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
> @@ -1062,6 +1070,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	pathspec.recursive = 1;
>  	pathspec.recurse_submodules = !!recurse_submodules;
>  
> +	if (pathspec_from_file) {

... one of which is checked here ...

> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with pathspec arguments"));

... causing a lot of tests to fail in our OSX CI builds (but,
strangely, in none of the Linux builds), either with the above error
message, e.g.:

  expecting success of 4014.150 'format-patch --pretty=mboxrd':
  [...]
  ++git format-patch --pretty=mboxrd --stdout -1 01b96447182ff76f30268fb82d3f9e9e09b14e6c~1..01b96447182ff76f30268fb82d3f9e9e09b14e6c
  ++git grep -h --no-index -A11 '^>From could trip up a loose mbox parser' patch
  fatal: --pathspec-from-file is incompatible with pathspec arguments
  error: last command exited with $?=128

or with:

  expecting success of 7814.2 'grep correctly finds patterns in a submodule': 
  [...]
  ++git grep -e '(3|4)' --recurse-submodules
  fatal: could not open '����?' for reading: No such file or directory
  error: last command exited with $?=128

> +		pathspec_from_stdin = !strcmp(pathspec_from_file, "-");
> +
> +		if (patterns_from_stdin && pathspec_from_stdin)
> +			die(_("cannot specify both patterns and pathspec via stdin"));
> +
> +		parse_pathspec_file(&pathspec, 0, PATHSPEC_PREFER_CWD |
> +				    (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
> +				    prefix, pathspec_from_file,
> +				    pathspec_file_nul);

The other uninitialized variable is passed as parameter above and
checked below, but I haven't seen any test failures caused by it.

> +	} else if (pathspec_file_nul) {
> +		die(_("--pathspec-file-nul requires --pathspec-from-file"));
> +	}
> +
>  	if (list.nr || cached || show_in_pager) {
>  		if (num_threads > 1)
>  			warning(_("invalid option combination, ignoring --threads"));
