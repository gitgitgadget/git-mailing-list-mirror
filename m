Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A8CD4847
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjIVRn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjIVRn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 13:43:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BB8F
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:43:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77386822cfbso150086485a.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1695404630; x=1696009430; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVLDSIDSzSSZFCS4Zu9xQJlxLYE2jZxXbWwflrQ4qMM=;
        b=VW3SIpdCLc69kv0TQ8emUHpoyJ0Gk6+8fYf2+kKs/VNecRlNDRtTQKeeU29sXuxu8z
         Mz1NTmhD4h/lvDTL85BThnAmWP3qtnTOQDJ2pVXL+CeNCQTKSXvyVxPBZOnQ3nqCUw4G
         CZ0GREgGrD2+Wbpx8fC+thOSrLL1TzBnD8Fos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404630; x=1696009430;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVLDSIDSzSSZFCS4Zu9xQJlxLYE2jZxXbWwflrQ4qMM=;
        b=sXvoXqfF5Wa5AymsQiJ33YqA6jKiCzavzRPVtvIzYg6EQvF/h3L1gMtWT7VeueGPC2
         Ko+BuBgNQfzx3npny/xjGtdw8MbsCW5gYtcE9syvQoTLiROXlX2TVueOPCUOBV478szT
         hQkD7RlLP2hEEznTwRraa1HJQa/U4PxjFJUsVxQS3xO3XNYEvx8hok7tO/6ir6J3JtfW
         D5mtD0SCHTksyfIGWCg91rY0kzChAfqmPnU8ss/mhMiP2wmX7sZic87PtiKeKPpVUIvl
         N4dsA8+5Mm0v5KXXq1ewzJ2PwiUqz8F7XqSezYQSg0F7Uz2SldoSyBFtSF4Vk6YdvKzW
         Pzgg==
X-Gm-Message-State: AOJu0YyEOdhBNhkod7ClmmSMrY+ymW3oo6R5P/0RMEA8qpfO4/gurTqU
        WhWYKcPV7isYf5VJCOR1Sza8thssc2ljQ9JOvN3Flg==
X-Google-Smtp-Source: AGHT+IEIDskOLcwfgyseP8kAnoMJvJWD9xr1PSoR/H1Zw2IgFeWE0wGM0mxei3TlFQdEyD0ARISz6g==
X-Received: by 2002:a05:620a:218c:b0:767:954:a743 with SMTP id g12-20020a05620a218c00b007670954a743mr137200qka.51.1695404630281;
        Fri, 22 Sep 2023 10:43:50 -0700 (PDT)
Received: from localhost (cpe-142-105-146-128.nycap.res.rr.com. [142.105.146.128])
        by smtp.gmail.com with ESMTPSA id h8-20020ae9ec08000000b0076e672f535asm1562123qkg.57.2023.09.22.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:43:49 -0700 (PDT)
Date:   Fri, 22 Sep 2023 13:43:48 -0400
From:   'Ben Boeckel' <ben.boeckel@kitware.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <ZQ3SVJWPzAjVbTT0@farprobe>
References: <ZNffWAgldUZdpQcr@farprobe>
 <ZQ21NsLmp+xQU5g+@farprobe>
 <8f034aa3-67ac-456c-a754-b0a86666bcdb@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f034aa3-67ac-456c-a754-b0a86666bcdb@app.fastmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 19:35:01 +0200, Kristoffer Haugsbakk wrote:
> Looks related:
> 
> Link: https://public-inbox.org/git/CABPp-BH2zuYe87xhjdp5v7M7i+EfEgLHAZgwfzJUAxGk1CFgfA@mail.gmail.com/
> Message-ID: CABPp-BH2zuYe87xhjdp5v7M7i+EfEgLHAZgwfzJUAxGk1CFgfA@mail.gmail.com
> Via: https://stackoverflow.com/questions/72886894/git-describe-is-not-returning-the-expected-tag

Thanks. It seems that these discussions previously determined the same
(painful) pill:

SZEDER Gábor at https://lore.kernel.org/git/20191008123156.GG11529@szeder.dev/:

    I think the proper way to fix this issue would be to make 'git
    describe' traverse the history in topographical order.  Alas, I'm
    afraid this would result in a noticable performance penalty on big
    histories without a commit graph.

The `sleep 1` is probably the remedy we'll use if time to actually fix
this doesn't come up (or the "proper" fix is deemed as "too expensive").

Thanks for the links,

--Ben
