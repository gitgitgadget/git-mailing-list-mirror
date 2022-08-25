Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27061C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 15:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiHYPaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiHYP3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3ABA149
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 08:29:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v14so3715089ejf.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=hMPUd287qo97EGPGCB8JHDE1xlPTp+UH4JjjvmWmTv4=;
        b=FFoidFRg+wR5FENqa9eZhrtl0wI8JlIGk1TTi3U3T3jHGkzfumx0TVx1qY9o0dpeVV
         Gv7DXGuP1DrrKxSsQVQ96QYmwv7dl9IEcjrJO78YJbG1CcVj98GhM5wxIaUjCCtEe8jA
         4JqzpB0ppPK19eGR2UgXK+MgMV6s+NI0QFbTyO5yWG09znT6BSX834WJBXy5Zwkv1rpQ
         dArttStqMk9yBWuv4rfXJR9hMtqez9lvtlQzktXS0VfWm6HZZNq2m1/Nt2KVIBdZlJz9
         LvycaCa3nja3VjtOQEJt0YswEy73PHncQ8mIMt2R1n9Od38mRNsjT5OTwFkYDNcf3WSt
         kWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=hMPUd287qo97EGPGCB8JHDE1xlPTp+UH4JjjvmWmTv4=;
        b=xYhL0dZYRd187VL493gHfLaZppNL9hS2Lww1/ymUP96CGD9r+QYpftWZttyqdS2T7p
         iyaUWynxT0BthUdTQ6/eO8gI8c+piP82sxJefWW18XEeXnEcCOtGDOVbeWF2C6eytpNs
         7MWO57D9GAvzCECJq/eYvPxaL6h2fiw5lWL/f63xaozU+xNmWucCoL4fVGaP+QoEcUmX
         pEl9jSvR0I8uWsPneFgAkTufLWnzpcOotw5D4kIvPujfhbFSPBCxkkvtS8fLJ0jxU9tH
         FM5wZgtpl81ivipFcryvfJEk2+rgYQsx8eYdymUJHxa1+Jyfnk3Y+3ZkK12QY2u9keqa
         jV0A==
X-Gm-Message-State: ACgBeo3sjUgl+sfNINm+hPe0FoP4udDAiquvunQQiTdc40EwR5Unmdnd
        n6dWvEZm/r693z3QOLvGs7o=
X-Google-Smtp-Source: AA6agR7p54A5qo5F5Djaa0auiDh0yt/0YSb0VFM/dNfWL8YK3xRFUxceCoWGyvvKt6GIpciNoeWPog==
X-Received: by 2002:a17:906:6a0f:b0:730:df34:6ec4 with SMTP id qw15-20020a1709066a0f00b00730df346ec4mr2921851ejc.659.1661441358902;
        Thu, 25 Aug 2022 08:29:18 -0700 (PDT)
Received: from localhost (78-131-17-114.pool.digikabel.hu. [78.131.17.114])
        by smtp.gmail.com with ESMTPSA id l18-20020a056402029200b004479cec6496sm1963677edv.75.2022.08.25.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:29:18 -0700 (PDT)
Date:   Thu, 25 Aug 2022 17:29:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] Makefile: have "coccicheck" re-run if flags change
Message-ID: <20220825152916.GH1735@szeder.dev>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <patch-2.5-db3b3427668-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.5-db3b3427668-20220825T141212Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 04:36:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix an issue with the "coccicheck" family of rules that's been here
> since 63f0a758a06 (add coccicheck make target, 2016-09-15), unlike
> e.g. "make grep.o" we wouldn't re-run it when $(SPATCH) or
> $(SPATCH_FLAGS) changed. To test new flags we needed to first do a
> "make clean".

Nit: make cocciclean

