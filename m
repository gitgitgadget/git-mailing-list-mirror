Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071921F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbeKTQkS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:40:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46696 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeKTQkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:40:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so451377ply.13
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gnxos7238RK9JBXTMLYdE1/r2Mmy5C60jUNvaKJJuRs=;
        b=FeR+51R+RlXxHVZnuMl1kLoKvtJjUnfXoM/xXOxlicyqHdcawNjXpgVVC7ZTucvBD8
         QtAxt26YNFF5oHYtWJ+DffOkjmgj/rLTeUQfCEnO4a+Seim35ixGbuSCyt1UKcKmO1qB
         oxdTnlGGkCeqCvVAzf5UrpOld2Ty+SdAhvVTB3Qyz3UyMMv8+XhBFi0jylUMqSQoj6AT
         c4fkwNLR3cG4txhVrpqlRE6O/q2tjaRjTf7DM4KiYfVOexnMs6rXo631hhSQapUZ86bR
         WNuU8IC90PpWTN8QYBDeGGWZKvWncwaBP33e2exAcUuHietpqqOiu5KJuTCmbXSCJ1mC
         jG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gnxos7238RK9JBXTMLYdE1/r2Mmy5C60jUNvaKJJuRs=;
        b=WHbdpjorNHadXk1u+G3a5017pxipJTZrMXawAjwFQsarfLpOAirwFFJntcyVaPEutA
         kifRfVPMCCvzgmyaO2OVLH56utI4z0m9s+H3BReAHKfPQni49NAros4g2SG1zbnMxHvV
         0ja35IBMbdejOsHRKxKaFcq5bYRDJgjDMAWVp34Gr3u+o3kPij1swMw9cmYijXEHTe14
         zSauIB5OrfgZ6RTPqZ4+L3+7fwDoUafoSE0/k6qrx3HDsazr0qPkiTpyqgsEKK2bN5Nf
         PJfcR167h5jV21jPGtCjw0nOxcaSuhswBoaaqmBBA2FwlkEKLuY2OkJKQozJlGp6p+LT
         II+A==
X-Gm-Message-State: AA+aEWaknoq/f8cCvNf2K9lJUgEW+Vw10navEyhMmWN4EoBvgdKCTi0M
        gQkf7qEgIdXAZwjuwEwIhkE=
X-Google-Smtp-Source: AFSGD/Vm5T9CxDM7dTmF3Naj887D9AcdV8PorRLy/KNtBvBv8/YfYq+6/cTs9a/2qxo8RZeVfOGh5A==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr812132pls.303.1542694374043;
        Mon, 19 Nov 2018 22:12:54 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id q1sm23928718pfb.96.2018.11.19.22.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:12:53 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:12:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH 3/5] index: do not warn about unrecognized extensions
Message-ID: <20181120061251.GD144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060920.GA144753@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/technical/index-format explains:

     4-byte extension signature. If the first byte is 'A'..'Z' the
     extension is optional and can be ignored.

This allows gracefully introducing a new index extension without
having to rely on all readers having support for it.  Mandatory
extensions start with a lowercase letter and optional ones start with
a capital.  Thus the versions of Git acting on a shared local
repository do not have to upgrade in lockstep.

We almost obey that convention, but there is a problem: when
encountering an unrecognized optional extension, we write

	ignoring FNCY extension

to stderr, which alarms users.  This means that in practice we have
had to introduce index extensions in two steps: first add read
support, and then a while later, start writing by default.  This
delays when users can benefit from improvements to the index format.

We cannot change the past, but for index extensions of the future,
there is a straightforward improvement: silence that message except
when tracing.  This way, the message is still available when
debugging, but in everyday use it does not show up so (once most Git
users have this patch) we can turn on new optional extensions right
away without alarming people.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged.

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index f3d5638d9e..83d24357a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1726,7 +1726,7 @@ static int read_index_extension(struct index_state *istate,
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
 				     ext);
-		fprintf(stderr, "ignoring %.4s extension\n", ext);
+		trace_printf("ignoring %.4s extension\n", ext);
 		break;
 	}
 	return 0;
-- 
2.20.0.rc0.387.gc7a69e6b6c

