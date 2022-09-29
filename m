Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F6C433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiI2TWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiI2TWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:22:16 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B0D13A06B
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:22:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p202so1691403iod.6
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=KcLxq1fG4fRe1yE+XI9MpXQcv+Wm8YYySMwvum1TCSE=;
        b=4Kvs7C1e6+tHRbSF8pwygDOLxhioYU0cVXDloz4pNdBvqlQY2tsgmQ3x3ri5EyNasl
         HkFtwxMyQQ0aSn4wBaxKu4UIw9j/ZRiFBkBrl+ZDw71KE7nZ5anC/SQBo2tZpaGkQitj
         zfgKR7dnwnKfYIq3cOz5JUS2hsUmKKb6yWPccRpb+e3ux6g4XygrFaDBHh0YQGDPWvSw
         d0ukDvlGG24eHD2p0nR+eqmhZFn2DmuxzXwb8c2W4mXtzQx6vCkmZrvbWeM0JCYBJAj3
         UJIKXE/yg6rzzozlJqtuBWoO5LfMQIvuU9qD6eFK/uskZcn26mEP1iQ/sgkEa2Wy2Jta
         o/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KcLxq1fG4fRe1yE+XI9MpXQcv+Wm8YYySMwvum1TCSE=;
        b=wIIUqxisbTpK9ihkAKN/vct1VVAzHUmOLMqnZpC5YiJIMlHM3VlCPUEs+dQkkF8ZXx
         i8VT998cqQnfu3vuKO4hIwhtLwqIEIrpmgugUM3xUyJougXW8WT53xkEtYCljW/SuMIs
         GeVmsi40xZ+xhus3vSi2r9tNT+CsSr0nZqe+JHOhCyNKW7zBgPX9WdtEKTKLLsWnPWfM
         7s4AjOoSZsRWgOeeAqmyP5aElX+FVCKCuheUMDTdWjFsclTJy8WMyZsNiDHCBnDM/3uU
         xfRVSawml4djiPZ44vb3/6ALQ6u3cuRswSWXGEPTteD9x+qACdlqoc0imahlQnlmpNoY
         QXEQ==
X-Gm-Message-State: ACrzQf2waI0RF8ZsAhVEEojPuo+sLIYMDWBFCFO3/AmfKSatKR8GcrHE
        0PONy1Ci2fsTAvP1zFaxdrpmyWJAx1Hn6g==
X-Google-Smtp-Source: AMsMyM7BV6290x4mqZmX1InCOjEARFnCUJdzl1L4xE+0byHQik+6dpAStKFmtYQFGUtAcWJdx4+eAg==
X-Received: by 2002:a05:6638:419f:b0:35a:286e:6bdb with SMTP id az31-20020a056638419f00b0035a286e6bdbmr2581168jab.295.1664479334158;
        Thu, 29 Sep 2022 12:22:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v28-20020a02b09c000000b00349ccc2db88sm83798jah.101.2022.09.29.12.22.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:22:13 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:22:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 8/8] Using Git securely in shared services
Message-ID: <YzXwZQbM69eNJfm7@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to run git securely in shared services (Kevin)

- Kevin: What do we think about GIt on a shared device? e.g. Git trusts
	the repo more than the global config, but the repo might not be
	trustable. What do we think of, say, inverting this precedence?
- bmc: Repo config overriding global config is an important feature we
	should not lose. But I could imagine some global option that affects
	that behavior — making it very explicit, on that particular machine.
- Stolee: I wrote an email to the mailing list months ago about this
	subject.  Title "What is Git's security boundary?" Concrete proposal:
	anything that executes an executable could go through a hook that is
	installed at the global or system level, and local config can refer to
	that. E.g. "please run vim, which has been controlled at the system
	level".
	 - I got zero traction, but there's some prior art.
- Taylor: We think of Git as special in this way. For "make", we
	wouldn't ask this same question.
- Jrnieder: With "make", it's very clear to users that arbitrary
	commands might be run, but users don't have that same expectation when
	just browsing code.
- Taylor: We could create a mode that ignores repo config, and that
	makes prompts safer. But we're inherently make-like.
- Jrnieder: That's obvious to us, but not to most users. I think we're
	quite far from having Git's security model match users' mental model
	and I think it's hard to change the behavior but would be even harder
	to change users' mental model in this example.
- Jrnieder. I wish we could separate out "repo properties" from "actual
	config": keep my user preferences separate from the things that Git
	needs to run.
- Ævar: Emacs has solved this. Emacs can run arbitrary code for all
	kinds of things, but it prompts users to approve the code first. We
	could allowlist harmless config, and then only prompt users for
	sketchy things. Taylor: This kind of allowlisting sounds impossible
	though. Bmc: Can we do this just for core.repositoryformat and
	extensions.-?
- (much spirited discussion, did not hear)
- JTan: If we want repositories to still be movable, how would we
	maintain this allowlist?
- Ævar: There are ways to do this for just certain variables, or certain
	variables in certain paths, etc. We have a lot of space to do the
	right thing.
- Bmc: It's important to make this behavior configurable from the
	command line.
- Ævar: I was experimenting with this because I wanted a way to have
	config in-repo. It would be very useful even if we could only control
	a subset of config
- Jrnieder: We already have some defense against hooks-and-config in
	special cases e.g. uploadpack doesn't trust the local repo's hooks.
	Suppose we have completely solved the problem of protecting against
	those; are we comfortable with changing the threat model to encompass
	normal commands in local repositories?
- Peff: I think the safest option is to just ignore the in-repo config
	altogether. Johannes: But the unsafe thing isn't parsing the repo,
	it's executing code. We could just shift the boundary to "don't
	execute code outside of safe.directory".
