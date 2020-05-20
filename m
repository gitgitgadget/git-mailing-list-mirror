Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5FCC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA2C2084C
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqXsTGiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgETWAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 18:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgETWA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 18:00:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C6C061A0E;
        Wed, 20 May 2020 15:00:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n15so2001761pjt.4;
        Wed, 20 May 2020 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4JmOvD2TyoQ5PlnHW0M+2Uibc7d3SIyYFIVbY6RyYR4=;
        b=eqXsTGiKOHrK015U2Y69X7/wA962a5nOkMWhK/QYqV3Ec4k+eK/DQmXSpX/CqX6/yN
         yuuOKMtnGf/bYh3jZOShjjLlv71HKx1JfVt4swZvykjPSpdZvapniIjP/MqnIGgZTiNA
         Cqem/NJDSvkiQiFoK1kMzTQTFckzl4nV+qFmemtAG6Ookv4mf7mpE5eWzPY5cf33TWO2
         h/UsrNigz28COgyfWhXekLtDmF2VOZKdFza4I0Bm6nUnA7/LM/e+Q4Ns5Dyeu7SY+XKd
         3/O5LWa41yiDdY+xQ99xOLfw+z5J/VI91WCSusOJu0nCO7mghPAHtejqTqJBnrED78HQ
         4rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4JmOvD2TyoQ5PlnHW0M+2Uibc7d3SIyYFIVbY6RyYR4=;
        b=L5HbOC7rdFp2N5Gl4ICqM7Y7MZ9fSsDGGi2BfDJl1GLspIrXqsc2tujAC2jE9vrA1K
         rK3SekYqcTpsi/d3da5ulagtRBzD50VMaGBWDuGHL75GLdFgvqaa0epajNlSJIPfvEL7
         WuGyV7v/M+V7Fy9OxFcXEa+fz1P9YldHvI7697Rjab7Ky4rpZR7xKkAvsP86O8/Rr9di
         IMBZ6wpRI4hRpm0Wm2JZWs4SHz+gwllOYbzNbLOQzIUivf3Fe+4hWEgHx4l6MmZX7qNC
         DmuRHkJV7kYr2jFO8ZbgSUOpau0l9D/Ce0D2trpjobaPKpZYY0Ix3LcL57GNS0QsSYaI
         cSXA==
X-Gm-Message-State: AOAM530h3IQqkqS/07VOk72fMHJNL1Za3jHa5EPMWTroWqmW6KrqQCpd
        ZJyjQaAVBZ+rfBrJSvMdx5s=
X-Google-Smtp-Source: ABdhPJze/d22doq9O8a6Meb4pDynDLvbyPjQsLlo2DAFKxSBmbXNXijOFROsXNsb7fYPLGuichLTIQ==
X-Received: by 2002:a17:90a:a62:: with SMTP id o89mr7680765pjo.217.1590012026445;
        Wed, 20 May 2020 15:00:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id gg8sm2760738pjb.39.2020.05.20.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:00:25 -0700 (PDT)
Date:   Wed, 20 May 2020 15:00:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
Message-ID: <20200520220023.GB3648@google.com>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(other lists -> bcc)
Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

>> Is it worth mentioning here the reversion of v2 as the default protocol?
>>
>> It does end up (along with the actual code fix) in the "fixes from
>> v2.26" section:
>>
>>>  * Those fetching over protocol v2 from linux-next and other kernel
>>>    repositories are reporting that v2 often fetches way too much than
>>>    needed.
>>>    (merge 11c7f2a30b jn/demote-proto2-from-default later to maint).
>>>
>>>  * The upload-pack protocol v2 gave up too early before finding a
>>>    common ancestor, resulting in a wasteful fetch from a fork of a
>>>    project.  This has been corrected to match the behaviour of v0
>>>    protocol.
>>>    (merge 2f0a093dd6 jt/v2-fetch-nego-fix later to maint).
>>
>> but that's somewhat buried. I dunno. It is not likely to introduce _new_
>> compatibility issues, but perhaps folks looking into compatibility stuff
>> may want to know about the revert.
>
> The promotion in Git 2.26 was buried in the "performance &
> implementation details" section and not in the backward
> compatibility section, so it feels a bit funny to highlight the
> reversion.  In any case, here is what I prepared (but not committed
> yet)

Speaking of which, should we enable protocol v2 by default for people
with feature.experimental enabled, like this?

(This isn't part of the rest of the feature.experimental handling
because those are tied to a repository object, whereas this code path
is used for operations like "git ls-remote" that do not require a
repository.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git c/Documentation/config/protocol.txt i/Documentation/config/protocol.txt
index 0b40141613e..c46e9b3d00a 100644
--- c/Documentation/config/protocol.txt
+++ i/Documentation/config/protocol.txt
@@ -48,7 +48,8 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `0`.
+	If unset, the default is `0`, unless `feature.experimental`
+	is enabled, in which case the default is `2`.
 	Supported versions:
 +
 --
diff --git c/protocol.c i/protocol.c
index d390391ebac..d1dd3424bba 100644
--- c/protocol.c
+++ i/protocol.c
@@ -17,6 +17,7 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
+	int val;
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
@@ -30,6 +31,9 @@ enum protocol_version get_protocol_version_config(void)
 		return version;
 	}
 
+	if (!git_config_get_bool("feature.experimental", &val) && val)
+		return protocol_v2;
+
 	git_test_v = getenv(git_test_k);
 	if (git_test_v && *git_test_v) {
 		enum protocol_version env = parse_protocol_version(git_test_v);
