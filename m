Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EDC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A4B61056
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhJLJSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhJLJSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:18:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709FEC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 02:16:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so78536210edt.7
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G3C7iwabGBHDkoB8fROS6DqwdfDyLOFW/I4HgyfKz14=;
        b=IxH6ebBKxMkFQWdNif4ksl8YgNEiDIkdk8V/PqTWj2fJ1r0Sxu8jkR+f+rT4UYi4PX
         I8jc3fu4Bz5sqoyf0B7tlegXXyDKeF3z8KGxZUqaH3VUzmNU710lZE4pI5dDulIBBHhA
         dzRh8NBrarVyo9KhPYRp6k0f++P9fvnXsW0qvtf7gXITwQJgPGi34KUtkRgCWJAKbz+u
         6Zv88GN7789fYcfUJrbOh60Ni5SaNQ6gZUIaACWONk2iL9OOQQfrvnv0GhqFwDiwGl7N
         eDMZxvrkDtTG12KK+c/T09qZuF+m0FrYv/J2Bz72C/PizqgZFGPkk8YcTSiSVaRIB/Wg
         7Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G3C7iwabGBHDkoB8fROS6DqwdfDyLOFW/I4HgyfKz14=;
        b=R4wkzMIMbpTImVnRZUbeZ5YX4KR6t88rkxEHyCvwYR1dGamjcFcorh8+smQN1Jk/Bc
         G52vqt+2dHEkV5JFp9slDUO85z5URnHsr5tfdzfe1cTKmlKyuwdvfJpcC80LteL+BMwU
         Y4WFCA/5+mOJDUb4AcEOI8UOCYQEYFSMK4rxPQT/l4P46fxKMyuk8TSles8kK/Ojv5aN
         GSwlbTZND6fmBdve7CVE8I1Rur7ee2gryPz8woVBXbiLxVzzYRnOBJRz5I6WIJqV16Om
         FdPeYaWNs4dS6PxPL3nECqfTLnTKd13kj8BfhABEbNm/7qs407yDHswZEbiWPNKitwWM
         0MUw==
X-Gm-Message-State: AOAM531UPk4DO9MqjGCLek6ImjuA7ARqRluOImkbBbrfVmQ/H8Zg8YAg
        3s9xKVKA/ugef0oYMWwc3YA=
X-Google-Smtp-Source: ABdhPJx8GWDT4jYS1nKtU0N1AX9T3UKbfj/fVgycOW1nx3EsssmCo1ab8UEXys+OWojw5h3hpNK4PQ==
X-Received: by 2002:a17:906:e99:: with SMTP id p25mr32000391ejf.534.1634030168758;
        Tue, 12 Oct 2021 02:16:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yz9sm4637309ejb.51.2021.10.12.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:16:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Robin Dupret <robin.dupret@gmail.com>, git@vger.kernel.org,
        Robin Dupret <robin.dupret@hey.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
Date:   Tue, 12 Oct 2021 11:07:55 +0200
References: <20211011192546.1571-1-robin.dupret@hey.com>
 <20211011192546.1571-2-robin.dupret@hey.com>
 <YWTyr6joJlyi1TPe@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YWTyr6joJlyi1TPe@coredump.intra.peff.net>
Message-ID: <8735p6li20.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Jeff King wrote:

> On Mon, Oct 11, 2021 at 09:25:46PM +0200, Robin Dupret wrote:
>
>> Signed-off-by: Robin Dupret <robin.dupret@hey.com>
>
> You signed-off, which is good (and necessary for contributing a patch).
> This is a good place to say "why". Even if it is "because it makes the
> code more readable", it is good to say that rather than leave readers
> guessing (though of course people won't necessarily agree ;) ).
>
>> ---
>>  http-backend.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/http-backend.c b/http-backend.c
>> index e7c0eeab23..3d6e2ff17f 100644
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
>>  	struct child_process cld = CHILD_PROCESS_INIT;
>>  	ssize_t req_len = get_content_length();
>>  
>> -	if (encoding && !strcmp(encoding, "gzip"))
>> -		gzipped_request = 1;
>> -	else if (encoding && !strcmp(encoding, "x-gzip"))
>> +	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
>>  		gzipped_request = 1;
>
> I think this conversion is correct, and I do find the resulting slightly
> easier to read. I wondered if the two conditions might have come
> separately, but no, they were both there in the initial 556cfa3b6d
> (Smart fetch and push over HTTP: server side, 2009-10-30).
>
> We do frown a bit on making small style changes like this. This kind of
> churn isn't dramatically improving the quality of the code, and it
> carries the risk of regression (if there is something subtle that you or
> the reviewers missed) and creates a maintenance burden (it may conflict
> with other patches, though I doubt it in this case, and it creates work
> for reviewers and the maintainer to apply).
>
> So...I dunno. I don't mind it, but it is not a pattern we like to
> encourage in general. Let's see what Junio thinks.

Maybe the existence of this discussion is also why we frown on churn :)
But not being able to resist: FWIW I think if this were refactored the
below makes more sense (untested etc.):

Because the pattern in that function is to:

 1. Get params via getenv
 2. Provide defaults in case those are NULL
 3. Set resulting structs/variables, use them

The "encoding" and "gzipped_request" are the odd ones out there, this
makes them consistent with the rest.

It also has the effect of column-aligning the two strcmps, which along
with avoiding indentation is why I general is why I've sometimes used
this pattern of:

    if (a && b)
        ;
    else if (a && c)
        ;

Over the obvious simplification of:

    if (a && (b || c))
        ;

Although due to the "if" / "else if" in the pre-image that didn't apply
here...

diff --git a/http-backend.c b/http-backend.c
index e7c0eeab230..13bc421b4e8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -462,19 +462,19 @@ static void run_service(const char **argv, int buffer_input)
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
 	const char *host = getenv("REMOTE_ADDR");
-	int gzipped_request = 0;
+	int gzipped_request;
 	struct child_process cld = CHILD_PROCESS_INIT;
 	ssize_t req_len = get_content_length();
 
-	if (encoding && !strcmp(encoding, "gzip"))
-		gzipped_request = 1;
-	else if (encoding && !strcmp(encoding, "x-gzip"))
-		gzipped_request = 1;
-
 	if (!user || !*user)
 		user = "anonymous";
 	if (!host || !*host)
 		host = "(none)";
+	if (!encoding)
+		encoding = "";
+
+	gzipped_request = (!strcmp(encoding, "gzip") ||
+			   !strcmp(encoding, "x-gzip"))
 
 	if (!getenv("GIT_COMMITTER_NAME"))
 		strvec_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
