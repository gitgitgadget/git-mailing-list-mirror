Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A3C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A45261038
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhIWCKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhIWCKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:10:12 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA529C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:08:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d18so6028855iof.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7M5VinBlOHculYiOSoKmhlFqKKLgkc6iZRkU1GwKrdI=;
        b=JwpMuN6ESbnfRorwMhOCc6eNoxTJYoUilU+LBZwWzvWH5kl/VJYKdcq6shDOnJLE4B
         QMsOTpl+IMVsnRJymWTp/yx6THKJqyJAhaR/qhkYhy6Ri5z9Yn+iPQe7raFJYWeigOxY
         hg5emExu8eV5gmeiSenlek1CkZ6uVW0EkVXBz03YNUh5G4cb/P8x2BhpkB+ZvuiwbPWy
         BSnIRP6ulXiS+PwLludEmXVQRyAw27chhk2+J1o106fIx3iHop0BQ0saOZ2usCp6VXnV
         l8Q9SqB1rG2dXV6F51x+ZwpfkK8k0aGbTOCjKHS9XS0kxbAQf8Kn54AqZkgjntTFO4jw
         oSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7M5VinBlOHculYiOSoKmhlFqKKLgkc6iZRkU1GwKrdI=;
        b=50xnsVr6/wmyc9oJ23pRR1gkdR8ePNAHezyqcY+XSrN8CnJLIqsJJHkke9aNroUv1f
         xhW31NIqXPpdzDqeVX0c1XA+3kSqXGkAFSY4IAtX1ce2Y8pK5lU9NKLcDi/pmbxEReJu
         qqvog9fK6XxNA/jHaERLfUXEy1ABSPSiqA48nMI51pNYT9EJUYz50+7wTbv8jHYUJcG7
         1vBsvueoKM6HGhzp+st2sMdrbLrtrwliP+Aci+SCDVppgPIBq5mJCAhm9VGNkkP08xjL
         YowH7iCNfi01MY81WbTxuG4ht6/wBiGSOkXnypW69AOvMVUBwgi0IsMS0QKibsyIh3ZB
         tPXA==
X-Gm-Message-State: AOAM530ieFbLkVSEAm7YBph/GDZyv0TWcWIj3alKUswa5cKbazFaxmTd
        geLXVDIIXTib6J42aHthm9jlfg==
X-Google-Smtp-Source: ABdhPJzFVAw8l0FPR331SD5P4v5ngIAgNmSllCg8bKwIj/q3n9v8WfQBNC+6+1qDpUouvmWuDk++/Q==
X-Received: by 2002:a6b:3e84:: with SMTP id l126mr1843938ioa.151.1632362921063;
        Wed, 22 Sep 2021 19:08:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d67sm1731734iof.50.2021.09.22.19.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:08:40 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:08:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 3/8] midx: preliminary support for `--refs-snapshot`
Message-ID: <YUvhp6EVPEPwuKZ4@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
 <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
 <YUuvjZl43k3G2SBn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUuvjZl43k3G2SBn@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 03:34:53PM -0700, Josh Steadmon wrote:
> > +		object = parse_object_or_die(&oid, NULL);
> > +		if (preferred)
> > +			object->flags |= NEEDS_BITMAP;
> > +
> > +		add_pending_object(revs, object, "");
> > +	}
> > +
> > +	fclose(f);
> > +	return 0;
> > +}
>
> `buf` needs to be released here.

Good eyes; thanks for noticing :-).

Thanks,
Taylor
