Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD7B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbcLSXNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:13:15 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33699 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbcLSXNO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:13:14 -0500
Received: by mail-it0-f65.google.com with SMTP id c20so12041794itb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyIwBBX/uiDuIImmb+EX+VUF80Ganku5KQ1vgwF4bQE=;
        b=fWWEqFFSkk+3dWqHjBtmpSNQgtt7wOf6hMVRGbwBQA9Eht4bHYDsuog8CwlxU5fv5G
         hQqNqNSkgTkwe70j5oXX33xpCHI2/RQjvAHFFV0s6luRXu6V8zdWlLvMyjQlLyOju+Ym
         +J7qMBCleOlmhcbfPLmj+U1DnnS9DkI+8VOnsYvfffAhdknjHaa9d4wmBCvNZqYzq1gQ
         WNRinMWKgseVNiHGID1FZrG9uHkZbhS0yCVoXrlgiPzHJN6XZs+e0zEPVKafIEwW+3jY
         oGrscNR7dwKDSdhOKCxUbOGhGCVq0k8P9R3xrkBZG4PRzRUsuL5vRSW5XlkDUZi9nJJu
         Lgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyIwBBX/uiDuIImmb+EX+VUF80Ganku5KQ1vgwF4bQE=;
        b=NW11ICWefY/Vg+s03zlKBy6vzOoktNVVYRWGdIeJSBsRpCaGLebEydRvtEw29rs93I
         9cT4JtabL9SBp2eHhrCaJLD6vWWINPRMB8X//2sjUeHYE0Ojx3uxWJzoNHTZVU9lA1df
         3uoSW6IeyOkryqO/y5XXpdhDnAPffxTYEhDHCp9X5DuP903/CWH4iW38DvylAO+JoO3v
         KY1PDb/lNJmdvyOx7l0jF0dpHImwPa/fKt/hF5BJEU7yQk34nDKppzKOFfz8Ss+3DXf+
         JWB1RN7Ea4dKzlh6jPN+y1Gb5VTCu5dm9Y4OvIbF3gnh6TXzOq2ksIj7yo4EEz9gCA49
         +9ew==
X-Gm-Message-State: AIkVDXLaDdV8qTUOO89llsyA6/0lk4Y2GeBF6O00OxuaMs5mlLt0Pla7m4DRHh3FBVOgow==
X-Received: by 10.36.54.147 with SMTP id l141mr7980052itl.75.1482189193905;
        Mon, 19 Dec 2016 15:13:13 -0800 (PST)
Received: from localhost.localdomain ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id f24sm9214212iod.21.2016.12.19.15.13.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:13:13 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2] mailinfo.c: move side-effects outside of assert
Date:   Mon, 19 Dec 2016 15:13:00 -0800
Message-Id: <ebaf4c892a78bc3ae614a23d87f9c0f@58437222ff6db9ee7cbe9d1a5a1ad4e>
In-Reply-To: <xmqqbmw7ocoz.fsf@gitster.mtv.corp.google.com>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com> <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com> <xmqqbmw7ocoz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 19, 2016, at 13:01, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>>> This is obviously an improvement, but it makes me wonder if we  
>>>> should be
>>>> doing:
>>>>
>>>> if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data))
>>>>    die("BUG: some explanation of why this can never happen");
>>>>
>>>> which perhaps documents the intended assumptions more clearly. A  
>>>> comment
>>>> regarding the side effects might also be helpful.
>>>
>>> I wondered exactly the same thing myself.  I was hoping Jonathan  
>>> would
>>> pipe in here with some analysis about whether this is:
>>>
>>>  a) a super paranoid, just-in-case, can't really ever fail because  
>>> by
>>> the time we get to this code we've already effectively validated
>>> everything that could cause check_header to return false in this  
>>> case
>>> ...
>> The answer is "a". The only time that mi->inbody_header_accum is
>> appended to is in check_inbody_header, and appending onto a blank
>> mi->inbody_header_accum always happens when is_inbody_header is true
>> (which guarantees a prefix that causes check_header to always return
>> true).
>>
>> Peff's suggestion sounds reasonable to me, maybe with an error  
>> message
>> like "BUG: inbody_header_accum, if not empty, must always contain a
>> valid in-body header".
>
> OK.  So we do not expect it to fail, but we still do want the side
> effect of that function (i.e. accmulation into the field).
>
> Somebody care to send a final "agreed-upon" version?

Yup, here it is:

-- 8< --

Since 6b4b013f18 (mailinfo: handle in-body header continuations,
2016-09-20, v2.11.0) mailinfo.c has contained new code with an
assert of the form:

	assert(call_a_function(...))

The function in question, check_header, has side effects.  This
means that when NDEBUG is defined during a release build the
function call is omitted entirely, the side effects do not
take place and tests (fortunately) start failing.

Move the function call outside of the assert and assert on
the result of the function call instead so that the code
still works properly in a release build and passes the tests.

Since the only time that mi->inbody_header_accum is appended to is
in check_inbody_header, and appending onto a blank
mi->inbody_header_accum always happens when is_inbody_header is
true, this guarantees a prefix that causes check_header to always
return true.

Therefore replace the assert with an if !check_header + DIE
combination to reflect this.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Jeff King <peff@peff.net>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

Notes:
    Please include this PATCH in 2.11.x maint

 mailinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 2fb3877e..a489d9d0 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -710,7 +710,8 @@ static void flush_inbody_header_accum(struct mailinfo *mi)
 {
 	if (!mi->inbody_header_accum.len)
 		return;
-	assert(check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0));
+	if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0))
+		die("BUG: inbody_header_accum, if not empty, must always contain a valid in-body header");
 	strbuf_reset(&mi->inbody_header_accum);
 }
 
---
