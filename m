Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7AC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 20:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A262073E
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xcaunt7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgFKUFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKUFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 16:05:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF758C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 13:05:00 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11so5817753qtm.7
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v6nKYLSphnoI0RMkMX3Qp22qbeSf+zrat8owmwva2RE=;
        b=Xcaunt7MsUNfTHglJv4NQEGw8cSkpE1n5b2LNMUmw6WPbhVA6mBnbjYsN0Sb8uFXAA
         IEhAIHGhpqflXFYJKF9fTz2BG9OhkZRHb0HG79h6rFUciVZFJ4Qt6E+J6I9/sO+aSm/e
         wGdrsq883Eo90FXik1JczR0OoZ4HebOBQ/3bkb8sbXqYMCqsou7+aNnrE2VkfQ7Q/p5o
         CmWITccNu2J3/soMGk6UGrffmddJS7cNsFSRTR2iWWADOSReQOePutH/MWTHsBi6vBHn
         ZwqgUzvNIpAycGPET9Xio4kT6TSxJR9VI4QsVPmNO4bnQc+E+pUZwhCmujPzLoLIysNr
         dxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v6nKYLSphnoI0RMkMX3Qp22qbeSf+zrat8owmwva2RE=;
        b=ECHFj/DkyrSis6ynUHp0hLZDlcKKDcxM8TxIU8HpTB2gA59b/f9cMdWUXpjLdG6m5b
         aS7J4/BfZ/L/sJEcqrIxQW7Tky5xoDHWOeSdYqHiksvHD0idHyTeR9smtGobNJi+87U7
         DFz8EwWz0XS9X6L901G4m160BlkpRgAf96r6wn3k+8p2wLBobElyUh4Vg2as994H131d
         8ewY578bP44m9S7DQYJqJuZdpZj/xIMLESaOUp/Wiu5Krlu6VuVhku6GRYnncvAiZTuD
         ESY5YFKZFruvSHhwxS/tUp5/cpI3xt083k4l03YEE3dalNxu/rFINGwTicADcLWiBd1D
         phvA==
X-Gm-Message-State: AOAM531B1O+V+WHpK41wUIzmVKb9xU4QRwkvFpxfVfc/gf7a8JcJsGnW
        SLPDX7chrgafvKNGJZva/t+qTGJNEbWvNeEMEYo4
X-Google-Smtp-Source: ABdhPJxJggNh2vJ70AYt8ke/nXbRaZAftzeDAgdQHM7ZA1zwfg6ZLiWFywAAKTfaRqBddjVcejBlvkzmTDBakRXARkGP
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr9506968qvb.106.1591905899496;
 Thu, 11 Jun 2020 13:04:59 -0700 (PDT)
Date:   Thu, 11 Jun 2020 13:04:56 -0700
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
Message-Id: <20200611200456.102655-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200611120518.10771-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: Re: [PATCH 00/14] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 3
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This patch series is the third and last part of an effort to move all
> static variables in 'upload-pack.c' into 'struct upload_pack_data'.
> 
> It is based on 'cc/upload-pack-data-2' which contains "part 2" of this
> effort.
> 
> There are no static variables left in 'upload-pack.c' after this patch
> series. Patch 14/14 is a small refactoring on top which can be left
> out.

Thanks. Overall, I see that this patch set gives "struct
upload_pack_data" to functions that use global variables (and in doing
so, shrinks their parameter list), enabling global variables to be moved
into that struct with a small diff. The changes are generally
mechanical, and this patch set looks good to me.

As an aside, I have attempted rebasing my CDN offloading patches [1]
from cc/upload-pack-data-2 onto this series, and the rebase succeeds
with trivial work needed.

[1] https://lore.kernel.org/git/cover.1591821067.git.jonathantanmy@google.com/
