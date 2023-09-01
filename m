Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E69CA0FEF
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbjIAS7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjIAS7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 14:59:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C7DE56
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 11:59:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26d1a17ce06so1650247a91.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693594760; x=1694199560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFJuL2v9NsXBcD1Hout6tsCQ3CDUdt4ZwKtT6Srp6Q=;
        b=amcfjZG83gem/Zg7Bc9QjpmK/Cn+OFz2d2T1u/0abJQrwbdJLfAa8G5PqNocCm2Lmv
         dEWjrtQlYCUrSfcyTjpO5MPvltgrWb8pvwMQ7o9EyC2xFpPTrsW/Zv5R0Dl/0O6gKlBt
         DMvRbw2x4uvQUmkP7/0xgmGNJrZ3CcMtCAQDSPOsGdnMKGfLrwGxQTT1IB5Yi0K0tOAq
         lAxTVwva2B48Al1QTf7RSAlZkkUaI10dSPbXbYVRQe9CHU86skFyG3YjmCMCILHbzsvX
         I0uXl/DdtDHwvhpJkyx9M5PRmO1LzIG9IotHBvZ3zRWFIDiDnW45ejCpGgCnaGuus41e
         UYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693594760; x=1694199560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIFJuL2v9NsXBcD1Hout6tsCQ3CDUdt4ZwKtT6Srp6Q=;
        b=Mw3ymlEYhWBjOx73zLRS2sS6lDM542qQZMBkCaJfOByhT77im7VU4rT7nF+9I80NWA
         6f2ma1bZhpvloVCT/VPseFXbnlWg4S44azZTvViCbIU/0fU72Vhefk5tmFNhrK5zgIjn
         LHNVm2NnLgajnP/SYJ76k1v5blpUST2EZpSGiLmoOrCcRQL5PDDw08luhMAQxzTwjL77
         yhRJ4r+wVh1dMAw5eSXWRNtI7SOAFyF1UY2FjTXPG+w2I2p9yIZv7OXYVy6JW6p22RQ1
         cdyafw/JUS6zAPu5Eo7EiiwxC1uB4zXsjAML0itFfPKZv48L4Qdyen+JWK0RhExxXtUh
         Akrw==
X-Gm-Message-State: AOJu0YwuEPO4JN4MCER9XP1lTA/QgyVnpMY8NF/ZK6dS1qtFLAGicCfu
        L3I2pWWFTYXALrlBjK+treY=
X-Google-Smtp-Source: AGHT+IHjMiY3gD0ul9UWAzE7Xw9UgMSY5RM+CrHPqshZsVm9pr17jVGLjMsBOdKqFSzkQ3II5ZeJyA==
X-Received: by 2002:a17:90a:ac10:b0:267:f094:afcf with SMTP id o16-20020a17090aac1000b00267f094afcfmr3389438pjq.12.1693594760383;
        Fri, 01 Sep 2023 11:59:20 -0700 (PDT)
Received: from five231003 ([49.37.156.236])
        by smtp.gmail.com with ESMTPSA id c89-20020a17090a496200b0026cecddfc58sm5277815pjh.42.2023.09.01.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:59:19 -0700 (PDT)
Date:   Sat, 2 Sep 2023 00:29:07 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <ZPI0e1XzZrDV2fJk@five231003>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
 <20230901174540.GB1947546@coredump.intra.peff.net>
 <xmqqr0nhpyf3.fsf@gitster.g>
 <20230901183206.GA1952051@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901183206.GA1952051@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 02:32:06PM -0400, Jeff King wrote:
> On Fri, Sep 01, 2023 at 10:59:28AM -0700, Junio C Hamano wrote:
> 
> > > Yeah, I had the same thought after reading the patch. Unfortunately the
> > > "type" is used only for comparison, not formatting. So you are still
> > > stuck setting both v->value and v->s in grab_sub_body_contents(). It
> > > feels like we could hoist that xstrfmt("%"PRIuMAX) to a higher level as
> > > a preparatory refactoring. But it's not that big a deal to work around
> > > it if that turns out to be hard.
> > 
> > Setting of the .value member happens O(N) times for the number of
> > refs involved, which does not bother me.  Do you mean "when we know
> > we are not sorting with size we should omit parsing the string into
> > the .value member"?  If so, I think that would be nice to have.
> 
> No, I wasn't worried about code efficiency, but rather programmer
> effort. IOW, I expected that the second hunk that I showed could look
> like this:
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index 88b021dd1d..02b02d6813 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1886,7 +1886,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
>  		} else if (atom->u.contents.option == C_BODY_DEP)
>  			v->s = xmemdupz(bodypos, bodylen);
>  		else if (atom->u.contents.option == C_LENGTH)
> -			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
> +			v->value = strlen(subpos);
>  		else if (atom->u.contents.option == C_BODY)
>  			v->s = xmemdupz(bodypos, nonsiglen);
>  		else if (atom->u.contents.option == C_SIG)

This looks very tempting, although too good to be true with the current
ref-filter I guess, as you explain below.

> rather than setting both "value" and "s", and that some higher level
> code would recognize "oh, this is FIELD_ULONG, so I'll format it rather
> than looking at v->s". But it seems that such code does not exist. :)
> All of the other spots that set v->value (e.g., objectsize), just set
> both.

This was also one of the reasons why I decided to set both v->value
and v->s, that is because "objectsize" was implemented in a similar
fashion. Although I left "cmp_type" field untouched for the reasons
below.
 
> > > I think they are covered implicitly by the "else" block of the
> > > conditional that checks for FIELD_STR.
> > 
> > Ah, OK.  That needs to be future-proofed to force future developers
> > who want to add different FIELD_FOO type to look at the comparison
> > logic.  If we want to do so, it should be done as a separate topic
> > for cleaning-up the mess, not as part of this effort.

What I also find weird is the fact that we assign a "cmp_type" to the
whole atom. Like "contents" is FIELD_STR and "objectsize" is "FIELD_ULONG"
in "valid_atom". This seems wrong because the options of the atoms should be
the ones deciding the "cmp_type", no?

I wanted to leave the "cmp_type" field of the atom untouched because that
would mess up this "global" setting of "contents" to be a "FIELD_STR" (or
even "raw" for that matter). Although that seems like a bad idea, after
I've read Junio's and your comments.

Thanks

> 
> Yes, agreed.
> 
> -Peff
