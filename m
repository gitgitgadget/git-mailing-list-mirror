Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E2C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFCE60E75
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhJYW4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhJYW4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:56:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D2C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:54:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so162051wmj.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6GR+qDqtBpLyDOPaTLZQ7vWRCCsr+ZBPzgmKIvq/OgY=;
        b=etM1bnQm4UO3ZJnLIwDdsmGzNVMitngmZYv8p9QBn+nuN9KyTqoYEbjbHzVBx/J3Ek
         HnNFGgMt/C7/FTSOCVAvwlMuoyfvCNgTMhVMRYOvFGe9lYE+loTERmP5cQNnVM3OEqDc
         Pr/sQ9znImltKQcNnm9WLg7ZWKc8EThtr9x8Vs7fAy7Uo0kya2enyWlJt6bY7eachqnO
         Cpug4IaiS63YSYSOu095V8OPDrMMF/pF6xbbrFS+AyIx1WNFkcanBstlnv92GqpclkSA
         yN6hxOaQAJ+g0VLz2Chb+VGIDLS7iXl1WlDUV7I2vEWFekax9Hm+fwsuVuQcwDHkej06
         Jc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6GR+qDqtBpLyDOPaTLZQ7vWRCCsr+ZBPzgmKIvq/OgY=;
        b=6NqPQWL5dL67BnDneGSU8kry09sPwzsVfn5eKiFVNkgFkbT3Cwvhn22L8492dH5tAI
         5oey/e1ZSlGcTqpNNKIzN5l0ZbmeXJpr1VREocTH3cX1+kivX+U2opm5kbQkho2/vwdg
         9Fj38qG+UibUxDVDYAJjCAXFxnvDYslVsEFEN7hPpfKGDlfm1RXXiBpExGyJOIhgtAY4
         nRS1DNQRu0Qys02loTtwcoVIrK0PAjbBM2JV8+h+zUzct0GONsLcFqiXYT1tCW/KT/TI
         wY7caUwXx499O+hmK+pIRihdi7BmdCGNBfsSbo372CWpbWR1+7GnEBO1VxbpqiKfNZQH
         flcg==
X-Gm-Message-State: AOAM530aI5/seVzYr+TL4nuTIaiHts3Ho9JEEceGccIg6xPfcjUVqrVv
        cExUmmE8HVFmc2jw6YTBJn8dUhtDXdJ2cQ==
X-Google-Smtp-Source: ABdhPJyhC0A1ZeAeIrIELeDlUEE+7c6+fjSSnMRX8rOJzH5kviOQ79tNSXA+6+FycNsQe+nVq+1T1A==
X-Received: by 2002:a7b:cc87:: with SMTP id p7mr3340042wma.26.1635202467393;
        Mon, 25 Oct 2021 15:54:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v191sm17406412wme.36.2021.10.25.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:54:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mf8rJ-001hH8-Ui;
        Tue, 26 Oct 2021 00:54:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     git@vger.kernel.org, carenas@gmail.com, gitster@pobox.com,
        bagasdotme@gmail.com
Subject: Re: [PATCH v8 0/2] send-email: shell completion improvements
Date:   Tue, 26 Oct 2021 00:44:37 +0200
References: <87fst7lkjx.fsf@evledraar.gmail.com>
 <20211025212707.188151-1-tbperrotta@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211025212707.188151-1-tbperrotta@gmail.com>
Message-ID: <211026.86o87c1zry.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Thiago Perrotta wrote:

>> ...I think that re-indentation is better left alone for the patch
>> readability.
>
> Reverted the `GetOptions` indentation. Noise is now gone :-)

Thanks.

>> First, in your 1/3 you're adding a \n, but in 2/3 we end up with \n\n. I
>> think you can just skip 1/3, maybe mention "how it also has a "\n" in
>> the commit message.
>
> I don't quite see how this would fit into the commit message. A comment in the
> code seems to fit better to account for this detail. That's what I did, but if
> you still disagree, please elaborate where in the commit message this sentence
> should be added.

Makes sense I think, will take a look.

>> You then strip out "--" arguments from the combined list, but isn't this
>> something we do need to emit? I.e. it's used as syntax by the bash
>> completion isn't it? (I just skimmed the relevant C code in
>> parse-options.c).
>
> I interpreted that standalone `--` as an extraneous / useless token. If it's
> there intentionally, then I am reverting my stripping of it. At the end of the
> day whether to include it or not is a small detail, but FYI, when I do:
>
>   $ git clone -<TAB>
>
> in bash, nothing happens. I would have expected it to be expanded to "--"
> because of the explicit "--", but it doesn't. Therefore my conclusion is that
> "--" in the output of "--git-completion-helper" is useless. Am I missing
> something? What would be the function of the standalone "--" then?
>
> From my local testing, whether the options are sorted or not, whether
> they are repeated or not, whether they follow a specific order with
> respect to "--" or not, all of those details seem not to matter. Bash
> completion seems to handle all of those cases just fine interactively.

Digging a bit more: It's for folding away options that are negated, not
for completing "-<TAB>". See the examples at b221b5ab9b9 (completion:
collapse extra --no-.. options, 2018-06-06).

> In fact, here's another example:
>
> $ git init --git-completion-helper | tr ' ' '\n'  | grep -C1 '^--$'
> --no-template
> --
> --no-bare
>
> ...there are --no-* options both _before_ and _after_ the --. I really
> cannot see the point of the -- in the output, it seems to be just noise.

Right, because some --no-whatever we define because we've got a
--whatever and it's boolean, but for others we've got a --no-whatever as
the primary, as in th case of --no-template..

> I readded -- to the output anyway since you requested it, but if it
> needs to follow a certain spec w.r.t. ordering, we should have tests for
> it. This specific part (the -- and the --no- order thing) of the commit
> is something I am not keen to doing though, at least not in this patch
> series; sorry, it already goes far beyond the scope of my original
> intent. Anything else you ask for that is inline with the original
> intent (like generating options programatically instead of hard-coding
> them) I am fine with though, and in fact I believe I have addressed all
> comments so far, if there's anything else I may have missed let me know.

Yeah sorry about the confusion so far, it's also been a voyage of
discovery for me :)

This time around I tested with:

diff --git a/parse-options.c b/parse-options.c
index 6e0535bdaad..d659309c5e7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -515,8 +515,6 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 static void show_negated_gitcomp(const struct option *opts, int show_all,
                                 int nr_noopts)
 {
-       int printed_dashdash = 0;
-
        for (; opts->type != OPTION_END; opts++) {
                int has_unset_form = 0;
                const char *name;
@@ -551,10 +549,6 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
                        if (nr_noopts < 0)
                                printf(" --%s", name);
                } else if (nr_noopts >= 0) {
-                       if (nr_noopts && !printed_dashdash) {
-                               printf(" --");
-                               printed_dashdash = 1;
-                       }
                        printf(" --no-%s", opts->long_name);
                        nr_noopts++;
                }

Which will fail a test in t/t9902-completion.sh showing this specific
behavior.
