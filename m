Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977DC432C0
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69732068E
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 04:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSmMZGX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLDEXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:23:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37838 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDEXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 23:23:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so2430566pjb.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 20:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7POaD8C3QZNNqXA3R3tKwYxVTQPVQcyN3AY0TU3/VJ0=;
        b=BSmMZGX5LsWPFTPmAWWp3PmV3ByXC7VYiI/oKDlqOffTiWu65TrFApk8dkaaP+kRQf
         D1MViAdxtF198VT8C1B46fGDvd6/xafud7FwAe8V6LYsJvVYcc1xlutljGJcCbG0S00Y
         6KSp3l71oLIJxK6qQOXyn9P4MvsHlalzEAGWuGojwFIDC/c25tvdwV2pwFXlZcmn91wK
         TiRFokzCiv86e4QVnab6W70GtZq1easkZ1WAPk0Xgu/rOCjpFz414w3hWiCQs7QUDjUS
         vuV3ip4hpKjx8KzlBByJWo1SQvjMqHDD0It6Lzx2J2XWVVTiTy9eMMXkUAJfKAmIvTuI
         JQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7POaD8C3QZNNqXA3R3tKwYxVTQPVQcyN3AY0TU3/VJ0=;
        b=RMhso4dxQUTizisE8Bot6TYcmCXFaVyz9coU0jZDi3JybGjp8JrqaF45cPUkEM4ztL
         1BOinoJ9V4+18l9rtNtkxznimNt2lCleaySq0tEvzPRkmBttqmST6E89nVWuQhfteFtV
         6d3CJMFJOY+L9VVTtAOMXf/S58yYwGbycF/a7ps2ZpYE4rsrwuIOvqkTczqGGRMFi1iA
         FLaPb2G9sKhI57WuGFfj30AYB18S8zL4CgruD0UO+fR7QNYbaUGANwg7X6O3ogMcI/Mz
         j5NAB1p9GLfL3s4TOusqLzZF7hACEnVh4YiwUdaPyOSs3ToSfFbUJ8X3OXNQJ5Gbn9n1
         3qzA==
X-Gm-Message-State: APjAAAWNs0NOmAVssRudtOFX6Ad8/E1miuHS3MV0v/zSr1g/Xn4B7aKN
        5tpKMt65YfVRVxog5i5dC4Q=
X-Google-Smtp-Source: APXvYqz/0/GnV+ybPZ0NQWufrnZVGJm0gRa3IeHAM5IHSXg/5J+nyQzNW1HfJkb5O+RyB+pgwmVBKg==
X-Received: by 2002:a17:90a:1f8e:: with SMTP id x14mr1208606pja.29.1575433417779;
        Tue, 03 Dec 2019 20:23:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id j23sm5473153pfe.95.2019.12.03.20.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 20:23:34 -0800 (PST)
Date:   Tue, 3 Dec 2019 20:23:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191204042332.GG214771@google.com>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
 <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
 <20191203221730.GA28419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203221730.GA28419@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I agree that 10,000 packs is ridiculous, but we do see it (and worse)
> occasionally from people pushing in a loop before our scheduled
> maintenance kicks in.

On that subject: one thing Martin Fick (cc-ed) has suggested is moving
more of the garbage collection work "inline" into the push path.  That
is, instead of letting someone push 10,000 packs in a loop, build
concatenated packs ("exponential rollup") in the push path and don't
return success and commit the packs into the object store until we're
done.  That way a reasonably small amortized cost is paid up front by
the pusher instead of later by everyone.

Midx changes things a little: it might make sense to build
concatenated idxes instead of packs, which would still avoid the same
quadratic behavior.

Just a random thought,
Jonathan
