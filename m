Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9CC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 07:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1CF60EE3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 07:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhIJHxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhIJHw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 03:52:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F5C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 00:51:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q3so1230987iot.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2N/zxofK2X2+MXnyTpXCZTc6his6g7vwFPFZ78mSja8=;
        b=UEJJpBb7AUDwCh25jkfHNJX2yBgpt2q1STU/QXmIEX+Hg6vjCSruwlcOY5rdCjwet2
         PeRS5fA9scU/R9FNfLx0DiaZPcGiIfJYxwdyFUk7366r6u2jBdFTTxuG3plMUNSYnbku
         QkA21VGLXiVr8z1SvzJA6qo3U2vUMfERetKosfcrqoeYFltSQLdur8/1p5s9Ix0j6YHf
         Rr20KkkwP/kSCbSjkEK6aIReGN6ikwnQs9lMXhQNjdrPQIteQtKMQfjAVLk+sCGgR/0W
         9nXr+urxR/fPcuzaQ3JMC1Cd9kA7SACHLGxw9RKorw/Do9xXuARXoz3Y4Q2YFrkeDSa+
         7QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2N/zxofK2X2+MXnyTpXCZTc6his6g7vwFPFZ78mSja8=;
        b=wabzQXEPbdabJI3tNnWbgLebWZ9JKvAEDsKbh4FhhYScFGcgSYQCOQU7uoxZIV51wv
         9M09qvH02dcE/Ele8bGF5TEEIoelt4RCEJfiLP5hiDIKlEF+jA/prCI9XxAdKAKGIYIM
         S6VIjkPj9hZ+lBwd3OrjOpeEHwdXuJg83vyDV3x7ctJjlIFMioHksf5rxirhk8nPO9wJ
         DkXX3zBil2HDVF4Y4pvQTu8GghAHUXlbM1taCyfoy92ZXIDQ98k+EglasgdHpMYCKzBO
         YA5P4423DqEiBsm63VGSNpJZ8UgvoUt1Vnerc1tOpi3s8pr3bs4s33NGKNQ0oLPcM80n
         5GYQ==
X-Gm-Message-State: AOAM5336UDfmyvOonTBy0QhJBXrm2EuEAuJ3I8b4SB0MZOtBF0kAgy1+
        veWvJCeP+kWhb75mXkUYMwI=
X-Google-Smtp-Source: ABdhPJzCqfIv8styrgXK1yX2Sq7pYI6SWn8rDsMf870iU68bNt0kboCBdh/McWBUSzXGhra998zifw==
X-Received: by 2002:a05:6638:243:: with SMTP id w3mr3324764jaq.71.1631260306871;
        Fri, 10 Sep 2021 00:51:46 -0700 (PDT)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b19sm2167338ile.88.2021.09.10.00.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 00:51:46 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 2/2] parse-options: properly align continued usage output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <patch-2.2-ab4bb70902b-20210901T110917Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <f8560b11-ba56-0a52-8bb4-5b71f0657764@sunshineco.com>
Date:   Fri, 10 Sep 2021 03:51:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <patch-2.2-ab4bb70902b-20210901T110917Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/21 7:12 AM, Ævar Arnfjörð Bjarmason wrote:
> Some commands such as "git stash" emit continued options output with
> e.g. "git stash -h", because usage_with_options_internal() prefixes
> with its own whitespace the resulting output wasn't properly
> aligned. Let's account for the added whitespace, which properly aligns
> the output.
> 
> The "git stash" command has usage output with a N_() translation that
> legitimately stretches across multiple lines;
> 
> 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
> 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
> 
> We'd like to have that output aligned with the length of the initial
> "git stash " output, but since usage_with_options_internal() adds its
> own whitespace prefixing we fell short, before this change we'd emit:
> 
>      $ git stash -h
>      usage: git stash list [<options>]
>         or: git stash show [<options>] [<stash>]
>         [...]
>         or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
>                [-u|--include-untracked] [-a|--all] [-m|--message <message>]
>                [...]
> 
> Now we'll properly emit aligned output.  I.e. the last four lines
> above will instead be (a whitespace-only change to the above):
> 
>         [...]
>         or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
>                       [-u|--include-untracked] [-a|--all] [-m|--message <message>]
>                       [...]
> 
> In making this change we can can fold the two for-loops over *usagestr
> into one. We had two of them purely to account for the case where an
> empty string in the array delimits the usage output from free-form
> text output.

More on this below...

> We could skip the string_list_split() with a strchr(str, '\n') check,
> but we'd then need to duplicate our state machine for strings that do
> and don't contain a "\n". It's simpler to just always split into a
> "struct string_list", even though the common case is that that "struct
> string_list" will contain only one element. This is not
> performance-sensitive code.

Makes sense.

> This change is relatively more complex since I've accounted for making
> it future-proof for RTL translation support. Later in
> usage_with_options_internal() we have some existing padding code
> dating back to d7a38c54a6c (parse-options: be able to generate usages
> automatically, 2007-10-15) which isn't RTL-safe, but that code would
> be easy to fix. Let's not introduce new RTL translation problems here.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/parse-options.c b/parse-options.c
> @@ -917,25 +917,78 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
> +	 * When a translated usage string has an embedded "\n" it's
> +	 * because options have wrapped o the next line. The line

"wrapped o the next line"?

> +	size_t or_len = strlen(or_prefix) - strlen("%s");
> +	int i;
> +	int saw_empty_line = 0;
> +
> -	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
> -	while (*usagestr && **usagestr)
> -		/*
> -		 * TRANSLATORS: the colon here should align with the
> -		 * one in "usage: %s" translation.
> -		 */
> -		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
> -	while (*usagestr) {
> -		if (**usagestr)
> -			fprintf_ln(outfile, _("    %s"), _(*usagestr));
> -		else
> -			fputc('\n', outfile);
> -		usagestr++;
> +	for (i = 0; *usagestr; i++) {
> +		const char *str = _(*usagestr++);
> +		struct string_list list = STRING_LIST_INIT_DUP;
> +		unsigned int j;
> +
> +		string_list_split(&list, str, '\n', -1);
> +		for (j = 0; j < list.nr; j++) {
> +			const char *line = list.items[j].string;
> +
> +			if (!saw_empty_line && !*line)
> +				saw_empty_line = 1;
> +
> +			if (saw_empty_line && *line)
> +				fprintf_ln(outfile, _("    %s"), line);
> +			else if (saw_empty_line)
> +				fputc('\n', outfile);
> +			else if (!j && !i)
> +				fprintf_ln(outfile, usage_prefix, line);
> +			else if (!j)
> +				fprintf_ln(outfile, or_prefix, line);
> +			else
> +				fprintf_ln(outfile, usage_continued,
> +					   (int)or_len, "", line);
> +		}
> +		string_list_clear(&list, 0);

I may be missing something obvious, but I'm having trouble understanding 
why this single loop is better than the two loops it replaces. The 
cognitive load of the new code is much higher than that of the original. 
With the original code, the logic was obvious at a glance. On the other 
hand, I had to concentrate hard to figure out what the new code is 
trying to do and to wrap my brain around all the cases it is handling. I 
suppose you went with the single loop to avoid code duplication (in 
particular, the call to string_list_split() and the loop over the split 
elements)?

There are other ways this might be accomplished which don't carry such a 
high cognitive load. One (typed-in-email) possibility which closely 
resembles the existing code:

     const char *pfx = usage_prefix;
     while (*usagestr && **usagestr) {
         string_list_split(&list, _(*usagestr++), ...);
         fprintf_ln(outfile, pfx, list.items[0].string);
         for (i = 1; i < list.nr; i++)
             fprintf_ln(outfile, usage_continued,
                 (int)or_len, "", list.items[i].string);
         pfx = or_prefix;
     }
     while (*usagestr) {
         string_list_split(&list, _(*usagestr++), ...);
         for (i = 0; i < list.nr; i++) {
             const char *line = list.items[i].string;
             if (*line)
                 fprintf_ln(outfile, _("    %s"), line);
             else
                 fputc('\n', outfile);
         }
     }

I also wonder if you really need to support the embedded-newline case 
for the free-form text loop. For free-form text, it's just as easy for 
each line of text to be a distinct item in the usage[] array, if I 
understand correctly, so there isn't really a good reason for clients to 
embed newlines in the free-form text portion. Given that there's only a 
single client in the entire project which takes advantage of the 
free-form text support -- and that client doesn't embed newlines -- it 
may be simpler to not bother supporting embedded newlines for the 
free-form text, in which case you don't even need to modify that loop; 
the existing code is good enough.

Anyhow, the above observations are subjective, thus not necessarily 
actionable, however, there is also a subtle yet dramatic behavior change 
in the new code, if I understand correctly. It's not clear if this 
behavior change is intentional (it isn't mentioned in the commit 
message), but it does seem potentially dangerous. Specifically, with the:

     if (!saw_empty_line && !*line)
         saw_empty_line = 1;

check inside the inner loop which iterates over the split lines, this 
means that if someone accidentally embeds an extra newline in some usage 
line:

     static const char *foo_usage[] = {
         N_("git foo --bar\n\n" /* <-- accidental extra newline */
            "        --baz"),
         N_("git boo"),
         NULL
     };

then _all_ following usage lines will incorrectly be treated as 
free-form text lines rather than as the "or:" lines they are intended to 
be. Moving the:

     if (!saw_empty_line && !*line)
         saw_empty_line = 1;

check from the inner loop to the outer loop should restore the original 
(intended) behavior, I believe.
