Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6647CCA0EC2
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbjIKVdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjIKNZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 09:25:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA3193
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:25:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so27930035e9.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438710; x=1695043510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQx10/Zvuwk9lirMMThdWVZvMNUm2Che1zRZnmyuBQg=;
        b=MvbU29rcT1l6kEG4Ch1nf3iAWmyw5483Ggbc4SQj9wxyX3zZ0Gcqy34XvLf6Cbx3A3
         quqQvVOBYH4x5vcpoj+PVblZlLAM2PD856i465W5B7jIUbklEGcJRyi0D+F60EfWEDc8
         HEE91mu+lzt01BGoDNmMPdIk/Ikul8PsJ/ErUM8smdbQKcyIXm8I1DmQg0ARjP2f9ydy
         Otw4l/a8uh/56Sf/hMh3L7GKmxthnttAVBQ2eL0UFUxBcY44eLDU4hYE6TLYii9CjzZu
         WY+OwHTG8M0VA6p+Rt+iR8lCXfvWT8zuaIa/pO2b0i2b4KCwijuBwWBBScVmsxlg7YV4
         A5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438710; x=1695043510;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQx10/Zvuwk9lirMMThdWVZvMNUm2Che1zRZnmyuBQg=;
        b=IMrX8ag90kIJcCsHk/VDM1vFH/NFFWhjNu1XOLWAKWIG0xVG/vu58vA+nOF5I/O1mg
         44ZrDb7L294vU09caA4ihC5CORuSCFwiMZvBoZMdnikohT8v8AMu0VfpV4HAtOZv4mlg
         Xn5CdxkC/KzAMrDJpxgN3rhroX1KIK5enDexPlSjZm0aOd6ivRRV7+hhKDVX3ZZtokj0
         lqZLKT0IqufeZI3s6UsHzyHINhdG4luMsMLLmeRuIQNrp0jUQXmBxRm5vLS06BfiKH4S
         FwfNppO9+cvFo/OJmt8LSMuqdT5ps+2QM8xmGaD3LmWZPsi5DOX5uX4Hy3Mo7tDH2W0C
         e2UA==
X-Gm-Message-State: AOJu0YwCklPLV+6qvqw6Q1WL5REnqiQwo/rKUQBI8xPX255A3XPCe2/H
        rLh0f/Z4/Tsz5qAduXPvXMLjNl/socml5Q==
X-Google-Smtp-Source: AGHT+IHh+i8KkaWy768fgFQMC1Ba//1A0s8M7OSIA8+PuYwkYpgyDscQOoGSi51NwwqaDt8IPoQS/Q==
X-Received: by 2002:a05:600c:4e0d:b0:401:c717:ec6d with SMTP id b13-20020a05600c4e0d00b00401c717ec6dmr9358182wmq.15.1694438709923;
        Mon, 11 Sep 2023 06:25:09 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id c10-20020a7bc84a000000b003fee0741b8csm13303558wml.23.2023.09.11.06.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:25:09 -0700 (PDT)
Message-ID: <69f6f263-06e1-4fef-abd9-d6c03ae0c148@gmail.com>
Date:   Mon, 11 Sep 2023 14:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/4] unit-tests: do show relative file paths
Reply-To: phillip.wood@dunelm.org.uk
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
 <2b4e36c05c9e01b1e489100531fd01515b0786ab.1693462532.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <2b4e36c05c9e01b1e489100531fd01515b0786ab.1693462532.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 31/08/2023 07:15, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Visual C interpolates `__FILE__` with the absolute _Windows_ path of
> the source file. GCC interpolates it with the relative path, and the
> tests even verify that.

Oh, that's a pain

> So let's make sure that the unit tests only emit such paths.

Makes sense

> +#ifndef _MSC_VER
> +#define make_relative(location) location
> +#else
> +/*
> + * Visual C interpolates the absolute Windows path for `__FILE__`,
> + * but we want to see relative paths, as verified by t0080.
> + */
> +#include "strbuf.h"
> +#include "dir.h"
> +
> +static const char *make_relative(const char *location)
> +{
> +	static const char *prefix;
> +	static size_t prefix_len;
> +	static struct strbuf buf = STRBUF_INIT;

So far test-lib.c avoids using things like struct strbuf that it will be 
used to test. In this instance we're only using it on one particular 
compiler so it may not matter so much. We could avoid it but I'm not 
sure it is worth the extra complexity. One thing I noted in this patch 
is that prefix is leaked but I'm not sure if you run any leak checkers 
on the msvc build.

static const char *make_relative(const char *location)
{
	static char prefix[] = __FILE__
	static size_t *prefix_len = (size_t)-1;
	static char buf[PATH_MAX];

	if (prefix == (size_t)-1) {
		const char *path = "\\t\unit-tests\\test-lib.c";
		size_t path_len = strlen(path);
		
		prefix_len = strlen(prefix);
		if (prefix_len < path_len) ||
		    memcmp(prefix + prefix_len - path_len, path, path_len)
			die(...);
		prefix_len -= path_len - 1; /* keep trailing '\\' */
		prefix[prefix_len] = '\0';
	}

	/* Does it not start with the expected prefix? */
	if (fspathncmp(location, prefix, prefix_len))
		return location;

	if (strlen(location) - prefix_len > sizeof(buf) - 1)
		die(...)

	/* +1 to copy NUL terminator */
	memcpy(buf, location + prefix_len, strlen(location) - prefix_len + 1);
	convert_slashes(buf);

	return buf;
}

Best Wishes

Phillip
