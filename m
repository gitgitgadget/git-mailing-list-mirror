Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA58C201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935490AbdEOTbI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:31:08 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35523 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbdEOTbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:31:07 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so62959570pfb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kPmJzWeB/1Ra7HNHR5x3MuOnAatkc3v+EJzJDvuQ05I=;
        b=Q9fRlfkQ+fB20XVo2eeJDbZ7m78glpIr4sDOvu6U27gvUUeAsEy08LwQSfVYO7vjbw
         0yWVLPSuxfkMZQH0u71p6emMeNxH+3lGi5Brnd2zuLlzKntmrcn38p9vE6dQ1bnmxSoS
         Gt3iKwAbH/WROZNocu6ctqjpWeip2AodRvuJ57W7DtRXq/FtVM4RBk48f/b1W1CI2s9f
         qHvWks4fRNfCPpDqNbvqL+kK4KYwDf4Mp+6CzAh6anzqi8U6lMj0/hUMMhBbjdet3tDU
         2pw/8xjR/KGvg2zk26YUJbnz4xNWHkkGJ/8zubm4Hdn8fBVjp04J01s91CSjoQrW5uHG
         0Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kPmJzWeB/1Ra7HNHR5x3MuOnAatkc3v+EJzJDvuQ05I=;
        b=cYxCaeHd+f8srCna7+GOdjHMYCVx1HFDIrFMaC0CeaMNcaNEZNiW9XZGaT6s4U92fA
         UNIzUwQQxwygohjvM271jX/KUktNq375zcUUX3ovobITHPMucHpQSTXIarlmYUn67WJr
         zqGsKUmVS41tFKBuhxuLSeFs8ILKXPyPf7rO2hfuwCwWuq8rYo9nn9CE/5qQVwO+5mPg
         GxI7EO6azLudaUdbM3njzdXrYlt0ko81VA5na8Ii1I5AxnOyw2WvRcfVK4PCwr/dwwHU
         WGLVgolbhwQ0pm21FaxXZ9X3FLZTG15ZatgG0vwbG+rgpcNi3sCKxfcpVueW1+v1oyRF
         06sg==
X-Gm-Message-State: AODbwcBaq5ZWLWvKYWZop4TYwilrNl5DA3bIeA1wy6ceIddhY4Tb1BDp
        BKwiD95L11Wyqt4YHA3Bt0IVq2KoFbvG
X-Received: by 10.84.228.207 with SMTP id y15mr10551089pli.172.1494876666182;
 Mon, 15 May 2017 12:31:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 12:31:05 -0700 (PDT)
In-Reply-To: <d67fa7ed-fbde-7bce-a691-01dafaa93732@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-11-sbeller@google.com>
 <d67fa7ed-fbde-7bce-a691-01dafaa93732@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 12:31:05 -0700
Message-ID: <CAGZ79kafiLjKbMSz5qpm6uqEJqHKJkn0rQQ--OA7g0w5=5S3jw@mail.gmail.com>
Subject: Re: [PATCH 10/19] diff.c: convert emit_rewrite_lines to use emit_line_*
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 12:09 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>
>
> On 05/13/2017 09:01 PM, Stefan Beller wrote:
>>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> This covers emit_rewrite_lines.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index e4b46fee4f..369c804f03 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -748,7 +748,7 @@ static void emit_rewrite_lines(struct emit_callback
>> *ecb,
>>         if (!endp) {
>>                 const char *context = diff_get_color(ecb->color_diff,
>>                                                      DIFF_CONTEXT);
>> -               putc('\n', ecb->opt->file);
>> +               emit_line(ecb->opt, NULL, NULL, "\n", 1);
>
>
> This outputs diff_line_prefix(ecb->opt) - is that OK?

It shows this area is not covered well by our test suite.

My first reaction was that this is not ok, but we'd have
to inspect the situation. It was introduced in
35e2d03c2c (Fix '\ No newline...' annotation in rewrite diffs,
2012-08-04).

And looking at the code of the function I think this is broken.

I wonder what the best way forward is for this patch series here,
as we'd need to buffer the last line. That should be fine as it is
a corner case, maybe:

diff --git a/diff.c b/diff.c
index 0f10736ee6..f46e52135d 100644
--- a/diff.c
+++ b/diff.c
@@ -1011,15 +1011,27 @@ static void add_line_count(struct strbuf *out,
int count)
 static void emit_rewrite_lines(struct emit_callback *ecb,
                               int prefix, const char *data, int size)
 {
-       const char *endp = NULL;
-       static const char *nneof = " No newline at end of file\n";
+       static const char *nneof = "\\ No newline at end of file\n";
        const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
+       struct strbuf sb = STRBUF_INIT;

        while (0 < size) {
                int len;

                endp = memchr(data, '\n', size);
-               len = endp ? (endp - data + 1) : size;
+               if (endp)
+                       len = endp - data + 1;
+               else {
+                       /* last line has no \n */
+                       while (0 < size) {
+                               strbuf_addch(&sb, *data);
+                               size -= len;
+                               data += len;
+                       }
+                       strbuf_addch(&sb, '\n');
+                       data = sb.buf;
+                       len = sb.len;
+               }
                if (prefix != '+') {
                        ecb->lno_in_preimage++;
                        emit_del_line(reset, ecb, data, len);
@@ -1030,12 +1042,12 @@ static void emit_rewrite_lines(struct
emit_callback *ecb,
                size -= len;
                data += len;
        }
-       if (!endp) {
+       if (sb.len) {
                const char *context = diff_get_color(ecb->color_diff,
                                                     DIFF_CONTEXT);
-               emit_line(ecb->opt, NULL, NULL, "\n", 1);
-               emit_line_0(ecb->opt, context, reset, '\\',
+               emit_line(ecb->opt, context, reset,
                            nneof, strlen(nneof));
+               strbuf_release(&sb);
        }
 }
