Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4757C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbiBDVmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbiBDVmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:42:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A118C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:42:00 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id j2so22771180ejk.6
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=Rk+EcvTXWl57k7dhTyV6yvj31Bv6OUDo7nKlchXG5Yo=;
        b=VrsjZuHbrN2B6BEMV6XO1j/wIDb9wrwVj48FFXHhOPoFK/j63o1priNSW6gq9gdjdX
         NWy57FK3Wa7lV84nsR51xnjRoF5HYKxyQT1KPJ/wNof2VQWJsxm1uYA98X2/KtPD3V0e
         MAqZWTMt89XQ0nTjKK6NTF/L4vqXokOV/8IbmdPer7fLFHH3Dy50q3Wh4jey9DmodKNh
         Mj0LevwHapK5mPwYx/2+MlqKfJIaGqDo9CXMFIA9UaXb/w6I6EnAfx18IeJNDyK6D+2K
         a20Tsx7FRYrKSvcpq07rjF7xxhH+5GqbOrKCGyZwDk1hYCKKX6gM+VDlmUYyTxkqvWk/
         pw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=Rk+EcvTXWl57k7dhTyV6yvj31Bv6OUDo7nKlchXG5Yo=;
        b=QT4VNh7/3GSaTvagNvMBVJHbYlbAyX0nqAovbrmsaZTZn1QR56ex8sYcODu/I0UpYL
         Zzb89OzyhI43jezoGYazgIWWE+/7wNjOlPZPaegVzt6ubreM+Gj7fn4wy8jsnHS3DiWe
         O8cgEFXXxjMwaj+OgMZjKJo6ma0OA9CcnobALoW81q8Ay3apxRme6Q6K7BcFktMp1TOW
         WsCb9gIqjCzt560ZpvP1oDm6Wash+vhiSGtA+RfAERI9Jk4sPt64dxMh6Rvf6Qlbel0d
         Le1eSYBp3WIRJXSe4uqdfFEw8L1vvJTJEL9jNd9Bi5WyvPStpoqED0Mn/QGGV9/3Ntzc
         NMtg==
X-Gm-Message-State: AOAM533jvKCRFh/zCHUYiJbesIwZkZaMLlWPnDHTNie0L3gHwD3kur02
        kMCIkB6NTjk5Q9Wzkk+Qx58=
X-Google-Smtp-Source: ABdhPJydhWqetmlPWQCIk253TOAZHMnil4NaKhZ3aqjMHlWuCdZFGMcqy43IiMK8iI6VeuegTcEuhQ==
X-Received: by 2002:a17:906:1e06:: with SMTP id g6mr712299ejj.517.1644010918929;
        Fri, 04 Feb 2022 13:41:58 -0800 (PST)
Received: from [10.200.48.154] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id p12sm1013166ejd.180.2022.02.04.13.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Feb 2022 13:41:58 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
Date:   Fri, 04 Feb 2022 16:41:56 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <3F83E252-D99C-47CB-B47F-11B8EA554A4F@gmail.com>
In-Reply-To: <CAPig+cQHcstj28F-==oCakp3iMLHtd1SVQV+snzewYihHxNG6g@mail.gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
 <CAPig+cQHcstj28F-==oCakp3iMLHtd1SVQV+snzewYihHxNG6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

I appreciate the feedback and the thorough review!

On 4 Feb 2022, at 1:45, Eric Sunshine wrote:

> ()()On Thu, Feb 3, 2022 at 7:20 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add new flag --batch-command that will accept commands and arguments
>> from stdin, similar to git-update-ref --stdin.
>>
>> contents <object> NL
>> info <object> NL
>>
>> With the following commands, process (A) can begin a "session" and
>> send a list of object names over stdin. When "get contents" or "get info"
>> is issued, this list of object names will be fed into batch_one_object()
>> to retrieve either info or contents. Finally an fflush() will be called
>> to end the session.
>>
>> begin
>> <sha1>
>> get info
>>
>> begin
>> <sha1>
>> get contents
>
> I had the same reaction to this new command set as Junio expressed
> upstream[1], and was prepared to suggest an alternative but Junio said
> everything I wanted to say, so I won't say anything more about it
> here.
>
> That aside, the implementation presented here is overly loose about
> malformed input and accepts all sorts of bogus invocations which it
> should be reporting as errors. For instance, a lone:
>
>     get info
>
> without a preceding `begin` should be an error but such bogus input is
> not diagnosed. `get contents` is likewise affected. Another example:
>
>     begin
>     <oid>
>     <EOF>
>
> which lacks a closing `get info` or `get contents` is silently
> ignored. Similarly, malformed:
>
>     begin
>     begin
>     ...
>
> should be reported as an error but is not.
>
> There is also a bug in which the accumulated list of OID's is never
> cleared. Thus:
>
>     begin
>     <oid>
>     get info
>     get info
>
> emits info about <oid> twice, once for each `get info` invocation. Similarly:
>
>     begin
>     <oid1>
>     get info
>     <oid2>
>     get info
>
> emits information about <oid1> twice and <oid2> once. Invoking `begin`
> between the `get info` commands doesn't help because `begin` is a
> no-op. Thus:
>
>     begin
>     <oid1>
>     get info
>     begin
>     <oid2>
>     get info
>
> likewise emits information about <oid1> twice and <oid2> once.
>
> It also incorrectly accepts non-"session" commands in the middle of a
> session. For instance:
>
>     begin
>     <oid1>
>     info <oid2>
>     <oid3>
>
> immediately emits information about <oid2> and then bombs out claiming
> that <oid3> is an "unknown command" because the `info` command --
> which should not have been allowed within a session -- prematurely
> ended the "session".
>
> The `info` and `contents` commands neglect to do any sort of
> validation of their arguments, thus any and all bogus invocations are
> accepted. Thus:
>
>     info
>     info <arg1> <arg2>
>     info <non-oid>
>
> are all accepted as valid invocations, misleadingly producing "<foo>
> missing" messages, rather than erroring out as they should. The "<oid>
> missing" message should be reserved for the case when the lone
> argument to `info` or `contents` is something which looks like a
> legitimate OID.

So actually the argument to info and contents doesn't have to be an OID but an object name that
eventually gets passed to get_oid_with_context() to resolve to an actual oid. This is the
same behavior as git cat-file --batch and --batch-check, neither of which throws an error. My
goal was to maintain this behavior in --batch-command.
>
> The above is a long-winded way of saying that it is important not only
> to check the obvious "expect success" cases when implementing a new
> feature, but it's also important to add checks for the "expect
> failure" cases, such as all the above malformed inputs.

I overall agree and will add test coverage for invalid input.

> It's subjective, but it feels like this implementation is trying to be
> too clever by handling all these cases via a single strbuf_getline()
> loop in batch_objects_command(). It would be easier to reason about,
> and would have avoided some of the above problems, for instance, if
> handling of `begin` was split out to its own function which looped
> over strbuf_getline() itself, thus could easily have detected
> premature EOF (lacking `get info` or `get contents`) and likewise
> would not have allowed `info` or `contents` commands to be executed
> within a "session".
>
> Similarly (again subjective), the generic command dispatcher seems
> over-engineered and perhaps contributed to the oversight of `info` and
> `contents` failing to perform validation of their arguments. A simpler
> hand-rolled command-response loop is more common on this project and
> often easier to reason about. Perhaps something like this
> (pseudo-code):
>
>     while (strbuf_getline(&input, stdin)) {
>         char *end_cmd = strchrnul(&input.buf, ' ');
>         const char *argstart = *end_cmd ? end_cmd + 1 : end_cmd;
>         *end_cmd = '\0';
>         if (strcmp(input.buf, "info"))
>             show_info(argstart);
>         else if (strcmp(input.buf, "contents"))
>             show_contents(argstart);
>         else if (strcmp(input.buf, "begin"))
>             begin_session(argstart);
>         else
>             die(...);
>     }

I think I agree that the code in this patch is a little hard to follow,
but now I'm planning to simplify the design by getting rid of "begin"[2].

I'm hoping this change will make the code easier to reason about.

2. https://lore.kernel.org/git/767d5f5a-8395-78bc-865f-a39acc39e061@gmail.com/

>
> and each of the command-handler functions would perform its own
> argument validation (including the case when no argument should be
> present).
>
> [1]: https://lore.kernel.org/git/xmqqo83nsoxs.fsf@gitster.g/
>
>> +static void parse_cmd_begin(struct batch_options *opt,
>> +                          const char *line,
>> +                          struct strbuf *output,
>> +                          struct expand_data *data,
>> +                          struct string_list revs)
>> +{
>> +       /* nothing needs to be done here */
>> +}
>
> Either this function should be clearing the list of collected OID's or...
>
>> +static void parse_cmd_get(struct batch_options *opt,
>> +                          const char *line,
>> +                          struct strbuf *output,
>> +                          struct expand_data *data,
>> +                          struct string_list revs)
>> +{
>> +       struct string_list_item *item;
>> +       for_each_string_list_item(item, &revs) {
>> +               batch_one_object(item->string, output, opt, data);
>> +       }
>> +       if (opt->buffer_output)
>> +               fflush(stdout);
>
> ... this function should do so after it's done processing the OID list.
>
>> +}
>> +static void parse_cmd_get_info(struct batch_options *opt,
>> +                          const char *line,
>> +                          struct strbuf *output,
>> +                          struct expand_data *data,
>> +                          struct string_list revs)
>
> Missing blank line before the function definition.
>
>> +static void parse_cmd_get_objects(struct batch_options *opt,
>> +                          const char *line,
>> +                          struct strbuf *output,
>> +                          struct expand_data *data,
>> +                          struct string_list revs)
>> +{
>> +       opt->print_contents = 1;
>> +       parse_cmd_get(opt, line, output, data, revs);
>> +       if (opt->buffer_output)
>> +               fflush(stdout);
>> +}
>
> Why does this function duplicate the flushing logic of parse_cmd_get()
> immediately after calling parse_cmd_get()?
>
>> +static void batch_objects_command(struct batch_options *opt,
>> +                                   struct strbuf *output,
>> +                                   struct expand_data *data)
>> +{
>> +       /* Read each line dispatch its command */
>
> Missing "and".
>
>> +       while (!strbuf_getline(&input, stdin)) {
>> +               if (state == BATCH_STATE_COMMAND) {
>> +                       if (*input.buf == '\n')
>> +                               die("empty command in input");
>
> This never triggers because strbuf_getline() removes the line
> terminator before returning.

yes, this was an oversight. thanks for catching it!

>
>> +                       else if (isspace(*input.buf))
>> +                               die("whitespace before command: %s", input.buf);
>> +               }
>> +
>> +               for (i = 0; i < ARRAY_SIZE(commands); i++) {
>> +                       if (!skip_prefix(input.buf, prefix, &cmd_end))
>> +                               continue;
>> +                       /*
>> +                        * If the command has arguments, verify that it's
>> +                        * followed by a space. Otherwise, it shall be followed
>> +                        * by a line terminator.
>> +                        */
>> +                       c = commands[i].takes_args ? ' ' : '\n';
>> +                       if (*cmd_end && *cmd_end != c)
>> +                               die("arguments invalid for command: %s", commands[i].prefix);
>
> Ditto regarding strbuf_getline() removing line-terminator.
>
>> +                       cmd = &commands[i];
>> +                       if (cmd->takes_args)
>> +                               p = cmd_end + 1;
>> +                       break;
>> +               }
>> +
>> +               if (input.buf[input.len - 1] == '\n')
>> +                       input.buf[--input.len] = '\0';
>
> Ditto again. This is especially scary since it's accessing element
> `input.len-1` without even checking if `input.len` is greater than
> zero.

I realize we actually don't need this if block at all because strubf_getline()
strips the line terminator for us already.

>
> Also, it's better to use published strbuf API rather than mucking with
> the internals:
>
>     strbuf_setlen(&input, input.len - 1);
>
>> +               if (state == BATCH_STATE_INPUT && !cmd){
>> +                       string_list_append(&revs, input.buf);
>> +                       continue;
>> +               }
>> +
>> +               if (!cmd)
>> +                       die("unknown command: %s", input.buf);
>> +
>> +               state = cmd->next_state;
>> +               cmd->fn(opt, p, output, data, revs);
>> +       }
>> +       strbuf_release(&input);
>> +       string_list_clear(&revs, 0);
>> +}
