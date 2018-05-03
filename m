Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD94200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeECSFD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:05:03 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:40059 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeECSFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:05:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id l2-v6so13662878pgc.7
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7ZzIYXdNJPYxeUSBWd8to7sreYyeDtwpHWACFExp98=;
        b=KBFtN2AbyisgQO5usoIA1zZPY8/S5tviKI2Rz/XOD16UuKH01zqbH8/AJry5LrVaab
         83g250wfkNilYyzDf5HAbcsbLrL5EPYnV9MrCmGJV9ckcd4wMFfnsB2u3LfU7I4img4c
         61R9Fpc1VAA/P8dWS2IFxjIxGIfQek79ivDXhKLIeBauBbrGGdmE2TZCtaEavYtyFjtc
         O57LuDkr6/Nrr6Jr3GfSF0MptcW0e5Pb+C5rj7wAhhOduGixPCe90pqsTblOc+zwOUjj
         nJmAS2DwISslo2OM0KMM4cXEp+LqBWlrWdo3BprNagCKoZqS7raJOXEox8GAKst//gKR
         Isfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7ZzIYXdNJPYxeUSBWd8to7sreYyeDtwpHWACFExp98=;
        b=ZBfxGRduq8yd2QgnpWtD/lqFa7NPDuGazB4RNpHWEVi3flWaHqp1lyZkwZTJ5y8pnP
         CCTUd0der5yzHGNzv00/liRXWEV1DHRqFlexmqNVZUjWNmcvGRB9jAiaynv5xNHDjNTq
         SHqTSISHVTMl+nydo1corNSm7yUTD+IcJWLleonc4PzuReob0w63MbxAKAUJP2WZXKnF
         DcUV0QF1CCNRsVy5vpOL5uAqGVDIGB4uDdHmfwhZry1GV+MrgQyM2vx1PBLTPb6zlsHh
         vvqjAIP3IgVTWOB/ltVc+3zOHjaDhTtV+Hsem5EXgvoF1MhnFsXNCdEmfIvAHjEJR1Zb
         GNJg==
X-Gm-Message-State: ALQs6tA7DiCOG/qmlFvy2l/9lc5S3VeyjKFS4mLT4a4/eRuY+gJeN1rH
        ZL9Qgnl0OJ6GbmcfbJNcK6XUzg==
X-Google-Smtp-Source: AB8JxZoSJbpHvQgWLZHcJPcVXKtAfQXbFIvSYatS/Mu9Ic7ilbwLzVI6E4gfdkzAi2qs0QOHkPl9sQ==
X-Received: by 10.98.50.198 with SMTP id y189mr18710690pfy.241.1525370701986;
        Thu, 03 May 2018 11:05:01 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id j1sm25981731pfh.95.2018.05.03.11.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 11:05:00 -0700 (PDT)
Date:   Thu, 3 May 2018 11:05:00 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com,
        pc44800@gmail.com
Subject: Re: [PATCH 5/5] submodule: port submodule subcommand 'foreach' from
 shell to C
Message-Id: <20180503110500.cbabf44370b28302d74d9701@google.com>
In-Reply-To: <20180503005358.89082-6-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180503005358.89082-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  2 May 2018 17:53:58 -0700
Stefan Beller <sbeller@google.com> wrote:

> +		argv_array_pushf(&cp.args, "path=%s; %s",
> +				path, info->argv[0]);

Do we need to quote the path here? (For example, what if path has a
quotation mark?)

Also, would it be useful to have a test testing a submodule with a
"weird" character (e.g. greater-than or single quote) in the name and
the path?
