Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCE8C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B8661176
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEDR1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:27:03 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:43672 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhEDR1D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:27:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id CFD56722;
        Tue,  4 May 2021 19:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1620149164; x=1621963565; bh=xBV3f3ZIRRdWOPA/+Nq
        q2fk27d8vBHr0+Qf5WKI9UbE=; b=jIC2vLho3ZuDZGLnD8fjmh9ED/XehUa5xQ9
        tguAh9GX6YOLBknYwIebmZ/1vMtUpOrvCNO9ROL/+6LuDYek5gSBmXR98xnIz3Yg
        Q/xT91Pi+mgqwv1a7wFaLIeXi9LYXGu/lIUY/HWC+ObIjDC9V9kMx6ClLgPcl14n
        cFUiRSjUB0VsYycAUqXAKv5H1Xj7aillulHzSp42Ws6Idr8J706oSJiSMpfdGWUb
        3O9pVBEWDVvx711klfoC2scBLTe3kU9c0MwU+DMSjXFOnsF0arAD28IyxCdetiTG
        eBSULkIC3GR/3Xcr0o8OF4wGTADrMR7NiqQ4YT6coI4eg19Lpc/DBysdBSTDfr5N
        XfEsidyB4bhS6sXrvCaWs2PPuEZCMBSeK0EYw8Bc5NZ2QLYjQec51WrhkuzX37/0
        MOjSk5MnkCrQ1xd4xqDZQ/bsuipqEQpTGh7ONwk8A7uH1ucewIojXDYHd9pQNZxS
        L2EYzGJRwb8mkxQ4OoUowS07STYCGOQW3JlWVs3kLA6YATYp0GLYM2gpRFdMvHjO
        JstZUL+Nnr6uz+5SKl3OUFe+FvFavk+ymwDdLoQzD+RzYCPsFyoPh8bUoFzx75Bz
        +W2plXLfGaTWxUOn2WoBlV/8B/mZ1/TPiBMHkVTpllbXzfikIg7CrtDd/v2RNFh7
        WAPBZ46I=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kcRO1e2iJndW; Tue,  4 May 2021 19:26:04 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 22EED45E;
        Tue,  4 May 2021 19:26:03 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 7230A45C2;
        Tue,  4 May 2021 19:26:02 +0200 (CEST)
Subject: Re: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20210411095538.34129-1-mirucam@gmail.com>
 <20210411095538.34129-4-mirucam@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <3771bfc2-e4a4-3c5d-bcf5-673b403358ca@ahunt.org>
Date:   Tue, 4 May 2021 19:26:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210411095538.34129-4-mirucam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/04/2021 11:55, Miriam Rubio wrote:
> From: Tanushree Tumane <tanushreetumane@gmail.com>
> 
> Reimplement the `bisect_run()` shell function
> in C and also add `--bisect-run` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>   builtin/bisect--helper.c | 83 ++++++++++++++++++++++++++++++++++++++++
>   git-bisect.sh            | 62 +-----------------------------
>   2 files changed, 84 insertions(+), 61 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 71963979b1..dc87fc7dd0 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -18,6 +18,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>   static GIT_PATH_FUNC(git_path_head_name, "head-name")
>   static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>   static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
> +static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>   
>   static const char * const git_bisect_helper_usage[] = {
>   	N_("git bisect--helper --bisect-reset [<commit>]"),
> @@ -31,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
>   	N_("git bisect--helper --bisect-replay <filename>"),
>   	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
>   	N_("git bisect--helper --bisect-visualize"),
> +	N_("git bisect--helper --bisect-run <cmd>..."),
>   	NULL
>   };
>   
> @@ -1073,6 +1075,78 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
>   	return res;
>   }
>   
> +static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int res = BISECT_OK;
> +	struct strbuf command = STRBUF_INIT;
> +	struct strvec args = STRVEC_INIT;
> +	struct strvec run_args = STRVEC_INIT;
> +	int exit = 0;
> +	int temporary_stdout_fd, saved_stdout;
> +
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_FAILED;
> +
> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else
> +		return BISECT_FAILED;
> +
> +	run_args.v[0] = xstrdup(command.buf);
> +	run_args.nr = 1;

AFAIUI manipulating the strvec directly like this means that we will 
violate the promise that strvec.v is always NULL-terminated. It's 
probably safer to call 'strvec_push(run_args, command.buf)' instead of 
manipulating v and nr?

Violating the NULL-termination promise a problem because... (continued 
below)

> +
> +	while (1) {
> +		strvec_clear(&args);
> +		exit = 1;
> +
> +		printf(_("running %s"), command.buf);
> +		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);

run_command_v_opt() implicitly expects a NULL-terminated list of 
strings. It's not documented in run_command_v_opt()'s comments, however 
run_command_v_opt() does explain that it's a wrapper around 
start_command(), which uses child_process, and child_process.argv is 
documented to require a NULL-terminated list.

If argv is not NULL-terminated, we hit a buffer overflow read  in 
prepare_shell_cmd(), which can be reproduced by running something like:

   make CC=clang-11 SANITIZE=address COPTS="-Og -g" GIT_TEST_OPTS=-v 
T=t6030-bisect-porcelain.sh test

which results in ASAN reporting this error:

==2116==ERROR: AddressSanitizer: global-buffer-overflow on address 
0x000001a51e28 at pc 0x0000009c6c1f bp 0x7ffcf0f60670 sp 0x7ffcf0f60668
READ of size 8 at 0x000001a51e28 thread T0
     #0 0x9c6c1e in prepare_shell_cmd run-command.c:284:8
     #1 0x9c6c1e in prepare_cmd run-command.c:419:3
     #2 0x9c6c1e in start_command run-command.c:753:6
     #3 0x9c7d35 in run_command run-command.c:1015:9
     #4 0x9c800c in run_command_v_opt_cd_env_tr2 run-command.c:1051:9
     #5 0x9c800c in run_command_v_opt_cd_env run-command.c:1033:9
     #6 0x9c800c in run_command_v_opt run-command.c:1023:9
     #7 0x4e5b60 in bisect_run builtin/bisect--helper.c:1102:9
     #8 0x4e5b60 in cmd_bisect__helper builtin/bisect--helper.c:1252:9
     #9 0x4ce8fe in run_builtin git.c:461:11
     #10 0x4ccbc8 in handle_builtin git.c:718:3
     #11 0x4cb0cc in run_argv git.c:785:4
     #12 0x4cb0cc in cmd_main git.c:916:19
     #13 0x6beded in main common-main.c:52:11
     #14 0x7f28636f7349 in __libc_start_main (/lib64/libc.so.6+0x24349)
     #15 0x420769 in _start ../sysdeps/x86_64/start.S:120

0x000001a51e28 is located 56 bytes to the left of global variable 
'config_update_recurse_submodules' defined in 'submodule.c:26:12' 
(0x1a51e60) of size 4
0x000001a51e28 is located 0 bytes to the right of global variable 
'empty_strvec' defined in 'strvec.c:5:13' (0x1a51e20) of size 8
SUMMARY: AddressSanitizer: global-buffer-overflow run-command.c:284:8 in 
prepare_shell_cmd


[... snip the rest ...]
