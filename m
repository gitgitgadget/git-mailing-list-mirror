Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320AC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722C561245
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbhIUDce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhIUDbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:31:37 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0A1C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 20:30:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q14so21160926ils.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 20:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uvoZaBQlC4neyDBjqRlggLCy1HzCSWh12jbJohRB9nk=;
        b=1e6BTuiQ15QIR0J0wvCxL4bGsMJazGOv3ngkQXCk86mL3Es1B0OMs84M9CUIyMMsHh
         2R9XMAAQ8KQYCgdrIBzbX25O+b6zO2f5jrMaiLCZKlQOQ8WP2125+2TFjpA0LRoAybZQ
         YVJHeNUaBKmZVdYyFIX1GrIbkNZZZzBhTg1PopO164ioaXTFUriRWvDkXmrS7bgVDJPO
         hIdH8LHJAGNaGmhCQTa9OC16Re760zfg9rtkv0BwDHz24kteFnciVlvLAkPGfXnwoBYq
         c9ukp71Q+QlV1mV3MfJ7Z6GwdZrtoanyCbtlZEyeN0Pw4QzAaW3tkEdvWuU11ShcOJDg
         fjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uvoZaBQlC4neyDBjqRlggLCy1HzCSWh12jbJohRB9nk=;
        b=IeKJBvipVuaHiem6/LjKMRVOLStlKfbqdU5LAhtCvyEluTSsPd4JwVIV2mEl9i0ZnF
         OMuJei19fP/9iVVcocc+OXHHB9+WL0tSjvX8FBQbSsIPteef+ki6d6zLFoVDuOr4mtff
         cePNu4cnlVAF6xzzjQBxSPkrWqFSZsmkjSFjzJxVpXOiIC/jIgZOWiXWU0oPSLk3wwGd
         clwNf9docE8LDaVmBh5wn5rsAJ0p6gdXHscikVniZSccK805KGwhn57u4H5CwPngPq2y
         KVAxmB9yZ0wxfYNKg+zap0Wygrbr1l+iinCcWhMZrwfqVGBEzbyxxKQPPoxzY4aCHJPu
         Lz0A==
X-Gm-Message-State: AOAM532Wdj71jwyAx8v7BCU6XQ3vKp3q+JnzFkvHk9Sv5dkVGT2Jq3m+
        wDm364eW7pfKQxLObtdlD7QGrf8n7YspGA==
X-Google-Smtp-Source: ABdhPJwPWSOTMDX7q/Qn6gIVe7yOENjSUk3Z+kSX7I2Y6eV0NKzPHs2qFOjIOff/YqfZcvHhDsUP8Q==
X-Received: by 2002:a92:da85:: with SMTP id u5mr20882216iln.213.1632195008942;
        Mon, 20 Sep 2021 20:30:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19sm9256871ilc.41.2021.09.20.20.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:30:08 -0700 (PDT)
Date:   Mon, 20 Sep 2021 23:30:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v7 06/17] cat-file tests: test for missing/bogus object
 with -t, -s and -p
Message-ID: <YUlRv7LMDyB2Nw4L@nand.local>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
 <patch-v7-06.17-051088aa114-20210920T190305Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-06.17-051088aa114-20210920T190305Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 09:04:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/oid-info/oid b/t/oid-info/oid
> index a754970523c..ecffa9045f9 100644
> --- a/t/oid-info/oid
> +++ b/t/oid-info/oid
> @@ -27,3 +27,5 @@ numeric		sha1:0123456789012345678901234567890123456789
>  numeric		sha256:0123456789012345678901234567890123456789012345678901234567890123
>  deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
>  deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
> +deadbeef_short	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbee
> +deadbee_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee

This jumped out at me while I was reading it. In the second line,
s/deadbee_short/deadbeef_short/ ?

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ea6a53d425b..af59613250b 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -327,6 +327,81 @@ test_expect_success 'setup bogus data' '
>  	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
>  '
>
> +for arg1 in '' --allow-unknown-type
> +do
> +	for arg2 in -s -t -p
> +	do

This is quite the loop! I appreciate the extra thoroughness, although it
may come at some extra cost of intertwining all of these combinations of
tests together.

But that may be warranted, since they are all related. But it's not a
full matrix of all possible combinations; e.g., "--allow-unknown-type"
does not go with "-p".

So this may be the best that we can do. It's definitely a mouthful, but
I think it's overall an easier read than what we had in the previous
version. And it's definitely more thorough, which is good. Thanks for
spending the time improving this test.

Thanks,
Taylor
