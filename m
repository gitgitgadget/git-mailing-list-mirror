Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C2C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54752222D9
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyD3XQsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJVpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:45:36 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:50346 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJVpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 17:45:36 -0400
Received: by mail-pj1-f74.google.com with SMTP id na17so1329917pjb.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sVot+cm1FNUUkWRnvSDwvxRuIpDlfphJg+Po1erz9zk=;
        b=VyD3XQsCV8Kglaq7smhnBis8YrBmWVeiMnm/unl72UbVfD2kDGG/miE4osqVkiQylq
         cD7QEfFTXnw+X1w2MQ8jygl/ATVxr49LMbzLHWQWO9zbw+/lDXKAk5QiVVn5XjUwu+tT
         1AZeAqq7pr/wp24DurASOQgWFnh5Ts2JdkESyflMJS0l9Pw63yhkw59GayUUp1HYPIoa
         48LtzIhwnT3TjxuKOwaLij7wt8qQgreVm9uu79cy8SjHn9e6u1g1u5nwTS5Ht6Y1gvow
         NNHmTPsmiTPi4iwVgElY6FwsXfdaFkXCqRoRmZfXEG9eFaWaW1AN8YOhLHdkgmsCO9DW
         ACfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sVot+cm1FNUUkWRnvSDwvxRuIpDlfphJg+Po1erz9zk=;
        b=U5G8aXpgGug1PZIWMkyQJ18cRp4xNoItsbVDXAyizWClbX0CbhKm+qrjHfXbBOUvYv
         pooSTPtdESdebDfbmFgr3mtAK3KZoO7c+wQk2BZrykATveUzb2SOpIjjU+fqap+2X2E/
         lkxKOIHY3qIcUPCSEaSGo0GPKqAzoVquIBuOJyRkhuqF/jkj2TxHiMvqgGoC611nNJNZ
         D8b/ulKmKyuMLGzn0cndFCQ/1xxjGReofFdrpvQ95ARFNVH67aP4/fj/pU5eaINPFcdi
         WF6hXynDNaTheA/99NebnDHEin4W3m2KLBytrcaMqQrR0cRPVENxGxDZDOBHbUMHe+NR
         dSOw==
X-Gm-Message-State: ANhLgQ0s8ALjUq0JLEYN0ll1Er6bv0Cp0Hv9tvxkhlLSCbWhstxT0v8+
        XtK1Pwjfa2+qfcYUNbFoAOo8IX9dz6Z1OXDo0wCt
X-Google-Smtp-Source: ADFU+vscvdrOwLDJpYw5pyniJakZgeTFRv9PUaSLrZHsuk85ZStsEKpBtsSdEjd2eKvyX2DIgj44KA8e0ZxFR2Di76nU
X-Received: by 2002:a17:90a:ae16:: with SMTP id t22mr50313pjq.34.1583876734751;
 Tue, 10 Mar 2020 14:45:34 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:45:32 -0700
In-Reply-To: <20200228000350.GB12115@google.com>
Message-Id: <20200310214532.83349-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200228000350.GB12115@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH v2 0/7] Better threaded delta resolution in index-pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series mostly looks good to me. There were a few parts I had
> trouble following or convincing myself were safe, so there could be some
> improvements with comments or more explicit commit messages, but no
> problems apart from that.

Thanks!

For the rest who are following along, I somehow couldn't "git am" these
on latest master, but I could "git am" these on an old master commit
(from the time of the original work). The subsequent rebase works with
trivially-resolved merge conflicts except for one due to a21781011f
("index-pack: downgrade twice-resolved REF_DELTA to die()", 2020-02-04)
- but that was fixed by changing the relevant assert() command to
if/die().
