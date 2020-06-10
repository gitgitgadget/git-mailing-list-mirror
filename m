Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B136C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0335B207ED
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCprUQTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFJW1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJW1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 18:27:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8FC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 15:27:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x11so1514246plv.9
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XdqSJVRnvZOWhqAJZERat8dZ3mAhnsVE84qlwHGcXsM=;
        b=VCprUQTncIgWSR+9el7cxL4iB5K9Q7dN3lXOPeSUTMq8Kv9M4OppW8A5XV33ljjXa/
         GiCPG+PU/V/whlPs4KQ5RLA8gvwgWk3hQsX5XDfDNqzPIBPc0mtiarBSPazo12/+zv00
         L9UvAYU9WgT7KooTNRZOlC50f4lO8UnPSle7VMp2PNlif4e3J1PMN6uAK7zW9VcNIbnO
         mAqodK0riBivIhPN0X8EtkLCg3PK5XrY12kqgrjcgy78Ql8irllQ+ad4zjrRwtGXR69t
         a0k/QQlRCmoRKGOUkX2nlhYKE6yIHZ04rn4Rlr6HjEglzx7yeyEZZkTULH08YyjYR+UB
         Obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XdqSJVRnvZOWhqAJZERat8dZ3mAhnsVE84qlwHGcXsM=;
        b=nzY4Q04xRgXBOlWieg6xfqs8YxQjvRuffzQG3zwg0rY5UxYGghHUbagMHeIFxissqu
         4IIqo4mTw0wBn6xUXGx7BB55+1Af0LMhi/kwNzXEkQUVHpmZMOlAklIa74frrBFPi8H+
         9bF57u0EeMdbRroB47GPdepGhbKy7vmdcjiJ+mimTBLq0KZ9bQDNnCriL363mBTrp6Zm
         diTMK+WjliqCL9hwyW8z9Wl2nVjP03DFNC0CzLgy7gXZRLVrprMVN/8ZFnt5gdSRAlDl
         /1wtI7LtV903iHkxFdgUNez5+F9gqxnZLR+puDnmfBiqborna6wipb2krDkj0XVgkcuE
         GIjA==
X-Gm-Message-State: AOAM533yIN9vyVivK1phICs3jwo4hFHRyWBI5khswj6e/ZC/B+5KSXlG
        JTi8Zd1pXUFiHtb0CluqDYkK37827iY=
X-Google-Smtp-Source: ABdhPJxL4iPiRY0p2qtDPFlbadLyypsul/Z/XzbjEeQzxYbbgi0kdOzw3RSMct998lkmA5gSjixpAg==
X-Received: by 2002:a17:90a:3b09:: with SMTP id d9mr5441888pjc.225.1591828043543;
        Wed, 10 Jun 2020 15:27:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h8sm897536pfo.67.2020.06.10.15.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:27:22 -0700 (PDT)
Date:   Wed, 10 Jun 2020 15:27:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Virtual Inclusion Summit (was: Re: Rename offensive terminology
 (master))
Message-ID: <20200610222719.GE148632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 11:30:31PM +0200, Johannes Schindelin wrote:

> Encouraged by Emily in #git-devel (who pointed out that a subject like
> this is much better discussed seeing each others faces and hearing each
> others voices), I would like to organize another Virtual Contributor
> Summit, this time focused on inclusive language in Git, what we can do
> about it, and what we should do about it (or not).
> 
> Tentatively, I would like to propose having this meeting in the coming
> week, via Zoom, just like we did the Virtual Contributor Summit last
> September.
> 
> Could I ask all interested parties to reply to this email?

The Google contingent is interested in attending.

One note I'd like to make is that the Git community already suffers from
a lack of diversity; it will be hard for us to make meaningful changes
if just those of us who already contribute attend, because many of us -
myself included! - come from privilege and don't have much or any
firsthand experience with microaggressions (or overt discrimination). I
think it's a good idea to expand the attendance of this summit beyond
the current contributor base and try to include more diverse voices and
experts in building inclusive products.

To that end, I'm going to see what kind of interested parties we can
find to invite within Google - and I hope others will do the same within
their own network. I think the risk of us coming up with meaningless
changes far outweighs the risk of us having too many people in the Zoom
call. :)

 - Emily
