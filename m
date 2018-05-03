Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340E6200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeECQKP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:10:15 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33064 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECQKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:10:14 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id EGo7fDWrUsD7bEGo8fYjUR; Thu, 03 May 2018 17:10:13 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=7fXGaTHkJTKYXlyk9sUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
Date:   Thu, 3 May 2018 17:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOk4cKB2piQXJE8aGXXh3u0eyO18TAC0Q+y/eDQFaNZDIktb33o5elRyjKlxR6C/hGcKsiSnb50QrJ0IArI+hl6N9vXKkM4ugz2m5G36dUov4ipT686z
 mT4+NSm7zckvhefYXnGEE3vD9UrW3rRA/WRYhuI0txDnCthdaK7etUMr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/05/18 16:30, Johannes Schindelin wrote:
> This builtin does not do a whole lot so far, apart from showing a usage
> that is oddly similar to that of `git tbdiff`. And for a good reason:
> the next commits will turn `branch-diff` into a full-blown replacement
> for `tbdiff`.
> 
> At this point, we ignore tbdiff's color options, as they will all be
> implemented later and require some patches to the diff machinery.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore            |  1 +
>  Makefile              |  1 +
>  builtin.h             |  1 +
>  builtin/branch-diff.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  command-list.txt      |  1 +
>  git.c                 |  1 +
>  6 files changed, 45 insertions(+)
>  create mode 100644 builtin/branch-diff.c
> 
> diff --git a/.gitignore b/.gitignore
> index 833ef3b0b78..1346a64492f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,6 +20,7 @@
>  /git-bisect--helper
>  /git-blame
>  /git-branch
> +/git-branch-diff
>  /git-bundle
>  /git-cat-file
>  /git-check-attr
> diff --git a/Makefile b/Makefile
> index 96f2e76a904..9b1984776d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -953,6 +953,7 @@ BUILTIN_OBJS += builtin/archive.o
>  BUILTIN_OBJS += builtin/bisect--helper.o
>  BUILTIN_OBJS += builtin/blame.o
>  BUILTIN_OBJS += builtin/branch.o
> +BUILTIN_OBJS += builtin/branch-diff.o
>  BUILTIN_OBJS += builtin/bundle.o
>  BUILTIN_OBJS += builtin/cat-file.o
>  BUILTIN_OBJS += builtin/check-attr.o
> diff --git a/builtin.h b/builtin.h
> index 42378f3aa47..e1c4d2a529a 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
>  extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
>  extern int cmd_blame(int argc, const char **argv, const char *prefix);
>  extern int cmd_branch(int argc, const char **argv, const char *prefix);
> +extern int cmd_branch_diff(int argc, const char **argv, const char *prefix);
>  extern int cmd_bundle(int argc, const char **argv, const char *prefix);
>  extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
>  extern int cmd_checkout(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> new file mode 100644
> index 00000000000..97266cd326d
> --- /dev/null
> +++ b/builtin/branch-diff.c
> @@ -0,0 +1,40 @@
> +#include "cache.h"
> +#include "parse-options.h"
> +
> +static const char * const builtin_branch_diff_usage[] = {
> +	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),

s/rebase--helper/branch-diff/

ATB,
Ramsay Jones

