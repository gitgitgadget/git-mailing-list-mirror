Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B63D1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIKX1n (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:27:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42546 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKX1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:27:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so27042802wrr.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TFzB5oJ0bMXO9LZNuIFeHrxpd3Un1J/Dwqp9nLVIarQ=;
        b=uqXpt9hiWrLoGvPqiFlnJdkq3O7w9a2fUkY2sfoHM2hziF7k9OqH8e61c/WNozisRZ
         oTpOYL+dvb1j3iEaOQunvuMIPyb70EfSoQ8TbLpcU0RtDK9EKMONnrrsruKYMfQzCJYO
         MAzDidWO5xFfqVvQnNJpAQLOaAR85tcSOUdHifHUkmeBt+b272iqxkB4zqttsN/E3aGQ
         iILssKJMvjYD2xFzTIgDjR9KQYLuhpBjw/yFTdUmRdRFS+qKmX/twvyWFyECBRNTj7X3
         ufam8VPWi0wFEBXIpV9JWJU+VUP1QQH3bNi4N2A076gviz9IVwxKb5JoInv8HnJV+wuE
         tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TFzB5oJ0bMXO9LZNuIFeHrxpd3Un1J/Dwqp9nLVIarQ=;
        b=k/Lw1ThjXo77EhF0unQW6bldh1Edgh4xdGZqWOaUNJ35QvDvYhnGeZhyKpKdr7Y7bV
         gOVJNn+EvCuBR5yWFpJ43/h4fTuo73taSRxlgk7EN0SVLx+jWTtIuM9HXrQ5H7FSWgyH
         xL6miGLG7PYVyomJeOhIdEdcykIvlm4FLx4eRpN4EFneehhmxjinLSfrWRpLxqBBXTOz
         G1vIeN01LTtNtdSk2ZbzmxVNStkwPcuJjWAU0mm3hDgKVr57bVJbbAX8TU0Tb6laImlO
         uftU1Vb190HhEU/dbE5q/ZW3mBvfFXbcVZSCSm2w45bfRFcHBK0fZkLxTWtZAqzOJm3f
         dDaA==
X-Gm-Message-State: APzg51DEFbv1JAOczq8xxjor9Bhs7hCXR5df7pSAHntRrBrtKDo5r8B3
        LI/95UeexgaVWuuXPPqjHSr/ajOa
X-Google-Smtp-Source: ANB0VdbiDRN1TRoEgKPoXmz7dd2rWW6lJ7Hze24LmDzDsUV1ESL/7BEkkNiRMGS0tX7O0JBZE+K+gA==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr19324506wrg.249.1536690428659;
        Tue, 11 Sep 2018 11:27:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b124-v6sm928002wmh.17.2018.09.11.11.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:27:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
        <20180910205359.32332-1-max@max630.net>
        <20180911034227.GB20518@aiede.svl.corp.google.com>
        <20180911040343.GC20518@aiede.svl.corp.google.com>
        <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 11 Sep 2018 11:27:07 -0700
In-Reply-To: <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Sep 2018 11:15:13 -0700")
Message-ID: <xmqqa7onq490.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> +		/*
>>> +		 * According to RFC 3875, an empty or missing
>>> +		 * CONTENT_LENGTH means "no body", but RFC 3875
>>> +		 * precedes HTTP/1.1 and chunked encoding. Apache and
>>> +		 * its imitators leave CONTENT_LENGTH unset for
>>
>> Which imitators?  Maybe this should just say "Apache leaves [...]".
>
> I tend to agree; I do not mind amending the text while queuing.
> ...
> I do not think we would mind terribly if we do not support
> combinations like gzipped-and-then-chunked from day one.  An in-code
> NEEDSWORK comment that refers to the production in RFC 2616 Page 143
> may not hurt, though.

I refrained from reflowing the first paragraph of the comment in
this message, but will probably reflow it before committing, if the
updated text is acceptable.


 http-backend.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8f515a6def..b997eafb00 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -357,10 +357,17 @@ static ssize_t get_content_length(void)
 		/*
 		 * According to RFC 3875, an empty or missing
 		 * CONTENT_LENGTH means "no body", but RFC 3875
-		 * precedes HTTP/1.1 and chunked encoding. Apache and
-		 * its imitators leave CONTENT_LENGTH unset for
+		 * precedes HTTP/1.1 and chunked encoding. Apache
+		 * leaves CONTENT_LENGTH unset for
 		 * chunked requests, for which we should use EOF to
 		 * detect the end of the request.
+		 *
+		 * NEEDSWORK: Transfer-Encoding header is defined to
+		 * be a list of elements where "chunked", if exists,
+		 * must be at the end.  The current code only deals
+		 * with the case where "chunked" is the only element.
+		 * See RFC 2616 (14.41 Transfer-Encoding) when
+		 * extending this code.
 		 */
 		str = getenv("HTTP_TRANSFER_ENCODING");
 		if (str && !strcmp(str, "chunked"))
