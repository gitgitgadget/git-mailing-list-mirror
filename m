Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6FEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 12:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhLGMTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 07:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLGMTP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 07:19:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 04:15:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so56192416edx.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ktiDsHmyIlHWipdScrKrBylscEcFt/GMQRwMRDKdCv8=;
        b=ZC9+mczw6a5aBrY3dSQehLGqRKLk6EVg7SWUkbMBvnl7eZ0CA+K2+7qKswUXfhyY+5
         HRIfbiay90QJT4JP8CjZrrsi9/exFmmoZeJx6Kk6jQO5icXbvz3MrS3jGxHlh985lQFf
         JnwjJnfFDePZEIzVMI3dfumk0snhnvx7YZZ9GVeH8N/uJrT55ed1l4oLlrRKpdHGNbKx
         lOmYfjj0m/r9s+sIviQzL/ds07Xz3N7cYkWtSYs5bene+B/5KVt6HXdoq68w1dsdIqna
         mfz3v50H6reHketXZaj4HCKztVn+c2jclUwI1SFhjgaT28pWZ2Vc1qz41uIqJPVYXUcU
         HGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ktiDsHmyIlHWipdScrKrBylscEcFt/GMQRwMRDKdCv8=;
        b=Hl7MuTHSnVDjX3U5ELGtsSrkQp0EwuZj2Zp4JOC2hvQcoS9jH8w6F066PEHGQ0L/kt
         eFz7kujqMGgiefbzU26r8risulXqAmeVYxyI7wG/IX/l4ckQZHZF2pBR1geozMRc60ao
         qwiTJiqhqeGpghQJAowL/kc7JmdUZuDHZYeJSaSl54Ddr9Ap1uagYOxYcmojGSn6JgH1
         3oPa0lzzKZt5LhBfak1hjRp0inm1XxGYD2ND7NnnUD0UdvAryn6h3YjbDeUcOoPaOFZ0
         vv0osY0ROH54wRM8PI7+zNYHOuI7/6z5NYvoLKwvFSY6s6jL5+Rd3rYp/dCm6XOQceXo
         jcAQ==
X-Gm-Message-State: AOAM531JjCvyHIbI6wr4cCYf6XrDlq0LzSxnJbFsyZgu3rpTtOpkH+9Z
        ReciCNeFiJ7PttrkSt3iygg=
X-Google-Smtp-Source: ABdhPJwLAWDt8smUwwvt80JvqbHz6ASCYiMc3lli+bltNOECO6V1Nxc4k8EpKdmxs9yZHSgnvRGlCw==
X-Received: by 2002:a50:9514:: with SMTP id u20mr8426129eda.117.1638879343914;
        Tue, 07 Dec 2021 04:15:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dz18sm10830260edb.74.2021.12.07.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:15:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muZNm-0018NZ-Nw;
        Tue, 07 Dec 2021 13:15:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, nksingh85@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
Date:   Tue, 07 Dec 2021 13:14:45 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
 <Ya9JJlItvDJCLHqj@ncase>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <Ya9JJlItvDJCLHqj@ncase>
Message-ID: <211207.865ys0pq4x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Tue, Dec 07, 2021 at 02:46:49AM +0000, Neeraj Singh via GitGitGadget wrote:
>> From: Neeraj Singh <neerajsi@microsoft.com>
> [...]
> [snip]
>> diff --git a/wrapper.c b/wrapper.c
>> index 36e12119d76..1c5f2c87791 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -546,6 +546,62 @@ int xmkstemp_mode(char *filename_template, int mode)
>>  	return fd;
>>  }
>>  
>> +int git_fsync(int fd, enum fsync_action action)
>> +{
>> +	switch (action) {
>> +	case FSYNC_WRITEOUT_ONLY:
>> +
>> +#ifdef __APPLE__
>> +		/*
>> +		 * on macOS, fsync just causes filesystem cache writeback but does not
>> +		 * flush hardware caches.
>> +		 */
>> +		return fsync(fd);
>
> Below we're looping around `EINTR` -- are Apple systems never returning
> it?

I think so per cccdfd22436 (fsync(): be prepared to see EINTR,
2021-06-04), but I'm not sure, but in any case it would make sense for
this to just call the same loop we've been calling elsewhere. It doesn't
seem to hurt, so we can just do that part in the portable portion of the
code.
