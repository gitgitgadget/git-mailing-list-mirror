Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260F51F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIDUeb (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 16:34:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40689 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIDUeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 16:34:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so3424093lfi.7
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVhJThLFThXbxDdFTK4h92IIHdw3oxnoZtVB8o1esKw=;
        b=FNwVgoI4QdLcbpod3Hqau4MxQvpHPvFZlcCTGOQ/UpUFdXrIeH/cv8Kca4byKB9kd/
         WNsqYg084dfuRt7VDulgJQTJQJIY3lSvokRh5pUYJ5dods1YWZ1IVtaoD0KOXbSZrPCc
         roTSPwClbXuc1F5CkK4vdxkAt5S33Mnbu5ydXjCRI8M7KXEpZjhBAJFBgn6IcgpqBM5C
         rnBdkl8iRz89H/JpRFiBoFbLgvyVRSBt+cYUejJHquh82IVhFY1DNZpzMAyhkZC98SQo
         i84nMlqKDI700mWpJ4AoWiXgU18ly4JGoSYhZUf8A2vczXAx8VRU3PpTxughR7iX4pCc
         KZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVhJThLFThXbxDdFTK4h92IIHdw3oxnoZtVB8o1esKw=;
        b=gXlhDVEFtplS2v67pFm8LB56+rhYdVUpJxJLzYDYj21VPm+QQBASbdSrirhHL+bq2a
         CneYPnViYGakTadFQS4Uk3OeFMBAPf1Rp9WrMofda0ldaYLiIUKcWMIO1OwPebtRvMeE
         XBJ5XsCXbQHLPOw0ADLQM5asbTJSon5/+qXA88PnrEBgKJ/JkDD28HHwJCHCgN/QW8TP
         gccEPbrHEmRuYIyC6dI6VjAhA607gQd2ycFUx1MqCmMf81vfXME4QXqhwSF5wRJzigmY
         iY86nGzqAMq/HBaepWEQyNbJrDOnA+XlNYUUt0amz3urr93/RAtA/V8+IFWlRMl0LXHA
         sgeA==
X-Gm-Message-State: APzg51AUHr2R1t927FzJ+X5bOZEraOfjCqq5/yVTJ3ruCh2sa4gtet/h
        7Obp9O8N6lo1aMjJC0zhq2o=
X-Google-Smtp-Source: ANB0VdbznogwxTwTF/TRm6S4q6/xs/EgERNxRW/AFD5/n1Q4KTcQPBVcrclfk9LT/Qv38mA9/F0SPg==
X-Received: by 2002:a19:988a:: with SMTP id a132-v6mr20487162lfe.76.1536077323009;
        Tue, 04 Sep 2018 09:08:43 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j24-v6sm4088594lfb.62.2018.09.04.09.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:08:42 -0700 (PDT)
Date:   Tue, 4 Sep 2018 18:08:40 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH] read-cache.c: optimize reading index format v4
Message-ID: <20180904160840.GA24679@duynguyen.home>
References: <20180824155734.GA6170@duynguyen.home>
 <20180825064458.28484-1-pclouds@gmail.com>
 <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 12:36:27PM -0700, Junio C Hamano wrote:
> > PS. I notice that v4 does not pad to align entries at 4 byte boundary
> > like v2/v3. This could cause a slight slow down on x86 and segfault on
> > some other platforms.
> 
> Care to elaborate?  
> 
> Long time ago, we used to mmap and read directly from the index file
> contents, requiring either an unaligned read or padded entries.  But
> that was eons ago and we first read and convert from on-disk using
> get_be32() etc. to in-core structure, so I am not sure what you mean
> by "segfault" here.

To conclude this unalignment thing (since I plan more changes in the
index to keep its size down, which may increase unaligned access), I
ran with the following patch on amd64 (still webkit.git, 275k files,
100 runs), the index version that does not make unaligned access does
not give noticeable differences. Still roughly around 4.2s.

Running with NO_UNALIGNED_LOADS defined is clearly slower, in 4.3s
range. So in theory if we avoid unaligned access in the index and
avoid slow get_beXX versions, we could bring performance back to 4.2s
range for those platforms.

But on the other hand, padding the index increases the index size by
~1MB (v4 version before padding is 21MB) and this may add more cost at
update time because of the trailer hash.

So, yeah it's probably ok to keep living with unaligned access and not
pad more. At least until those on "no unaligned access" platforms yell
up.

diff --git a/read-cache.c b/read-cache.c
index 8628d0f3a8..33ee35fb81 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1794,7 +1794,7 @@ static struct cache_entry *create_from_disk(struct index_state *istate,
 		if (copy_len)
 			memcpy(ce->name, previous_ce->name, copy_len);
 		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
-		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
+		*ent_size = ((name - ((char *)ondisk)) + len - copy_len + 8) & ~7;
 	} else {
 		memcpy(ce->name, name, len + 1);
 		*ent_size = ondisk_ce_size(ce);
@@ -2345,8 +2345,10 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 			result = ce_write(c, fd, to_remove_vi, prefix_size);
 		if (!result)
 			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common);
-		if (!result)
-			result = ce_write(c, fd, padding, 1);
+		if (!result) {
+			int len = prefix_size + ce_namelen(ce) - common;
+			result = ce_write(c, fd, padding, align_padding_size(size, len));
+		}
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);

--
Duy
