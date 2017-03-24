Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0056B1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966697AbdCXW0F (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:26:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35986 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbdCXW0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:26:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id r137so497425pfr.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2KmxErh6VrRD177s08w6A2A45mwEqU+HIYDSwe8MVLw=;
        b=tq1CRmxeRe0Spz12XVWx5TQiYAYpk6Z8ZasFwTsxDZbE/Ig6vOylWVNeumKsu1CPzQ
         i+/v7x5GTYcXrp71Py0uQeGg+snOcowVOsTL19FxWENyDKxFMqVQ+3bQ7owYnkjZbuG6
         Lb9bsYDK6+P3IpkPASgYCqfc3qBBnwIXRXXEzBc/eAlTcgVLUjAzYF8ER1l2Z0e2wVAQ
         chEldiCZX31EZ7UxWVQeEsRf4pd6bo+5aLN2UJmFjBlZctHtB1964eif1iO4kza8nRld
         wMPeRXL5yBcYAGtlt+Ua7Nfw+Reqf8g8hm3dnlNzczx+UGXf0+mfeIfKpdhrtN9avFDk
         P4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2KmxErh6VrRD177s08w6A2A45mwEqU+HIYDSwe8MVLw=;
        b=jAbmwqq61O5PTXquyCKouoC87k1vSTOHmj3lJCGYJNeP/3DLnEkx3wrlfOrFzJD0Ks
         QFHw46c+exSscrREXMgNiwJV90Ai0RQGxe95wxkYdMELrkBdNY0KJfEW5C2kPPY2UqNd
         wzIt7NXl9PDGzHrk3LCyzyVN5b97jZFPco5O3fe4wy9NVpiwKANJ5IdGlC5fU9Fps+qI
         /mnYiN2bYZwb3LxSSxOabpRgGtT0Q99Ao5aqxdoFvFIJj/h8IFA0V4h3wQridfWt8w57
         8mr0Oc70UO538cm7gHS4wFcP6Tv9iyoDiS8B4eMzXU/e/Lkt9gTmaNuAJNr8afHqnCDB
         zZSQ==
X-Gm-Message-State: AFeK/H3iQvtLUBTmHOCDxqi9tU5L6++pBal3fEh+fnIr8TVbjCMX6Q37DbrgD2OTHx2cng==
X-Received: by 10.98.252.211 with SMTP id e202mr11999403pfh.118.1490394360217;
        Fri, 24 Mar 2017 15:26:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id x68sm6537375pfx.45.2017.03.24.15.25.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 15:25:59 -0700 (PDT)
Date:   Fri, 24 Mar 2017 15:25:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/7] submodule.c: use argv_array in is_submodule_modified
Message-ID: <20170324222557.GF31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> struct argv_array is easier to use and maintain

Missing '.' at end of sentence.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

With or without that tweak, I still like this as much as last time. :)
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
