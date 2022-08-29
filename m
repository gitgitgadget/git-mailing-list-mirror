Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB3ECAAA4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiH2RaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiH2RaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:30:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AE022515
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:30:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so5454023pjg.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=fjwLmsUiL3+QzFGzu74IQoyuFOcoYoG3bmGjWx8UbXQ=;
        b=TFEojd0K4SjQK90OfEfCXVytFtnb5O3K/18q3QWAaPVkmPihOVlGeFvetyatQFcBPs
         uuAHlW+56KYbuHRvESfTHfoEdDkZnqq5wbqTdx4XPUcqOlZsrPJP2tW+qlpLrHCN64fy
         dVLVvEKIa//PiSPQBLZKpHdAFH3VWACdsPPfrBViC3GwtsyyyrWDpWJHfO+O8KV3/A2/
         CXdW3FlVS39kXehtOWH2fJC2hLWEEBeCbO+zowx83VNwZszI4Mx+KWbMRcqUaZoB4DSP
         F/VkjAzHwYHZkoe83YDf8dbc00EHfgO0eKUCiIDuxtdN502/VVan+92z+PbgqX3n+pD2
         e9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=fjwLmsUiL3+QzFGzu74IQoyuFOcoYoG3bmGjWx8UbXQ=;
        b=GrStUFmOsd1jJ0dgQi6mG86L6+tHYntq1jFQipWj94W+/YzbD0UrMg9lUo1W+DXMJX
         Res9pn0bcAjNiCeXRMtzdFMfApsVP73tI2sYQ8v3IiLbur2CO6uMnm3qsT3bsGxrSlh1
         FT4qJM90FoO7fBXUpfnZWYo9cp5qmlJDE7EERmYssrPOZzj638BScCubyYJBo9PL4kiZ
         PHk07xNeRcCQAv8fwjAmy/29f6UoswZzkTUt3epRxIwsBj1+WC4DyjNlQye+onQEnQPW
         h081YPftFqoxQAh1uIMrVUECvlnpK1kfwGSUhDtegJGYYgMzQgARRG8HZ2UT/cbjSyw9
         doWg==
X-Gm-Message-State: ACgBeo1M/Zx6ek2jMwBFt2nlUTdEvSoGZ/lSi4iyEeH4RLspKryR8uZ1
        xyIJTuJePIfDEi4mNE+0dQxiAC5dz4o=
X-Google-Smtp-Source: AA6agR4GdROXdhr2jz32c/MLAG6lklYmamgpO1K8ULSIxkkqyiYdjmBFGJ71RIGEBerwGdMyC18Vow==
X-Received: by 2002:a17:90b:3506:b0:1fd:9a86:2f4c with SMTP id ls6-20020a17090b350600b001fd9a862f4cmr11332687pjb.99.1661794199886;
        Mon, 29 Aug 2022 10:29:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm7911898plh.170.2022.08.29.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:29:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] pretty: separate out the logic to decide the use of
 in-body from
References: <20220826213203.3258022-1-gitster@pobox.com>
        <20220826213203.3258022-2-gitster@pobox.com>
        <08p469q7-2os4-p391-9nr4-10q7o9s4414s@tzk.qr>
Date:   Mon, 29 Aug 2022 10:29:59 -0700
In-Reply-To: <08p469q7-2os4-p391-9nr4-10q7o9s4414s@tzk.qr> (Johannes
        Schindelin's message of "Mon, 29 Aug 2022 13:32:27 +0200 (CEST)")
Message-ID: <xmqq7d2rot48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 26 Aug 2022, Junio C Hamano wrote:
>
>> When pretty-printing the log message for a given commit in e-mail
>> format (e.g. "git format-patch"), we add in-body "From:" header when
>> the author identity of the commit is different from the identity of
>> the person who is "sending" the mail.
>
> The quotes around "sending" made me stumble over this a bit. Maybe replace
> it by saying "the person running the command"?

It reads much better.

>> Split out the logic into a helper function.  Because the "from_ident
>> must be set" condition is there not because it is used in the
>> ident_cmp() next, but because the codepath that is entered when this
>> logic says "Yes, you should use in-body from" requires values there
>> in from_ident member, so separate it out into an if() statement on
>> its own to clarify it.
>
> Even after reading this three times, I had trouble understanding it. I
> then consulted the diff and started to grasp what you mean. I have no
> good idea how to improve the wording, but maybe you can give it another
> go? Or simply state that the condition was untangled a bit.

Yeah, (pp->from_ident != NULL) there serves two purposes.  Whatever
else is in that if() statement, the body of the statement depends on
the pp->from_ident being non-NULL and the control must not enter
there otherwise.  The other purpose is to guard the other half of
the if() statement, which happens to be ident_cmp() that looks at
the same pp->from_ident and depends on it being non-NULL.

I think the condition gets much cleaner by untangling it to

    - use_inbody_from() function does *not* check pp->from_ident; it
      just assumes it is not NULL 

    - the caller becomes

	if (pp->from_ident && use_inbody_from(...)) {
		... stuff that use pp->from_ident ...
	}

> P.S.: I do not know how strongly you feel these days about lines longer
> than 80 columns, but personally I do not care about this rule, so I am
> more than just fine with adding such a line here.

I allowed wider line for function decl, by inertia, for
greppability, but I should fix that.  Thanks for noticing.

