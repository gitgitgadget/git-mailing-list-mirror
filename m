Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428FFC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE620721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrNJhE2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEDPkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728294AbgEDPkA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 11:40:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AA3C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 08:39:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so6886009plr.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gf/wasHXkwQLNhdAA0nNDlSbkgU/aYD6PlMB/NPAflw=;
        b=OrNJhE2miApXV3Jxq3oxGedb24De4yL5SNtuBsxDx72iUvxxPrystfRNSubScCuQMu
         Foq+pSAY0Z6ZZq1YRpesMrXLKzUCW6HwcZnw1S0vxgaZYnnmli1rC4THAJpmhHWjVlaR
         OShh5ekjIQ6kA3ZIoTzhQlYGzlnVCPIprEvBEBuZXC7bdqsJ/aklnG7OtXoh+xFhbXe1
         qdDuzmAch5phY7HbPOjBNLRkxD6Jv8Y2OBm0tSrrAs0Uj3I960HN7JboapyTZhgAjd5l
         XV1iAOuyk1KbJ6JRkaXzida1tI11Dd7ftfL1UN/sTJ5Pdvke5cQz0ZO29TuLn+AbR4TQ
         m4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gf/wasHXkwQLNhdAA0nNDlSbkgU/aYD6PlMB/NPAflw=;
        b=SltpTQBaAqoHYO/ta+EpLbKb/M/sBj2NbSE7loSjYTZodJdOMDUWi0sn85Z3Gy+8I+
         hXsde1U/4xcqfC0/Nwdw1AowSKyh9OVqxtuKu2OCDQSu98z6WKbN3AniIWNscQDdUse+
         qD0d66OLA2g41CJbgKrugzrFyw+GqnbM/B3ticcTJa9V3UiDGqeo1PEv4TxE4MbOkxny
         PUlVpO+pbiYPDGrcBgR++1BLuuVh3D22dQUps3mYRDAO/pWUpJLrs0JvXq0jKNDAW35I
         FiFcp89pq/ngAz5D0zgRihX33GHyS5OLS22Bw58uZyM8fy/47fl1WrLTFTTxGZXPi7KF
         1Jyw==
X-Gm-Message-State: AGi0PuZm6g5HTpRsGLnRLXH7RUuQvaYILY8SA5/93DxiVy1Nu+yqyC7h
        Gw2j1iKVTXF5030ZSmG6OJbXfo5j
X-Google-Smtp-Source: APiQypLafpLHIHCLEXSwN0B4uLhU0L+DBoLkli3ZBDYg9/eFl3NhIknuxHsBKJrGDPPStDzHUJN24A==
X-Received: by 2002:a17:90b:1111:: with SMTP id gi17mr12997975pjb.121.1588606799358;
        Mon, 04 May 2020 08:39:59 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d35sm4301267pgd.29.2020.05.04.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:39:58 -0700 (PDT)
Date:   Mon, 4 May 2020 08:39:57 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504153957.GC86805@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
 <20200504074520.GB86805@Carlos-MBP>
 <20200504144436.GA9893@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504144436.GA9893@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 10:44:36AM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 12:45:20AM -0700, Carlo Marcelo Arenas Belón wrote:
> > 
> > * the meaning of "exactly" for matching protocol and hostname in the URL
> >   since 06 are both case insensitive per RFC3986 and we have been
> >   ambiguous on that, leading to some helpers assuming case or encoding.
> 
> Yeah, IIRC we discussed case-sensitivity at the time and went with the
> stricter behavior in the name of safety over convenience. And I don't
> think anybody has complained since then. So I'm not really _opposed_ to
> loosening it to match the URL, but perhaps a maintenance release is not
> the best time to do so.

agree, but I was talking not in the context of a feature, but on how we
are to define the interaction with helpers (which was meant to be part of
this maintenance release).

currently (since it is undefined) a naive helper could do a caseless match
by assuming we really meant url as defined by RFC3986, and therefore affect
the wrong credential by the operation.

indeed; our own code might get confused so maybe something like (not fully
tested and likely to need some test coverage) will make sense then as part
of this maintenance release, with some additional mention that clarifies
we REALLY meant "exactly" so that helpers can be updated?

Carlo
---
diff --git a/credential.c b/credential.c
index 108d9e183a..d2c879a9b3 100644
--- a/credential.c
+++ b/credential.c
@@ -70,7 +70,7 @@ static int proto_is_http(const char *s)
 {
 	if (!s)
 		return 0;
-	return !strcmp(s, "https") || !strcmp(s, "http");
+	return !strcasecmp(s, "https") || !strcasecmp(s, "http");
 }
 
 static void credential_describe(struct credential *c, struct strbuf *out);
diff --git a/fsck.c b/fsck.c
index 73f30773f2..d779acdae8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -997,10 +997,10 @@ static int url_to_curl_url(const char *url, const char **out)
 	    skip_prefix(url, "ftp::", out) ||
 	    skip_prefix(url, "ftps::", out))
 		return 1;
-	if (starts_with(url, "http://") ||
-	    starts_with(url, "https://") ||
-	    starts_with(url, "ftp://") ||
-	    starts_with(url, "ftps://")) {
+	if (istarts_with(url, "http://") ||
+	    istarts_with(url, "https://") ||
+	    istarts_with(url, "ftp://") ||
+	    istarts_with(url, "ftps://")) {
 		*out = url;
 		return 1;
 	}
