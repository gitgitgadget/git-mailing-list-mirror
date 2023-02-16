Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A17C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBPXgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 18:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBPXgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 18:36:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CF505F6
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 15:36:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q15so214464plx.13
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DhP+uos2SD4HvG5EP6SIhs7ROpZpqgf6sgUkldC1eU=;
        b=Ja3Vr1JcnKnBMtprkYaJqYy4S34wcyXoVgv0712Qp/9GBND9A2AYGtr1XPalZTvrA8
         1eVoTDM3O9q0rAHr3wtiqAip8YxEYvwd7b1YLgvehcaJ2v2QCdbWIFK5cfHcNdCUptMT
         ryCW25k1qA9/pyQJgyLNjrDkbVTSRdYA4BWWWeq0sEOfG9q0zWok05IVgPzxftgwqwwu
         gbDgWSN+XMWt6wPUVAMn8bGvuUfJeiZ7R8fsC+65r/aL768+fTG3wHMB5aYW72M7+jzi
         MA9biRN85neJGmpBZGMRqgT3nrVW2K/dZxenKkVKbdBB0qSyb+QB+GAXeTnRtMBfln1P
         9lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DhP+uos2SD4HvG5EP6SIhs7ROpZpqgf6sgUkldC1eU=;
        b=FCBKO0L/YM1c0p16j2YSVFdz+YG5yLcjB8voJK2GTHAsnY/1w5bpEZWGwv+IrUza7/
         y9HsX0HwBfx6qtQ7P3VczOZ8ZP0B0J02HDJH8G7M48ntQSoCOFF5ogr4ZZQgQ4aRlCnj
         u3BFGzN0IawGYmUOLgqBwGMQahP3xmKvqfGD5cWQo5SiCOnfjQF0K2Oznyy9MSWrcv5U
         1XO+juI+C7A76jsAAiJ2ct6kVLVdw7q9Cw0Sc0ZhsnRkg8AZFY2Iej2cjwrkjPT3zTZZ
         Z3wQRFQTBUlHczdvdwcA07Uz9bdnOmCOo44M6pbr9FIIm5gVL9fL2B9hHUgILV2yMlI5
         UdOA==
X-Gm-Message-State: AO0yUKVmJmuYkiM5eWFpvphIAy4emrLISIBEFlpAGFE3qgSnTEbrlwVH
        kwdddr2NN23tbeDlzjgDIlA65ok0h58=
X-Google-Smtp-Source: AK7set8sWrj/B8iYslU2JbsKWD+j1/ZlsIW9ZLCTJo4qta9KQ6MgQpY/VUClSBdosSauhxScut2Ksw==
X-Received: by 2002:a05:6a20:7fa3:b0:b9:46a1:7f14 with SMTP id d35-20020a056a207fa300b000b946a17f14mr10366924pzj.56.1676590576847;
        Thu, 16 Feb 2023 15:36:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id i3-20020a6551c3000000b004fb43397fbesm1629963pgq.65.2023.02.16.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 15:36:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
        <tboegi@web.de>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
        <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
        <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
        <CAPig+cR3fNVnLcfR0K85YgVo3go2p9cbC9ekdmm=orh0WQ+HwQ@mail.gmail.com>
        <xmqqlekxr0fo.fsf@gitster.g>
        <Y+5nuTbsbuqll5YP@coredump.intra.peff.net>
Date:   Thu, 16 Feb 2023 15:36:15 -0800
In-Reply-To: <Y+5nuTbsbuqll5YP@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Feb 2023 12:28:25 -0500")
Message-ID: <xmqq1qmpnpxs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do kind of wonder if this test is even doing much. It is nice to
> verify the fix (and hopefully somebody with macOS did indeed verify that
> it fails before the fix!). But it does not seem all that likely that we
> are going to regress in this area. I think it's reasonable to include
> it, but if the LC_ALL bit starts creating any portability problems, my
> first instinct would be to drop the test.

That was my thought as well.  I do not see this particular test to
be about protecting against regression.  With the greediness of its
patterns, it is not likely that our future update will reintroduce
use of sscanf(3) and suffer from the same platform bug.  It is about
documenting the historical bug, i.e. the value of the test part of
the patch primarily is that macOS folks can apply it (and revert the
code fix) and demonstrate the presence of a problem.

The refs/remotes/%s/HEAD test does have value---it is to keep us
away from the temptation to go back to the sscanf(3) based solution.
So do the other two to lessor degree, as they cover corner cases
that a similar/rejected implementation would have failed to handle.

Thanks.
