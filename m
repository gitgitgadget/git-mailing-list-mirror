Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401B0C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC73A23B1A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 18:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbhANS3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbhANS3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 13:29:31 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA022C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 10:28:50 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so9196945qkm.8
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 10:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MppSb2zhrb+BnD195VIyfYLbjJ5k1BtTCZoWfix+1Sc=;
        b=Lu8ixRyTd9ythAknPKfZAIAzLD/PpPvxqOuifkD+DNUzczQePCSd4wMwduDoG/yJVk
         j9TOA2nCxmgXZYJFs/vx3I9JO8u9CMjawXpquSvopoe3KH/am0ANy4Q3PoPHAlTzBOrt
         9OMYOy5cq3ubFrShXRTUeG9q12k02toHjv+Gkic9O+H61LxrZgOqkm3I6gWJDpZJrXQh
         BQyb+GOpZD4SkxKco+zLwjIE1OauYaLe14gUDpVkqTuR7a28YRmEq0aJe4Hek+XgUpza
         phP9HU+MIuXaB1lr4YwdzJ8Vp9xa2Ba4LjnC0m5+XFMSnYmcck4QrztBoQ8sAWvypOtC
         cMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MppSb2zhrb+BnD195VIyfYLbjJ5k1BtTCZoWfix+1Sc=;
        b=ZHQz1Or9w4rIxzjnvtN7q97890nh3fRJkXUuaLC88QMc3z7Qtt8W/OPUg8LnzaL8W8
         UXrwe6xnom0qwgYiKQttuEq5oycwjWEO1KfmkqCjS3GQvzUZSSiLZBs9GXlAh68LPVRe
         vljNG1n/pB1gT60XpCnvDXEklSaYryKb2xNF81rXZIfZrt9UngToSY8++boVru5ZT24e
         z7bJs4WziNtROtp5XlqhSMnMnNbPWsuZ1+dc77N7uwmF2uJ6DzyRCcSvLWfwwRr47vM3
         WCVsEGW0xLhPd0PrJ55mixA4vWFq2RCAuMQanFzNK09ByMR2iFEa7wbZQ+X01xhBGTEV
         z6PA==
X-Gm-Message-State: AOAM530jV/etdyDWbTBHIkAJq2UQzTau8x9lyXVykc5AHxhn3nSnhwM7
        wUOfljQIoQANjGu9AvJHWAQGUQ==
X-Google-Smtp-Source: ABdhPJw/53SGy1fzWN9Ygy4wql1HHcTGZEqTyjVVgvrcazWZpXDFdmDPISgc5HMXNsQJcbgao2Z3uA==
X-Received: by 2002:a37:63c3:: with SMTP id x186mr8660501qkb.361.1610648930173;
        Thu, 14 Jan 2021 10:28:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id h26sm3476295qtc.81.2021.01.14.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 10:28:49 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:28:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YACNX+ExF1yAn4g3@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 11:22:53PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +== pack-*.rev files have the format:
> > +
> > +  - A 4-byte magic number '0x52494458' ('RIDX').
> > +
> > +  - A 4-byte version identifier (= 1)
> > +
> > +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256)
>
> These two are presumably 4-byte-wide network byte order integers.
> We should spell it out.

Yep, all entries are network order. I added a sentence at the bottom of
this sub-section to say as much.

> We've seen hardcoded constant "12" twice so far in this patch.
>
> We need a C proprocessor macro "#define RIDX_FILE_HEADER_SIZE 12" or
> something, perhaps?

Good idea, thanks.

> > -	return p->revindex[pos].nr;
> > +
> > +	if (p->revindex)
> > +		return p->revindex[pos].nr;
> > +	else
> > +		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));
>
> Good.  We are using 32-bit uint in network byte order.  We should
> document it as such.
>
> Let's not strip const away while casting, though.  get_be32()
> ensures that it only reads and never writes thru the pointer, and
> p->revindex_data is a "const void *".

Agreed, and thanks for the suggestion. I take it that what you mean is:

-		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));
+		return get_be32((const char *)p->revindex_data + (pos * sizeof(uint32_t)));

...yes?

> > diff --git a/pack-revindex.h b/pack-revindex.h
> > index 6e0320b08b..01622cf21a 100644
> > --- a/pack-revindex.h
> > +++ b/pack-revindex.h
> > @@ -21,6 +21,9 @@ struct packed_git;
> >  /*
> >   * load_pack_revindex populates the revindex's internal data-structures for the
> >   * given pack, returning zero on success and a negative value otherwise.
> > + *
> > + * If a '.rev' file is present, it is checked for consistency, mmap'd, and
> > + * pointers are assigned into it (instead of using the in-memory variant).
>
> Hmph, I missed where it got checked for consistency, though.  If the
> file is corrupt and has say duplicated entries, we'd happily grab
> the data via get_be32(), for example.

It doesn't, I'm mistaken. I removed that incorrect detail from this
comment. Thanks for catching it.

Thanks,
Taylor
