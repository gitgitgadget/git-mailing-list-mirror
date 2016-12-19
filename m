Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9F71FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbcLSXyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:54:47 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34890 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbcLSXyq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:54:46 -0500
Received: by mail-io0-f194.google.com with SMTP id f73so20784667ioe.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pagJPJ4SFDQeJoJOyaUTqqvI5Cco7FZrHLo9O9gTFuo=;
        b=RAVZpmwZLYV06PB6pHWJetODdEkVkP/ITki/Ddj9nAhwtFBHkoYWljJzZQk44xQ3A8
         FtJiX6s/oU/yblQhaUemRqsRsxjfsNdQ9ehrNHSlt2i2HjmHQy6YTdx4UT85AnC6P6+Z
         TXJWWXSarPxB3vCAYM9PWPA4LNnMXOpgeN9uPlDmsBqFJOiHT8uqnKribdVvc7MuoNCq
         k+110hwF6UZzEnXNPZm3ebOLBkNculiHCPf38atHbe0rtFXlmjZP8gYWH+XSFuZiQ4zc
         BE5lNOAjSY4aGX86Cx3itFyVV2oMJ/eWWI7weyTHZ+nvuKJGgvkaqdzLd4vE5uprR0Uo
         Oh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pagJPJ4SFDQeJoJOyaUTqqvI5Cco7FZrHLo9O9gTFuo=;
        b=BprrR51ezauY+r0vwpqZ4Yz3mYVN1pMgZAWbqyqgKSUIw2gC2WADbS7MFoApwuy4B5
         fd4204sHvfOr+qB1KbCcRMHN28MVm3RqBhsv0eI/OwCpMIlKUnuKTh2HZH/dw3ud7C4a
         vQQHs8yTBnRQYNnddlKNdPnrTEJ5MvnXagY838pLz6gZjQf4SfyC2xVa9vsqCjmTU8CS
         TVTm1vCjPdcTfc5baelBs6kwZTrJYjDdFr+yoJYW6O9ZQFOqFQiFh/lJMwjhhY5lmjbR
         LRu7IrHRJsqnCrESqfieWYWtMHe5M4KLkBJTJq1/pX4Y8RaaC3t3w5PDREwO1f/0rB8E
         5tJw==
X-Gm-Message-State: AKaTC03ox6WW1LLpdhqKHdYASe5KrqlEar5Y5tUdrc/yElBkcC4kzY6iTXWdQBZWluxQiQ==
X-Received: by 10.107.59.88 with SMTP id i85mr19487285ioa.198.1482191685385;
        Mon, 19 Dec 2016 15:54:45 -0800 (PST)
Received: from localhost.localdomain ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id t129sm9305892iod.3.2016.12.19.15.54.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:54:45 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v3] mailinfo.c: move side-effects outside of assert
Date:   Mon, 19 Dec 2016 15:54:41 -0800
Message-Id: <735f6ca98151fc081ea871016afc4b6@58437222ff6db9ee7cbe9d1a5a1ad4e>
In-Reply-To: <xmqqbmw7mrg4.fsf@gitster.mtv.corp.google.com>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0> <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net> <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com> <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com> <xmqqbmw7ocoz.fsf@gitster.mtv.corp.google.com> <ebaf4c892a78bc3ae614a23d87f9c0f@58437222ff6db9ee7cbe9d1a5a1ad4e> <xmqqbmw7mrg4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dec 19, 2016, at 15:26, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>>> OK.  So we do not expect it to fail, but we still do want the side
>>> effect of that function (i.e. accmulation into the field).
>>>
>>> Somebody care to send a final "agreed-upon" version?
>>
>> Yup, here it is:
>
> Thanks.

Whoops. there's an extra paragraph in the commit description that I
meant to remove and, of course, I didn't notice it until I sent the
copy to the list.  :(

I don't think a "fixup" or "squash" can replace a description, right?

So here's a replacement patch with the correct description with the
deleted paragrah:

-- >8 --

Since 6b4b013f18 (mailinfo: handle in-body header continuations,
2016-09-20, v2.11.0) mailinfo.c has contained new code with an
assert of the form:

	assert(call_a_function(...))

The function in question, check_header, has side effects.  This
means that when NDEBUG is defined during a release build the
function call is omitted entirely, the side effects do not
take place and tests (fortunately) start failing.

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
