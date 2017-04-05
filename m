Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F4820966
	for <e@80x24.org>; Wed,  5 Apr 2017 22:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbdDEWzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 18:55:03 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34183 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbdDEWzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 18:55:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so6531521wrb.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=3uMhhGquDpwRLRneQ3bSxHg/OpwXnRI3CqRBIg2ii0Y=;
        b=KHHhF5rVDdQJ8P2P41lhxX9TvbBGLxmO+3vaFazzDY88KJ3nVopJREpVfBXL23NlvH
         YOxDy79WguNBz4J09iMjiq2CSxbGrvDMxx7Y5zvlwi7TtYRPnNSfwt6gycYpo+uVL4Py
         ocQ9Zl6C4jJKomREdOiIeAcYoyFtxybuPI6Bs5BgZvmBD6Wxf65rN4u9PqS2XWWTjiQP
         n97DXtMUk+AB779IWcJp/ENnoWOKgOzZ4zOAyBie7iKzZGthCumf3GfxD2WGKXcoEr6e
         aRuDqizfHnBQvJDj4/AsEBgjvczoG5GuoR/FjcM0Dm8PLX//QtA+D10wQHySM+Q3R8b6
         2zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=3uMhhGquDpwRLRneQ3bSxHg/OpwXnRI3CqRBIg2ii0Y=;
        b=VARyRoFBUxiOu1wMpe9iPcvSjInWfJ4ymRGWgY+pXoOjb6A/uClGHmr8ami67RKc6+
         /dg7OWS2qTRU2fUT1v9GN6iR6udtdbiyqPGefbP0WnIjxygBWJlLsCgsa47IXuRuBUFA
         vzWR4AqY6RvKFM57a2kCvdbeQ4tkpRDp9DwvXTWGPlARrNTOe8l52zd75m54kNhh6SGO
         U2ClWpPCcrr5C+5Ov6QI7Cqk27fA2HBt+pvKdF+PpRcU78+ShcqV3E4TSw2NvsYaz0Ip
         h/5/tvwAkWoYYynMrU13HIdUtLsWV6vYwXcgwxB7wfNOuzK9Jg8ABxz6gWJ1kOK/4oJ/
         3mJA==
X-Gm-Message-State: AFeK/H363tD9V5ri7HfvMpYXxXHG3evbN932ji9SQk9BaAykRC7+TWMt
        GHvHygEebz7dEA==
X-Received: by 10.28.197.133 with SMTP id v127mr19751240wmf.120.1491432900780;
        Wed, 05 Apr 2017 15:55:00 -0700 (PDT)
Received: from localhost.localdomain (x590d7ced.dyn.telefonica.de. [89.13.124.237])
        by smtp.gmail.com with ESMTPSA id w10sm23990053wmw.14.2017.04.05.15.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 15:55:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@jeffhostetler.com
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] read-cache: speed up add_index_entry during checkout
Date:   Thu,  6 Apr 2017 00:54:53 +0200
Message-Id: <20170405225453.2632-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170405173809.3098-5-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach add_index_entry_with_check() and has_dir_name()
> to see if the path of the new item is greater than the
> last path in the index array before attempting to search
> for it.
> 
> During checkout, merge_working_tree() populates the new
> index in sorted order, so this change saves at least 2
> lookups per file.

I think the performance numbers from the cover letter should be
included here, so they will be included in the history.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>


