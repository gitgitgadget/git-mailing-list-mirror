Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97819C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 02:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBICKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBICKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 21:10:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1FC669
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 18:10:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u22so2280233ejj.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E42TGhaDAk3ah8u2V9PMjWSovIYHE6otiHj8DKtx28A=;
        b=HzV6ojcwSs+dmR8eYwIlmnvAba6ljmDL4CQu8PaRe4SSCktWToqEBubFMy1L4juQOy
         RqYjZjeX5BsAfaZFbkRjrSLy/iyCWajYDvOt9mOtV0e6mWzKMNHqZldmhnRGSxrZ4VGu
         u2dJKGrxWDWfC5NtJcGbfmBSgtPTKiMtolf/W+0bMCd96sbMAl7/tlDlJdW/lhayeJUp
         HPcElkirPt2QStwxw5wYb0LON/pEcXUrD3fORQG6wTPcvelamp6/6bFLPpVtlWXwB1d7
         e9nCSWmqy5RVLjc8PQmicBo8Fs+p7Vg382TZy7v9ztr3yaZmsDKucdd2m3PSuFdyIWUv
         W64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E42TGhaDAk3ah8u2V9PMjWSovIYHE6otiHj8DKtx28A=;
        b=jO47abfUtYVVpKzk1tvUan2+QwxJriWItpJ5MSIVFiIYzrD1SX5lzkpL5uQQl1mSjz
         x2b5LUXEE9CqwOncp6QEFTIlyggV6rYd+4wRt5DU9jS1+3ixVs4uzaU5XZ3zlzWYZtGa
         aPgXGwXKmcwlpjcUmS7w7laBHvwmTapZcG26DocZxwlQ5PCuRYF3AqhtZbDrCYkSRKkn
         qacEbkywuL1/z2WxJD10wFW/MepdTBL2l0FTfhUJnp60HVKueTNsg4/KB0t/1ODu/Zur
         AOaPG6vvw2P4Wy1OYAsDwmKF7VOFhMC1yXhSDRNIb6pRxNt7i/3c+bfp4Hfj/hR72oHM
         UGRw==
X-Gm-Message-State: AO0yUKUg2TfDgG3wIi2RJj4BXgH2rWfM4Qaj1sLRDIGA9WrDaGcb7EVd
        GdHjuPsqC+qIeUzLYPkFKWU=
X-Google-Smtp-Source: AK7set8753IROxE1plGIp8vJXXsnXhWl87pS63IAt1FztnPW0KEvpvoCWBnls6SqbtjFvlgI/LExyQ==
X-Received: by 2002:a17:907:7e95:b0:8aa:af33:72d6 with SMTP id qb21-20020a1709077e9500b008aaaf3372d6mr8623097ejc.45.1675908634442;
        Wed, 08 Feb 2023 18:10:34 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906150c00b00888d593ce76sm222726ejd.72.2023.02.08.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:10:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPwOP-001bYv-0o;
        Thu, 09 Feb 2023 03:10:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] hook: support a --to-stdin=<path> option
Date:   Thu, 09 Feb 2023 02:56:24 +0100
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
 <patch-v2-5.5-b4e02f41194-20230208T191924Z-avarab@gmail.com>
 <xmqqpmajq2cx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqpmajq2cx.fsf@gitster.g>
Message-ID: <230209.86y1p7y4fa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> From: Emily Shaffer <emilyshaffer@google.com>
>>
>> Expose the "path_to_stdin" API added in the preceding commit in the
>> "git hook run" command.
>>
>> For now we won't be using this command interface outside of the tests,
>> but exposing this functionality makes it easier to test the hook
>> API. The plan is to use this to extend the "sendemail-validate"
>> hook[1][2].
>
> OK.
>
> What does it take to tackle the obvious leftover bits of [4/5]?  Use
> tempfile API to allocate a temporary file, slurp the input and close
> it, and then use the "path_to_stdin" feature to spawn the hook?

You did ask for it :)

The below is something I wrote for the end of the initial v2 CL, but
then decided it was way too long and dropped it.

The tl;dr is that no, that would be the shortest way forward, and
arguably what we should do now.

But those hooks currently print straight to the pipe, so having the API
force them to use a tempfile would suck.

But since this is all going for supporting N hooks in parallel the next
step requires an API that's future-proofing the feeding of the same
content to multiple hooks.

So, without further adieu, that dropped part of the v2 CL:=20

The rest of this is a large digression about the future API design of
this topic, please don't read ahead unless you're very curious about
that (mainly I wanted to brain-dump this somewhere).

I considered expanding this series to include the rest of the
remaining "post-rewrite" hook in sequencer.c, but as that needs at
least a couple of prep patches to expand the API I've left it out for
now.

The main reason I didn't include (aside from the "let's start small"
of this topic) it is that I still don't like the API we'll eventually
need for the parallel hooks that take "stdin", and would like to mull
it over a bit.

What comes after this series eventually wants to convert these hooks
from (pseudocode):

	struct child_process proc =3D CHILD_PROCESS_INIT;
	[...]
	start_command(&proc);
	[...]
	for item in transaction:
		write_in_full(proc.in, item, strlen(item));

To e.g.:

	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;

	[...]

        opt.feed_pipe =3D pipe_from_string_list;
        opt.feed_pipe_ctx =3D &to_stdin;

	[...]

	for item in transaction:
		string_list_append(&to_stdin, item);

	run_hooks_opt("some-hook", &opt);
	string_list_clear(&to_stdin, 0);

The reason is that if we're producing data for stdin we'll need to
give it to N hooks. For this topic we neatly side-step that with a
"to-stdin", as Junio notes in [3] and [4].

I think even that is arguably a bit ugly, but it's all internally
changable uglyness, i.e. for the "sendemail-validate" whether we feed
"git hook" with content on stdin or are forced to create a file and
feed it with "--to-stdin" is something we can change later.

But the answer to the question raised in [4] is that we'll eventually
need something like the above. But I don't like it, because:

A) The currently proposed API[5] wants to represent lines to the hooks
   are a "struct string_list", so you add "\n"-less items to it, and
   we'll always print "%s\n" for each item.

   This is an arbitrary limitation over the write_in_full() we do now,
   and will be a hassle e.g. if you have already prepared content,
   you'll first need to line-split it.

   Maybe I'm missing some reason for why the hook interface needs to
   intrinsically promise that it'll be doing write()'s to the hooks
   ending in \n's, but right now I don't see that, we could leave that
   up to each hook, and if they're spewing content larger than that
   the hook itself should just be line-buffering if they care about
   the distinction.

B) Even if we internally line-split a "struct string_list *" is just a
   bad fit as we lose the string size, we should pass something that
   give us a "size_t len" (which we could stuff in the "util" field,
   but...)

C) We need to buffer up the stdin in full before we feed the first
   line to the hook, which seems to me to be an API design that
   creates the problem the second paragraph of [5] claims to be trying
   to avoid. I.e. "simply taking a string_list or strbuf is not as
   scalable as using a callback".

   That would be true if the result of the callback were streamed to
   the N hooks we have, but it's not the case. It's a callback
   mechanism that amounts to just handing off a big "struct
   string_list", which we need to fully populate before we start the
   hook.

D) Most importantly, the API seems to be structured around a problem
   we don't actually have.

   The more general problem *could be* that you'd want to feed N hooks
   with the same content, we ourselves get that content streamed into
   us on "stdin", and therefore need to either buffer it in full
   up-front, or as we read it re-spew it into the N hooks we're
   executing.

   But e.g. for the "reference-transaction" hook all we need to
   support N hooks is to allocate a single "size_t pos" for them, as
   when we're executing them we have a "struct ref_transaction
   *transaction" that doesn't change for the duration of the hook. The
   same goes for the "pre-push.

   Actually, the only eventual API users that really could have used
   buffering to ensure consistent results won't use the buffering
   API. E.g. for the "post-rewrite" and "rebase" hooks we consume a
   file in ".git/" to give to the hooks on stdin. Currently (and still
   with this topic) we'll only have one hook, so the file's content
   will always be the same.

   But if we were being paranoid we'd buffer it up, so that we could
   ensure that our N hooks all get the same input, but for the API
   users that could get a benefit from that we don't use it, but only
   for those that are guaranteed not to need it.

So before the next iteration I'll try to find some time to play with
that. I.e. I think we can rip out the whole "struct string_list" feeder,
and just have an eventual mechanism for each of the N hooks to
init/release their "feed stdin" state with callbacks, and to save away
their state in their own "void *".

Then e.g. for the reference-transaction we'd just allocate a "size_t
pos" per hook, and then just spew content at them on the fly from the
transaction struct, no pre-generation necessary.

Such an interface will nicely support streaming without pre-buffering
delay, and could even run lock-less while multi-threaded (the source
data being const, and (almost) all state per-thread.

The interface would then be general enough to support
pre-slurping/buffering content at the start, and then streaming to N
hooks, e.g. for the "read a file, but guarantee that everyone gets the
same version". We won't need a string list for that, at most a strbuf,
but maybe we can just mmap() those...

3. https://lore.kernel.org/git/xmqqy1pskfo6.fsf@gitster.g/
4. https://lore.kernel.org/git/xmqqtu0gkaye.fsf@gitster.g/
5. https://lore.kernel.org/git/patch-v5-24.36-bb119fa7cc0-20210902T125110Z-=
avarab@gmail.com/
