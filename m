Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16BC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 07:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBMHGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 02:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMHGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 02:06:44 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FF3C143
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 23:06:43 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n2-20020a170902d2c200b0019a8c8a13dfso2821552plc.16
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 23:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl66q48YCRr6Bs9PRUMvu/b7UtQzjqPzjyFj14aSWXA=;
        b=nFg6lqETWzLiUNFuvqRaX2v71Ynjmw7S21EBJVlRDuAYGb04KzwHCWhXS3WD1+zGZb
         fwdNE7eAdtFP2g/riFV0mN0eMMbGfCKKgCADt1G0Efy5UzEQ3BvF8gAXq6BmEEZfy0N5
         L+hcYvhHziwCOj17RAzho6+CsOLuiK5RVbDwWfYku7RsEYJu6Cx/0e655bB1XMcohQ60
         CwGSdZOAW4S7N1RklI6OmwdgwpFyCMojkkiCoufOJmpyqFpcPXOT5SOZN4swxr+J6G+M
         8bchCVrkLfkhDcJVMP/f3OWp/n/1Z257i9OQOl2vZmyI6UveuCJTs0Zwdh+g+dyD3JLg
         6RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl66q48YCRr6Bs9PRUMvu/b7UtQzjqPzjyFj14aSWXA=;
        b=kVjppBtzmC/96IfMT5FsbhrjTFdZGVnM/SrQyM1WwerT8/18YpUIs9womEMD56KKV2
         QCuymMOPNHs/M1Cz1K8LYkY/lHvt+QiOnmQJHQLy8rAOH2vAkxoNoZQwO0Agm4NzB07Y
         9ASqa6meUBqYtiRcsv89cTu+FVjPLIw9GE3kL06aE5B21hQHCUZA08w6wHxsIRguQqtg
         Nrl5dHoT5lws7JFyQLjkWYM7Z8GvUvpwSGnHiSBKsOl1g18t0gzUtBX6oX+WLhmz7S7q
         ILFs0Vkd2H33Bqe/1rK2NEXbI4C84q/31ozlowcGhYj2+5PRjS5WrENYDWqOyi6NR04A
         BuUQ==
X-Gm-Message-State: AO0yUKWjHqdtQ9pWl+vlwJhQBWwPq8HD7fT0ResX9W34jYtHwldqROsp
        aMO3xWTfjLznHnR63eEhAjGtfPFkhaB3Jg==
X-Google-Smtp-Source: AK7set8ouwBop3kpLfI9u66RUT+wAyA3YCuJGcKYWEXoRHWwVMcIbLIV4NaxIx5dUqR8domdbwX7AkugwDyiag==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:b78a:b0:199:26df:77b6 with SMTP
 id e10-20020a170902b78a00b0019926df77b6mr5329939pls.3.1676272002950; Sun, 12
 Feb 2023 23:06:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 15:06:41 +0800
In-Reply-To: <20230209000212.1892457-5-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com> <20230209000212.1892457-5-calvinwan@google.com>
Message-ID: <kl6lk00mavsu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 4/6] submodule: refactor is_submodule_modified()
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Refactor out submodule status logic and error messages that will be
> used in a future patch.

This improves the readability of the last patch by quite a lot. Thanks
for taking the suggestion :)

(This patch was actually introduced in the previous round, but I missed
that, sorry.)
