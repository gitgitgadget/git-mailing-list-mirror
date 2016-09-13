Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8022C207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbcIMAl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:41:56 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35101 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbcIMAlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:41:55 -0400
Received: by mail-oi0-f47.google.com with SMTP id d191so131569692oih.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0YS7yhI/WK7PNzyvuie2AGl8Ai6wC0An4T9y1Wj8qFk=;
        b=GTG8nJGOtT1woWK1Nja+INY58Y1sn7z6BSOCTx5wRCEGNgDOhZ++Yh9TAjLPrWE1zn
         X8Xq/QuP8Bu6Hu5Mo3upvNTIa0VQ6QZ/ZD7wicJ53K71BTPhVCpNXbFxUS3qHnYEE0Dl
         KHhF1c8ASNXq9kS5IhgoeaH62HmVD4YIX550WTm3O9kRg9gLYAXBCk1FYqzMdHWcHj6V
         Rhypqj9SLb+R7k6yTkUc0bYjqj7y2qc/VLQaxA4KCH0GM235V6ggBXGu6aABFOte5itq
         6yrE9nOvD0sMiSDAvGsL6WGuUq5Z8ZHp5U9dfw8uMtx9L2Gj0tH27ELDkeV2SjlxBem9
         wSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0YS7yhI/WK7PNzyvuie2AGl8Ai6wC0An4T9y1Wj8qFk=;
        b=cXKuQ0qL42M7pi/0+SFVSPUVtMpCBJxcCt9LrmMy/xbtta0/NowzIpaOFUImddEoGR
         HZpq7yle9UoPJ12EJR66bUagIRRT8tA5KoDXCuc51LEO77hXc++xgKNgb5tGshhw4yV5
         o4om/KsLVSmoOAEJoVquGe9nhqJlNfpbGoWUxHPgAfs++dIakcBaw0DpsmChewKW15tC
         D97UigHzEs0WV6477M/XN0oyRM6EnJgkw4Dt00ocx4HOqLAGKqUsl2comEFmnJCYWHeD
         1IHOG2qWgujVSN8aXk/tSNFIlSxv1S594ELhwuALr3w7nlKw1AGOAubqvqTQW82pbUhi
         muRA==
X-Gm-Message-State: AE9vXwNO3B7fbBmy5ZHgXyLSWbclcHF3Qa3SHMgRrmuh0qTbgjnyuOLhgE9ay+ytQHaKzqF+jZDjfghzoqlOSURW
X-Received: by 10.202.84.147 with SMTP id i141mr2981536oib.93.1473727313685;
 Mon, 12 Sep 2016 17:41:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Mon, 12 Sep 2016 17:41:53 -0700 (PDT)
In-Reply-To: <xmqqk2egwsq3.fsf@gitster.mtv.corp.google.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
 <1473572530-25764-8-git-send-email-stefanbeller@gmail.com> <xmqqk2egwsq3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Sep 2016 17:41:53 -0700
Message-ID: <CAGZ79kZbuVsj+hqc1CE05Nx+NqGYp9bRqKr+oKu-Rmx87A1C-Q@mail.gmail.com>
Subject: Re: [PATCH 07/10] diff.c: convert fn_out_consume to use emit_line_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> diff --git a/diff.c b/diff.c
>> index 2aefd0f..7dcef73 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -493,6 +493,19 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>>       emit_line_0(o, set, reset, line[0], line+1, len-1);
>>  }
>>
>> +static void emit_line_fmt(struct diff_options *o,
>> +                       const char *set, const char *reset,
>> +                       const char *fmt, ...)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     va_list ap;
>> +     va_start(ap, fmt);
>> +     strbuf_vaddf(&sb, fmt, ap);
>> +     va_end(ap);
>> +
>> +     emit_line(o, set, reset, sb.buf, sb.len);
>> +}
>> +
>>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
>>  {
>>       if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
>> @@ -1217,7 +1230,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>>       const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
>>       const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
>>       struct diff_options *o = ecbdata->opt;
>> -     const char *line_prefix = diff_line_prefix(o);
>>
>>       o->found_changes = 1;
>>
>> @@ -1233,10 +1245,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>>               name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
>>               name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
>>
>> -             fprintf(o->file, "%s%s--- %s%s%s\n",
>> -                     line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
>> -             fprintf(o->file, "%s%s+++ %s%s%s\n",
>> -                     line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
>> +             emit_line_fmt(o, meta, reset, "--- %s%s\n",
>> +                           ecbdata->label_path[0], name_a_tab);
>> +
>> +             emit_line_fmt(o, meta, reset, "+++ %s%s\n",
>> +                           ecbdata->label_path[1], name_b_tab);
>
> Hmph, the original showed the following for the name-a line:
>
>         diff_line_prefix(o) META "--- " label_path RESET name_a_tab LF
>
> The updated one calls emit_line_fmt() with o, meta, reset, fmt and
> args, and then
>
>  * strbuf_vaddf(&buf, "--- %s%s\n", label_path, name_a_tab) creates
>    a string "--- " + label_path + LF
>
>  * emit_line() is called on the whole thing with META and RESET

Oh right, that is a real issue, i.e. name_b_tab is not colored. I'll
have to think about that.

>
>  * which is emit_line_0() that encloses the whole thing between META
>    and RESET but knows the trailing LF should come after RESET.
>
> So the coloring seems to be correct, but I am not sure where the
> line-prefix went.

emit_line_0 puts the line_prefix by default in front, i.e.
it emits

    line_prefix (SET) (first char) line (RESET) (CR/LF)

with things in parenthesis optional.

As said in 6/10 I think the emit_line_0 function is a great starting point
to build up a buffer when we do a two passes output. For that I want to channel
all output through emit_line_*.


---
I am done converting all diff output to emit_line for a rought first series,
and now all tests pass when asking for a buffered output.

So I started building the --color-moved on top of that, which seems
to work as well. The diff stat is  ~700 insertions and ~300 deletions
compared to 2.10, however we call out to the xdl stuff only once.

Comparing that to the original quick-hack-patch
https://public-inbox.org/git/20160906070151.15163-1-stefanbeller@gmail.com/
which has just 280 additions, 10 deletions;
we seem to need about ~350 refactor lines and
slightly slower emissions in the non-color-moved case
(all the calls to emit_line instead of directly using fprintf/fputs/fputc)
