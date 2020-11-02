Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE4C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E438522268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dt8ANujH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBSql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:46:40 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:46:39 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id z28so6617702qkj.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uzgia/vBv1kuW1QAZzBN4pvTTCy1GbeCyN9TKvFgMxY=;
        b=dt8ANujHCNkdvVWNSiFclIic40gJm1y/cLLnxJWAJnpijKALxk3tAjK5Ht3oHDd7uK
         6tWxJYwJ1bfiqJQum67RlpqVeGiAaHX0uNYlTWWqO1Gz4srjgfSaOy3k2Vg0V3Btx3r/
         3bb8NgEFbQn/pJhL25AwgzmUCempMXI2xyQyhQU61pvmIJEPI1UYmgyaFjZ8mzA0Qftb
         ldwe/vGmkMNhOUjhlQmtnS6H51qm5xWrtXA1Q7/CMiJYxDvd7x2dqz2zb2uqPRRzAw/N
         mqhz/XSlysA1cDeKErWulTKXXb6BU6XAvF9yMN5XOAo8QLty91IOd56JaMmC1thb6GVd
         8GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uzgia/vBv1kuW1QAZzBN4pvTTCy1GbeCyN9TKvFgMxY=;
        b=Mgi3O+BvqsDK3cedPzQaUo3dY9c7JxVvYDa0inVdYq81h+V84KBjO6Y49md0f3Rej8
         9JSEh8co64YuRBcC2Rehjkb/ZMW44sFZgInPhTdYWATsHu0SqR08g5ZC26t2dbTMQaRM
         y0tM9scBc80xw4vz6q32jAd2Jc1Yg7aGajoyvM1bduyvjGvNm6llZRmkLhSnTJr2tHHV
         mvpakkq01Fv0MSkGnX21gJCCDavIOqghhufvSsMsmZfrKO7CuOTHnmgAW6us2GMaBf2t
         EVVVUs1UqwN6A6FMRgNt/VZqDznUHuN2zUX+Dk/TXUpAaDwZu9Sbcm9ImkgzqfK7K4pu
         rN/w==
X-Gm-Message-State: AOAM530RFDEHcf9+ugwL7cvbsJ7zUdoQ07t4l8Ie9jF55de27B+jpPdf
        J43Yxz4MgBicJvng1+2RK66JJLQ2XFQTUkDzB+ca
X-Google-Smtp-Source: ABdhPJyrtSWL4e/as7Eu+LdtAvUaUEkgDbJywT6gb3RDb/ldr1DazyK6B0bjL5ubbCahh6cuCq/qWnF+aqP+genpLn+E
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:1507:: with SMTP id
 e7mr23815215qvy.18.1604342798436; Mon, 02 Nov 2020 10:46:38 -0800 (PST)
Date:   Mon,  2 Nov 2020 10:46:34 -0800
In-Reply-To: <xmqqsg9rvc9z.fsf@gitster.c.googlers.com>
Message-Id: <20201102184634.3280859-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqsg9rvc9z.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: Re: jc/sequencer-stopped-sha-simplify, was Re: What's cooking in
 git.git (Oct 2020, #04; Tue, 27)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Junio,
> >
> > On Tue, 27 Oct 2020, Junio C Hamano wrote:
> >
> >> * jc/sequencer-stopped-sha-simplify (2020-10-21) 1 commit
> >>  - sequencer: tolerate abbreviated stopped-sha file
> >>
> >>  Recently the format of an internal state file "rebase -i" uses has
> >>  been tightened up for consistency, which would hurt those who start
> >>  "rebase -i" with old git and then continue with new git.  Loosen
> >>  the reader side a bit (which we may want to tighten again in a year
> >>  or so).
> >>
> >>  Is this a real issue, or just a theoretical one?
> >>  cf. <xmqqd01b429a.fsf@gitster.c.googlers.com>
> >
> > We had a similar situation when we decided to fix the incorrect quoting in
> > the `author-script` file, and we decided that we have to be careful:
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.1807271415410.10478@tvgsbejvaqbjf.bet/
> >
> > In light of that, I think we should go with Jonathan's patch for a couple
> > of versions before tightening the reader side again.
> 
> I do not mind taking the approach as a prudent and careful thing,
> but I want the question answered regardless, as I know Jonathan is
> in a good position to tell if this is just a theoretical issue than
> I am, and depending on the answer, we may rethink the approach of
> trying to be overly careful.

From what I see, this is just a theoretical issue for now. (I spotted it
while looking at the code, not because of a bug report.)
