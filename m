Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BDC433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C53A20724
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbgFWV26 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 23 Jun 2020 17:28:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35336 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbgFWV24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:28:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so107790wrm.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=68rlqdLgeckm4Mm49Wkbzoe2na86JqaADLRuyYKro4w=;
        b=BhGnJSjYoODB8+duFv9zLf3DngNlchnIDBn9BhfjLoppMsx7PbnF/94IkBQSqYhzQb
         yd1iU3T9Q5NePL5jgMxVFSEJBEBTCCinfPvc2hzV1M93ScRbunbe/Jw2ebZKMs7kNRC/
         FQCNVN+TS/tTR2aF6go2d3ZLHq4E11GJMOb0t7nsCfoYG8+MGVt4L+AxVKla9QaSa3l2
         OOzHQHg4IIMKlmhCu4va+v44KwT+fGYIOLmO5PaLRhmzKnCpYLjIZyvaDlh7v6cEbOBd
         PhH9/5w4qAXbtJ1A+zjO5oYIQNPE0OVlIjExh/XdI+TI8RzfibbA1Vh1yQnvXsnhF4Ur
         E53A==
X-Gm-Message-State: AOAM531vjOMqT52x+Ir25NSIYZSoBg0VZwMjUG604/gHuuK0NrgXW07Z
        pL5Dq4sWDzOoIgU8RGD7m+QDEq0zgfjMwJas3RnS6LSAl5U=
X-Google-Smtp-Source: ABdhPJxASXSa86BcZuOzPEK/YZnzxMCfLOHkl0OOzz5+f5vH+0Z1YdSYnPdBFNFu7Zh+FTs+FELS8jTEnpmKLXPLWu4=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr28033305wrd.277.1592947734548;
 Tue, 23 Jun 2020 14:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623010519.GR6531@camp.crustytoothpaste.net> <20200623202129.2616672-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200623202129.2616672-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 17:28:43 -0400
Message-ID: <CAPig+cSPwR_0xR5X50dbBAJ9EJKqP7Vyu_e3jsq_WOg=B0tKXQ@mail.gmail.com>
Subject: Re: [PATCH] http-push: ensure unforced pushes fail when data would be lost
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Ward <mward@smartsoftwareinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 5:23 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> When we push using the DAV-based protocol, the client is the one that
> performs the ref updates and therefore makes the checks to see whether
> an unforced push should be allowed.  We make this check by determining
> if either (a) we lack the object file for the old value of the ref or
> (b) the new value of the ref is not newer than the old value, and in
> either case, reject the push.
> [...]
> Signed-off-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Do you want a "Reported-by: Michael Ward <mward@smartsoftwareinc.com>"
in this vicinity?
