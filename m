Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CF81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeGWNfb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:35:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36690 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbeGWNfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:35:30 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so146343ywg.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7aI7i+5hgdToGt6HQ5IfTpHiLgLtXmlNSvlQQ4A4Rc=;
        b=SGvE5VH3MEBMWvvAR1WAAAzBgCJnFP3zQdBr21JhCtZFsK91p0iBsOuGesOM7ottsS
         04DCmRkobkd7pM1kMQlitnJUtFacb6xcQR3o4blpkhPbvLwsoo+luzXE0W1cz5afXbYP
         bT1RUpdRWdvnGyTxVU0bbXkWjI1VaUz6waKtbRdCw5Mgcxj90BFlTunQcEGWwgJCwyCA
         eUtJQKHWl0qMISCrn4KRpi/z+PTTvLFi0tOm9291i7OZKZ8L6c8gAZ+LzuZD0jO9Q8mF
         UWM8tQ2NEbRMwFwedSMfbyTopzRktJ6SeshhtshfaCvjzSXlpDVuyKpea8Ia0DuhUBFi
         +nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7aI7i+5hgdToGt6HQ5IfTpHiLgLtXmlNSvlQQ4A4Rc=;
        b=gMk6OTDYeUKhU7LAT3ZmhAPcje4NlryLsIKoTiOMzuFrU0UEOssyOGkQGc09y7lCPE
         i6mYoU0Ei5vJNfjCoQE1MVs8K7iIcMYVlStQvyTGK8xpjiCzPVey+Fy0xgfYgWaYRq8u
         WCNZKRQzflu3ZKfQXbYz12bOV7rmstQDJclzEyjUcELt+PwXAFZaNWJXB/nGoUmPz490
         VvbTks1ImTOX6na9fHW2jd5gdepvQ83bxZciOz9doDrDBbD9P3twxFAtDk6sjP8NIHRE
         NQ8b8vmm6+x56H0loTm42SN+IGrJj9FfmQbLDTGa0ZBEwABscJBoq/j1+jeyqm0o6AT/
         JuwA==
X-Gm-Message-State: AOUpUlGC4kjVPkpWWG4szS0uUdxgyMQMRVS8Rq8Y78Kv50dHJ1g53gTx
        h/K6jtkTDKKPVFCaRTV45NdbCd0E
X-Google-Smtp-Source: AAOMgpcmLL5bZMj6987mwAtstC57jqKna84jnySM9uRtOqUSg6U37Wpi8etKaSE4LFYFNCxCxQsoGA==
X-Received: by 2002:a81:a1c3:: with SMTP id y186-v6mr6272268ywg.351.1532349269822;
        Mon, 23 Jul 2018 05:34:29 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x69-v6sm7230624ywx.105.2018.07.23.05.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 05:34:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, peff@peff.net,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
Date:   Mon, 23 Jul 2018 05:34:23 -0700
Message-Id: <20180723123423.32186-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.234.g2d1e6cefb
In-Reply-To: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
References: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 10:43 AM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Jul 20, 2018 at 8:39 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:

>>  If we want a quick fix for 2.18.1. I suggest bumping up
>>  OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
>>  think it's safe to fast track this patch.
>
> Okay, I'll submit that with a proper commit message then.  Since you
> also bump OE_DELTA_SIZE_BITS in your patch (though to a different
> value), it'll require a conflict resolution when merging maint into
> master, but at least the change won't silently leak through.

And here's the re-submitted patch, with commit message...

-- 8< --
Subject: [PATCH] pack-objects: fix repacking of repositories with some large
 deltas

Commit 0aca34e826 (pack-objects: shrink delta_size field in struct
object_entry - 2018-04-14) reduced 'struct object_entry' size, by dropping
the delta size field to 20 bits (max delta size 1MB).  There was a
fallback to reference existing pack files that already had large deltas,
but when aggressively repacking, it drops the deltas on the floor,
resulting in much worse packs.

For comparison, the following measurements were made for running 'git gc
--aggressive' for one particular repo:

    Version  Pack (MB)  MaxRSS(kB)  Time (s)
    -------  ---------  ----------  --------
     2.17.0     5498     43513628    2494.85
     2.18.0    10531     40449596    4168.94

This patch provides a stop-gap improvement for maint that increases the
delta size back up to 32 bits (still an improvement over the 64 bit size
of the original).  A better fix preserving the memory savings for most
repos that do not have large deltas is being prepared for 2.19.0.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I think Duy's comment that I'm responding to suggests he Acks this
patch for maint, but there is that little 'if' he put in his statement.

I'll be on vacation until the end of the week, so I apologize in advance
for not responding quickly...

 builtin/pack-objects.c | 2 +-
 pack-objects.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..49b7af295d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2023,7 +2023,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+	if (delta_size >= (1UL << OE_DELTA_SIZE_BITS)) {
 		free(delta_buf);
 		return 0;
 	}
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..26021328aa 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
+#define OE_DELTA_SIZE_BITS	32
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
-- 
2.18.0.2.gf4c50c7885

