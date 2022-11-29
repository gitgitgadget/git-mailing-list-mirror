Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B24C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 22:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiK2WyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiK2WyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 17:54:06 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD9173B83
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:53:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h206so11196191iof.10
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5XnZXv6HNo8hEZDlhp8z8hMBTnH9Tcb3CK68535FLU=;
        b=RPDNxISyrjBHAN/GjZYYZQbKf4z88qvrl3GnkWV+9f9ToARIJq+noQX0F2udx5o2tY
         PREhVUlo1nT9/PmZY7Mc5iYA70IchSWuwssliHxJmv5QLBepHT6pOmTye/tXVw0NS8Dq
         A7Rd6NuVlv0mrwSeIAEnzroB1bVNAwAbppCOxRe5iXx2JGwp0HxsULKqczHgu2RqFNIe
         bQL9q2EXcQwJRxgMwSTmNg4cGD5oJA8mG6drw+xKLXr39m1O7AxTI0WC0gTyqsHTXKA7
         4tW2Wm3tM8yA5xjXvApUTBPmQKphoQY6oeP+MUNrUKMiwfI4bQ/T6IbiYgPniQXIfQX3
         i7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5XnZXv6HNo8hEZDlhp8z8hMBTnH9Tcb3CK68535FLU=;
        b=FfzbD5VjY42ZaNjTAIf2lYoZ+mSx0CGSqXMOUfLzzA6qvcX+nRO9vognJlqvUuwLQ+
         XCyPqNGc/+Uaw3AFvRuqeIa3kV1noNWJ4/nUmdrMYssAMZnULq62kl0sUWPNUAuYyZc6
         7t5gKRy0OZEwMVo7nimKYOc+JazpnC7DLayBnz5FVE4eS0lxyc3BXR+rNXJehY+n2gMe
         aUII2WxgTHArqQN6z3yK5IdeIN2vidNrTZpfSaEzV+Q7SY/9/3HJ27DSgDNunkTKpLy2
         WUz8+cDVaD+/Sx1ZIAWB35QZIszma5rS8y+sEfkk4h/auiZEXxLOghQidgArf9atHurn
         L1wQ==
X-Gm-Message-State: ANoB5pnvJDica+IA4nbqiqS4V+XOldU/Joj2FQJDQIwpnjn0j7lpjREG
        O2NlSm5caK+Bb6X9vbAPvYWSKA==
X-Google-Smtp-Source: AA0mqf7Pl8a9+uCoOT7HZczNFRJFj7bwBzTO3+9RCxdiv4+H5uUNbU+p/AogXRbYf9jFXTiNM6/SIg==
X-Received: by 2002:a02:3b56:0:b0:375:8878:9c80 with SMTP id i22-20020a023b56000000b0037588789c80mr25692780jaf.157.1669762415335;
        Tue, 29 Nov 2022 14:53:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z28-20020a056602081c00b006c75c702342sm185630iow.14.2022.11.29.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 14:53:34 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:53:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
Message-ID: <Y4aNbc1ZMxscyvU1@nand.local>
References: <cover.1667980450.git.dyroneteng@gmail.com>
 <20221128142032.71179-1-tenglong.tl@alibaba-inc.com>
 <xmqqzgca4lb7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzgca4lb7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 10:10:52AM +0900, Junio C Hamano wrote:
> Teng Long <dyroneteng@gmail.com> writes:
>
> >> Teng Long (5):
> >>   notes.c: cleanup 'strbuf_grow' call in 'append_edit'
> >>   notes.c: cleanup for "designated init" and "char ptr init"
> >>   notes.c: drop unreachable code in 'append_edit()'
> >>   notes.c: provide tips when target and append note are both empty
> >>   notes.c: introduce "--no-blank-line" option
> >
> > I'm not sure if this patch series should continue, and if there are no
> > updated comments it will be temporarily suspended.
> >
> > Thanks for the reviews on the past patches.
>
> Taylor, This topic was marked to "expect" a reroll in the second
> issue of November "What's cooking" report you did.  Do you recall
> what remaining works there were?

Looking at the dates, I sent that WC on 2022-11-08, which means that I
most likely was referencing the discussion between the author and Ævar.

The following WC on 2022-11-14 likely should have changed the status to
"Waiting for review".

Thanks,
Taylor
