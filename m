Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F19DC19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 03:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGaCwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGaCwe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 22:52:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6610576
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 19:52:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w15so12471826lft.11
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w/gAu25J2m4fLjgAFS0/Cv0/QziHXXgt2LkI5KzT0Bs=;
        b=ZFcqX+U6N13k12GA/Jyc/90VKg/WgQ5/zsjtS2slbuiu9gmK4z27w5JQDWgBy+LrL3
         lIOhHorrXaBhEmQciJLYgdAErwoi0kXgiy2ufbdAdnscv6YQCcz/PRep30wq/mUzNRnY
         lrfZJj6lGJyVRq1I8DiznOCCXE+XmZddCE0OGaX51vbYQyTTDvSvvbmlfCY8rVYyz4EO
         YGurwCYrCV0gzmMaLhQdFZ2+WBqMVs0tSqfiReDyL3D+PEt332BFp0DWSdLLZWIhwgZU
         IqsI0wpr9Su95o3RI1hARMRqzPDk2KiElk/Xt/X0vr3rYQuPFqN6331Wq5UEAbwExUXj
         y9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w/gAu25J2m4fLjgAFS0/Cv0/QziHXXgt2LkI5KzT0Bs=;
        b=U1GSjZ8+XiHmwTLePy8oeWK5uekKRzkN8UB3AFuEHAvgJQwi1ruXwko9SU9gnuRx0N
         EVPvmlGIsyhBSJ0LLE50LSgcOwnUmgVa0cVV80zb5eCXpWHoTnIAHdcnSInfHfErQdO1
         vBwb50J2UPoQdp666GUw88cbM3OjB3F/uDT6GWr4HzbeXZvTwzem9YgJfNmeAnwCdhdA
         Zzr0UcHHA6QycF6ta2lIYC/UhsPY6FEJwMeCchyfXt4esX9Ayur6zp7ypTpmhDNS2/e/
         Cz5JhV1GPlPBujp4Jxbj7GQg07rskGPATfzPzHMWMVmOgmwkcJuFi9KvMHog8P8DmETS
         OYMQ==
X-Gm-Message-State: AJIora9OO0hVv1Nyez3MEUUMhs9TRjqDVwqUh0JGIOFnE51XMtYAt4ZK
        jmLWV8oRzjYOGz1mxy+V/9tweHFYa+Uk0TUbzCV3og==
X-Google-Smtp-Source: AGRyM1uzYIX3cHk0HGGz0eGJ7InasdDwNJVVdWVQwRh81C6QHcyyJ2ToMvn8YgX66EDlIIPdRKJtvkMLtsUzwMlw6IQ=
X-Received: by 2002:a05:6512:3f13:b0:48a:a89e:3ccb with SMTP id
 y19-20020a0565123f1300b0048aa89e3ccbmr3328345lfa.245.1659235947446; Sat, 30
 Jul 2022 19:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658518769.git.matheus.bernardino@usp.br>
 <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
 <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
In-Reply-To: <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 23:52:16 -0300
Message-ID: <CAHd-oW6LZay=MX2FdFjgTh1pjE=g-XTm63mGWuMhHd=-N=tXRA@mail.gmail.com>
Subject: Re: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Dscho

On Thu, Jul 28, 2022 at 1:58 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 24 Jul 2022, Matheus Tavares wrote:
> >
> > diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
> > +static char *rot13(char *str)
> > +{
> > +     char *c;
> > +     for (c = str; *c; c++) {
> > +             if (*c >= 'a' && *c <= 'z')
> > +                     *c = 'a' + (*c - 'a' + 13) % 26;
> > +             else if (*c >= 'A' && *c <= 'Z')
> > +                     *c = 'A' + (*c - 'A' + 13) % 26;
>
> That's quite verbose, but it _is_ correct (if a bit harder than necessary
> to validate, I admit that I had to look up whether `%`'s precedence is higher
> than `+` in https://en.cppreference.com/w/c/language/operator_precedence).
>
> A conciser way (also easier to reason about):
>
>         for (c = str; *c; c++)
>                 if (isalpha(*c))
>                         *c += tolower(*c) < 'n' ? 13 : -13;

Nice :) Thanks.

> > [...]
> > +static void packet_read_capabilities(struct string_list *caps)
> > +{
> > +     while (1) {
> > +             int size;
> > +             char *buf = packet_read_line(0, &size);
> > +             if (!buf)
> > +                     break;
> > +             string_list_append_nodup(caps,
> > +                                      skip_key_dup(buf, size, "capability"));
>
> It is tempting to use unsorted string lists for everything because Perl
> makes that relatively easy.
>
> However, in this instance I would strongly recommend using something more
> akin to Perl's "hash" data structure, in this instance a `strset`.

Ok, will do.

> > +
> > +/*
> > + * Check our capabilities we want to advertise against the remote ones
> > + * and then advertise our capabilities
> > + */
> > +static void packet_check_and_write_capabilities(struct string_list *remote_caps,
> > +                                             struct string_list *our_caps)
>
> The list of "our caps" comes from the command-line. In C, this means we
> get a `const char **argv` and an `int argc`. So:
>
> static void check_and_write_capabilities(struct strset *remote_caps,
>                                          const char **caps, int caps_count)
> {
>         int i;
>
>         for (i = 0; i < caps_count; i++) {
>                 if (!strset_contains(remote_caps, caps[i]))
>                         die("our capability '%s' is not available from remote",
>                             caps[i]);
>
>                 packet_write_fmt(1, "capability=%s\n", caps[i]);
>         }
>         packet_flush(1);
> }

Makes sense. We also use the list elsewhere (has_capability()), but we
can easily replace that with two global flags to indicate if we have
the "clean" and "smudge" caps.

> And then we would call it via
>
>         check_and_write_capabilities(remote_caps, argv + 1, argc - 1);
>
> [...]
> > +static void command_loop(void)
> > +{
> > +     while (1) {
> > +             char *command = packet_key_val_read("command");
> > +             if (!command) {
> > +                     fprintf(logfile, "STOP\n");
> > +                     break;
> > +             }
> > +             fprintf(logfile, "IN: %s", command);
>
> We will also need to `fflush(logfile)` here, to imitate the Perl script's
> behavior more precisely.

I was somewhat intrigued as to why the flushes were needed in the Perl
script. But reading [1] and [2], now, it seems to have been an
oversight.

That is, Eric suggested splictily flushing stdout because it is a
pipe, but the author ended up erroneously disabling autoflush for
stdout too, so that's why we needed the flushes there. They later
acknowledged that and said that they would re-enabled it (see [2]),
but it seems to have been forgotten. So I think we can safely drop the
flush calls.

[1]: http://public-inbox.org/git/20160723072721.GA20875%40starla/
[2]: https://lore.kernel.org/git/7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com/

> > +
> > +             if (!strcmp(command, "list_available_blobs")) {
> > +                     struct hashmap_iter iter;
> > +                     struct strmap_entry *ent;
> > +                     struct string_list_item *str_item;
> > +                     struct string_list paths = STRING_LIST_INIT_NODUP;
> > +
> > +                     /* flush */
> > +                     if (packet_read_line(0, NULL))
> > +                             die("bad list_available_blobs end");
> > +
> > +                     strmap_for_each_entry(&delay, &iter, ent) {
> > +                             struct delay_entry *delay_entry = ent->value;
> > +                             if (!delay_entry->requested)
> > +                                     continue;
> > +                             delay_entry->count--;
> > +                             if (!strcmp(ent->key, "invalid-delay.a")) {
> > +                                     /* Send Git a pathname that was not delayed earlier */
> > +                                     packet_write_fmt(1, "pathname=unfiltered");
> > +                             }
> > +                             if (!strcmp(ent->key, "missing-delay.a")) {
> > +                                     /* Do not signal Git that this file is available */
> > +                             } else if (!delay_entry->count) {
> > +                                     string_list_insert(&paths, ent->key);
> > +                                     packet_write_fmt(1, "pathname=%s", ent->key);
> > +                             }
> > +                     }
> > +
> > +                     /* Print paths in sorted order. */
>
> The Perl script does not order them specifically. Do we really have to do
> that here?

It actually prints them in sorted order:

        foreach my $pathname ( sort keys %DELAY )

That is required because some test cases will compare the output using
this order.

> In any case, it is more performant to append the paths in an unsorted way
> and then sort them once in the end (that's O(N log(N)) instead of O(N^2)).

OK, will do.

> > +                     for_each_string_list_item(str_item, &paths)
> > +                             fprintf(logfile, " %s", str_item->string);
> > +                     string_list_clear(&paths, 0);
> > +
> > +                     packet_flush(1);
> > +
> > +                     fprintf(logfile, " [OK]\n");
> > +                     packet_write_fmt(1, "status=success");
> > +                     packet_flush(1);
>
> I know the Perl script uses an else here, but I'd much rather insert a
> `continue` at the end of the `list_available_blobs` clause and de-indent
> the remainder of the loop body.

Sure! I think we can take a step further and extract the if logic to a
separate function.

> > +             } else {
> > +                     char *buf, *output;
> > +                     int size;
> > +                     char *pathname;
> > +                     struct delay_entry *entry;
> > +                     struct strbuf input = STRBUF_INIT;
> > +
> > +                     pathname = packet_key_val_read("pathname");
> > +                     if (!pathname)
> > +                             die("unexpected EOF while expecting pathname");
> > +                     fprintf(logfile, " %s", pathname);
>
> Again, let's `fflush(logfile)` here.
>
> > +
> > +                     /* Read until flush */
> > +                     buf = packet_read_line(0, &size);
> > +                     while (buf) {
>
> Let's write this in more idiomatic C:
>
>                         while ((buf = packet_read_line(0, &size))) {
>
> > +                             if (!strcmp(buf, "can-delay=1")) {
> > +                                     entry = strmap_get(&delay, pathname);
> > +                                     if (entry && !entry->requested) {
> > +                                             entry->requested = 1;
> > +                                     } else if (!entry && always_delay) {
> > +                                             entry = xcalloc(1, sizeof(*entry));
> > +                                             entry->requested = 1;
> > +                                             entry->count = 1;
> > +                                             strmap_put(&delay, pathname, entry);
>
> I guess here is our chance to extend the signature of `add_delay_entry()`
> to accept a `requested` parameter, and to call that here.
>
> > +                                     }
> > +                             } else if (starts_with(buf, "ref=") ||
> > +                                        starts_with(buf, "treeish=") ||
> > +                                        starts_with(buf, "blob=")) {
> > +                                     fprintf(logfile, " %s", buf);
> > +                             } else {
> > +                                     /*
> > +                                      * In general, filters need to be graceful about
> > +                                      * new metadata, since it's documented that we
> > +                                      * can pass any key-value pairs, but for tests,
> > +                                      * let's be a little stricter.
> > +                                      */
> > +                                     die("Unknown message '%s'", buf);
> > +                             }
> > +                             buf = packet_read_line(0, &size);
> > +                     }
> > +
> > +
> > +                     read_packetized_to_strbuf(0, &input, 0);
> > +                     fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
>
> This reads _so much nicer_ than the Perl version!
>
> > +
> > +                     entry = strmap_get(&delay, pathname);
> > +                     if (entry && entry->output) {
> > +                             output = entry->output;
> > +                     } else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.r")) {
> > +                             output = "";
> > +                     } else if (!strcmp(command, "clean") && has_capability("clean")) {
> > +                             output = rot13(input.buf);
> > +                     } else if (!strcmp(command, "smudge") && has_capability("smudge")) {
> > +                             output = rot13(input.buf);
> > +                     } else {
> > +                             die("bad command '%s'", command);
> > +                     }
> > +
> > +                     if (!strcmp(pathname, "error.r")) {
> > +                             fprintf(logfile, "[ERROR]\n");
> > +                             packet_write_fmt(1, "status=error");
> > +                             packet_flush(1);
> > +                     } else if (!strcmp(pathname, "abort.r")) {
> > +                             fprintf(logfile, "[ABORT]\n");
> > +                             packet_write_fmt(1, "status=abort");
> > +                             packet_flush(1);
> > +                     } else if (!strcmp(command, "smudge") &&
> > +                                (entry = strmap_get(&delay, pathname)) &&
> > +                                entry->requested == 1) {
> > +                             fprintf(logfile, "[DELAYED]\n");
> > +                             packet_write_fmt(1, "status=delayed");
> > +                             packet_flush(1);
> > +                             entry->requested = 2;
> > +                             entry->output = xstrdup(output);
>
> We need to call `free(entry->output)` before that lest we leak memory, but
> only if `output` is not identical anyway:
>
>                                 if (entry->output != output) {
>                                         free(entry->output);
>                                         entry->output = xstrdup(output);
>                                 }

I think, entry->output will always be NULL here, since we only get
inside this if block after entry->requested has been set to 1 at the
top of the function; and, at that point, we haven't run ro13 yet.
Nevertheless, it doesn't hurt to add the free call anyway :)

>
> > +                     } else {
> > +                             int i, nr_packets;
> > +                             size_t output_len;
> > +                             struct strbuf sb = STRBUF_INIT;
> > +                             packet_write_fmt(1, "status=success");
> > +                             packet_flush(1);
> > +
> > +                             strbuf_addf(&sb, "%s-write-fail.r", command);
> > +                             if (!strcmp(pathname, sb.buf)) {
>
> We can easily avoid allocating the string just for comparing it:
>
>                                 const char *p;
>
>                                 if (skip_prefix(pathname, command, &p) &&
>                                     !strcmp(p, "-write-fail.r")) {
>
> > +                                     fprintf(logfile, "[WRITE FAIL]\n");
>
>                                         fflush(logfile) ;-)
>
> > +                                     die("%s write error", command);
> > +                             }
> > +
> > +                             output_len = strlen(output);
> > +                             fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
> > +
> > +                             if (write_packetized_from_buf_no_flush_count(output,
> > +                                     output_len, 1, &nr_packets))
> > +                                     die("failed to write buffer to stdout");
> > +                             packet_flush(1);
> > +
> > +                             for (i = 0; i < nr_packets; i++)
> > +                                     fprintf(logfile, ".");
>
> That's not quite the same as the Perl script does: it prints a '.'
> (without flushing, though) _every_ time it wrote a packet.
>
> If you want to emulate that, you will have to copy/edit that loop (and in
> that case, the insanely long-named function
> `write_packetized_from_buf_no_flush_count()` is unnecessary, too).

Hmm, I'm not sure we need to emulate that. I do dislike the huge
function name as well, but I also don't quite like to repeat code
copying that loop here...

> > +                             fprintf(logfile, " [OK]\n");
> > +
> > +                             packet_flush(1);
> > +                             strbuf_release(&sb);
> > +                     }
> > +                     free(pathname);
> > +                     strbuf_release(&input);
> > +             }
> > +             free(command);
> > +     }
> > +}
> > [...]
> > +static void packet_initialize(const char *name, int version)
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +     int size;
> > +     char *pkt_buf = packet_read_line(0, &size);
> > +
> > +     strbuf_addf(&sb, "%s-client", name);
> > +     if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
>
> We do not need the flexibility of the Perl package, where `name` is a
> parameter. We can hard-code `git-filter-client` here. I.e. something like
> this:
>
>         if (!pkt_buf || size != 17 ||
>             strncmp(pkt_buf, "git-filter-client", 17))

Good idea! Thanks. Perhaps, can't we do:

        if (!pkt_buf || strncmp(pkt_buf, "git-filter-client", size))

to avoid the hard-coded and possibly error-prone 17?

> > +             die("bad initialize: '%s'", xstrndup(pkt_buf, size));
> > +
> > +     strbuf_reset(&sb);
> > +     strbuf_addf(&sb, "version=%d", version);

Thanks for a very detailed review and great suggestions!
