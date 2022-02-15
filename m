Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3CFC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbiBOW7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:59:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbiBOW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:58:55 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C4DAAD4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:58:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o3so352012qtm.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=6QOTk3VjRm4Jd6QxVxjOTwQ8BZ/Oz4ibhuqPb9E5lVk=;
        b=ipqFIcOIlh3+AgkVnA4+lpqsQ6SJeuxZoVji3CPRBq9/Yc5YAcaULadA100dungj02
         3O+g8gpihbdBwDEorJU25iuGg6nIxQ838z8YFhr3cpeWdfHplUCPpeSJLwc38LZsmOil
         USRJT//tqXHwepvApH7fA7W1pkVlojRBAWI0K6Ag2qdtDSX+TdsBei+rMrBhg5iF2hkT
         xLCn6cNZ2By9FtA5BYqFlv5ysawCFd29BOThU9RrOw8GESJyV1VnNGZBSVSkaPzadUjv
         ajTw68TBks4hx6+CFSj+Iftq9ENBH03S3Mdsipb+APbQSxn9GCOhxJ+hMFBQVQi4Pg6e
         wwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=6QOTk3VjRm4Jd6QxVxjOTwQ8BZ/Oz4ibhuqPb9E5lVk=;
        b=JJfdOcPt15OQu1Ax3u3+ZwxuwuKfe0g3TeMG4ObI5c6gAbkQ7r3zW8cySjU1GX502n
         pVPFOHeyr2k5AzmbdwSTHOg9yk1UV5n0h3xH5FHVFJ8l9Stry5e1ndCWWBuVznLCVp+Y
         8XnlpcgU37yjvgg0UlgF+/7YhzkNxWpe0kLVcJr7Xc8dspaRzur94a+kQb/g1op34Lzc
         YO/uagha2Nq8ri0pP+teb4e5kBbAKVmRVaRPr/DKtyuNFNk2dH6n7QviIazqGWcevY0p
         l7EXyjotrtpKN0kX/FU18ae19VLr0iCvccp7bHHuf60Ae5G4mgGouKy6omoaptZGh82E
         /PLA==
X-Gm-Message-State: AOAM533uCPLVSyFd094YFjhavgOP/L9mRL/WEkvPvg43Deq0rnOj/y6U
        5qvP9Q+RGjAegfuGnIC4eEw=
X-Google-Smtp-Source: ABdhPJy8jMo19aGQDNKSAFNc4ffcPLmECUM+2S+PzvuUFqHZEDR/4HFBssygJNl7fbUYDFeogCmN6A==
X-Received: by 2002:a05:622a:1ba6:b0:2d0:6f2:d309 with SMTP id bp38-20020a05622a1ba600b002d006f2d309mr172883qtb.389.1644965923192;
        Tue, 15 Feb 2022 14:58:43 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id w5sm17838680qko.34.2022.02.15.14.58.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:58:42 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 4/4] cat-file: add --batch-command mode
Date:   Tue, 15 Feb 2022 17:58:41 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <1FF9283F-C823-4D26-A39B-6506B900CEB2@gmail.com>
In-Reply-To: <CAPig+cTwLhn1GZ_=6s0FXL0z=Q=p1w9ZGK0hAV8wfK9RsQYjnA@mail.gmail.com>
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
 <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
 <a6dd5d72fce8cec430c0ec5da2dd9f0969a7fd91.1644862989.git.gitgitgadget@gmail.com>
 <CAPig+cTwLhn1GZ_=6s0FXL0z=Q=p1w9ZGK0hAV8wfK9RsQYjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thanks for taking another look!

On 15 Feb 2022, at 14:39, Eric Sunshine wrote:

> On Mon, Feb 14, 2022 at 1:23 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add a new flag --batch-command that accepts commands and arguments
>> from stdin, similar to git-update-ref --stdin.
>
> Some relatively minor comments below. Not sure any of them are serious
> enough to warrant a reroll...
>
>> The contents command takes an <object> argument and prints out the object
>> contents.
>>
>> The info command takes a <object> argument and prints out the object
>> metadata.
>
> s/a <object>/an <object>/
>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,33 @@ OPTIONS
>> +contents `<object>`::
>> +       Print object contents for object reference `<object>`. This corresponds to
>> +       the output of `--batch`.
>> +
>> +info `<object>`::
>> +       Print object info for object reference `<object>`. This corresponds to the
>> +       output of `--batch-check`.
>
> Sorry if I wasn't clear in my earlier review, but when I suggested
> s/<object>/`<object>`/, I was referring only to the body of each item,
> not to the item itself (for which we do not -- I think -- ever use
> `<...>`). So:
>
>     content <object>::
>         Print object contents ... `<object>`. ...
>
> As mentioned in my earlier review, I think the SYNOPSIS also needs an
> update to mention --batch-command.

:face-palm: yes I forgot about that in the last version.

>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> @@ -513,6 +514,129 @@ static int batch_unordered_packed(const struct object_id *oid,
>> +static void dispatch_calls(struct batch_options *opt,
>> +               struct strbuf *output,
>> +               struct expand_data *data,
>> +               struct queued_cmd *cmd,
>> +               int nr)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nr; i++){
>
> Style: for (...) {
>
>> +               cmd[i].fn(opt, cmd[i].line, output, data);
>> +               free(cmd[i].line);
>> +       }
>> +
>> +       fflush(stdout);
>> +}
>
> If I recall correctly, Junio suggested calling free() within this
> loop, but this feels like an incorrect separation of concerns since it
> doesn't also reset the caller's `nr` to 0. If (for some reason),
> dispatch_calls() is invoked twice in a row without resetting `nr` to 0
> in between the calls, then the dispatched commands will be called with
> a pointer to freed memory.
>
> One somewhat ugly way to fix this potential problem would be for this
> function to clear `nr`:
>
>     static void dispatch_calls(..., int *nr)
>     {
>         for (...) {
>             cmd[i].fn(...);
>             free(cmd[i].line);
>         }
>         *nr = 0;
>         flush(stdout);
>     }
>
> But, as this is a private helper, the code as presented in the patch
> may be "good enough" even though it's a bit fragile.

What you suggested makes sense from a separation of concerns point of view. I'm
still learning what looks ugly in C :), but I think this is easier to read
overall than what I had before.

>
>> +static void batch_objects_command(struct batch_options *opt,
>> +                                   struct strbuf *output,
>> +                                   struct expand_data *data)
>> +{
>> +       while (!strbuf_getline(&input, stdin)) {
>> +               if (!input.len)
>> +                       die(_("empty command in input"));
>> +               if (isspace(*input.buf))
>> +                       die(_("whitespace before command: '%s'"), input.buf);
>> +
>> +               if (skip_prefix(input.buf, "flush", &cmd_end)) {
>> +                       if (!opt->buffer_output)
>> +                               die(_("flush is only for --buffer mode"));
>> +                       if (*cmd_end)
>> +                               die(_("flush takes no arguments"));
>
> I didn't articulate it in my previous review since the thought was
> only half-formed, but given "flushify", this will incorrectly complain
> that "flush takes no arguments" instead of complaining "unknown
> command: flushify" as is done below (or it will incorrectly complain
> "flush is only for --buffer mode" if --buffer wasn't specified).
>
> If I'm reading the code correctly, it seems as if these problems could
> be avoided by treating `flush` as just another parse_cmd::commands[]
> item so that it gets all the same parsing/checking as the other
> commands rather than parsing it separately here.

This is a good idea. I like the reduced complexity.

>
>> +                       dispatch_calls(opt, output, data, queued_cmd, nr);
>> +                       nr = 0;
>> +                       continue;
>> +               }
>> +
>> +               for (i = 0; i < ARRAY_SIZE(commands); i++) {
>> +                       if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
>> +                               continue;
>> +
>> +                       cmd = &commands[i];
>> +                       if (cmd->takes_args) {
>> +                               if (*cmd_end != ' ')
>> +                                       die(_("%s requires arguments"),
>> +                                           commands[i].prefix);
>> +
>> +                               p = cmd_end + 1;
>> +                       } else if (*cmd_end) {
>> +                               die(_("%s takes no arguments"),
>> +                                   commands[i].prefix);
>> +                       }
>
> Good. Appears to be correctly handling the full matrix of
> command-requires-arguments and the actual input having or not having
> arguments.
>
>> +                       break;
>> +               }
>> +
>> +               if (!cmd)
>> +                       die(_("unknown command: '%s'"), input.buf);
>
> If you treat `flush` as just another parse_cmd::commands[], then right
> here is where you would handle it (I think):
>
>     if (strcmp(cmd->prefix, "flush")) {
>         dispatch_calls(opt, output, data, queued_cmd, nr);
>         nr = 0;
>         continue;
>     }
>
>> +               if (!opt->buffer_output) {
>> +                       cmd->fn(opt, p, output, data);
>> +                       continue;
>> +               }
>> +
>> +               ALLOC_GROW(queued_cmd, nr + 1, alloc);
>> +               call.fn = cmd->fn;
>> +               call.line = xstrdup_or_null(p);
>> +               queued_cmd[nr++] = call;
>> +       }
>> +
>> +       if (opt->buffer_output &&
>> +           nr &&
>> +           !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
>> +               dispatch_calls(opt, output, data, queued_cmd, nr);
>> +
>> +       free(queued_cmd);
>> +       strbuf_release(&input);
>> +}
