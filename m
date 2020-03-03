Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B0BC3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 00:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F144721D56
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 00:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4PgyVO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCCAKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:10:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46155 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCAKj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 19:10:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so607060pga.13
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 16:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Poi4mVOE61ZeJOWEJOAL5HbawwnsB43AajBZAozQs0A=;
        b=N4PgyVO8OVCQAa01wehfz6XNi6eGZh3hPwhsT5PVHp2rLlGjeXONT3pyK6ympaKy9M
         zJn5G+EhrSpPf2sfkPGhOp9c5Hl6SFrY05CkuPgDnbUFKix1sAyWUhkMnuDV24gOuRgZ
         WOYvECpv1RNtF+alclOxJBazjxlNkiknglqzC4yuevRQpQ1h1XQi9fRG2eYeWnIHehl5
         fDJ0TYzmQvgzyBFg5RhaWQ43T8ROe21e2sYRJIG9Q5OYwq3p6H8z+nuoEwD/wRGBicqT
         V9J73U+ShnkiAWSETAfMAu6qQ7Pnq8QR9D8E3S7nh+fM9V82b6NZvK48MJEsqoTxyEL0
         Ihdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Poi4mVOE61ZeJOWEJOAL5HbawwnsB43AajBZAozQs0A=;
        b=Ok1nAdelXQgdQYxaLTzWADPTufc2wGSQMHpbz6EA9mcIF8G0wpLAXWHkUCLHbF6oVA
         ez9suh54xuQliwRLBFGJSDB3873jyNDSXJfgPGRfzsDMT06TIUiMp+3HdXoZIg3sJ4QU
         pq7O8LhfCcIqMy9E5Ha/uRraKQTpuPPeGxuaPlNkc41Fa7g5eA3g4RbmGJqtERhKcGGD
         3UJ9WmfdEi4GxFsbDVicCK374b3vwheZ60PfttqDZqMP04kebKD7lpAEL1IgIx26BxLd
         6uF0qTebtI6r4oQKbhxuE6RwIlheVHhk+aZDT0kHJEBZXJ3GTj6nACV7YpNcbxymttNR
         XkYA==
X-Gm-Message-State: ANhLgQ3p+uXVBQ4wwA4ySsD5esGnfss/aobi2oVBkr1T1KMV01VMOt1U
        xyDgLMqplMv1xeH1jXUibZfEGBFg
X-Google-Smtp-Source: ADFU+vvjN8xR+YGFtSljmGy+dDNxBHc/nifTx1EuIxfJRchE917SUpenQ5vV/3D9n6v/2m5Of7p16w==
X-Received: by 2002:a63:6202:: with SMTP id w2mr1442941pgb.154.1583194238793;
        Mon, 02 Mar 2020 16:10:38 -0800 (PST)
Received: from f3 (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id b15sm22160795pft.58.2020.03.02.16.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:10:37 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:10:33 +0900
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH] git-gui: fix error popup when doing blame -> "Show
 History Context"
Message-ID: <20200303001033.GA138670@f3>
References: <20200302183538.7195-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302183538.7195-1-me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020/03/03 00:05 +0530, Pratyush Yadav wrote:
> In d9c6469 (git-gui: update status bar to track operations, 2019-12-01)
> the call to 'ui_status' in 'do_gitk' was updated to create the newly
> introduced "status bar operation". This allowed this status text so show
> along with other operations happening in parallel, and removed a race
> between all these operations.
> 
> But in that refactor, the fact that 'ui_status' checks for the existence
> of 'main_status' was overlooked. This leads to an error message popping
> up when the user selects "Show History Context" from the blame window
> context menu on a source line. The error occurs because when running
> "blame" 'main_status' is not initialized.
> 
> So, add a check for the existence of 'main_status' in 'do_gitk'. This
> fix reverts to the original behaviour. In the future, we might want to
> look into a better way of telling 'do_gitk' which status bar to use.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

Tested-by: Benjamin Poirier <benjamin.poirier@gmail.com>

Thank you for looking into this.
