Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB7C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68B42077D
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQA95hOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZWbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:31:01 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55726 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWbB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 18:31:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id z5so9206675wml.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+ppBF9rGobvsmrkwlqmn4LUqdfAumj9KZuFdQqwY2GE=;
        b=tQA95hOhKqvLYJaXQrQFFVLLmCRX8cZNk4VX7NNRYRnijDGKtfKuPITaySFR8QH1KJ
         GyMOdP9eCbxf5087C1ZSFoBS4vbs3eErLb15zka8sQO9BNnDwVt6OSVC9demt57CGJYl
         s/V5z6qIDnLnqGsWESBP/FmCDeKnF8HPDRSf/wAsNRFIKmI9XW0MH1pUZ9FxkHc+KJRl
         rylkwMEMaLJJ+SCjiASNXLDpBRQba3ap8mqjgqFHbHOipzI8CaE55XahUX9FWeSzMUI9
         aZUzUgXiHEaID5H5643lV4B8mmMF3LRP+SKqvpRyMkeCnNcWdSfwtzBFECJ4ngmKEg5t
         y/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+ppBF9rGobvsmrkwlqmn4LUqdfAumj9KZuFdQqwY2GE=;
        b=FxMBLrsh4t45ShP9Qfc9D5v/d+WbdaFItXn1WxFAmJRaIoVIUPscLtUS3HNv2D5+OQ
         D2uZDAJdo/rrd2MIC+fQ7+6Vn5aUl4kQPDeeR9OSIdSJgV5Z1SE6zcfaEaACcr613AHG
         F/7b7NnqqOQlRL/5NPNdkrvjYslFAQpZ+Luc/utblEzlpyXFSjMm9gOKPW2lqH/IptEs
         US+dMhb4AUcFQH39k5S1LpNtv+nSTn/1EYkMZjLoZlP+mI2b01u/LkOaKIEboszWop7p
         YSqKeOhaqJ39F8qrc07YbVi1+ZzRXY3YiMY3uYPYHpiE2/pjKeQMrLyQSYIg49q5xgSW
         2wDQ==
X-Gm-Message-State: ANhLgQ1zjEEoiZA4PNWhLWbSTr/ioaAojgGjuTZ3QhoMIi4eILag2qkC
        U9sz5JMGfUr7HHFRNWmFQ3mw2dWlDFcKkA==
X-Google-Smtp-Source: ADFU+vuf8SVcJaenSPzr8Mg5AgxyMnJWl0P0T9Zl/r6JAE+FdJLwojwf6kadwD0JQPQS5rSZ54DBIQ==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr2305228wmf.4.1585261859221;
        Thu, 26 Mar 2020 15:30:59 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u8sm5242495wrn.69.2020.03.26.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:30:58 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:30:56 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     James Ramsay <james@jramsay.com.au>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [TOPIC 3/17] Obliterate
Message-ID: <20200326223056.csfa4vbuir5lab5b@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 26 Mar 2020 23:28:57 +0100
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
 <20200315221940.bdgi5mluxuetq2lz@doriath>
 <CABPp-BEnYTvakuP9nBi3Q_-mP3i7BJEvKofC3_4N8cO9JkF22Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEnYTvakuP9nBi3Q_-mP3i7BJEvKofC3_4N8cO9JkF22Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Elijah Newren, Mon 16 Mar 2020 at 09:32:45 (-0700) :
> > I am interested in more details on how to handle this using replace.

> This comment at the conference was in reference to how people rewrite
> history to remove the big blobs, but then run into issues because
> there are many places outside of git that reference old commit IDs
> (wiki pages, old emails, issues/tickets, etc.) that are now broken.
[...]

Interesting, thanks for the context!

> As for using replace refs to attempt to alleviate problems without
> rewriting history, that's an even bigger can of worms and it doesn't
> solve clone/fetch/gc/fsck nor the many other places you highlighted in
> your email.

I agreed, but one part that makes it easier in my context is that I don't
need to distribute the replaced references, I just need them for myself.
This alleviate a lot of problems already, and as I outlined in my email the
combination of replace ref and sparse checkout is almost enough.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
