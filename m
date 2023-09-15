Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB9EED61E
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjIOSaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjIOS3u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:29:50 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7005269D
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:29:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c2ca01f27so2862967b3.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694802580; x=1695407380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Armbu1j6m2br43z532qzNzzWfI8dNXo/P0v3qD1q7PU=;
        b=SXOLPwsnuAlh/aOlixZrB3u5WSDT9JRl4OXrftm7mKr7QA3srZcmIWsy+goNSscf73
         NbU8Rb/25E5avQonBC3ylSCjOOfceR396rqNK1oP3LtoSrYj8v0ofiromyXkRGYo66UC
         vNDYMDpFk7tulJdC2seEY9Ue8Mfsbp6usu3towgo6vDG8jLJN1IkJjrG7Fi+RFNdXsNe
         a+8ZRRmNYlmjp0Mu80t27+bePmw6F41qK4FN9dSo/m+SzieGK2yFK2ei4kcUPVMinK0e
         jk6C79BCavN+v2SV8OWGYFbLsS7wbMQr2V82PhHmAT9ZvZXpki5bGg+DOQB5w+ZZHfc/
         KVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802580; x=1695407380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Armbu1j6m2br43z532qzNzzWfI8dNXo/P0v3qD1q7PU=;
        b=syGI1Bs/6QI5RczK7/yOGboRmI8tLrRgUykvoPjlkyhfqa/0sXNobWY2UjTakJ2554
         tLmFThD/1+fCt2VWWo229Z1sPSJ9bzSv+nMnRCLOzG5RyAO9x4Vj87ycNv0j3KA6fR0h
         DTwrTspLVaPyQr7mFHeu115LsEu4SHlGiEtFjr3ymLPFvMXbKmLPasrNJBTOXE6qAzgW
         G+5XjbVRLFQQ8QFPQER4o429cRkmKg4KGju559hIE0cO5TwZKYNEtVBcsicOhXGJX/ta
         zzVemzTAF41VUyNVLsD96eL9ptKLsymBnppAddu4WDJley6UD/IOaaVpp7BS/tlzu6kz
         56NA==
X-Gm-Message-State: AOJu0Yz5OtXSXZASpIhyqjnxdjlSz5p5uQCEsl/yKtUJc2NboBtQwE0P
        W3sjMkq/lGdctw1xvTTUCSocKETNDx4Rnb4wePTHMg==
X-Google-Smtp-Source: AGHT+IF+E0HDEQL/1lI4t3pFBl29zfYCJu5fyTa4N6K26m9Qfmi3rSvQpGWzOTWgn/TmDavctvxo0w==
X-Received: by 2002:a0d:eb13:0:b0:595:733b:38b with SMTP id u19-20020a0deb13000000b00595733b038bmr2623504ywe.19.1694802579825;
        Fri, 15 Sep 2023 11:29:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y18-20020a81a112000000b0058451c12076sm998880ywg.14.2023.09.15.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:29:39 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:29:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] http: factor out matching of curl http/2 trace lines
Message-ID: <ZQSikid1kgbjCDJV@nand.local>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
 <20230915113316.GA3531587@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915113316.GA3531587@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 07:33:16AM -0400, Jeff King wrote:
> We have to parse out curl's http/2 trace lines so we can redact their
> headers. We already match two different types of lines from various
> vintages of curl. In preparation for adding another (which will be
> slightly more complex), let's pull the matching into its own function,
> rather than doing it in the middle of a conditional.
>
> While we're doing so, let's expand the comment a bit to describe the two
> matches. That probably should have been part of db30130165 (http: handle
> both "h2" and "h2h3" in curl info lines, 2023-06-17), but will become
> even more important as we add new types.
>
> Signed-off-by: Jeff King <peff@peff.net>

Makes sense, and this sets us up well for the next step in fixing the
test fallout from newer versions of curl.

Thanks,
Taylor
