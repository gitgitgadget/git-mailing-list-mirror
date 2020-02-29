Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB6C3F2C6
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 17:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5CD2467D
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 17:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMzX2+n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgB2RP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:15:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgB2RP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 12:15:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id e10so5771367wrr.10
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PS9lwG0a4ILFxm18/HfEOY1YS8d9U28PItuH5aycpLU=;
        b=VMzX2+n6dWx8YwO+wAsqwScTZmyv7XaspmT5OeACuFLGMUWYUY5K6acBow7/HSXnZM
         E/8aRmJmNzC6kKkHHkqN4u7mBWhbAvC1Yho8jEv48R2TWHKrlYBVd5HvH4fd3e1RpqvG
         FTiQIB9OVZNeZ7k3rmAqPzln5nP33yy22A9BPFstWL7oVeTPtxjECEeo5BX+smsyEdMf
         xhPTc20VgSdpaljhUWziVC8BAJzqAOwR967l2IlWvVJf+XDnfkCS79e/VHx8OzsWsC+h
         GjD4x3ewhsQQrY/4tCmKp7GOqh9rELrm/3gMs4BIVllXAsntRvhcRG8mfE1PDUBkE1tW
         O1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PS9lwG0a4ILFxm18/HfEOY1YS8d9U28PItuH5aycpLU=;
        b=ceqcl674vUrAosDSPpUaMDQmhfS4QmCpCoDpLclxx1PYAJNltNZvl4O+wJHMX8koXM
         EdNdH+oRGk8cVFDedFA0ee7NZz88UCsr4LhP9CCYaEZssN1OnFU2opJFMMwn37626BiR
         3y1JuW7s5x8euj/PHJ3xrY5Jqq836wyiY6ngg/Vcfp+LC8F9gbRBtGEe/paj7l1IyhLy
         NaiCQ7vWEAnmRTej8n6+4qzhjRUn6YgaBaxzO069tH8ene9CRr6mw/0aaP6KNNZCTEng
         ERE0ZgNS9C1FOuk1RMkgou24PPc2gEVwFOdDIaDYu4TINwpVuT6fIH3Jd3M9YyYL5HO+
         O3vg==
X-Gm-Message-State: ANhLgQ2Wa2Lh93zIcvSadBGENxQseBL7KDMA22A4nR8OpscnddflpSdt
        jeHMY8XSyZbQl1Ahdvs9iFP+fFQ/vqpXjg==
X-Google-Smtp-Source: ADFU+vvegzetKX5VmBTpKh2O60IRzmr11gkjs4qcJTyyeBdO+G5B40CC/6Iktl0aLnRErJlAtvmjPA==
X-Received: by 2002:adf:d086:: with SMTP id y6mr361819wrh.387.1582996553315;
        Sat, 29 Feb 2020 09:15:53 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id o24sm6900786wmh.28.2020.02.29.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 09:15:52 -0800 (PST)
Date:   Sat, 29 Feb 2020 18:15:40 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] midx.c: fix an integer overflow
Message-ID: <20200229154241.gxwb4u7l5u6iaveg@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 29 Feb 2020 16:39:03 +0100
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
 <20200228185525.GB1408759@coredump.intra.peff.net>
 <xmqqzhd2cup5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhd2cup5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Fri 28 Feb 2020 at 12:39:50 (-0800) :
> "Count up while i+1 is smaller than..." looked extremely unnatural and
> it was hard to grok, at least to me.  This

> 	for (i = 0; i < m->num_objects - 1; i++) {
> 
> might have been more palatable, but yours is much better.

This is probably a question of taste. The
	for (i = 0; i < m->num_objects - 1; i++) {
looks like someone who forgot to use <= instead of < to me (until the body
of the for explain that we are actually iterating over two consecutive
objects), while
	for (i = 0; i + 1 < m->num_objects; i++) {
makes it clear that we are iterating over two objects (and has the
advantage of not overflowing :))

> > Though I almost wonder if we should be catching "m->num_objects == 0"
> > early and declaring the midx to be bogus (it's not _technically_ wrong,
> > but I'd have to suspect a bug in anything that generated a 0-object midx
> > file).
> That, too ;-)

Yeah I'll go for that solution in my reroll.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
