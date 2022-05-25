Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B68C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 12:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiEYM7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEYM7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 08:59:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59225A2053
        for <git@vger.kernel.org>; Wed, 25 May 2022 05:59:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rq11so19413712ejc.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GQjmvdIIV7++HjwAZERklEOPaIrnFYyUo3cijY1ejaA=;
        b=kebo+aZjxGORWwm9f9ZvHLdS98AoTQhLB9Z51wOyMbeQpgnudxrWRpwNoCaISIfBaZ
         ahBa+l7r27YjGb4JRO3ir9hIoyaQZZJ7rQgzI9jFW/OlyAJoFIBrVejNYgMQJ1znH5Av
         /PchOR3TIbb4EX82ITgY6h0MaKV3g9wVFC2kfQMAIVl3Un+uuuleXHCtN9D8FKLbqzTl
         qx1rmGbvI8yElS2Thaf+2aSJHNpUNuVINI68VBwjxjpmjlUk6Ly9qii479/q0B+JUEb1
         /235tU3Iqpk1Fs5qiw3PCpQ6Ogcz5uidH7Unvx17nkdTp01MHFoTDZHJpL/CZ7CKhLmS
         FbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GQjmvdIIV7++HjwAZERklEOPaIrnFYyUo3cijY1ejaA=;
        b=4SvBx2l1e0FLjAyuJBGezxq1mMAksv/aoqLgmVB8KQh+LPsW9rm2S7BK26X7kglOoF
         XjMlLdiZ/6zqeYwhIJ67kAHBwnHLNFqgRh6swcx/piP+04Oa2+AC+B74hUzp/mvbboGn
         dBS9FTQf3JNEFJBCz4BjoqQlMxow3HEB7fCZ0fdnMt3/CpMhEDQ6yt/+C/EnV0fRFxsx
         XXXzp9GZHe09/PUDXNvgLbgLOVaB31KxZ9F4oyusVbU7/0aiuqWFT4pZOgu04aJXTrqC
         6kP7r8fiH58CvKOwO7FwSngNUtsvk8WVECKXSl+c2Pp6KaMF5dyUny5DiMz/8w9SbAwt
         ysgg==
X-Gm-Message-State: AOAM531BMQ6hMuArkMSKKbXnpdLFjz0u6Ap+jeoN+ceOLz1acOQ563aV
        q0dHqDQ1+thP6rIVcMxEEcQ=
X-Google-Smtp-Source: ABdhPJzqJBNmUOueVFWRs93bTxO6sPe1jh1azJ5M+TDsp8J37sVEFStskFZ2Pxx2U+l7DP9TpZUubA==
X-Received: by 2002:a17:907:7da2:b0:6f4:dcb8:7b7 with SMTP id oz34-20020a1709077da200b006f4dcb807b7mr29054718ejc.443.1653483588631;
        Wed, 25 May 2022 05:59:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709060a8700b006fec3b2e4f3sm4180146ejf.205.2022.05.25.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:59:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntqc7-003ngG-5z;
        Wed, 25 May 2022 14:59:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
Date:   Wed, 25 May 2022 14:48:36 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
 <220524.86fskzxsvq.gmgdl@evledraar.gmail.com> <xmqq35gyhf11.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
 <xmqqczg2eeth.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205251208560.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205251208560.352@tvgsbejvaqbjf.bet>
Message-ID: <220525.86k0a9u5rw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 24 May 2022, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Tue, 24 May 2022, Junio C Hamano wrote:
>> >
>> >> The "clear slot->finished", by the way, is what I think is the right
>> >> thing to do, especially that the objective is to squelch the false
>> >> positive warning from a new compiler.  If there is a way to annotate
>> >> the line for the compiler to tell it not to warn about it, that would
>> >> have been even better.
>> >
>> > We could do something like this:
>>
>> Yuck.
>>
>> > -- snip --
>> > diff --git a/http.c b/http.c
>> > index b08795715f8a..2ac8d51d3668 100644
>> > --- a/http.c
>> > +++ b/http.c
>> > @@ -1365,7 +1365,14 @@ void run_active_slot(struct active_request_slot *slot)
>> >  	struct timeval select_timeout;
>> >  	int finished = 0;
>> >
>> > +#if __GNUC__ >= 12
>> > +#pragma GCC diagnostic push
>> > +#pragma GCC diagnostic ignored "-Wdangling-pointer"
>> > +#endif
>> >  	slot->finished = &finished;
>> > +#if __GNUC__ >= 12
>> > +#pragma GCC diagnostic pop
>> > +#endif
>> >  	while (!finished) {
>> >  		step_active_slots();
>> > -- snap --
>> >
>> > That's quite ugly, though. And what's worse, it is pretty unreadable, too.
>>
>> Yes, very ugly.  Would an unconditional
>>
>> 	slot->finished = NULL;
>>
>> at the end squelch the warning?
>
> No, unfortunately not:
> https://github.com/dscho/git/actions/runs/2383492484 

Yes it does. Didn't you just have a PBCAK between writing that test &
pushing it? Your
https://github.com/dscho/git/blob/tmp/http.c#L1370-L1371 shows that you
didn't make that edit.

This on top of "seen" makes the warning go away:
	
	-       if (slot->finished == &finished)
	-               slot->finished = NULL;
	+       slot->finished = NULL;

This is also all covered in the initial thread from back in January,
which if you're slowly re-discovering the learnings from there I
encourage you to read in more detail... :)

> As you mentioned elsewhere, the error is clearly about the assignment in
> the first place, and it does not matter that the function will rectify the
> situation. It's the correct thing to do for the compiler, too: since
> `slot->finished` already has the pointer, and since the
> `active_request_slot` struct is declared globally, code outside the
> current file might squirrel that pointer away for later use.

Per the above this isn't true, and in some side-thread replies (and in
the initial thread) I've linked to the GCC code in question. NULL-ing
the slot is sufficient, it doesn't matter that the struct it's in
survives the function, just that the pointer isn't exposed.

>> Or there is a way to say "we make all warnings into errors with
>> -Werror, but we do not want to turn this dangling-pointer warning to
>> an error, because it has false positives"?
>>
>> Or we could add "-Wno-dangling-pointer" globally, perhaps.
>
> I'd like to avoid that because it would quite likely hide legitimate
> issues elsewhere.
>
> It currently seems to be the easiest solution to simply turn the local
> variable into a heap variable:
>
> -- snip --
> diff --git a/http.c b/http.c
> index f92859f43fa..0712debd558 100644
> --- a/http.c
> +++ b/http.c
> @@ -1327,10 +1327,10 @@ void run_active_slot(struct active_request_slot *slot)
>  	fd_set excfds;
>  	int max_fd;
>  	struct timeval select_timeout;
> -	int finished = 0;
> +	int *finished = xcalloc(1, sizeof(int));
>
> -	slot->finished = &finished;
> -	while (!finished) {
> +	slot->finished = finished;
> +	while (!*finished) {
>  		step_active_slots();
>
>  		if (slot->in_use) {
> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +	if (slot->finished == finished)
> +		slot->finished = NULL;
> +	free(finished);
>  }

Also, if we were going to tweak this extensively I'd think this slightly
larger POC patch would be a better direction, i.e. we don't need a
pointer at all, we're just (ab)using it for a tri-state NULL/0/1, why
not just use an enum?

I think the "if it's what we just set it to" is just cargo-culting, is
there anything to show that run_active_slot() is reentrant? Wouldn't we
be better off with a static variable + BUG() that we increment/decremant
and panic if it's anything but 0 and 1 if we'd like to add paranoia
around that?

diff --git a/http-walker.c b/http-walker.c
index b8f0f98ae14..26184a82ddb 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -225,13 +225,13 @@ static void process_alternates_response(void *callback_data)
 					 alt_req->url->buf);
 			active_requests++;
 			slot->in_use = 1;
-			if (slot->finished)
-				(*slot->finished) = 0;
+			if (slot->f != FIN_UNSET)
+                            slot->f = FIN_NO;
 			if (!start_active_slot(slot)) {
 				cdata->got_alternates = -1;
 				slot->in_use = 0;
-				if (slot->finished)
-					(*slot->finished) = 1;
+                                if (slot->f != FIN_UNSET)
+                                    slot->f = FIN_YES;
 			}
 			return;
 		}
diff --git a/http.c b/http.c
index b148468b267..845dd40768c 100644
--- a/http.c
+++ b/http.c
@@ -197,8 +197,8 @@ static void finish_active_slot(struct active_request_slot *slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
-	if (slot->finished)
-		(*slot->finished) = 1;
+	if (slot->f != FIN_UNSET)
+		slot->f = FIN_YES;
 
 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results) {
@@ -1204,7 +1204,7 @@ struct active_request_slot *get_active_slot(void)
 	active_requests++;
 	slot->in_use = 1;
 	slot->results = NULL;
-	slot->finished = NULL;
+	slot->f = FIN_UNSET;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
@@ -1327,10 +1327,9 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished = 0;
 
-	slot->finished = &finished;
-	while (!finished) {
+	slot->f = FIN_NO;
+	while (slot->f == FIN_NO) {
 		step_active_slots();
 
 		if (slot->in_use) {
diff --git a/http.h b/http.h
index df1590e53a4..fc664d90bc9 100644
--- a/http.h
+++ b/http.h
@@ -19,12 +19,13 @@ struct slot_results {
 	long http_connectcode;
 };
 
+enum fin { FIN_UNSET, FIN_NO, FIN_YES };
 struct active_request_slot {
 	CURL *curl;
 	int in_use;
 	CURLcode curl_result;
 	long http_code;
-	int *finished;
+	enum fin f;
 	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
