Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46977C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2108D206FA
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C2jHzzOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHaRRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgHaRRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:17:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158EC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 10:17:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w17so9809665ybl.9
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+5bFM9XoboMueLZKFAs+lsIrXzPnbrcRbyEPEgBnV7Q=;
        b=C2jHzzOXAZ66VWHzbVLBGdbkqDno9AFokn+R2630mbyFK0NoRIaW6xZTmpNiBCqKLB
         xpDTFGPNTPqk0YHy/Ccx9IXf/02Ec60CrFrlm5+tSetyI2uql2A50/RQAj9w8iJ6p4Wn
         xScYEe53D1VzVEchqEpWD3MDPy70RegjYTkk3zuiKLnpEGhF6vpxFwDDnQuvsVNA0RNI
         SXr3JqokI4pgBTM4wBrGeCsXuo6vGYoEyfWWRPwLBNdLcabPOMgDkNTJCtfKxLP23KVI
         oRddh95zwptUljm80BQd8wjdeWfcY/LyXzixlr0hmjpaX9wgMIzZnl85guaVNvwmcgoJ
         GtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+5bFM9XoboMueLZKFAs+lsIrXzPnbrcRbyEPEgBnV7Q=;
        b=f2HvfCZNLJi4U6Z0jndscCE0+jAqTlG3J3t5lU1TPuRmIpBq71ISyLL31QAB1JJV0L
         mWeOGwGH9RvaS3p7ydkLmrriJiNgVWMDyvoJEJtdSK7Pdzn7zxyj3enLl5YO0qEfY8oE
         UvCBQTVPBjfHbW7U7LCC6GkWRvimS3jK0ioa8xR0PAXa3MVOgA3GsWVHCcSF5Uo2s+3o
         LzQBcu1OsadRDdXbPU/A70gx2Lvtg2MMbcUVYqwBoOQg2OgapA0WJPJEmFeUkce2PNt2
         QBtAFRkNeqVl36YDeQDKbloXzu4afKTRHd6p+r2OHWnfApmES8fEYhKulqPlSB2cRXiE
         jjnw==
X-Gm-Message-State: AOAM530auwaPktnIho9UV27atg2BPhLGwAzQf1UrIBHuir9/ZS+0dHPc
        WxY2NlnJxOLlLNdOgY5mA2O4kIJPTTYuiDRWNEaP
X-Google-Smtp-Source: ABdhPJywzg4Khlzykzxvlg5GZ2SgpF4see14Rx9YQjWbpbr8re5VF+PSni1dgohYmlcKxO1YhUpfARl7nvgfUTo21FtO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:880e:: with SMTP id
 c14mr3651828ybl.181.1598894256483; Mon, 31 Aug 2020 10:17:36 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:17:32 -0700
In-Reply-To: <xmqqo8mti8od.fsf@gitster.c.googlers.com>
Message-Id: <20200831171732.1199755-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8mti8od.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: Re: [PATCH v2 2/2] wt-status: tolerate dangling marks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +
> > +	/*
> > +	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
> > +	 * branch in question does not have such a reference, return -1 instead
> > +	 * of die()-ing.
> > +	 */
> > +	unsigned nonfatal_dangling_mark : 1;
> 
> Micronit; I would have avoided "or equivalent" as the point of
> parenthetical comment was not to say these two modifiers upstream
> and push (and other forms that spell differently but invokes exactly
> one of these two features) are special, but to say that these two
> are merely examples, and any other ^{modifiers} we have or we will
> add in the future would honor this bit.  Perhaps "(and the like)"?

"(and the like)" sounds good.

> Among these callers that reach substitute_branch_name(), how were
> those that can specify the new bit chosen?

I just did the minimal change to fix the bug in the test.

> For example, what is the reasoning behind making dwim_ref() unable
> to ask the "do so gently" variant, while allowing repo_dwim_ref()
> to?
> 
> I am NOT necessarily saying these two functions MUST be able to
> access the same set of features and the only difference between them
> MUST be kept to the current "repo_* variant can work on an arbitrary
> repository, while the variant without repo_* would work on the
> primary repository only".  As long as there is a good reason to make
> their power diverge, it is OK---I just do not see why and I'd like
> to know.

Maybe add the following to the end of the last paragraph of the commit
message:

  (dwim_ref() is unchanged because I expect more and more code to use
  repo_dwim_ref(), and to reduce the size of the diff.)

If you prefer not to make this change locally, let me know and I'll
resend one with the updated commit message and the "(and the like)"
change above.

> The same question about not allowing the gentler variant while
> drimming the reflog.

Same as above - I only did the minimal change to fix the bug.
Admittedly, if a reflog-accessing command could fail in the same way
(dangling mark), we would need to fix repo_dwim_log() and then we could
simplify substitute_branch_name() to not take the nonfatal_dangling_mark
parameter (since all dangling marks would now be nonfatal), but I
haven't looked beyond this.
