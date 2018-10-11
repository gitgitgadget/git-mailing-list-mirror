Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13741F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeJLFbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 01:31:04 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:48162 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 01:31:03 -0400
Received: by mail-ot1-f74.google.com with SMTP id q16-v6so6596229otf.15
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oFSGRagLl/dvOi0GRze/Rg4UwGB5oDck6eAG/wHxz5o=;
        b=Naknbh1qgJ4w0Sx6fJFvLeDiBvECW9PG2uF6Y7/fiqpBCPBVlVcqdCqevRs7dpMCOp
         rOYRHX/wibPqnhKyON93kuK5sAPCLepQYszFj9YEy77sYbeQTZZfnRFOjhiTanIn0xMl
         7CoPQqt+g2k++ZmgkegRonQFx83C0LcJIvmrcQtpRjp7rkPQXr1JsfsEjoHSZW9xhhUe
         4Q1QqAb3NslwOgAy9FTPfikgsK384YelNIfRozO44PAZ/FxANmoGqTlHGtdk3CuX5q5o
         1RNeh3dSTigWpHpJk7vBr4HRmUFNDJM06Zq8tIkOgOBgtJS/dARl+HfzvrsAaBMByZfi
         N/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oFSGRagLl/dvOi0GRze/Rg4UwGB5oDck6eAG/wHxz5o=;
        b=TMvgKnGWH9hkeR9Y+HOuMKpoydnr8g/4MBXbHBQyDmsXx8aAdOt8stqmCfL3oEfsld
         ERlZJG/3Y8DOC1sSOSmRL8DQ1DgzMPMC1q3cSwDbPeAR+dG4vpOH34n1tGX2EhL59x2w
         wTZYJDLrs61bLQBy6SxxXMebb22Mae0t76AmaZVmoBLIbkOkZyIIItA3HicFDTC8ZDpy
         +VcZBI+1SugJjEYpOcjqATjYF0oH0PJImidgHY3depCBp3euboi5TuJ3y2Am63zc+U4D
         zQZKixDnzZFacwvU1v6uKJsSiXxiaP1KFrgaFGhr5K/xpL/jHyjEfCgxwr9m+JZciDJd
         uNSQ==
X-Gm-Message-State: ABuFfogbPDqFOGulwymR+CQhbF1pt8zc9LdVWn5v42XoO66NWf+nv1WY
        JSpbwarGBlNgnpzN0tyL8tBX4QB+UfPG4BwhCMW7
X-Google-Smtp-Source: ACcGV63Adkx8Y5L+FHk7tSa+sbbEmC5+Mp3wqUfuLbUjMv15MphphpWXt8tkOSATVHTaj5nT/KZnz4SZ7CvlgGUEUD4o
X-Received: by 2002:a9d:6195:: with SMTP id g21mr2816078otk.10.1539295310438;
 Thu, 11 Oct 2018 15:01:50 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:01:47 -0700
In-Reply-To: <20181011211754.31369-5-sbeller@google.com>
Message-Id: <20181011220147.183266-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-5-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 04/19] object-store: prepare read_object_file to deal with
 arbitrary repositories
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Introduce repo_read_object_file which takes the repository argument, and
> hide the original read_object_file as a macro behind
> NO_THE_REPOSITORY_COMPATIBILITY_MACROS, which we planned for in
> e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)

That commit didn't seem to plan for anything - it just seems to add a
new function with the name "repo_" preprended and define a macro if
NO_THE_REPOSITORY_COMPATIBILITY_MACROS is not set, just like this patch.
Maybe s/which we planned for in/just like in/.

The patch itself looks good.
