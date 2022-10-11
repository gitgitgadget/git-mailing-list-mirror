Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53479C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJKN3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJKN3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:29:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D9B7EE
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:29:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u21so20083009edi.9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cr9w/LsFhKyplhrKSzZh3QBXB6fbQoNO33VifbwVARE=;
        b=PJ0bQk+BTAUwx6vni7YDYm1dWUWvh5VxK62DiIM7vay5MwDcTgPvYp2QH43J1i4yhw
         FA5jTnl1BvrWpSb1NmeP8IYpVfifpakbOOWh26aXliXNUiNFWQYu8bG100obfSEHbSlf
         SZWWXFRdlJ7ptm4T4bGBhp/rRKoeAUKFNH6cpp6dBHx1s+a9UHqZ6RfiSzOJUoZzNpSH
         4n7EAhj8CNR8B2bGY3K+mO7HdZyf9h8z1nloi4nsz1ddcfIAiYr1yRKYqn3nQBtGWvR1
         zOYb91XRvMm60odnxpka+8ckHmGjCKbEgNbHBlvXYkQXyee1fEiuohAb/Bdyv5zIpKFt
         P7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cr9w/LsFhKyplhrKSzZh3QBXB6fbQoNO33VifbwVARE=;
        b=pZ5c9800PpOKmWqydlusFhwpuw/uMfRn3DvFOVwrJjPX4m1szg8IOghrUNXOupr6Py
         meVwJg248AtED6etRsb4q3GHXo1TZPqsb0jd8FpeBxnHSHU2cp+c5TNzaEkwjWnQ4bKc
         FTBGXBh8Y8TVrpRy132YzwUqtViAJGWD1YXuINjZYg68JpQh35mz5cuUQpleFUivJMyB
         lNHAYj+lVZDgs/y729zgmeqI5SoQK4SAfpTU8vS5SyPzqxH06/aBP6r9NkKC10PLZzlZ
         s+pyS+5+MP3DU/PN0ODxjnPdWSJLqJQfNVSQi2vnwaqyAciGfYdyl0LmI/aU7qi84oKG
         83NA==
X-Gm-Message-State: ACrzQf3vORWDDLVsKuMJQtEchAkbmw+8fA+a91vEJZVlTHn5ccdA0hnx
        wULsZdGErHHnFyXrRGnCHZc=
X-Google-Smtp-Source: AMsMyM5+cUJk4bRF5j8qiQJNBt9wGmuV5WHUuOTgyiiaepKj6G8+khC43BWIK5i27XIIFGx+KJzo2g==
X-Received: by 2002:a05:6402:10c2:b0:45c:3c87:721f with SMTP id p2-20020a05640210c200b0045c3c87721fmr7679256edu.251.1665494982734;
        Tue, 11 Oct 2022 06:29:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00770880dfc4fsm972308ejc.29.2022.10.11.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:29:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiFKG-003uZC-2d;
        Tue, 11 Oct 2022 15:29:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
Date:   Tue, 11 Oct 2022 14:52:11 +0200
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
 <cb9f8321-d9e6-6f80-a590-a9ad49c7f557@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cb9f8321-d9e6-6f80-a590-a9ad49c7f557@jeffhostetler.com>
Message-ID: <221011.86lepmo5dn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Jeff Hostetler wrote:

> On 10/6/22 9:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Since ee4512ed481 (trace2: create new combined trace facility,
>> 2019-02-22) the "thread_name" member of "struct tr2tls_thread_ctx" has
>> been copied from the caller, but those callers have always passed a
>> constant string:
>> 	$ git -P grep '^\s*trace2_thread_start\('
>> 	Documentation/technical/api-trace2.txt: trace2_thread_start("preload_th=
read");
>> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-health");
>> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-listen");
>> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-worker=
");
>> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-accept=
");
>> 	compat/simple-ipc/ipc-win32.c:  trace2_thread_start("ipc-server");
>> 	t/helper/test-fsmonitor-client.c:       trace2_thread_start("hammer");
>> 	t/helper/test-simple-ipc.c:     trace2_thread_start("multiple");
>> This isn't needed for optimization, but apparently[1] there's been
>> some confusion about the non-const-ness of the previous "struct
>> strbuf".
>> Using the caller's string here makes this more straightforward, as
>> it's now clear that we're not dynamically constructing these. It's
>> also what the progress API does with its "title" string.
>> Since we know we're hardcoding these thread names let's BUG() out
>> when
>> we see that the length of the name plus the length of the prefix would
>> exceed the maximum length for the "perf" format.
>> 1. https://lore.kernel.org/git/82f1672e180afcd876505a4354bd9952f70db49e.=
1664900407.git.gitgitgadget@gmail.com/
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> PLEASE DON'T DO THIS.
>
> If you don't like my patch, fine.  Let's discuss it.  But DON'T submit
> a new one to replace it.  Or worse, try to inject it into the middle
> of an existing series.

I'm not seeking to replace your series, or to tick you off, sorry if it
came across like that.

I just thought (and still think) that we were at a point in the
discussion where it seemed clear that I wasn't quite managing to get
across to you what I meant, so sending that in the form of working code
should clarify things.

Per Junio's "That's nice to learn, indeed." in
<xmqqo7uoh1q0.fsf@gitster.g> it seems to have had that intended effect
on him. It's marked as an RFC, so not-a-thing-to-pick-up, but just for
discussion.

> Yes, current callers are passing a string literal and thread-start
> could take a "const char*" to it, but there is no way to guarantee
> that that is safe if someone decides to dynamically construct their
> thread-name and pass it in (since we don't know the lifetime of that
> pointer).  So it is safer to copy it into the thread context so that
> it can be used by later trace messages.

I think that's a defensible opinion, but I also think it's fair to say
that:

 * This seems to be *the* motivation for why you're doing things the way
   you're doing them, and at least to this reviewer that wasn't really
   coming across...

 * ...nor the context of why we'd need that sort of guarded API in this
   case, but not e.g. for another widely-used API like start_progress().

   See 791afae2924 (progress.c tests: make start/stop commands on stdin,
   2022-02-03) for a case where we're using that where we need to work
   around its behavior (and no, I didn't make the underlying API that
   way, it's just a commit of mine where I'm having to work with it).

I think designing our internal APIs to not be quite so guarded is fine,
and we do that in various other contexts (progress, etc.). We control
both the API and its users, so just leaving a "this must be a constant"
should be enough.

But even if you want to be paranoid about it there's much easier ways to
do that which give you more of the safety you seem to want. E.g. this on
top of master (and easily adjusted on top of this RFC patch):
=09
	diff --git a/trace2.h b/trace2.h
	index 88d906ea830..1c3a98fb30f 100644
	--- a/trace2.h
	+++ b/trace2.h
	@@ -306,12 +306,18 @@ void trace2_exec_result_fl(const char *file, int lin=
e, int exec_id, int code);
	  *
	  * Thread names should be descriptive, like "preload_index".
	  * Thread names will be decorated with an instance number automatically.
	+ * Thread names must point to data that won't change after it's passed
	+ * into this function. Once trace2_thread_exit() is called it can be
	+ * free'd.
	  */
	 void trace2_thread_start_fl(const char *file, int line,
	 			    const char *thread_name);
=09=20
	+/*
	+ * The "" is to assure us that API users pass only constant strings
	+ */
	 #define trace2_thread_start(thread_name) \
	-	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
	+	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name ""))
=09=20
	 /*
	  * Emit a 'thread_exit' event.  This must be called from inside the

Will pass, as we only pass it constant strings, but if someone were to
pass a variable it'll blow up, at which point we could provide some
inline macro/function that would do the required xstrdup().

All of which I think is *still* being too paranoid, but which I think
*if* you want the paranoia is much more explicit about what we're trying
to accomplish with said paranoida, and where the compiler will help you.

> [...]
>> +void jw_strbuf_add_thread_name(struct strbuf *buf, const char *thread_n=
ame,
>> +			       int thread_id);
>> +void jw_object_string_thread(struct json_writer *jw, const char *thread=
_name,
>> +			     int thread_id);
>
> This violates a separation of concerns.  json-writer is ONLY concerned
> with formatting valid JSON from basic data types.  It does not know
> about threads or thread contexts.
>
> `js_strbuf_add_thread_name()` also violates the json-writer conventions
> -- that it takes a "struct json_writer *" pointer.  There is nothing
> about JSON here.
>
> You might write a helper (inside of tr2_tgt_event.c) that formats a
> thread-name from the id and hint, but that is specific to the Event
> target -- not to JSON, nor the JSON writer.

That's fair, more on that below.

> But then again, why make every trace message from every target format
> that "th%0d:%s" when we could save some time and format it in the
> thread-start and just USE it.

If you actually care about this being fasterer -- and only reason for
posting this RFC patch is to try to tease out *why* that is -- then this
part of your concern can be trivially mitigated with having a struct
member like:

	char thread_id_str[3];

We'd then just snprintf() into that in tr2tls_create_self(). Then when
we print the thread to the JSON or log you'd do so without any
strbuf_addf(), just a strbuf_addstr() or strbuf_add().

I think that micro-optimization isn't needed in this case, but it *is*
easy to do .

> [...]
>> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_name,
>>   	}
>>     	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
>> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
>> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
>> -		    event_name);
>> +	oldlen =3D buf->len;
>> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
>
> This stands out as very wrong.  The _Perf target does not use JSON
> at all, yet here we are calling a jw_ routine.  Again, that code is
> in the wrong place.
>
> I'm going to clip the rest of this commit, since the above invalidates
> it.

A helper function being in the wrong place invalidates the whole commit?

I think you're right that this jw_strbuf_add_thread_name() helper should
live somewhere else, probably in thread-utils.c.

So, pretending that it's in whatever place you'd be comfortable with,
and using whatever naming convention you'd prefer. What do you think
about the rest of the commit?

You snippet it just as you were getting to the meaty part of it, namely:

 * With this approach we can BUG() out as soon as we try to construct
   the main thread if its name is bad, we don't need to wait until
   runtime when a child thread runs into the limit.

 * We no longer need the whole thread-creation-time string duplication,
   associated storage in the struct etc.

 * That struct member is "const", addresing your initial concern of
   (from the upthread commit message):

	Using a (non-const) `strbuf` structure for it caused some
	confusion in the past because it implied that someone could
	rename a thread after it was created.  That usage was not
	intended.

   Although I think (and I'm possibly misreading it) that your
   commentary here is saying that even that's not enough, i.e. we can't
   just leave it at a "const" here, but must assume that an API user
   will disregard that and modify it after it's passed to us anyway.
