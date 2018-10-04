Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B09A1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 19:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJEChb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 22:37:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32780 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEChb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 22:37:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so9663987edp.0
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6Te8Cys4J65C9R4geXATPZz6ysnohuT7Hf8kAKs9d8=;
        b=O9JUwHEiyvGZr9RCJlC3SprU4DqY+wZ77HV+4JQtXiZb22Cl7LyuuNhPGkC9V/jiBA
         sBhlxCQQHgF+XkpXjGtSGMu0o2lBZ+q1Dz+z6oXuCSk/Zq7IgKxXVL5OGgIaHvr6haJH
         Tceu91UNPGnK9ZQueiuZWvIBM7hiVBSXWm3+9Tuqi8hIF2cdabltEcNzWiA8kmeVatDf
         292qKwsblZZ9l8xCdplFyhLlIoS2wWomoDMu2eber/H6FXaE1gdKMffzRvz1nKOpNSK1
         co+5QVCk8bYKZ3gjqH5vThK5jqBwLCpbgICejJcW2hyKhF8zd8iCPCcgz9JHdWYK3HMa
         8g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6Te8Cys4J65C9R4geXATPZz6ysnohuT7Hf8kAKs9d8=;
        b=WJs29TFRBxaTWaY4ks+tp96yLAUJuzS9DpgDykH/Y7zpdP4EmKeJha4VLtz5aXbLdB
         Jvb7uXo5UF0SiPzbBNyrIq14/5Azw8p8ZK0v/My8f6bo/lYB1qxWpmDXmD2emCBM7oPL
         Db78NB1+v0kYt9VcTd0ep1zTGGSMuCgOqmVM5TKJNEe1s+pQldge49vBCZaWczBRCqDs
         jy8Q6ij/lvPEgHBe6BnzddpP96xYX6mvAlbH9jkrmJNMXMNiOdlD8F7RF/wmOBhLEbYk
         VIrfophK4acLSMFCExhHnpd/rUNAlbiLb5suVQx2HpJJhJO3Yrg+6tTYYpeDs1bp7M9A
         qgpQ==
X-Gm-Message-State: ABuFfojpRqhuKOQtGluw0ziMpK8YhZoOO9/eAUD6J4pOSdhPVgUHtxeh
        HbTOi5bvTvqHMzM+MMrMXto9w0FQ13xuoSMGZ+pIHQ==
X-Google-Smtp-Source: ACcGV63OXnMjYkwIYzpTPOXlqmHos7F/IA7xJB7lm0YDYcs8m3S7vVvkL9LyTMOUGAfT/VtjkUDarsenlRXp4gvtzOo=
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr10397014eda.154.1538682165508;
 Thu, 04 Oct 2018 12:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net> <20181004100745.4568-6-phillip.wood@talktalk.net>
In-Reply-To: <20181004100745.4568-6-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 4 Oct 2018 12:42:34 -0700
Message-ID: <CAGZ79kbamUK=d+-ejy9vopDiVZF7OVOngz1Zx9y04VR3HnmoXg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] diff --color-moved: fix a memory leak
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 4, 2018 at 3:07 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Free the hashmap items as well as the hashmap itself. This was found
> with asan.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for this series, all 5 patches are

Reviewed-by: Stefan Beller <sbeller@google.com>
