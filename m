Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B926F1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeDZHpR (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:45:17 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36198 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeDZHpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:45:16 -0400
Received: by mail-pg0-f41.google.com with SMTP id i6so15283098pgv.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=675fV2vvOt0BJES/RUbdprtxzo0O4w1DrOksDOI1d0E=;
        b=VBkspJOk9ieVcuqHvYUzhxnmb32TnoRsFqNfzjSDURa4wGMENfKENQneYaj6aqPDbr
         1/t0HIiBqGytj7R2W9fZZINChqUV0/WMOWWmq0a8+AvPq2NFUuZCGLn7xNmvwonGHeN1
         RXK10Tv2xOF03dYLtp8mKwen0vGZLTzWmausF6yi8Bl1L4XMundq95YMTqWLSg5WiFOb
         D3tTi9nYOig/JaxqxPeZwf9oy+mzZVFuPqR55xPBCcsdHXcK2WaxUKx9hpgDDmZlJbjC
         uqXCIru3i9Lv03M5MA41L661BtMI1OyHZrnZ21ff+20HBWMbYJJkQspN18q0uT4DV8zA
         tavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=675fV2vvOt0BJES/RUbdprtxzo0O4w1DrOksDOI1d0E=;
        b=gWGlxC3YVeCxTMaEHd5pFPoxr/jWjC4cnLj0KRHeKDtJ1b+Q+pLHmZJaONJiXcEOSt
         H8eU7aqUcFAHb5HBnMid87Ns+rrBpkJtVojkfArjinNpXK05rMsw1YPuYp35dPBdcmZo
         v06jtX5RsnYdu/6dc7PGZEsL3penLRQeAP7Pw1J4/o1hwBQk48l+D9lYta9YfBteQxPZ
         PIzlTfEYENHtaZZMENhkkyoM9fkVL5Ya59u4qeKoSNe6hPsOuEEUckL/e4lLFtsuENxk
         FWKrQBFPjxCCLm194FAy8wqz4FkCMhs/YBY6h8dJ284AibEr6sZpbiC9fIHluVr1znLe
         VSvQ==
X-Gm-Message-State: ALQs6tBkrJJk88lQSkgP93WVh3+7p8YCT/VTyMh6wHMh8JY5FikBWJ2A
        Fd7tA5qjCL4ywJYSo8/9MKZxaw==
X-Google-Smtp-Source: AIpwx49Udq/XIVXgB3/mh2j/ApfMQvgqwgCAgxKfz1zoOMcfSDXRqF4PJPumOm6O1GQpJfJBnf5KUQ==
X-Received: by 2002:a17:902:2804:: with SMTP id e4-v6mr30490938plb.153.1524728716345;
        Thu, 26 Apr 2018 00:45:16 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id e10sm31007774pfn.67.2018.04.26.00.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:45:15 -0700 (PDT)
From:   istephens@atlassian.com
To:     sunshine@sunshineco.com
Cc:     szeder.dev@gmail.com, gitster@pobox.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
Subject: [PATCH v4 0/2] blame and log: prevent error if range ends past end of file
Date:   Thu, 26 Apr 2018 17:45:00 +1000
Message-Id: <20180426074502.78318-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Picking this back up after a little while. This solution means we can still accept
-L, for an empty file but any other range will fail. I've made the change for both
blame and log (as two separate patches).

I've also changed behaviour in a couple of corner cases - before we couldn't
distinguish between -Ln,-(n+1) and -Ln, so -Ln,-(n+1) would blame from n to the end of
the file rather than the first n lines. Also, we now complain that -L,-n is an empty
range where previously this would blame the whole file.

