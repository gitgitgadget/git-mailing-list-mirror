Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF22C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAB12168B
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osnsGrXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405642AbgFSQTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404421AbgFSQSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 12:18:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92781C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:18:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f23so6529767iof.6
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SZUajVNIgV7hU7O/sn6umrWjvEMqW4J8YWT1q5IgUwM=;
        b=osnsGrXv2OGUqz6fN3pPbT8gL6J50Ycb1cloOEuQmWET0I01YyShKLSjhv5A/P+FA5
         ubmrIatLf+x+U0qrKnEZ2tujI22sFnBNk7Vf8Orw8w0GOGnMGQHrhGdaEGfeeu7f9kmv
         dpXje9doxTnyz6BSVIcKBREno6F3Qu8Pzcs3Mz1w6w/itwb3HW5TbxEfTJ/uU5v+oI/R
         5o8U/w4d5vILwkMjv2gkf3xCGARqnPzSkuG2A7XZzS6sRtEwJ/KY1DWVe/zbLRP4i7nK
         aYxaeYrgm2uFs4H7NPt/nKin2p1SIn2I23Hfi/8uWhiqdOBjI7oPxrUq5JiDJMRZckx9
         uIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SZUajVNIgV7hU7O/sn6umrWjvEMqW4J8YWT1q5IgUwM=;
        b=oEa9X3eJUDDx2UMOPlK8j1EQATQcE48nEpjV0qoIw1oTW1P4Hd0AfuAlJ4a3T4bp46
         8782A4Z5n5SQey9ID3bvItPXy+kYNHUy4zEbMVlJU3r4BAraMvzqGfT4vSXRO5pHVNoO
         Q/qiyEuRnWTFiQCNwCRphX8gcclermKSrMqtOS2Zgk/j1ZnoFWUXLZ+b+2wRyLQMMV6E
         JdSr2DojFH20ouVRbgBeYFYReOWu+WyMXleAsI3K8CYwUkgQpeVvEKZHGgJz8ntbGF41
         QyGh2ot7E10HolXiQUpOndraCKb8rk9NYKlvB0fLhlVoXqRW5lwkIDk/Sq/f4m/2nDXU
         Obbw==
X-Gm-Message-State: AOAM533yYH2LqM7nY0qAkBoRRMyFDiDtFp7ADfHRJ/NwpUCfbFZIEmud
        zWFNvjXKaQEeFU2sp7/CdXc=
X-Google-Smtp-Source: ABdhPJwtb9H8QuHHXvBxlEHP79jYC56qyupJb0yccLlIAnI9tzzYbdwB2I0az41R8TAMGorvz4TI5Q==
X-Received: by 2002:a02:cd1b:: with SMTP id g27mr4371247jaq.61.1592583502750;
        Fri, 19 Jun 2020 09:18:22 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n4sm3722459ioc.8.2020.06.19.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:18:22 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:18:16 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
Message-ID: <20200619161816.GA9205@flurp.local>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net>
 <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
 <20200619160129.GA1843858@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619160129.GA1843858@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 12:01 PM Jeff King <peff@peff.net> wrote:
> On Fri, Jun 19, 2020 at 11:51:06AM -0400, Eric Sunshine wrote:
> > That is, have the caller do this instead:
> >
> >   if (anonymized_refnames_handle)
> >     dump_anon(anonymized_refnames_handle, ...);
>
> <shrug> The names were long enough that I thought it was more clear not
> to repeat myself. [...]

Indeed, it's a minor point and subjective. Certainly not worth a
re-roll or even worrying about it.

> > This hard-coded "6" seems rather fragile, causing the test to break if
> > other refs are ever added or removed. Perhaps just count the refs
> > dynamically?
> >
> >   git show-ref >refs &&
> >   nrefs=$(wc -l refs) &&
> >   # Note that master is not anonymized, and so not included
> >   # in the mapping.
> >   nrefs=$((nrefs - 1))
> >   test_line_count = $nrefs refs.out &&
> >
> That's exactly what I wrote originally, but it failed on macos due to
> extra spaces in the "wc" output.

Hmph, that shouldn't have failed. Did you quote the $(wc -l refs)
invocation? Quoting it would cause it to fail.

I just applied this atop your patch and it worked fine on Mac OS:

diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 0c5dd2a4fb..849192b1b0 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -52,9 +52,12 @@ test_expect_success 'refname mapping can be dumped' '
 	# we make no guarantees of the exact anonymized names,
 	# so just check that we have the right number and
 	# that a sample line looks sane.
+	git show-ref >refs &&
+	nrefs=$(wc -l <refs) &&
 	# Note that master is not anonymized, and so not included
 	# in the mapping.
-	test_line_count = 6 refs.out &&
+	nrefs=$((nrefs - 1)) &&
+	test_line_count = $nrefs refs.out &&
 	grep "^refs/heads/other refs/heads/" refs.out
 '
