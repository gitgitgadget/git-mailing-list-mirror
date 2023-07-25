Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24048EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGYWwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjGYWwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 18:52:22 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D244C0B
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:50:21 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5701eaf0d04so72755727b3.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690325062; x=1690929862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0VIxeU8ZPuuefIgohzHEuzma6HLeiahvdNh6sf9wKo=;
        b=bLaeiGJSQ063R+gkwH7wxCdA5RGKZjgiBJIzxzxv5hIVc3xUZlxEhanmK8j8P0U0et
         hiYSSHjYIXFqZNwLpI5kais8Py/Bd4JwwijCxqB8qaftRQq/ehIu3EAnTbTZZbG0HJH4
         sPA85lbLqfRWq4uSUOpnA9LFH0AyUxqRFeqYghRi4OBS/c1nCd36+slj2rFwp4HMUqb9
         txOaguESPiHKtaJB/w+JZd2929lHYRgdwINRceGudcKAoUCPPz8tCaNge/1AWOTjfiqv
         gXSs5VkHWgcisXeTB6EyswhmFQfRhWk3P14IheovVuvvLkgdhsVOoaqLpSkcb4xvAHTr
         Wtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325062; x=1690929862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0VIxeU8ZPuuefIgohzHEuzma6HLeiahvdNh6sf9wKo=;
        b=HiodNBLhKoMQebKkRgdbvaY3af/WY5y4nJhN7WMqf/EXWalYypM1z19+E377lADR9/
         GuU91+GlKctH+DTLrc6Z/w04XbpNRlfAwL5CGWfqmrXbfSZdNN3eWvwCorCjPKggzobs
         GPQyhMNkoqVxUmFUWSjyrwcbdj+QIYtY2dQalQ2uzAZvf8n6SjoYuV6gnhVB23mslddc
         dJwwk5Fr043cuG+A/13mgG/YFRvYc79yzXbcSGTpfcGVYszHGKUSlEzh7Y0lhMgFU9BX
         Xq6qxreGZYxQ4aAmlUDzSIBQNXcUh02gj0F99WAW+sHV/53nAl5dS3L/xsfm0q539yMm
         ANWQ==
X-Gm-Message-State: ABy/qLb00MZtRRRiOO+YHSdGKlAscrC3Vk9kgLG7B6NJAiJVVcSjPpUe
        IxmwQ28SUGtU9m4CsONYuwCPXw==
X-Google-Smtp-Source: APBJJlESR4PSygucUylperuX9DRXVhd3wg2Y/J8y5U1ejaMvplus9ESae8r+ZFO5DchXBwCg4lWnYQ==
X-Received: by 2002:a81:4fce:0:b0:57a:5b6f:d41 with SMTP id d197-20020a814fce000000b0057a5b6f0d41mr487485ywb.42.1690325062282;
        Tue, 25 Jul 2023 15:44:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r142-20020a0de894000000b005616d72f435sm3838332ywe.116.2023.07.25.15.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:44:21 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:44:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/8] t/helper: add 'find-pack' test-tool
Message-ID: <ZMBQRRppsadqa8Ua@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-3-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-3-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:03AM +0200, Christian Couder wrote:
> ---
>  Makefile                  |  1 +
>  t/helper/test-find-pack.c | 35 +++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c      |  1 +
>  t/helper/test-tool.h      |  1 +
>  4 files changed, 38 insertions(+)
>  create mode 100645 t/helper/test-find-pack.c

Everything that you wrote here seems reasonable to me, and the
implementation of the new test tool is very straightforward.

I'm pretty sure that everything here is correct, and we'll implicitly
test the behavior of the new helper in following patches.

That said, I think that it might be prudent here to "test the tests" and
write a simple test script that exercises this test helper over a more
trivial case. There is definitely prior art for testing our helpers
directly in the t00?? tests.

Among the test helpers that I can think of off the top of my head, I
think a good handful of them have tests:

  - t0011-hashmap.sh
  - t0015-hash.sh
  - t0016-oidmap.sh
  - t0019-json-writer.sh
  - t0052-simple-ipc.sh
  - t0060-path-utils.sh
  - t0061-run-command.sh
  - t0063-string-list.sh
  - t0064-oid-array.sh
  - t0066-dir-iterator.sh
  - t0095-bloom.sh

I would definitely recommend adding a test here, too. Like I said
earlier, I think that you are implicitly testing the new behavior here,
but it's going to happen in much more complicated environments than
something you could construct synthetically here.

Thanks,
Taylor
