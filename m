Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600FFEE01F4
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 17:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjIMRSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjIMRRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 13:17:55 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2826BE
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 10:17:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-591ba8bd094so483557b3.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694625449; x=1695230249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXze7k+BvmG9nP2TS44l07KxaqMzUHUyEcH4ie4kiaQ=;
        b=lfDP+LsabRlQH3w9zFOB32tSI/1UQyvX7fi6sLUxP5m1ZJ32DD/sw0cavJFhtVhAhG
         6kB6WJEjRbv8YxEjmio8Nr5ZLb5BUxkiCSk/c3GGjesQ+cPDgdKiN6t4lQFl03TBqFgS
         NQzWCBdEaxtQRrqsFPCJ+025ZPcHjSD9IJZTcX0bXZlohba0fEpxXEnq7Lhtiet9o2xm
         gZ00kg4yRvh6LIzkh/TBkdl+gr3Shw7dNJDldaFb6EoD/cg0v/oeh8CeRtzKEfAvq+b1
         ktcErJnC6y0tXizpvcfRNzcYvxkTclQ9SbFGNYFWqy2bbiw6Iq8qq1FUXV5SIYLbzTUm
         zKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625449; x=1695230249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXze7k+BvmG9nP2TS44l07KxaqMzUHUyEcH4ie4kiaQ=;
        b=e/cucF8EkzIRffTkF/2qO0yIHrkKIqLt2J+sd2buw61OZ+nOa4OA+GtZBgkqQZiHdz
         dgVZO5MVbayASRP04BeOybfpJsYdKYpPUPH2h0R8i++BU3ShWeGFzMgz/29GIyGF4/dm
         +dh09OBAAk/CvAolmrl4P6Edj7hoQogq2tiWa6mvTCRJub2ZZFHm3sgyfz3WmSFKvkst
         w1TJRvLhmDQPmpCV2tZjlDKyQ0eZMNV2ZGWEF12DpAWJ+1TkJ2Ey+Xr9+RArnKvjeMur
         ziEbxcGBT6fKozi4dF2FalA9WgQhnIZ8pBy3TtF8SQCqrGMFLfG0Gv1jkzDQDqdLIUq8
         446g==
X-Gm-Message-State: AOJu0Yxhns3sVkJmSmWCxuonVc4NrjkC+iCc+Z83WD8CMpNSC2k7qxRy
        AL4O98F3ewBrwlFCEyboVa7nog==
X-Google-Smtp-Source: AGHT+IG0XFzYLCOf5q9X3nMSwVvqYTObf127l4DsJw3KpGWrcTOvxOJ3LnHFGxkeyndO94iGrVIGmg==
X-Received: by 2002:a0d:d4ca:0:b0:59b:1bf9:b2db with SMTP id w193-20020a0dd4ca000000b0059b1bf9b2dbmr3573496ywd.13.1694625448802;
        Wed, 13 Sep 2023 10:17:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r15-20020a81c30f000000b00592548b2c47sm3188901ywk.80.2023.09.13.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:17:28 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:17:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] revision: add `--ignore-missing-links` user option
Message-ID: <ZQHuo6oKoivXwdrC@nand.local>
References: <20230908174208.249184-1-karthik.188@gmail.com>
 <20230912155820.136111-1-karthik.188@gmail.com>
 <ZQCa3GHT3D7aibJ1@nand.local>
 <CAOLa=ZSVobP9Be9W3f1BWoZjLUYwOqOpCQMCXVH34=iGKfXnmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSVobP9Be9W3f1BWoZjLUYwOqOpCQMCXVH34=iGKfXnmw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 11:32:13AM +0200, Karthik Nayak wrote:
> > From my review locally, the resulting changes (which can be applied
> > directly on top of your patch here look like):
>
> This is much better. I didn't know about `test_oid_to_path` and
> `test_when_finished`, and overall your patch looks much nicer and is
> more thorough in the testing. I'll add it to the next version.

Thanks for folding it in! I felt bad that I might have stepped on your
toes by saying "here's how I would do it", but by the time I had applied
your patch locally to review it, I had already generated the
aforementioned diff.

> Will wait a day or two for more feedback before I submit v3.

Sounds like a plan :-).

Thanks,
Taylor
