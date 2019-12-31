Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C7CC2D0C3
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 01:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EEC2077B
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 01:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf4uaFYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLaBDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:03:08 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:38188 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfLaBDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 20:03:07 -0500
Received: by mail-pg1-f179.google.com with SMTP id a33so18823033pgm.5
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 17:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhdGWFH1iAJbpdRKEKNJ9pWY9FPPnWEYr3dO6VqCQks=;
        b=mf4uaFYEVAtZvsaRBk6e19C/8n5HgO6jhnPztDij6e0/mM/o2x/OPWF6t+UBMYFaGI
         3BdEqt2CC3c45NvQAuzf7ub6nbg2j8QWT27eAuW55Hw7bG43N12nX/BBRuDcnhkLouVy
         LHcwGOu6C3GjXhe3GYtDOpdk8ZdtnnNcThNsUXqaZh7ZGc7OOj4nqGV0PPlk2XgHa6pN
         Yuywo0pnacbXtZNXp0lpZd72ZdvoENWXDEmJxu0bf0gA7TOjD61kbVyANJxu0tqsiTLD
         s6vNHTkf+VkV3eE8tP3QsQMayojjjdUZu8CvL63FP32Rr7YNbvE0sawnNX9ktsHlqMwq
         efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhdGWFH1iAJbpdRKEKNJ9pWY9FPPnWEYr3dO6VqCQks=;
        b=BYTncO6r94FMbH/7dvl7TQdkDDJhYjnJdPx8Ed9jjjAmmGHoTc9WHjeh1ZVlC0ntHi
         oCphmDKIxSMiPCHKNLj3FuMAVCkaDOoBKGYVyMjDeK8LHvGtrCU7FPqwporNmUVzhTVU
         tkuDH3PaQkdtf+UmRdp+j7Vt2zlAzEKWzKl75jNshkY+FkAbE1MfXoqrQEjeAM/EffWf
         WkiU+y4Oyb8cM2oj7rDne2Pbq8UdNjfFQp+q6FVoaT3POPJLHPXz2BqBQ2zBicl1+Bs3
         V9I7KxeJTzT0BecD/AVCfNTCEHSEV60mK0EK50GFndnXDzLudgD6iKfJyD5U/JC3qngj
         0H5w==
X-Gm-Message-State: APjAAAW+wGJtLs0vWSxGmg6u/X8L0TzjcmlpMBM/BJ3WItPtXA+dq9qv
        n0bqCA5ahIBTH3td6+KjX01zwwCx
X-Google-Smtp-Source: APXvYqxQxuEuC0ZfJRWSH1717oOl9jDRq52Uz46Ehhq5PkKFa9ygOIOCE1J9KadG65euO70PEhIsYA==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr76843395pgt.208.1577754186357;
        Mon, 30 Dec 2019 17:03:06 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v7sm810850pjs.2.2019.12.30.17.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 17:03:05 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:03:03 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20191231010303.GD13606@google.com>
References: <20191230220155.GF57251@google.com>
 <20191231003903.36486-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231003903.36486-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
> Jonathan Nieder wrote:

>> Hm, where does this dichotomy come from?  E.g. is the latter a
>> lower-level function used by the former?
>
> I don't know the reason for the dichotomy - perhaps it was an oversight.

Ah, that makes sense.

[...]
> This might be a moot point, but what do you mean by the
> "'has_object_file || find_cached_object' pattern"?

Oh!  Thanks, I should have been more precise.  And calling it a pattern
was probably overreaching --- I can only find one instance, in
pretend_object_file:

	if (has_object_file(oid) || find_cached_object(oid))
		return 0;

Since there's only one, I was on the wrong track.  (Except that with
this change, that can indeed change to

	if (has_object_file(oid))
		return 0;

Thanks,
Jonathan
