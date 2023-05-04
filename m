Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD06C77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 21:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjEDVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDVhv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 17:37:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E091387B
        for <git@vger.kernel.org>; Thu,  4 May 2023 14:37:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so296469b3a.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683236270; x=1685828270;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUMZKGTNbc1KHrXRrwVmcNbYx7WZlzz3v7z+i5RfUOw=;
        b=ENr8V5tFsC2ot5kpwEcsLMdfCKcwBLdnqSTiGgmGNA2h8tdQK0gc0P9ZYaTHQKiMnM
         bxoDSN5d+xQZUr8/zMZKCW/2pWxWHZdvU2/e8JO4u7soUPIUHbzgtP/QvQzH2+5u8mO+
         D11xHYpFyg4hVLnDSFgKd648ZRlY3oaohpFHAFPaWagM8pcWbdeM5rtlgzGFZ0rY8YUA
         VAq8iJB5qsN7OhU6g7D6xwBCETGglEEJM9GHTuadLtuYNZgm0IP9j65FSNhz0aknAb8Y
         re2ZmDAyl1ajBY8VInhjjwe8AMgvsrDCQdl6C/WOEyeaAr9vZrd95uKMmsQcK1e8QlPN
         nsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683236270; x=1685828270;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cUMZKGTNbc1KHrXRrwVmcNbYx7WZlzz3v7z+i5RfUOw=;
        b=C2tbppGenV7+paWveA1KRDaVJQbzB6Z4/fW5FL7vbCy0Fcu7Fxy5jweZUPnUe6C9NR
         Neze50XNTTZh8LZp/uwHE5Aeqz7T9ee7K6TZ17B8EXZ/1J5QNwj8sf/dz8JxjlTo1YVE
         kBGS8nOiNKjBk53AfPicGYV9bIlv20XY0Vm4lkQt6KkNbGlajaRKR86MvVV8rnLLAWAg
         EUfEhZoSrWsTxkqTt71MOVFLN5G/lMguF6xSOSMzY5kP6mdNPlgkMEPcvqOQixkzHjyj
         Q+s3E7KOPquCy3LnNLL0PHVzIqDAmL2E9sV8tzHSyJnRicyD+efok+FcT0zmVgmRpdWg
         ph/A==
X-Gm-Message-State: AC+VfDxBIcBDWpSzSItyRXUCURswU3cLSm1jg6YytP3+bkjKXCSX6VBr
        RzZNMWhzBSUQW/dJU4sSMDM=
X-Google-Smtp-Source: ACHHUZ4KWJ2+Z2gape8FID6WJSHegNsFRyJYjmPE90sdThMFAmo/Qrh/4kX6dUGVqVq2ik9lFpsdUw==
X-Received: by 2002:a05:6a00:1148:b0:641:2d72:562 with SMTP id b8-20020a056a00114800b006412d720562mr4568268pfm.13.1683236269740;
        Thu, 04 May 2023 14:37:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j21-20020a62e915000000b005a8173829d5sm134449pfh.66.2023.05.04.14.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:37:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re* [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
        <87o7n03qgq.fsf@osv.gnss.ru> <xmqqpm7fizsl.fsf@gitster.g>
Date:   Thu, 04 May 2023 14:37:48 -0700
In-Reply-To: <xmqqpm7fizsl.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        04 May 2023 13:53:30 -0700")
Message-ID: <xmqqjzxnixqr.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> ... it'd be likely set of independent options:

>>  --patch --no-patch
>>  --raw   --no-raw
>>  --stat  --no-stat
>>
>> and then
>>
>>  -s being just a shortcut for "--no-raw --no-patch --no-stat"
>
> If I were writing Git from scratch without any existing users, that
> would be how I would design it (modulo that I would make sure we
> have some mechanism to make it easier for developers who may add
> a new output <format> to ensure that "-s" also implies "--no-<format>"
> for the new <format> they are adding to the mix).
>
> The fact that this wasn't brought up until now may mean that nobody
> would notice if we redefined the definition of "--no-patch" to
> behave that way, as long as "-s" keeps its original meaning.  
>
> I dunno.

I haven't run any tests (not just your new one, but existing ones)
but at least "git diff -s --stat" and "git diff -s --raw" do countermand
the earlier "-s" with this patch.  I am not signing it off because I
started from the options[] array in add_diff_options() and tweaked
those I happened to notice, and haven't checked if we need to adjust
other entries in the array.

 diff.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git c/diff.c w/diff.c
index 1e83aaee6b..2d8025a9f7 100644
--- c/diff.c
+++ w/diff.c
@@ -4929,6 +4929,7 @@ static int diff_opt_stat(const struct option *opt, const char *value, int unset)
 		BUG("%s should not get here", opt->long_name);
 
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
 	options->stat_name_width = name_width;
 	options->stat_graph_width = graph_width;
 	options->stat_width = width;
@@ -4947,6 +4948,7 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	 * The caller knows a dirstat-related option is given from the command
 	 * line; allow it to say "return this_function();"
 	 */
+	options->output_format &= ~DIFF_FORMAT_NO_OUTPUT;
 	options->output_format |= DIFF_FORMAT_DIRSTAT;
 	return 1;
 }
@@ -5502,9 +5504,9 @@ struct option *add_diff_options(const struct option *opts,
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
-		OPT_BIT_F(0, "raw", &options->output_format,
+		OPT_BITOP(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
-			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_RAW, DIFF_FORMAT_NO_OUTPUT),
 		OPT_BITOP(0, "patch-with-raw", &options->output_format,
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
@@ -5513,12 +5515,12 @@ struct option *add_diff_options(const struct option *opts,
 			  N_("synonym for '-p --stat'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
 			  DIFF_FORMAT_NO_OUTPUT),
-		OPT_BIT_F(0, "numstat", &options->output_format,
+		OPT_BITOP(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
-			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
-		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  DIFF_FORMAT_NUMSTAT, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
-			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
+			  DIFF_FORMAT_SHORTSTAT, DIFF_FORMAT_NO_OUTPUT),
 		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
 			       N_("output the distribution of relative amount of changes for each sub-directory"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
