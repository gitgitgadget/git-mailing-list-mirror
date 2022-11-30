Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B505C47088
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiK3Sqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiK3SqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:46:25 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D819493E
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:46:24 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y83so22730629yby.12
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgQMnNi8JrQ1whvmYv0ooa6RtHu0RlsUjvEtTm43mhc=;
        b=hvvvArVao2t9AU4dBHZDoz5oxBBGrKIBGvwADIWy6nOT7FAmCNcbrnFJ2znnSOG7Vo
         QyC70TJtEL9F+zpg+L/D3hwXC6qrpG6QTCkgOWfEit7Kb9vA0ZsGW6XhI4Mgx0lDAQi9
         AyS5inuJJM6H9V2g8L+OZccsrgzdrRR5BSh6OFN3V+UBPdwIJ5v/i8D0u9muy7xFLSEy
         atfb8GdydTcEWov0xD0dAJB0wZ6WvgBTYzpUZwZ80IAvi2M7RoM2Poo9Z7u6O44uxHs4
         bppZ31pfFCKzpcP5UTuGbpenPV5D5WHQPKy3jNEistCNiXfTRJebXxFeDmXYd7HiHaoO
         DhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgQMnNi8JrQ1whvmYv0ooa6RtHu0RlsUjvEtTm43mhc=;
        b=gmH5b4twWm76MIMFQalNRbKvAxoKFz25vNt9dG93NjobxsU9sK4nh5+3yvHOY3KXbz
         VR71cuLKQcdxvo1PDV7f9yueqtEHtqEoY6TxANPuOMlmSPESk90BA/NeVEiDGUt4ln1O
         Ze30bBJZOUdJdh6+xPmGjZUAhzrZG8ehO1OqQdKa91pMwotUX5CicY8YCNYi6rKrjRmk
         h74OZcKwmtLNqD6m5Qv7s4f3gQCn0BtEmtvWLtGI2tt4jFMfs6suFUrrhHuQGHjU6u5u
         dpMmPVJ5QmB/Z9ZJONCtvMgSXhuAVsFHI/vuvFaF/HUZTogL7rzIhtzU9JqIqgxDu48S
         LOJQ==
X-Gm-Message-State: ANoB5pnwN2VBVtB0UanNslSKbdTYU5chwBn/hELDWVgN6ojgPENAYQEY
        dE9C/OExw5EOxTKlz63AT9EPa6xB2fjsbo7bDiD9ag==
X-Google-Smtp-Source: AA0mqf6SqMqNQLChES+FftWCZYRyZH0oXnQnv6dBVnZAFcStubWqrNdE3E4FVv2OYdz9cdB6ErHEMjgnOJXN6xt6SaQ=
X-Received: by 2002:a5b:404:0:b0:6e8:6097:1264 with SMTP id
 m4-20020a5b0404000000b006e860971264mr42036620ybp.392.1669833975197; Wed, 30
 Nov 2022 10:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-2-calvinwan@google.com> <20221128204538.2748977-1-jonathantanmy@google.com>
In-Reply-To: <20221128204538.2748977-1-jonathantanmy@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 10:46:04 -0800
Message-ID: <CAFySSZB6XBzRedrp5+9r+xB9XmXR7Q09j+kkD-8Ym6B7bu69sQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 12:45 PM Jonathan Tan <jonathantanmy@google.com> wrote:

> Looking at this patch, since this new option is incompatible with "ungroup",
> I would have expected that the new functionality be in a place that already
> contains an "if (ungroup)", and thus would go into the "else" block. Looking at
> the code, it seems like a reasonable place would be in pp_collect_finished().

The code lives in pp_buffer_stderr(), which if you go one level higher, you'll
notice that the call to pp_buffer_stderr() is in the "else" block of an
"if (ungroup)".

> Is the reason this is not there because we only want the output of the child
> process, not anything that the callback functions might write to the out
> strbuf? If yes, is there a reason for that? If not, I think the code would
> be simpler if we did what I suggested. (Maybe this has already been discussed
> previously - if that is the case, the reason for doing it this way should be in
> the commit message.)

Yes, inside of pp_output(), you'll see that if the process is the output_owner,
then "pp->children[i].err" is printed and reset, which is why the code
lives before
pp_output(). The caller already has access to the callback functions and knows
what will be written to the out strbuf -- the goal of this patch is to
provide access
to all of the child output.

>
> > diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> > index 3ecb830f4a..40dd329e02 100644
> > --- a/t/helper/test-run-command.c
> > +++ b/t/helper/test-run-command.c
> > @@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
> >       return 0;
> >  }
> >
> > +static void duplicate_output(struct strbuf *process_out,
> > +                     struct strbuf *out,
> > +                     void *pp_cb,
> > +                     void *pp_task_cb)
> > +{
> > +     struct string_list list = STRING_LIST_INIT_DUP;
> > +
> > +     string_list_split(&list, process_out->buf, '\n', -1);
> > +     for (size_t i = 0; i < list.nr; i++) {
> > +             if (strlen(list.items[i].string) > 0)
> > +                     fprintf(stderr, "duplicate_output: %s\n", list.items[i].string);
> > +     }
> > +     string_list_clear(&list, 0);
> > +}
> > +
> >  static int task_finished(int result,
> >                        struct strbuf *err,
> >                        void *pp_cb,
> > @@ -439,6 +454,12 @@ int cmd__run_command(int argc, const char **argv)
> >               opts.ungroup = 1;
> >       }
> >
> > +     if (!strcmp(argv[1], "--duplicate-output")) {
> > +             argv += 1;
> > +             argc -= 1;
> > +             opts.duplicate_output = duplicate_output;
> > +     }
>
> In the tests, can we also write things from the callback functions? Whether we think that callback output should be
> duplicated or not, we should test what happens to them.

ack.
