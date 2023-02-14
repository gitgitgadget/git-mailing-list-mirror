Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F3CC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBNVec (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjBNVeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:34:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB3171C
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:34:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso60341pjn.5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpVTQT9Xx/x/B/PpHZ1NY0d+MuAJezsn2nepniGXFIw=;
        b=C/NoNYpl1fTlWKzl8Yyvef2Tw4BfBfAs1GNeF+DcrHTIKyPaRmixTOLTDM7mwG2jxM
         JGXMcTbU1Kttcq+LUb81eU1T/VOJT3PsuvTrjsTqfiFOlh5LV7xi7Aibp8BzD4/Jt8Rp
         ur0eQ/DAVMlgxpdEnMeFLNTq/qlhrmCUOfSrpi02QlY4ft0n/ARB0QL4qW7YHlHv0vyZ
         dk5MWgBn2qNGzhJ8JNmgJEhVSqp8qerqfPrikG+FNgdPLLriutjkMnkgyLXOSWoYl3pw
         EECCZYDywxY5wnjeMZY5VN7ILEK2YanJOM6SpBmUb3C5zJqegLjIMA0FWVCq4B/SE7pj
         JWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MpVTQT9Xx/x/B/PpHZ1NY0d+MuAJezsn2nepniGXFIw=;
        b=N7N8G76YWHHRPb4eGVWHKT/Hb2XLVLHRSEa5GzOEgJE/OnlVXX1qp4ukTkV1RoO/qr
         aLLlAfzznBW+hCUCvDVDrs951AAIpve5WJauahZ9lcUz7aN0yZAXNtUFCoK6smXD7Lvf
         FBBeOKs7TbnBf8gEvTlX7EpsL8XcxGH1W/uBp2UBfYImswhDz00+gMnA2xspiRPRnFbw
         Ctf9WdVrzMYFD+ODFAaSSpFyY992jxu+QWzUjTut1QI6i0Y9ef3wujLjmKeQGUcA1mGq
         vgydqGkgJGFgVh3TQaLyCJSktyPuTBD5rbCRI9zOxkYINC8tBr1xswR3RLOXKcyT4y0S
         f5xw==
X-Gm-Message-State: AO0yUKU8/jEqeRo5XCHGMvII76Id2C5XsFngPa7hMEin8ebC916NBaXF
        tuDscH5bsAG+LOackhcKSGShjnSPj+s=
X-Google-Smtp-Source: AK7set9Uf6+zvDKFtoJyhS6cWQ3JwOSAa7DkEo2TOCU7LRrpsmGKubaffkidUfyBr8YeiOkt95u3YA==
X-Received: by 2002:a17:902:f687:b0:19a:c4a0:5b1b with SMTP id l7-20020a170902f68700b0019ac4a05b1bmr1371109plg.1.1676410451515;
        Tue, 14 Feb 2023 13:34:11 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902a40a00b0019663238703sm10665497plq.109.2023.02.14.13.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:34:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES
 constant
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vVkhB59XYys4C7@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 13:34:10 -0800
In-Reply-To: <Y+vVkhB59XYys4C7@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 13:40:18 -0500")
Message-ID: <xmqq5yc453u5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The current count-up isn't a big deal, as we need to preprocess that
> array anyway. But it will become more cumbersome as we refactor the
> shortening code. So let's get rid of it and just use the constant
> everywhere.

OK.  As the array is constant, we could lose its NULL-termination
and -1 from the definition of NUM_REV_PARSE_RULES, but that has iffy
upside, and can come on top of the series if we really wanted to.

Looking good so far.

Thanks.
