Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2DC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D2960EB1
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGWQcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGWQbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:31:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0782C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:12:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i10so744285pla.3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R5MVjU2zY3NgdhVzds4Z4LxTzNLYDONgzJwTdGPpj7A=;
        b=aFpi/aE2dYByR3QjEaq/Cc+FhrWk9O4MIh1PXWhlrrkyCssFpyvXJ0aI4ZGkXChTM/
         TPT1WHlnlfFobc0ARlHeAE5evtCg3c7/p8AEEMfDy2/kBjzIpEWBmqBPCjarIyzo5bhj
         wWNagO8S+Q/jUAktvVhq1F5mxSSZNZmm70jiVUoM5ut38MJ7Poe0eK61tbf8G6FTYoKf
         2d2K8eIMhI+CEn0QcfI4+2Ion95NcuE4kP/cRSp/zN7nzAEQTOhNH7+4KkPGPOUZHCCK
         wgqEW5w3fMT4+/jimUFGtmsWCEsydlh0RgQz07g0c9NEob0CZ1wNuEl6crxffpoFxPSz
         DRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R5MVjU2zY3NgdhVzds4Z4LxTzNLYDONgzJwTdGPpj7A=;
        b=AHOGdeDwxBSXfTllka2XaH1jdMEI15Dp6E7e0p9mU1N7N9t+Wdud0ChLdRP2EnFc36
         FYrMmCGqMMoRVxjQs2bwYeKWtDyl6zAEtUSZ7XPYA+gUpI7mYLG8jg865nP+SGDByD63
         lQUlqN+H4cmAlF5X5btkK817d1I0D7045ESdzB8PN5vJK9Q8tYA76OGZYwbYlCm4H938
         RJrgnCXpXf+ZuWnMZsgDwcdFhe1sWkWmYcMbB8vAPBtDDmoVHdA7jjqf73eGwLqdptFG
         SgtehHtn0Sx7vYsiJ/TAQa1mLS3ZvG1TuxlVL2QvjUxgg9/gMLPlayE4dyi5yBbWA793
         ltbQ==
X-Gm-Message-State: AOAM531HkUYjUgc3pLWMY4SjUVtE1GcykjQVcjhOLeuOnnoRZ/60TSwv
        1aJ5M1OgQsYks4DWuB5SZyo=
X-Google-Smtp-Source: ABdhPJyG1ENZGRt0hW6kIyxLVSQ+NtdCEGo5w6rf97/2YuokPvuo6I3hf2CsgcmNR9oCrCCCKSDCxQ==
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr14798564pjb.87.1627060344343;
        Fri, 23 Jul 2021 10:12:24 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id i1sm34101939pfo.37.2021.07.23.10.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 10:12:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] submodule: drop unused sm_name parameter from
 show_fetch_remotes()
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YPqkHs47VDFBNZ0Z@coredump.intra.peff.net>
Date:   Fri, 23 Jul 2021 22:42:19 +0530
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E30F287A-0E19-45CD-8CA7-1FDA4DF20C61@gmail.com>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210710074801.19917-1-raykar.ath@gmail.com>
 <20210710074801.19917-5-raykar.ath@gmail.com>
 <YPqkHs47VDFBNZ0Z@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-Jul-2021, at 16:42, Jeff King <peff@peff.net> wrote:
>=20
> On Sat, Jul 10, 2021 at 01:18:01PM +0530, Atharva Raykar wrote:
>=20
>> +static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
>> +{
>> +	struct child_process cp_remote =3D CHILD_PROCESS_INIT;
>> +	struct strbuf sb_remote_out =3D STRBUF_INIT;
>> +
>> +	cp_remote.git_cmd =3D 1;
>> +	strvec_pushf(&cp_remote.env_array,
>> +		     "GIT_DIR=3D%s", git_dir_path);
>> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
>> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
>> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
>> +		char *next_line;
>> +		char *line =3D sb_remote_out.buf;
>> +		while ((next_line =3D strchr(line, '\n')) !=3D NULL) {
>> +			size_t len =3D next_line - line;
>> +			if (strip_suffix_mem(line, &len, " (fetch)"))
>> +				fprintf(output, "  %.*s\n", (int)len, =
line);
>> +			line =3D next_line + 1;
>> +		}
>> +	}
>> +
>> +	strbuf_release(&sb_remote_out);
>> +}
>=20
> The sm_name parameter is not used here. I don't think it's a bug; we
> just don't need it (there's a message that mentions the name, but it
> happens right before we call the function). Maybe this should go on =
top
> of ar/submodule-add?
>=20
> -- >8 --
> Subject: submodule: drop unused sm_name parameter from =
show_fetch_remotes()
>=20
> This parameter has not been used since the function was introduced in
> 8c8195e9c3 (submodule--helper: introduce add-clone subcommand,
> 2021-07-10).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> builtin/submodule--helper.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ed4a50c78e..1e65ff599e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2782,7 +2782,7 @@ struct add_data {
> };
> #define ADD_DATA_INIT { .depth =3D -1 }
>=20
> -static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
> +static void show_fetch_remotes(FILE *output, const char =
*git_dir_path)
> {
> 	struct child_process cp_remote =3D CHILD_PROCESS_INIT;
> 	struct strbuf sb_remote_out =3D STRBUF_INIT;
> @@ -2833,8 +2833,7 @@ static int add_submodule(const struct add_data =
*add_data)
> 				fprintf(stderr, _("A git directory for =
'%s' is found "
> 						  "locally with =
remote(s):"),
> 					add_data->sm_name);
> -				show_fetch_remotes(stderr, =
add_data->sm_name,
> -						   submod_gitdir_path);
> +				show_fetch_remotes(stderr, =
submod_gitdir_path);
> 				free(submod_gitdir_path);
> 				die(_("If you want to reuse this local =
git "
> 				      "directory instead of cloning =
again from\n"
> --=20
> 2.32.0.784.g92e169d3d7
>=20

Yes, this is definitely an oversight on my part, and it looks like this
topic has already made it to 'next'.

Thanks for the fix.

