Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436CC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 07:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjD0HWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbjD0HWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 03:22:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6E5586
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 00:21:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so60672695ad.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682580073; x=1685172073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+83EDmhBbJ/UPjwb4RVDgx1bj+TQWhQGrQ3VNDGU2o=;
        b=sW3G5+uXFk3pXanBrmhVrJYOhIbLaRh3qiwNp4nWdyyiCt2LKYyaf1/PSVEKJ5un8p
         3O78UNkrVKkUGlCKfIqhbawmpFNFeLAzCeqGGR6ZryqVlqrnVc/o+JZyqbtmvePRyP4f
         jhuzkwzFr4BnhrZAz6UkWBfwviKBiM60fUmMNLd/ZlPzf0ARzA/wr21aUUAFaVBowNzG
         NMKF/j81buZyphtdiVJRCEvRKcoD+8mZG+oCPdmblSjQGtpDSf9+uhxW2SUqM/Vh3MU1
         z7vhLS3JqMZDMeEbrLj3JZl/Orp/RunwVD3vK3Zpew5bxbllIyD4tJdCPWkPoeKJqXLg
         PFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682580073; x=1685172073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+83EDmhBbJ/UPjwb4RVDgx1bj+TQWhQGrQ3VNDGU2o=;
        b=cyhq33DeQLKVgeERo2d9305UBRvNBowGXqfYFVs5b3cZho6OJhQtsckwfsxBbFCIqc
         bf5+C2VMMbkQvAs94ePeqnpp5towGPzYv57Tx0HLW2p0p+Qr+nUlO1+dz+THdH7b6uaS
         CZWuE+TWrltq/htDibOT5vtDX0zb/fFSX9nj93iB/+0u+snZC6LLO737w8ZUlnBqJZVD
         RMYVv2JONj4Hh+RZYZmDLkopNFjZ/1aRk2g/Is1PHEh6+vMFv6upv8mJR7dqU6xs7gw4
         8dp/HrHqvPpsCtB5fUShklhetH04DVqpnR28JEHYQKmir7+Esg5nrvWMtSJjseiQnpmX
         nkMw==
X-Gm-Message-State: AC+VfDwJa9caEa5MiE6FX0WYCrmop6ekV8LKBVVHAm6Y/miRBNECMQ6c
        TEfI66si0GJhc6/HKM+ckjhNEAx8hcGshg==
X-Google-Smtp-Source: ACHHUZ4PcsS2EJSuNNlYI/Y4uzXuzrjeo6TL1nAR8QTgk3DccJmBO/4GzLQ8LcqW1P3wf7JGkxVMQw==
X-Received: by 2002:a17:902:e5d1:b0:1a5:3da:84cb with SMTP id u17-20020a170902e5d100b001a503da84cbmr675717plf.21.1682580073419;
        Thu, 27 Apr 2023 00:21:13 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902bd8b00b001a96a6877fdsm6967638pls.3.2023.04.27.00.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:21:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Thu, 27 Apr 2023 15:21:07 +0800
Message-ID: <20230427072107.29821-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.358.ged3339c3
In-Reply-To: <xmqqsfcn27e0.fsf@gitster.g>
References: <xmqqsfcn27e0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	while (d->msg_nr) {
>> +		--d->msg_nr;
>> +		strbuf_release(&d->messages[d->msg_nr]->buf);
>> +		free(d->messages[d->msg_nr]);
>> +	}
>
>        while (d->msg_nr--) {
>                strbuf_relesae(...);
>                free(d->messages[d->msg_nr]);
>        }

Will fix or optimize.

>> +static void concat_messages(struct note_data *d)
>> +{
>> +	struct strbuf msg = STRBUF_INIT;
>> +
>> +	size_t i;
>> +	for (i = 0; i < d->msg_nr ; i++) {
>> +		if (d->buf.len)
>> +			insert_separator(&d->buf, d->buf.len);
>> +		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
>> +		strbuf_addbuf(&d->buf, &msg);
>> +		if (d->messages[i]->stripspace)
>> +			strbuf_stripspace(&d->buf, 0);
>> +		strbuf_reset(&msg);
>> +	}
>> +	strbuf_release(&msg);
>> +}
>
>Interesting.  
>
>I would have expected that where we add to d->messages[] array a new
>note_msg structure and set its .stripspace member, we already knew
>if the associated strbuf needs to be stripspace'd and instead of
>maintaining the .stripspace member for each note_msg, we can just
>have it contain only a string (not even a strbuf).

That's because the "-C" option, it will not do stripspace for the
whole note, but support to use together with "-m" or "-F"(they will
do stripspace). So, for the consistent result with backforward
compatibility, we have to get the information about whether to do
stripspace when concating each message.

>The above loop, and the design to have .stripspace per each
>note_msg, smell iffy to me for one thing.  The .stripspace member is
>used to flag "after adding this element, the whole thing need to be
>treated with stripspace".  Is it intended?  What it means is that if
>you have two elements in d->messages[] array, one of them with and
>the other one without the .stripspace bit set, depending on the
>order of the elements, the result would be vastly different.  When
>the later element has the stripspace bit set, everything gets
>cleansed, but when the earlier element has it, only the earlier
>element gets cleansed and the later element is added with multiple
>blank lines and trailing whitespaces intact.  It does not sound
>quite right.

In the previous patch, I actually followed your suggestion to only
stripspace message itself but not the whole concatenate message. But
actually, there's a problem with this, in fact it's also caused by
"-C", "-C" doesn't stripspace, means that when mixed with "-m" and
"-F", the order of the options matters.

I'm not sure if this is a design flaw or if it's intentional, but
it's special about the stripspace handling of "-C" right now, which
is why I've added two new test cases in [3/6], just to make sure my
subsequent patches don't break them:

    * 'add notes with "-C" and "-m", "-m" will stripspace all together'

    * 'add notes with "-m" and "-C", "-C" will not stripspace all together'

>I wonder if the semantics intended (not implemented) by this series
>is to concatenate if none of the elements want stripspace and cleanse
>the whitespaces if any of them want stripspace, in which case an
>obvious implementation would be to just concatenate everything in
>the loop with separators, while seeing if any of them have the
>stripspace bit set, and then after the loop finishes, run stripspace
>on the whole thing just once if any of d->messages[] asked for it?
>If that is the case, an even better design could be to move the
>stripspace bit out of d->messages[] and make it d->stripspace to
>apply to the whole thing.

I agree, but this seems to break the effect of "the order matters" because of
the "-C" argument. 

If we think that the "-C" particularity is a case that should be optimized or
fixed(), then I strongly agree with this modification approach, and I think
that compared to this particularity, on the one hand, our implementation
is simple, on the other hand, users may find it easier to understand.

>Another possiblity is to just stripspace the elements taken from the
>source you want to stripspace (like "-m" and "-F" but not the ones
>taken from parse_reuse_arg()) before you even add them to
>d->messages[] array.  That way, the only possible source of multiple
>blank lines and trailing whitespaces in the concatenation of
>elements you want stripspace would be from the separator, which is
>under control by the end user. ...

I think this approach is feasible, and add judgment logic when supporting
subsequent --[no-] stripspaces.

>... So your concatenation could just
>ignore running stripspace at all---if the user does (or does not)
>want multiple blank lines or trailing whitespaces on the separator
>line, that's under their control.  That sounds like the simplest and
>cleanest design---we strip as we read from each source and make them
>into simple strings to be kept in d->messages[] without having to
>allocate and keep a strbuf per each source, and we concatenate just
>once, without worrying about stripspace.

The strbuf can record the "len" of the buf, to make sure the string
will be cut of if the content contains '\0' in the middle, like a binary
file. Maybe using a string could make that, but I‘m not sure how to solve
it.

>The simple approach may break when any of the elements ended up to
>be truly empty, but then we can solve that by refraining to push an
>empty result into d->messages[] array, or something?  I dunno.

I will add some test cases about it and found it out.

Thanks.
