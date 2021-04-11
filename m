Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D467AC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 08:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B1F610E9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 08:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhDKIwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 04:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKIwV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 04:52:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B86C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 01:52:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a7so15291298eju.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2N7NLV1gTtURP1P/03WOqqZe+v2zoZLlSL5F/zZc9pI=;
        b=BPPpXFV3dnhxeY+/4g/0b3slO62uAQWFrpSYkFKfO/R+cPfUabhW491ckEsmMQb+CL
         SZ/xuvQOQIo6EtVCCb9TvzxzC1SpYnwvYE9JB8r3rWON13s7px0jvu5KULzNJ+sewaRX
         YGAE0L+Wtc052ni31vp7ImJTEAAixUwKe+SH7+l5q+/ckFUi82zcJAuy4D0HscSwld7/
         biTFxyVlpoIDLPluKiEHyC/kRk20T85xuNvTONY2CP5f/HPgYYdbfGMddA9cnr21QBP0
         U3pEG3JEpAXDU9V+aF5JsG9RA/iqvp0EaW8ICajkIdHiifA4DDrDRO76hg19Xx/ELU58
         Fq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2N7NLV1gTtURP1P/03WOqqZe+v2zoZLlSL5F/zZc9pI=;
        b=Bbj4V+4/WLvAsCmL5afJ8q5CUhLeTwhJ5tMIC82iJFKRDxfh+cRpSTJfxgRwmRvQNd
         /WKLDkQfCUxmPnRzektJEsuLlWxEDlU+4tgpltQTKoRAgIsP+6UPt5l+S630oEPk+YYj
         oiQFGH6bb1f9JW32EV4vzXvrOYSx2HWiSxh1DEtM+DUZUOpCtDCJaUvdddQa5gBWziFN
         9YrnhogPoG2+SM1MUnWAJeOyzpqlUwbIGEu84u14x2wcgTUODf6QjXe5tpiAO5li6d7Z
         bRJutiolMBVrYUP3Jm0JnYKrUROuIgkInqfIfuhQ+qzl6v/0k+h5XCkXwztR5tc8tUQl
         KB0g==
X-Gm-Message-State: AOAM53285GzzZJ+uxpI+MsTu7C3YgaMqIQJlbPg4XjL4Oj7O+K3nmxSq
        8Pi5IQQmKxP1Jfz6gpXgL7rlzzKHH78=
X-Google-Smtp-Source: ABdhPJw5iDs27a/gxqa2vn40jh363i+HvDt33o79XSWhXxudlBrBNDx1i83VUzLUmBN1nWRxrAN6vg==
X-Received: by 2002:a17:906:3886:: with SMTP id q6mr22478972ejd.118.1618131123524;
        Sun, 11 Apr 2021 01:52:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gt37sm3701858ejc.12.2021.04.11.01.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 01:52:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] builtin/hash-object: allow literally hashing with
 a given algorithm
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-3-sandals@crustytoothpaste.net>
Date:   Sun, 11 Apr 2021 10:52:02 +0200
Message-ID: <87sg3xfbkd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> +	algo = the_hash_algo;
> +	if (object_format) {
> +		if (flags & HASH_WRITE_OBJECT)
> +			errstr = "Can't use -w with --object-format";
> +		else {
> +			int id = hash_algo_by_name(object_format);
> +			if (id == GIT_HASH_UNKNOWN)
> +				errstr = "Unknown object format";

An established pattern, but shouldn't these be N_()'d while we're at it?
At least for new strings.

> +			else
> +				algo = &hash_algos[id];
> +		}
> +	}

Style nit: if .. {} else {} not if .. else {}.

> +test_expect_success '--literally with --object-format' '
> +	test $(test_oid --hash=sha1 hello) = $(git hash-object -t blob --literally --object-format=sha1 hello) &&
> +	test $(test_oid --hash=sha256 hello) = $(git hash-object -t blob --literally --object-format=sha256 hello)
> +'

This would be more readable and easier to debug with 4x tempfiles and 2x
test_cmp.
