Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC85C4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DAD20809
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjZJdRQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI1TAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgI1TAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:00:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28CC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:00:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o25so1694439pgm.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BlVu9IQo9mzGw2W3cf5fw/G+AIekBZgBUPJvYYACI0M=;
        b=AjZJdRQ6dLf4mvf5E+C/y/2h4HFu0D8ycd1rf56zhwZog03EUwf2rqYe2CMInGGuw1
         /yp6hSjaxrkP2/QdV9Q17j8o0pGrBxh3oluLoOgNEGlIL0wTrKfJ8llPdgOCaP/217WN
         SMf2f096F2UnmwnXiqqSPPGVEFTMeCVRGPIyTdh6vn89ruMFJQ+K2436FWyo2lgd0AhI
         /DBj4fARWy+9Ner7nXRYC2jpUMN0Zz3l5jFYH47ETt/LAw3oZT/IFVVHJJUNVdpQpagU
         GqM1P7/3MCq5G4P5GnI/FBRCwDkWWDTBahien++2WQk4CzAVrZ4aAk/QrYcRyGItrYuu
         crvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlVu9IQo9mzGw2W3cf5fw/G+AIekBZgBUPJvYYACI0M=;
        b=DOHCLC2clVEIl0GBU8d7l5oRxiLexv6BlWtunk22dmWGf6ojw0CqGoqNqPMB6jX4eR
         Nsj9OqszsmfECZ3o3jNbUPu0j7RuTaJld2PdEqVKhXfd1jAx5tcVrIV7IjBimN8x4rz2
         KGwqZU6V1/mw8RskIixkzQgCtRdP+yaLRn1l0lARhdIEFR05cwHZWPYYc9NDWiSyBuTf
         SPramvP0rtaASYOj/eRhBYnGJoRD0/YXRYTvbCyvNWELCvyoEoI2lBRabE9JaPRkbRUV
         4KaiHvRmWk3VGSCglBlmkLvrq8cFqH1PtmZdPKAVXNx13U7qtl7eCxvJq2uS20Njcpb0
         3iCQ==
X-Gm-Message-State: AOAM532ZU3mnubsEny4DrHg73pWyixrnbx1YVVGmjP+gVoeuFXnTD/tr
        PH+LGJeLdKf3Byiju6Zqzk8=
X-Google-Smtp-Source: ABdhPJwsM5JCdnoVjPFIMRvl0yDn5n8TDqmWQxLX5hzbEWtw8qffA38h/DKZR1SXG6+dNIzAR7LZ0Q==
X-Received: by 2002:a63:1016:: with SMTP id f22mr387031pgl.226.1601319632232;
        Mon, 28 Sep 2020 12:00:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id a27sm2649416pfk.52.2020.09.28.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:00:31 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:00:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Evan Gates <evan.gates@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Doc: note minimum scissors line length for mailinfo
Message-ID: <20200928190029.GB2285677@google.com>
References: <20200925191659.31375-1-evan.gates@gmail.com>
 <20200928183559.GA2285677@google.com>
 <xmqq8sctn332.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sctn332.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> It certainly was fun to declare that users can use anything that
> look like perforation drawn on paper, and to pile more and more
> heuristics to detect such a line.  But I think, instead of
> describing all these details in the manual, telling the users to
> always write "-- >8 --" and nothing else would be a better approach.
>
> It would save them time.

Agreed, I think this is a much better direction.

Another advantage is that it makes us easier to change the heuristics,
confident that we are training users to aim for the simple and
reliable case instead of the edge cases that may need to be tweaked
over time.

Thanks,
Jonathan
