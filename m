Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F211E202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdB1VIY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:08:24 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34133 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdB1VIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:08:21 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so2980815pgb.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XzDXIlCGTCL1hLt0QXcsHeE9ZasggEkTT1ECRgnGsls=;
        b=Hos0/pytmofn6mrO/3obWOZ/O+G6rTiVaai0viay8YcRTKyzCBH2HDJ6HVpIpirhn+
         Kjs8plUtxw4PpW96f6iiXczZAjssks1V5NEZ8JG216m8RwDp9niJgby1dtUdxOCcS1B7
         aFuwu2JW+1xQyRAtM3dimGhlSei6RE5ihbddHj7f8hPRzC1CNHXJb4UpXa9dELPpoxua
         WLE1HFD7af224jVBlBww1EMgcbynJWJoSIHxeSt0my4plssDycCHJtXJ39+0elFRmmvY
         TdOsxVKpzSUztyRoAZGfUwsFDZmh3CXJkj0D7L/DdhWfzKqDQqQJA2v3G/W2ABjvBNIj
         T7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XzDXIlCGTCL1hLt0QXcsHeE9ZasggEkTT1ECRgnGsls=;
        b=URlvzwNQKPnYdDlnR/MYDeqSSMM3GJ3uEwl1r1shRBf7r0m8C6eUIkUpI18Xd203hm
         YHi3CNOsoMHgQ8h2zihDaN7qcL4VvcEKjo2MjCib6O9CD/4Yrplmm9hzRQ+tpoHxhToT
         oe68V1622r4H0wgqy0SriZ7xAeS1U/0hK+OoFXpEf9nFXvJ69BuuaHNrXHgQpf4Il1XQ
         P4ya9U20UCYQFT0oThGdERYtDbkXM/9JE75KfL/8nj0zRAIvtqQftYq5zBd2A6JjGZ1E
         8pkivXy5+YNTT3JaaZmHuozn4Z5uogoRmEJx791ldLacGHf8n63UceSAfWhupgkajuH/
         GfkQ==
X-Gm-Message-State: AMke39mkOeGbz4kfFdq5OBd80NV+DdW/Ktme/t9NBw/Rvuf9DkMKpC8vQamEeYdDYE3CmQ==
X-Received: by 10.84.248.11 with SMTP id p11mr5570894pll.72.1488316033829;
        Tue, 28 Feb 2017 13:07:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id o24sm5957551pfj.78.2017.02.28.13.07.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:07:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 5/5] ls-files: fix bug when recuring with relative pathspec
References: <20170224235100.52627-1-bmwill@google.com>
        <20170224235100.52627-6-bmwill@google.com>
Date:   Tue, 28 Feb 2017 13:07:12 -0800
In-Reply-To: <20170224235100.52627-6-bmwill@google.com> (Brandon Williams's
        message of "Fri, 24 Feb 2017 15:51:00 -0800")
Message-ID: <xmqqa896ja7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Fix a bug which causes a child process for a submodule to error out when a
> relative pathspec with a ".." is provided in the superproject.
>
> While at it, correctly construct the super-prefix to be used in a submodule
> when not at the root of the repository.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-files.c                     | 8 ++++++--
>  t/t3007-ls-files-recurse-submodules.sh | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 159229081..89533ab8e 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -194,12 +194,15 @@ static void compile_submodule_options(const struct dir_struct *dir, int show_tag
>  static void show_gitlink(const struct cache_entry *ce)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf name = STRBUF_INIT;
>  	int status;
>  	int i;
>  
> +	quote_path_relative(ce->name, prefix, &name);
>  	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",

Same comment as 3/5.  quote_path is to produce c-quote and is not
even meant for shell script quoting.  run_command() interface would
do its own shell quoting when needed, so  I think you just want the
exact string you want to pass here.

