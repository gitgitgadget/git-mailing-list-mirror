Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79EC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113582224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dz7uV/Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392121AbgJTVsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbgJTVst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:48:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DFC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:48:49 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v200so303309qka.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NrXtC7+pka1j1Q4yu8/076xy5HeSWEE6058mBDQicuE=;
        b=dz7uV/XlWdI2FK1nHQ7pbWmmp5c5EJqJaopMTL/gLDlV+P2vcc0X9RweI1CbHeQGyB
         HkIZHmrui2Oo0ASTaE5e+GyC/eFxQHNyruPTXn5rKPirRWI/Rau9Z/vyQUI+DsrvGXVn
         4rTGkHRDv0l2+2x7TNEELOO6DgyS7X7E+yVBfhfwQFF2/YhIURQNfVgiZqTEXHuboepO
         uDFDAUq4NdOoDmO1PbbbhrbTA1nkPk9O3NeBTnsUQYI/2AMftn8tWgTEC42NK5S6mBRL
         ZbsIgy4LzKJLZO0qcUSumrBY11Udgf8YAff1/lvhblIt0HMhxp1d7Em7IHg3fO5sq0Ji
         nEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NrXtC7+pka1j1Q4yu8/076xy5HeSWEE6058mBDQicuE=;
        b=lCMJgilufeQtjDLiHX8Jr98AEwRFUCEeAbnG3uFwCg7GzymI26LG5Q5Rc9ZrLZKeK/
         vcg0hY2nKb34laRpU6o1gbqQBedOG4uKQpEjRJfdnhSxLFWcH/5TI1jkEJa63SXjHJ7D
         4GfSOvQVyriP6AHpF5aXtydak4sKyNFCWKBoUUxjO0jmnZpxQCWE/6oho208JcJhY1g7
         iIF0gIKluItoOIf+IfXIpGUuWZmqcFUZ0gvRfUr4TImhj/8QktxIJ1SPbywqvJWCepLY
         tCBHKYPt9kOI8oU6YCy5gzXuyssFzQN+pfEk2FAM7PhbkpfMoKyn/mwXwPDB6XXwIQT9
         +epA==
X-Gm-Message-State: AOAM532g2QUwPb6GFj3zTgGFr2ocdXToFcH39P/fnJNWaeFpZxu6I2o0
        ZWxMflbuBQo4XySL+vNA57ClKA==
X-Google-Smtp-Source: ABdhPJwAjzSanF7uhwl80aC/UfIrPOTy/tnpw4It/Jc0UouxIbVlQOtvWWoQX7FsXq4gyJf56j6fEA==
X-Received: by 2002:a37:a5cd:: with SMTP id o196mr323959qke.374.1603230528999;
        Tue, 20 Oct 2020 14:48:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id i19sm1408353qti.71.2020.10.20.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:48:48 -0700 (PDT)
Date:   Tue, 20 Oct 2020 17:48:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/4] Documentation: clarify and expand description of
 --signoff
Message-ID: <20201020214846.GE75186@nand.local>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
 <xmqq8sc0d91d.fsf@gitster.c.googlers.com>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <418d15c53268f947e11dac2f22d1f8c3c8c60997.1603155607.git.bkuhn@sfconservancy.org>
 <20201020214431.GA1398231@ebb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020214431.GA1398231@ebb.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 02:44:31PM -0700, Bradley M. Kuhn wrote:
> > Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> I doubt Taylor cares whether this Reviewed-by trailer makes it in,
> but I did add that too based on Taylor providing it earlier in the
> discussion of this patch. ☺

He doesn't ;-).

Thanks,
Taylor
