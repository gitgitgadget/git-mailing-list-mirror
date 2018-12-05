Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A250211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 00:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbeLEAMw (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 19:12:52 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40462 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLEAMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 19:12:51 -0500
Received: by mail-pf1-f202.google.com with SMTP id p15so15327534pfk.7
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6/R+kKaElpXlYTvaa40J00muW015u0xQQCvvpU4KtT8=;
        b=b/C8lxFv4uQPWSAzWkhCF6v0v970lN0uHKAmQyd+07m5To5ptnpzNrNucDlBK2aPJq
         1vtoSDH+vwolXuMRMzJgHL98pPJZfcHY1Oiz5ksex7fNh2+uRvmND0VbmHlylVz3DSfK
         6quSlaGt4mAZHaajnjdyvewbwvYIOSZ5N4Ph8rjVQxvKAITf5Hk50lxxQJou4Uz9y4TE
         OGzWW5urLe2vdoSUXfzVyCTyL36mUKxZDxF1i8ksXePxL9Eo2ClK4O6qxjntiYqkBcVP
         Yp7Fh1JHvaOJeTcDKl/aIDreNAyPbJRci4HlLLxVNWeUva8scGeSZoTqU0xCl+WqG/mi
         yFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6/R+kKaElpXlYTvaa40J00muW015u0xQQCvvpU4KtT8=;
        b=kA34tloWwnajTWhzg8EQ88008YlKcuZch0K+tffS11vY1ejroNUBuFav+ehKfjGR3e
         Nn9UV13FxfkEFaDXxtzVBMnLy2KYfu9rxF12EpRYCdQDcqea7ccoWFKCt4f9fBkVrKlj
         ZWmzSta2qShZzW9vmOhV9qaSf1ATgnuTuqnIvfuzSFtAIaEnGVw4MaxzIV5oa+RDgPvs
         QUMcueGWBLDYv9Rci6Ghb3bfmvtlVx89YSkygrdI0dA5OyvEPUcX2/AMQKIxTGyf+79I
         d/Nfszkfqtpa4bs9AICeM6YOECypX6aORbaGmFhaI3FtAjpEMT31IiKE3faiq6yI66b8
         Lxxw==
X-Gm-Message-State: AA+aEWYWywdLI4G5EzRXJlcYa8Mbp1PWNyfXQ/DaYBaTM9yAOvu68xfQ
        Zn0FU9LPKs17rileYKphBh8b3olH32pqLGGGy1XE
X-Google-Smtp-Source: AFSGD/Uq5sQU0ZG9PgyA8dA/Efhi/V5WnlNnlA+cQh6AHGJODx3mZfVTrOFSJt40bIojSzV2/PWvZkD9ylFnOUHW1bTv
X-Received: by 2002:a63:1d8:: with SMTP id 207mr10195639pgb.40.1543968771023;
 Tue, 04 Dec 2018 16:12:51 -0800 (PST)
Date:   Tue,  4 Dec 2018 16:12:46 -0800
In-Reply-To: <20181129002756.167615-4-sbeller@google.com>
Message-Id: <20181205001246.71899-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-4-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 3/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We can string_list_insert() to maintain sorted-ness of the
> list as we find new items, or we can string_list_append() to
> build an unsorted list and sort it at the end just once.
> 
> As we do not rely on the sortedness while building the
> list, we pick the "append and sort at the end" as it
> has better worst case execution times.

I would write this entire commit message as:

  Instead of using unsorted_string_list_lookup(), sort
  changed_submodule_names before performing any lookups so that we can
  use the faster string_list_lookup() instead.

The code in this patch is fine, and patches 1-2 are fine too.
