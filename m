Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68D3211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 00:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeLEAia (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 19:38:30 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52244 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeLEAia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 19:38:30 -0500
Received: by mail-pl1-f201.google.com with SMTP id 89so13739214ple.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 16:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4qTEtrrZm7yyqx4nkfF49pYSfoBQ5cflAfWcSOzg2DQ=;
        b=ohSdmjxuOl1+GT2WCJ6YpNOUajGqsGjTTICvigX1og7U4EZF45DWQdW/MlyktZMvqn
         fLmws9T1lIinv23SaMJbZHc/+sLRPgLTbN51PFOa94sfrqDi1sqWJh6yTsOA8TNEN547
         EG+HbDJFgwXgodImdVE2wOFfnNLEjdU5lbprxr3lYoZZTl7QbFOTB5IuSZiTduZaOJX9
         8gKLhvEwwF31aJ2cbAD9V2NDRuGHon4pBpIPo0dh/6cP9OOrvsNdmURhUlLT7RKX/6JR
         w9QB7wofHsE0zTDUGAo75T7Rt45aXR5EoU/+Rk6xzlFZhZO3UqCZ8NSzbzudxslBz25B
         IKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4qTEtrrZm7yyqx4nkfF49pYSfoBQ5cflAfWcSOzg2DQ=;
        b=QBsNlSu+Ah53knqg0NbzVG1PvF/GzYp5VxZK2X+RuUusX/Tz7tVjCCv0viOc8Dd8gK
         ww0ABG1qI12m+eurvDFLr6yhiRtDEZAukOv4OeNr+tQIAoRg+XKfelJq6MiWtI8Euc1U
         3A17hp7/QFjZQMuJEcn0z/fgcsjzltyHadqH0XzlLHBrKMFlBp/1DXgh8SVpRcDAEV71
         WBLVWv/r67vFRrvRUjasj04yKnxhdyqE9ou7JlIRu4GRgzsRhKbRQ5jyKn524toHOFsd
         xliE5T9SYrHq21A2FBu7q5PG0Det4Ea64o+nPYWL5YnBbLB8MQaLrdAqfaw4ioUM68Nr
         +WgQ==
X-Gm-Message-State: AA+aEWYERqVrvb/0EgHH9+Ttd8eA/f9CjHOJ9EC008xLOOqMt8utTvvk
        JJWDBFdu1ryriJMlpa+nkY12q9U2I6gYbOO8h0ac
X-Google-Smtp-Source: AFSGD/WvdlSgI5Y44OHhjDePwdsbGX+vDCXPJML8gus3GGSkizeJy8sVtbT8SOhAp/getjqHKUUts1I4b10+83u5489+
X-Received: by 2002:a62:6085:: with SMTP id u127mr10532812pfb.37.1543970309801;
 Tue, 04 Dec 2018 16:38:29 -0800 (PST)
Date:   Tue,  4 Dec 2018 16:38:25 -0800
In-Reply-To: <20181129002756.167615-9-sbeller@google.com>
Message-Id: <20181205003825.79274-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-9-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 8/9] submodule.c: fetch in submodules git directory
 instead of in worktree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Keep the properties introduced in 10f5c52656 (submodule: avoid
> auto-discovery in prepare_submodule_repo_env(), 2016-09-01), by fixating
> the git directory of the submodule.

This is to avoid the autodetection of the Git repository, making it less
error-prone; looks good to me.
